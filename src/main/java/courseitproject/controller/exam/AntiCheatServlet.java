package courseitproject.controller.exam;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import courseitproject.model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

/**
 * Anti-Cheat Detection Servlet.
 *
 * Receives a webcam snapshot from the frontend (key="file"),
 * forwards it to the Python YOLO detection server (key="image"),
 * evaluates the result, and manages a per-session warning counter.
 *
 * Python AI endpoint: POST http://localhost:5000/detect
 * Returns: [{ "class": 0, "conf": 0.85 }]
 *
 * Business rules:
 *   - conf > 0.7  →  increment warning count
 *   - warnings >= 3 →  block exam (force auto-submit)
 */
@WebServlet(name = "AntiCheatServlet", urlPatterns = {"/detect-cheat"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1 MB  – buffer in memory before writing to disk
        maxFileSize       = 5 * 1024 * 1024,   // 5 MB  – max single file
        maxRequestSize    = 10 * 1024 * 1024   // 10 MB – max total request
)
public class AntiCheatServlet extends HttpServlet {

    private static final String AI_SERVER_URL = "http://localhost:5000/detect";
    private static final double CHEAT_CONFIDENCE_THRESHOLD = 0.7;
    private static final int    MAX_WARNINGS = 3;

    private static final String SESSION_KEY_PREFIX = "antiCheatWarnings_";
    private static final String EVIDENCE_FOLDER = "anticheat-evidence";
    private static final DateTimeFormatter TIMESTAMP_FMT = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");

    private final Gson gson = new Gson();

    // ------------------------------------------------------------------ POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");
        HttpSession session = request.getSession();

        // ─── 1. Auth check ──────────────────────────────────────────────
        Users user = (Users) session.getAttribute("USER");
        if (user == null) {
            sendJson(response, HttpServletResponse.SC_UNAUTHORIZED,
                    errorJson("Unauthorized – session expired."));
            return;
        }

        // ─── 2. Read attemptId & build per-attempt session key ─────────
        String attemptId = request.getParameter("attemptId");
        if (attemptId == null || attemptId.isBlank()) {
            sendJson(response, HttpServletResponse.SC_BAD_REQUEST,
                    errorJson("Missing attemptId parameter."));
            return;
        }
        String sessionKey = SESSION_KEY_PREFIX + attemptId;

        // ─── 3. Get current warning count for THIS attempt ──────────────
        Integer warnings = (Integer) session.getAttribute(sessionKey);
        if (warnings == null) warnings = 0;

        // If already blocked, reject immediately
        if (warnings >= MAX_WARNINGS) {
            sendJson(response, HttpServletResponse.SC_OK,
                    blockedJson(warnings));
            return;
        }

        // ─── 3. Extract the uploaded file part (key = "file") ───────────
        Part filePart;
        try {
            filePart = request.getPart("file");
        } catch (Exception e) {
            System.err.println("❌ [AntiCheat] Failed to read multipart file: " + e.getMessage());
            sendJson(response, HttpServletResponse.SC_BAD_REQUEST,
                    errorJson("Missing or invalid image file (key='file')."));
            return;
        }

        if (filePart == null || filePart.getSize() == 0) {
            sendJson(response, HttpServletResponse.SC_BAD_REQUEST,
                    errorJson("Empty image file."));
            return;
        }

        // ─── 4. Cache image bytes in memory ─────────────────────────────
        //       (so we can use them for both AI forwarding AND evidence saving)
        byte[] imageBytes;
        String imageContentType = filePart.getContentType();
        try (InputStream is = filePart.getInputStream()) {
            imageBytes = is.readAllBytes();
        }

        // ─── 5. Forward image to the Python AI server ───────────────────
        String aiResponse;
        try {
            aiResponse = forwardToPythonAI(imageBytes, imageContentType);
        } catch (IOException e) {
            System.err.println("❌ [AntiCheat] AI server unreachable: " + e.getMessage());
            // Gracefully degrade – don't punish the student if AI is down
            sendJson(response, HttpServletResponse.SC_OK,
                    degradedJson("AI server is unavailable. Monitoring paused."));
            return;
        }

        // ─── 6. Parse AI response and apply anti-cheat logic ────────────
        boolean cheatingDetected = false;
        double maxConf = 0.0;

        try {
            JsonArray detections = JsonParser.parseString(aiResponse).getAsJsonArray();
            for (int i = 0; i < detections.size(); i++) {
                JsonObject det = detections.get(i).getAsJsonObject();
                double conf = det.get("conf").getAsDouble();
                if (conf > maxConf) maxConf = conf;
                if (conf > CHEAT_CONFIDENCE_THRESHOLD) {
                    cheatingDetected = true;
                }
            }
        } catch (Exception e) {
            System.err.println("❌ [AntiCheat] Failed to parse AI response: " + aiResponse);
            sendJson(response, HttpServletResponse.SC_OK,
                    degradedJson("AI returned an unexpected response."));
            return;
        }

        // ─── 7. Update warning count & save evidence image ─────────────
        String evidencePath = null;
        if (cheatingDetected) {
            warnings++;
            session.setAttribute(sessionKey, warnings);
            System.out.println("⚠️ [AntiCheat] Warning #" + warnings
                    + " | conf=" + String.format("%.2f", maxConf)
                    + " | user=" + user.getUserId()
                    + " | session=" + session.getId());

            // Save the cheating evidence image to disk
            evidencePath = saveEvidenceImage(request, imageBytes, user.getUserId(), warnings, maxConf);
        }

        // ─── 8. Build and return response ───────────────────────────────
        boolean blocked = warnings >= MAX_WARNINGS;
        JsonObject result = new JsonObject();
        result.addProperty("cheatingDetected", cheatingDetected);
        result.addProperty("confidence", Math.round(maxConf * 100.0) / 100.0);
        result.addProperty("warnings", warnings);
        result.addProperty("maxWarnings", MAX_WARNINGS);
        result.addProperty("blocked", blocked);
        result.addProperty("aiRaw", aiResponse);
        if (evidencePath != null) {
            result.addProperty("evidencePath", evidencePath);
        }

        if (blocked) {
            result.addProperty("message",
                    "Exam blocked! You have been flagged for cheating " + MAX_WARNINGS + " times.");
        } else if (cheatingDetected) {
            result.addProperty("message",
                    "Warning " + warnings + "/" + MAX_WARNINGS
                            + ": suspicious activity detected (conf=" + String.format("%.0f%%", maxConf * 100) + ").");
        } else {
            result.addProperty("message", "OK");
        }

        sendJson(response, HttpServletResponse.SC_OK, result.toString());
    }

    // =====================================================================
    //  Forward multipart image to the Python AI server
    // =====================================================================
    private String forwardToPythonAI(byte[] imageBytes, String contentType) throws IOException {

        String boundary = "----JavaAntiCheat" + UUID.randomUUID().toString().replace("-", "");

        URL url = new URL(AI_SERVER_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(10000);
        conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);

        String fileName = "capture.jpg";
        if (contentType == null) contentType = "image/jpeg";

        try (OutputStream os = conn.getOutputStream()) {
            PrintWriter writer = new PrintWriter(new OutputStreamWriter(os, StandardCharsets.UTF_8), true);

            // ── Part header ──
            writer.append("--").append(boundary).append("\r\n");
            writer.append("Content-Disposition: form-data; name=\"image\"; filename=\"")
                    .append(fileName).append("\"").append("\r\n");
            writer.append("Content-Type: ").append(contentType).append("\r\n");
            writer.append("\r\n");
            writer.flush();

            // ── Binary image data ──
            os.write(imageBytes);
            os.flush();

            // ── Closing boundary ──
            writer.append("\r\n");
            writer.append("--").append(boundary).append("--").append("\r\n");
            writer.flush();
        }

        // ── Read AI response ──
        int status = conn.getResponseCode();
        InputStream is = (status >= 200 && status < 300)
                ? conn.getInputStream()
                : conn.getErrorStream();

        StringBuilder sb = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
        } finally {
            conn.disconnect();
        }

        if (status < 200 || status >= 300) {
            throw new IOException("AI server returned HTTP " + status + ": " + sb);
        }

        return sb.toString();
    }

    // =====================================================================
    //  Save cheating evidence image to disk
    // =====================================================================

    /**
     * Saves the cheating snapshot to:
     *   {webapp}/anticheat-evidence/user_{userId}/warning{n}_{timestamp}_{conf}.jpg
     *
     * Returns the relative web-accessible path (e.g. "/anticheat-evidence/user_5/warning1_20260321_193500_85.jpg")
     * or null if saving fails.
     */
    private String saveEvidenceImage(HttpServletRequest request, byte[] imageBytes,
                                     int userId, int warningNumber, double confidence) {
        try {
            // Resolve the real path on disk for the webapp root
            String webappRoot = request.getServletContext().getRealPath("/");
            if (webappRoot == null) {
                System.err.println("❌ [AntiCheat] Cannot resolve webapp root path.");
                return null;
            }

            // Build directory: {webapp}/anticheat-evidence/user_{userId}/
            Path userDir = Paths.get(webappRoot, EVIDENCE_FOLDER, "user_" + userId);
            Files.createDirectories(userDir);

            // Build filename: warning1_20260321_193500_85.jpg
            String timestamp = LocalDateTime.now().format(TIMESTAMP_FMT);
            int confPercent = (int) Math.round(confidence * 100);
            String fileName = "warning" + warningNumber + "_" + timestamp + "_" + confPercent + ".jpg";

            Path targetPath = userDir.resolve(fileName);

            // Write the cached image bytes to file
            Files.write(targetPath, imageBytes);

            String relativePath = "/" + EVIDENCE_FOLDER + "/user_" + userId + "/" + fileName;
            System.out.println("📸 [AntiCheat] Evidence saved: " + targetPath.toAbsolutePath());
            return relativePath;

        } catch (Exception e) {
            System.err.println("❌ [AntiCheat] Failed to save evidence image: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // =====================================================================
    //  Helpers
    // =====================================================================

    /** Send a JSON string with the given HTTP status code. */
    private void sendJson(HttpServletResponse response, int statusCode, String json) throws IOException {
        response.setStatus(statusCode);
        response.setContentType("application/json; charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(json);
            out.flush();
        }
    }

    /** Standard error JSON body. */
    private String errorJson(String message) {
        JsonObject obj = new JsonObject();
        obj.addProperty("error", true);
        obj.addProperty("message", message);
        return obj.toString();
    }

    /** Response when exam is already blocked. */
    private String blockedJson(int warnings) {
        JsonObject obj = new JsonObject();
        obj.addProperty("cheatingDetected", false);
        obj.addProperty("warnings", warnings);
        obj.addProperty("maxWarnings", MAX_WARNINGS);
        obj.addProperty("blocked", true);
        obj.addProperty("message",
                "Exam is blocked. You have exceeded the maximum number of warnings.");
        return obj.toString();
    }

    /** Response when AI server is unavailable – graceful degradation. */
    private String degradedJson(String reason) {
        JsonObject obj = new JsonObject();
        obj.addProperty("cheatingDetected", false);
        obj.addProperty("warnings", -1);
        obj.addProperty("blocked", false);
        obj.addProperty("degraded", true);
        obj.addProperty("message", reason);
        return obj.toString();
    }
}
