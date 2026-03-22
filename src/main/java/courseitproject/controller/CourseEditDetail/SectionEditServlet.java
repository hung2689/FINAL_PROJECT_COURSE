package courseitproject.controller.CourseEditDetail;

import courseitproject.service.SectionEditService;
import courseitproject.model.Course;
import courseitproject.model.Section;
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


@WebServlet(name = "SectionAdminServlet", urlPatterns = { "/sectionAdmin" })
public class SectionEditServlet extends HttpServlet {

    private SectionEditService sectionDAO;
    private courseitproject.service.RoleEditService roleDAO;

    @Override
    public void init() throws ServletException {
        sectionDAO = new SectionEditService();
        roleDAO = new courseitproject.service.RoleEditService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "GET method is not allowed for this endpoint.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        JsonObject jsonResponse = new JsonObject();

        // Check if user is admin (assuming session contains user object)
        courseitproject.model.Users user = (courseitproject.model.Users) request.getSession().getAttribute("USER");
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Unauthorized access.");
            out.print(gson.toJson(jsonResponse));
            return;
        }

        String cachedRole = (String) request.getSession().getAttribute("ROLE");
        boolean isAdmin = "ADMIN".equalsIgnoreCase(cachedRole);

        // Fallback to DB if session has no ROLE
        if (!isAdmin) {
            IUserService userService = new UserServiceImp();
            isAdmin = userService.findRolesByUserId(user.getUserId()).stream()
                    .anyMatch(r -> "ADMIN".equals(r.getRoleName()));
        }

        if (!isAdmin) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Forbidden access. Only ADMIN can perform this action.");
            out.print(gson.toJson(jsonResponse));
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                String courseIdStr = request.getParameter("course_id");
                String title = request.getParameter("title");
                Course course = new Course(Integer.parseInt(courseIdStr));

                String orderIndexStr = request.getParameter("order_index");
                int orderIndex;
                if (orderIndexStr != null && !orderIndexStr.isEmpty()) {
                    orderIndex = Integer.parseInt(orderIndexStr);
                } else {
                    orderIndex = sectionDAO.getNextOrderIndex(course.getCourseId());
                }
                Section newSection = sectionDAO.create(course, title, orderIndex);

                if (newSection != null) {
                    jsonResponse.addProperty("status", "success");
                    jsonResponse.addProperty("section_id", newSection.getSectionId());
                    jsonResponse.addProperty("order_index", newSection.getOrderIndex());
                    jsonResponse.addProperty("title", newSection.getTitle());
                } else {
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Failed to create section.");
                }
            } else if ("update".equals(action)) {
                int sectionId = Integer.parseInt(request.getParameter("section_id"));
                String title = request.getParameter("title");
                boolean success = sectionDAO.update(sectionId, title);
                jsonResponse.addProperty("status", success ? "success" : "error");
            } else if ("delete".equals(action)) {
                int sectionId = Integer.parseInt(request.getParameter("section_id"));
                boolean success = sectionDAO.delete(sectionId);
                jsonResponse.addProperty("status", success ? "success" : "error");
            } else {
                jsonResponse.addProperty("status", "error");
                jsonResponse.addProperty("message", "Unknown action.");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", e.getMessage());
        }

        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
}
