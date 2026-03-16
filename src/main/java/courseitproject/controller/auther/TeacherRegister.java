package courseitproject.controller.auther;

import courseitproject.model.Teacher;
import courseitproject.model.Users;
import courseitproject.service.FileUploadService;
import courseitproject.service.ITeacherService;
import courseitproject.service.TeacherServiceImp;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Legacy teacher register servlet.
 * This flow has been deprecated in favor of the new Teacher Recruitment system.
 * Any access to this servlet will be redirected to the teacher jobs listing.
 */
@WebServlet(name = "TeacherRegister", urlPatterns = {"/teacherRegister"})
public class TeacherRegister extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/teacher-jobs");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/teacher-jobs");
    }
}
