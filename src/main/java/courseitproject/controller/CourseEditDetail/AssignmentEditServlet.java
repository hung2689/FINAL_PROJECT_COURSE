package courseitproject.controller.CourseEditDetail;

import courseitproject.service.AssignmentEditService;
import courseitproject.model.Lesson;
import courseitproject.model.Assignment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import courseitproject.service.IUserService;
import courseitproject.service.UserServiceImp;
import java.util.Set;

@WebServlet(name = "AssignmentAdminServlet", urlPatterns = {"/assignmentAdmin"})
public class AssignmentEditServlet extends HttpServlet {

    private AssignmentEditService assignmentDAO;
    private IUserService userService;

    @Override
    public void init() throws ServletException {
        assignmentDAO = new AssignmentEditService();
        userService = new UserServiceImp();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        JsonObject jsonResponse = new JsonObject();

        courseitproject.model.Users user
                = (courseitproject.model.Users) request.getSession().getAttribute("USER");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Unauthorized access.");
            out.print(gson.toJson(jsonResponse));
            return;
        }

        // Check session-cached role first (no DB call)
        String cachedRole = (String) request.getSession().getAttribute("ROLE");
        Set<String> allowedRoles = Set.of("ADMIN", "TEACHER");
        String role = cachedRole;

        // Fallback to DB only if session has no ROLE
        if (role == null) {
            role = userService.findOneRoleByUserId(user.getUserId()).getRoleName();
        }

        if (!allowedRoles.contains(role)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Unauthorized access.");
            out.print(gson.toJson(jsonResponse));
            return;
        }
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                // Not strictly needed here based on fixt.md, but good for completeness 
                int lessonId = Integer.parseInt(request.getParameter("lesson_id"));
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String criteria = request.getParameter("criteria");
                String expectedOutput = request.getParameter("expected_output");
                String fileExtensions = request.getParameter("file_extensions");

                Lesson lesson = new Lesson(lessonId);
                Assignment newAssignment = assignmentDAO.create(lesson, title, description, criteria, expectedOutput, fileExtensions);

                if (newAssignment != null) {
                    jsonResponse.addProperty("status", "success");
                    jsonResponse.addProperty("assignment_id", newAssignment.getAssignmentId());
                    jsonResponse.addProperty("title", newAssignment.getTitle());
                } else {
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Failed to create assignment.");
                }
            } else if ("update".equals(action)) {
                int assignmentId = Integer.parseInt(request.getParameter("assignment_id"));
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String criteria = request.getParameter("criteria");
                String expectedOutput = request.getParameter("expected_output");
                String fileExtensions = request.getParameter("file_extensions");
                
                boolean success = assignmentDAO.update(assignmentId, title, description, criteria, expectedOutput, fileExtensions);
                jsonResponse.addProperty("status", success ? "success" : "error");
            } else if ("delete".equals(action)) {
                int assignmentId = Integer.parseInt(request.getParameter("assignment_id"));
                boolean success = assignmentDAO.delete(assignmentId);
                jsonResponse.addProperty("status", success ? "success" : "error");
            } else {
                jsonResponse.addProperty("status", "error");
                jsonResponse.addProperty("message", "Unknown action.");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

            e.printStackTrace(); // print to Tomcat console

            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", e.getClass().getSimpleName() + ": " + e.getMessage());
        }
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
}
