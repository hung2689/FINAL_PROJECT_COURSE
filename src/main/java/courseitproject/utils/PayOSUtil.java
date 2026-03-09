package courseitproject.utils;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class PayOSUtil {

    // THÔNG TIN PAYOS
    public static final String CLIENT_ID = "0ae09a8c-b15d-40a6-a895-b69c4618d015";
    public static final String API_KEY = "bf444ae9-05ee-48b2-94b8-3b00af0821f6";
    public static final String CHECKSUM_KEY = "35bddafab455e0d4fff283e8eb409fa910f1acf8004425f53da29b89b055378e";

    public static String createPaymentLink(int orderCode, int amount, String description, String returnUrl, String cancelUrl) {

        try {

            // thời gian hết hạn (15 phút)
            long expiredAt = System.currentTimeMillis() / 1000 + 900;

            // Chuỗi ký để tạo chữ ký
            String dataToHash =
                    "amount=" + amount +
                    "&cancelUrl=" + cancelUrl +
                    "&description=" + description +
                    "&orderCode=" + orderCode +
                    "&returnUrl=" + returnUrl;

            // HMAC SHA256
            Mac mac = Mac.getInstance("HmacSHA256");
            SecretKeySpec secretKey = new SecretKeySpec(CHECKSUM_KEY.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            mac.init(secretKey);

            byte[] hash = mac.doFinal(dataToHash.getBytes(StandardCharsets.UTF_8));

            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                String s = Integer.toHexString(0xff & b);
                if (s.length() == 1) hex.append('0');
                hex.append(s);
            }

            String signature = hex.toString();

            // JSON body
            String jsonBody = "{"
                    + "\"orderCode\":" + orderCode + ","
                    + "\"amount\":" + amount + ","
                    + "\"description\":\"" + description + "\","
                    + "\"returnUrl\":\"" + returnUrl + "\","
                    + "\"cancelUrl\":\"" + cancelUrl + "\","
                    + "\"expiredAt\":" + expiredAt + ","
                    + "\"signature\":\"" + signature + "\""
                    + "}";

            // API URL
            URL url = new URL("https://api-merchant.payos.vn/v2/payment-requests");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setConnectTimeout(15000);
            conn.setReadTimeout(15000);

            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("x-client-id", CLIENT_ID);
            conn.setRequestProperty("x-api-key", API_KEY);

            conn.setDoOutput(true);

            // gửi request
            try (OutputStream os = conn.getOutputStream()) {
                os.write(jsonBody.getBytes(StandardCharsets.UTF_8));
            }

            // đọc response
            int status = conn.getResponseCode();
            InputStream is = (status < 300) ? conn.getInputStream() : conn.getErrorStream();

            BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
            StringBuilder response = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                response.append(line);
            }

            String res = response.toString();

            // lấy checkoutUrl
            String key = "\"checkoutUrl\":\"";
            int start = res.indexOf(key);

            if (start == -1) {
                System.out.println("PayOS error: " + res);
                return null;
            }

            start += key.length();
            int end = res.indexOf("\"", start);

            return res.substring(start, end);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}