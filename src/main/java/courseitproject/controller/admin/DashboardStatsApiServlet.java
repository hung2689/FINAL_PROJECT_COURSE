package courseitproject.controller.admin;

import courseitproject.dao.DashboardStatsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DashboardStatsApiServlet", urlPatterns = {"/api/dashboard/charts"})
public class DashboardStatsApiServlet extends HttpServlet {

    private DashboardStatsDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new DashboardStatsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String filter = request.getParameter("filter");
        if (filter == null || filter.isEmpty()) {
            filter = "7days";
        }

        try {
            // Fetch Data
            Map<String, List<Object>> loginActivity = dao.getLoginActivity(filter);
            List<Map<String, Object>> courseCategories = dao.getCourseCategoryDistribution();

            // Build Response JSON String
            StringBuilder json = new StringBuilder();
            json.append("{");
            
            // Login Activity
            json.append("\"loginActivity\": {");
            json.append("\"labels\": [");
            if (loginActivity != null) {
                List<Object> labels = loginActivity.get("labels");
                if (labels != null) {
                    for (int i = 0; i < labels.size(); i++) {
                        json.append("\"").append(labels.get(i)).append("\"");
                        if (i < labels.size() - 1) json.append(",");
                    }
                }
            }
            json.append("],");
            
            json.append("\"data\": [");
            if (loginActivity != null) {
                List<Object> data = loginActivity.get("data");
                if (data != null) {
                    for (int i = 0; i < data.size(); i++) {
                        json.append(data.get(i));
                        if (i < data.size() - 1) json.append(",");
                    }
                }
            }
            json.append("]");
            json.append("},");
            
            // Course Category Distribution
            json.append("\"courseCategories\": [");
            if (courseCategories != null) {
                for (int i = 0; i < courseCategories.size(); i++) {
                    Map<String, Object> cc = courseCategories.get(i);
                    json.append(String.format(java.util.Locale.US,
                        "{\"categoryName\": \"%s\", \"totalCourses\": %d}",
                        escapeJson((String) cc.get("categoryName")),
                        (int) cc.get("totalCourses")
                    ));
                    if (i < courseCategories.size() - 1) json.append(",");
                }
            }
            json.append("]");
            
            json.append("}");

            PrintWriter out = response.getWriter();
            out.print(json.toString());
            out.flush();
        } catch (Exception e) {
            response.setStatus(500);
            e.printStackTrace(response.getWriter());
        }
    }
    
    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\"", "\\\"").replace("\n", "").replace("\r", "");
    }
}
