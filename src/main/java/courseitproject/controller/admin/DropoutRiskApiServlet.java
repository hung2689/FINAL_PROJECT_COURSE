package courseitproject.controller.admin;

import courseitproject.service.AIPredictionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

/**
 * REST-style API servlet for the admin dashboard dropout risk widget.
 *
 * Endpoints:
 *   GET /api/dashboard/dropout-rate          → overall stats (all time)
 *   GET /api/dashboard/dropout-rate?days=7   → last 7 days
 *   GET /api/dashboard/dropout-rate?days=30  → last 30 days
 *
 * Response JSON:
 * {
 *   "totalStudents": 100,
 *   "highRisk": 25,
 *   "mediumRisk": 40,
 *   "lowRisk": 35,
 *   "dropoutRate": 25.0
 * }
 */
@WebServlet(name = "DropoutRiskApiServlet", urlPatterns = {"/api/dashboard/dropout-rate"})
public class DropoutRiskApiServlet extends HttpServlet {

    private AIPredictionService service;

    @Override
    public void init() throws ServletException {
        service = new AIPredictionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Parse optional "days" parameter
        int days = 0;
        String daysParam = request.getParameter("days");
        if (daysParam != null && !daysParam.isEmpty()) {
            try {
                days = Integer.parseInt(daysParam);
            } catch (NumberFormatException e) {
                days = 0;
            }
        }

        Map<String, Object> stats = service.getDropoutRiskStats(days);
        
        // Fetch all students predictions
        java.util.List<Map<String, Object>> topStudents = service.getAllStudentRiskPredictions(days);
        StringBuilder topStudentsJson = new StringBuilder("[");
        for (int i = 0; i < topStudents.size(); i++) {
            Map<String, Object> student = topStudents.get(i);
            String email = (String) student.get("email");
            if (email == null) email = "";
            String fullName = (String) student.get("fullName");
            if (fullName == null) fullName = "Unknown";
            
            topStudentsJson.append(String.format(java.util.Locale.US,
                "{\"userId\":%d,\"fullName\":\"%s\",\"email\":\"%s\",\"riskScore\":%.2f}",
                ((Number) student.get("userId")).intValue(),
                escapeJson(fullName),
                escapeJson(email),
                ((Number) student.get("riskScore")).doubleValue()
            ));
            
            if (i < topStudents.size() - 1) {
                topStudentsJson.append(",");
            }
        }
        topStudentsJson.append("]");

        // Build JSON response using Locale.US to ensure '.' is used as decimal separator instead of ','
        String json = String.format(java.util.Locale.US,
            "{\"totalStudents\":%d,\"highRisk\":%d,\"mediumRisk\":%d,\"lowRisk\":%d,\"dropoutRate\":%.2f,\"topRiskStudents\":%s}",
            (int) stats.get("totalStudents"),
            (int) stats.get("highRisk"),
            (int) stats.get("mediumRisk"),
            (int) stats.get("lowRisk"),
            ((Number) stats.get("dropoutRate")).doubleValue(),
            topStudentsJson.toString()
        );

        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
    
    // Helper method to escape strings for JSON
    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\"", "\\\"").replace("\n", "").replace("\r", "");
    }
}
