package courseitproject.controller.admin;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Proxy servlet that fetches a PDF from Cloudinary and streams it to the browser.
 * This bypasses Cloudinary's X-Frame-Options header so the PDF can be 
 * displayed inside an iframe on the admin page.
 *
 * Usage: /cv-proxy?url=https://res.cloudinary.com/.../file.pdf
 */
@WebServlet(name = "CvProxyServlet", urlPatterns = {"/cv-proxy", "/cv-proxy/*"})
public class CvProxyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String cvUrl = req.getParameter("url");

        // Validate: only allow Cloudinary URLs
        if (cvUrl == null || cvUrl.isEmpty()
                || !cvUrl.startsWith("https://res.cloudinary.com/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid or missing URL");
            return;
        }

        HttpURLConnection conn = null;
        try {
            URL url = new URL(cvUrl);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(15000);
            // Pretend to be a normal browser if Cloudinary checks user-agent
            conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)");

            int status = conn.getResponseCode();
            if (status != 200) {
                resp.sendError(status, "Cloudinary returned status " + status);
                return;
            }

            // Set response headers for inline PDF display
            resp.setContentType("application/pdf");
            resp.setHeader("Content-Disposition", "inline; filename=\"cv.pdf\"");
            // Allow embedding in iframe by omitting X-Frame-Options (or specifically using CSP)
            resp.setHeader("Content-Security-Policy", "frame-ancestors *");

            // Stream the PDF bytes to the client
            try (InputStream in = conn.getInputStream();
                 OutputStream out = resp.getOutputStream()) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                out.flush();
            }

        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
}
