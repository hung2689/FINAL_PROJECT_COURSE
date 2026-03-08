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
                : currentResource.getLessonId().getSectionId().getCourseId().getCourseId();

        Integer studentId = null;
        HttpSession session = request.getSession(false);
        if (session != null) {
            Users currentUser = (Users) session.getAttribute("user");
            if (currentUser != null) {
                boolean isStudent = false;
                if (currentUser.getUserRoleCollection() != null) {
                    for (UserRole ur : currentUser.getUserRoleCollection()) {
                        if (ur.getRoleId() != null && "STUDENT".equals(ur.getRoleId().getRoleName())) {
                            isStudent = true;
                            break;
                        }
                    }
                }

                if (isStudent) {
                    studentId = currentUser.getUserId();
                }
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
