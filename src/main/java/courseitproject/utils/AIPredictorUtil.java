package courseitproject.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class AIPredictorUtil {

    public static double callAIPredictAPI(String jsonInput) throws IOException {
        double dropoutProb = 0.0;
        try {
            // AI Server URL (Python Flask/FastAPI)
            URL url = new URL("http://localhost:5000/api/predict");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; utf-8");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);

            // 1. Send data to Python AI Server
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInput.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 2. Read response from AI Server
            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "utf-8"))) {
                StringBuilder response = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }
                
                String resultStr = response.toString();
                // Log the raw result (now in English)
                System.out.println("✅ [AIPredictorUtil] Received from AI: " + resultStr);
                
                // 3. Extract dropout_prob from JSON
                if (resultStr.contains("\"dropout_prob\"")) {
                    String[] parts = resultStr.split("\"dropout_prob\":");
                    String valuePart = parts[1].split(",")[0];
                    
                    // Remove extra characters like } or : or whitespace
                    String cleanValue = valuePart.replaceAll("[^0-9.]", ""); 

                    dropoutProb = Double.parseDouble(cleanValue);
                }
            } 
        } catch (Exception e) {
            // English log for connection errors
            System.out.println("❌ [AIPredictorUtil] Connection to AI Server failed: " + e.getMessage());
        }
        return dropoutProb;
    }
}