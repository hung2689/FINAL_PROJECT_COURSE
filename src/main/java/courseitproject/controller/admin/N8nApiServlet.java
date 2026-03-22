/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.admin;

import courseitproject.service.ICandidateService;
import courseitproject.service.CandidateServiceImp;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * N8N Webhook handler
 */
@WebServlet(name = "N8nApiServlet", urlPatterns = {"/api/candidates"})
public class N8nApiServlet extends HttpServlet {

    private ICandidateService candidateService;

    @Override
    public void init() {
        candidateService = new CandidateServiceImp();
    }

    private int parseIntSafe(String val1, String val2) {
        if (val1 != null && !val1.trim().isEmpty() && !"null".equalsIgnoreCase(val1.trim())) {
            try { return Integer.parseInt(val1.trim()); } catch (NumberFormatException ignored) {}
        }
        if (val2 != null && !val2.trim().isEmpty() && !"null".equalsIgnoreCase(val2.trim())) {
            try { return Integer.parseInt(val2.trim()); } catch (NumberFormatException ignored) {}
        }
        return 0; // Default if neither parameter parses correctly
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {
            int userId = parseIntSafe(req.getParameter("user_id"), null);
            int jobId = parseIntSafe(req.getParameter("job_id"), null);
            int score = parseIntSafe(req.getParameter("score"), null);
            String decision = req.getParameter("decision");
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String cvUrl = req.getParameter("cv_url");

            // N8N sometimes sends singular forms (skill_count instead of skills_count)
            int skillsCount = parseIntSafe(req.getParameter("skills_count"), req.getParameter("skill_count"));
            int projectsCount = parseIntSafe(req.getParameter("projects_count"), req.getParameter("project_count"));

            if (userId == 0 || jobId == 0) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"error\":\"Missing user_id or job_id\"}");
                return;
            }

            boolean success = candidateService.updateCandidateFromN8n(
                    userId, jobId, score, decision, skillsCount, projectsCount, name, cvUrl, email);

            if (success) {
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("{\"status\":\"updated\"}");
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("{\"error\":\"Failed to update candidate.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }
}
