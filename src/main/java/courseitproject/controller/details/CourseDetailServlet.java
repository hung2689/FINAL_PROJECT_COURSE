package courseitproject.controller.details;

import courseitproject.dto.CourseDetailDTO;
import courseitproject.model.Role;
import courseitproject.model.Users;
import courseitproject.service.ICourseDetailService;
import courseitproject.service.CourseDetailServiceImpl;
import courseitproject.service.IUserService;
import courseitproject.service.UserServiceImp;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CourseDetailServlet", urlPatterns = {"/course-detail"})
public class CourseDetailServlet extends HttpServlet {

    private ICourseDetailService courseDetailService;
    private IUserService userService;

    @Override
    public void init() {
        userService = new UserServiceImp();
        courseDetailService = new CourseDetailServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseIdStr = request.getParameter("id");
        if (courseIdStr == null || courseIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        int courseId;
        try {
            courseId = Integer.parseInt(courseIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        HttpSession session = request.getSession(false);

        Users currentUser = null;
        Integer studentId = null;
        boolean isEditAllowed = false;

        if (session != null) {
            currentUser = (Users) session.getAttribute("USER");

            if (currentUser != null) {
                for (Role r : userService.findRolesByUserId(currentUser.getUserId())) {

 
                    if ("STUDENT".equals(r.getRoleName())) {
                        studentId = currentUser.getUserId();
                    }

                    if ("ADMIN".equals(r.getRoleName()) || courseDetailService.isTeacherOfCourse(currentUser.getUserId(), courseId)) {
                        isEditAllowed = true;
                    }
                }
            }
        }

        CourseDetailDTO dto = courseDetailService.getCourseDetail(courseId, studentId);

        if (dto == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Course not found");
            return;
        }

        request.setAttribute("isEditAllowed", isEditAllowed);
        request.setAttribute("courseDetail", dto);

        request.getRequestDispatcher("views/details/course-detail.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
