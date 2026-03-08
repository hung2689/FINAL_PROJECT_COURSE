
package courseitproject.utils;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

public class PayOSUtil {
    // 3 MÃ BÍ MẬT CỦA BẠN
    public static final String CLIENT_ID = "0ae09a8c-b15d-40a6-a895-b69c4618d015";
    public static final String API_KEY = "bf444ae9-05ee-48b2-94b8-3b00af0821f6";
    public static final String CHECKSUM_KEY = "35bddafab455e0d4fff283e8eb409fa910f1acf8004425f53da29b89b055378e";

    // Hàm tạo link quét mã QR
    public static String createPaymentLink(int orderCode, int amount, String description, String returnUrl, String cancelUrl) {
        try {
            // 1. Tạo chuỗi ký tự chuẩn để mã hóa
            String dataToHash = "amount=" + amount +
                                "&cancelUrl=" + cancelUrl +
                                "&description=" + description +
                                "&orderCode=" + orderCode +
                                "&returnUrl=" + returnUrl;

            // 2. Mã hóa chữ ký bằng HMAC_SHA256 (Chuẩn bảo mật của payOS)
            Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
            SecretKeySpec secret_key = new SecretKeySpec(CHECKSUM_KEY.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            sha256_HMAC.init(secret_key);
            byte[] hashBytes = sha256_HMAC.doFinal(dataToHash.getBytes(StandardCharsets.UTF_8));

            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            String signature = hexString.toString();

            // 3. Đóng gói dữ liệu thành chuỗi JSON
            String jsonBody = "{"
                    + "\"orderCode\":" + orderCode + ","
                    + "\"amount\":" + amount + ","
                    + "\"description\":\"" + description + "\","
                    + "\"returnUrl\":\"" + returnUrl + "\","
                    + "\"cancelUrl\":\"" + cancelUrl + "\","
                    + "\"signature\":\"" + signature + "\""
                    + "}";

            // 4. Gửi yêu cầu sang Server của payOS
            URL url = new URL("https://api-merchant.payos.vn/v2/payment-requests");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("x-client-id", CLIENT_ID);
            conn.setRequestProperty("x-api-key", API_KEY);
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(jsonBody.getBytes(StandardCharsets.UTF_8));
            }

            // 5. Đọc kết quả payOS trả về
            Scanner scanner = new Scanner(conn.getInputStream(), StandardCharsets.UTF_8.name());
            String response = scanner.useDelimiter("\\A").next();
            scanner.close();

            // 6. Tách lấy cái đường link quét QR
            String urlKey = "\"checkoutUrl\":\"";
            int startIndex = response.indexOf(urlKey) + urlKey.length();
            int endIndex = response.indexOf("\"", startIndex);
            
            return response.substring(startIndex, endIndex);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}