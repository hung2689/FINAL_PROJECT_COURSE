/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.details;

import courseitproject.dto.CourseDetailDTO;
import courseitproject.model.LessonResource;
import courseitproject.model.UserRole;
import courseitproject.model.Users;
import courseitproject.service.ICourseDetailService;
import courseitproject.service.CourseDetailServiceImpl;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "CourseVideoServlet", urlPatterns = { "/courseVideo" })
public class CourseVideoServlet extends HttpServlet {

    private final ICourseDetailService courseDetailService = new CourseDetailServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String resourceIdStr = request.getParameter("resourceId");
        if (resourceIdStr == null || resourceIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/course-detail");
            return;
        }

        int resourceId;
        try {
            resourceId = Integer.parseInt(resourceIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/course-detail");
            return;
        }

        LessonResource currentResource = courseDetailService.getLessonResourceById(resourceId);
        if (currentResource == null) {
            response.sendRedirect(request.getContextPath() + "/course-detail");
            return;
        }

        int courseId = currentResource.getLessonId().getCourseId() != null
                ? currentResource.getLessonId().getCourseId().getCourseId()
                : currentResource.getLessonId().getSectionId().getCourseId();

        Integer studentId = null;
        boolean isEditAllowed = false;
        HttpSession session = request.getSession(false);
        if (session != null) {
            Users currentUser = (Users) session.getAttribute("USER");
            if (currentUser != null) {
                boolean isStudent = false;
                courseitproject.service.IUserService userService = new courseitproject.service.UserServiceImp();
                java.util.List<courseitproject.model.Role> roles = userService
                        .findRolesByUserId(currentUser.getUserId());
                if (roles != null) {
                    for (courseitproject.model.Role r : roles) {
                        if ("STUDENT".equalsIgnoreCase(r.getRoleName())) {
                            isStudent = true;
                        }
                        if ("ADMIN".equals(r.getRoleName()) || courseDetailService.isTeacherOfCourse(currentUser.getUserId(), courseId)) {
                            isEditAllowed = true;
                        }
                    }
                }

                if (isStudent) {
                    studentId = currentUser.getUserId();
                }
            }
        }

        request.setAttribute("isEditAllowed", isEditAllowed);

        if (!isEditAllowed) {
            if (studentId == null) {
                response.sendRedirect(request.getContextPath() + "/course-detail?id=" + courseId);
                return;
            }

            courseitproject.service.IEnrollmentService enrollmentService = new courseitproject.service.EnrollmentServiceImp();
            if (!enrollmentService.isStudentEnrolled(studentId, courseId)) {
                response.sendRedirect(request.getContextPath() + "/course-detail?id=" + courseId);
                return;
            }
        }

        CourseDetailDTO dto = courseDetailService.getCourseDetail(courseId, studentId);

        if (dto == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Course not found");
            return;
        }

        request.setAttribute("courseDetail", dto);
        request.setAttribute("currentResource", currentResource);
        request.setAttribute("videoUrl", currentResource.getUrl());

        request.getRequestDispatcher("views/details/course-video.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
