package courseitproject.controller.teacher;

import courseitproject.model.Course;
import courseitproject.model.Users;
import courseitproject.service.CourseServiceImp;
import courseitproject.service.ICourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TeacherDashboardServlet", urlPatterns = {"/teacherDashboard"})
public class TeacherDashboardServlet extends HttpServlet {

    private ICourseService courseService;

    @Override
    public void init() {
        courseService = new CourseServiceImp();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("USER");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // since teacher_id maps 1:1 to user_id
        List<Course> courses = courseService.findCoursesByTeacherId(user.getUserId());
        request.setAttribute("courses", courses);

        request.getRequestDispatcher("/views/teacher/dashboard.jsp").forward(request, response);
    }
}
