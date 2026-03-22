package courseitproject.controller.CourseEditDetail;

import courseitproject.service.ResourceEditService;
import courseitproject.model.Lesson;
import courseitproject.model.LessonResource;
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

@WebServlet(name = "ResourceAdminServlet", urlPatterns = {"/resourceAdmin"})
public class ResourceEditServlet extends HttpServlet {

    private ResourceEditService resourceDAO;
    private courseitproject.service.RoleEditService roleDAO;
    private IUserService userService;

    @Override
    public void init() throws ServletException {
        resourceDAO = new ResourceEditService();
        roleDAO = new courseitproject.service.RoleEditService();
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
                int lessonId = Integer.parseInt(request.getParameter("lesson_id"));
                String title = request.getParameter("title");
                String url = request.getParameter("url");
                String type = request.getParameter("resource_type");

                Lesson lesson = new Lesson(lessonId);
                LessonResource newResource = resourceDAO.create(lesson, title, url, type);

                if (newResource != null) {
                    jsonResponse.addProperty("status", "success");
                    jsonResponse.addProperty("resource_id", newResource.getResourceId());
                    jsonResponse.addProperty("title", newResource.getTitle());
                    jsonResponse.addProperty("url", newResource.getUrl());
                    jsonResponse.addProperty("resource_type", newResource.getResourceType());
                } else {
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Failed to create resource.");
                }
            } else if ("update".equals(action)) {
                int resourceId = Integer.parseInt(request.getParameter("resource_id"));
                String title = request.getParameter("title");
                String url = request.getParameter("url");
                boolean success = resourceDAO.update(resourceId, title, url);
                jsonResponse.addProperty("status", success ? "success" : "error");
            } else if ("delete".equals(action)) {
                int resourceId = Integer.parseInt(request.getParameter("resource_id"));
                boolean success = resourceDAO.delete(resourceId);
                jsonResponse.addProperty("status", success ? "success" : "error");
            } else {
                jsonResponse.addProperty("status", "error");
                jsonResponse.addProperty("message", "Unknown action.");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

            e.printStackTrace(); // in ra console Tomcat

            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", e.getClass().getSimpleName() + ": " + e.getMessage());
        }
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
}
