package courseitproject.controller.CourseEditDetail;

import courseitproject.service.LessonEditService;
import courseitproject.model.Lesson;
import courseitproject.model.Section;
import courseitproject.model.Course;
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

@WebServlet(name = "LessonAdminServlet", urlPatterns = {"/lessonAdmin"})
public class LessonEditServlet extends HttpServlet {

    private LessonEditService lessonDAO;
    private courseitproject.service.RoleEditService roleDAO;
    private IUserService userService;

    @Override
    public void init() throws ServletException {
        lessonDAO = new LessonEditService();
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

        courseitproject.model.Users user = (courseitproject.model.Users) request.getSession().getAttribute("USER");
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Unauthorized access.");
            out.print(gson.toJson(jsonResponse));
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                int sectionId = Integer.parseInt(request.getParameter("section_id"));
                String title = request.getParameter("title");
                Section section = new Section(sectionId);
                String courseIdStr = request.getParameter("course_id");
                if (courseIdStr != null) {
                    section.setCourseId(Integer.parseInt(courseIdStr));
                }

                String orderIndexStr = request.getParameter("order_index");
                int orderIndex;
                if (orderIndexStr != null && !orderIndexStr.isEmpty()) {
                    orderIndex = Integer.parseInt(orderIndexStr);
                } else {
                    orderIndex = lessonDAO.getNextOrderIndex(section.getSectionId());
                }

                Lesson newLesson = lessonDAO.create(section, title, orderIndex);

                if (newLesson != null) {
                    jsonResponse.addProperty("status", "success");
                    jsonResponse.addProperty("lesson_id", newLesson.getLessonId());
                    jsonResponse.addProperty("title", newLesson.getTitle());
                    jsonResponse.addProperty("order_index", newLesson.getOrderIndex());
                } else {
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Failed to create lesson.");
                }
            } else if ("update".equals(action)) {
                int lessonId = Integer.parseInt(request.getParameter("lesson_id"));
                String title = request.getParameter("title");
                boolean success = lessonDAO.update(lessonId, title);
                jsonResponse.addProperty("status", success ? "success" : "error");
            } else if ("delete".equals(action)) {
                int lessonId = Integer.parseInt(request.getParameter("lesson_id"));
                boolean success = lessonDAO.delete(lessonId);
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
