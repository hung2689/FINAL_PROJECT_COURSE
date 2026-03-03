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

@WebServlet(name = "TeacherRegister", urlPatterns = {"/teacherRegister"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class TeacherRegister extends HttpServlet {

    private FileUploadService uploadService;
    private ITeacherService teacherService;

    @Override
    public void init() throws ServletException {
        uploadService = new FileUploadService(getServletContext());
        teacherService = new TeacherServiceImp();
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

        // JSP sẽ tự decide form hay success
        request.getRequestDispatcher("/views/auth/teacherRegisterCheck.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("USER");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ===== Parse dữ liệu an toàn =====
        String specialization = request.getParameter("specialization");

        int year = 0;
        try {
            year = Integer.parseInt(request.getParameter("year"));
        } catch (NumberFormatException e) {
            year = 0;
        }

        Part cvPart = request.getPart("cv");
        String cvUrl = null;

        if (cvPart != null && cvPart.getSize() > 0) {
            cvUrl = uploadService.uploadCv(cvPart);
        }

         Teacher t = new Teacher();
        t.setTeacherId(user.getUserId());
        t.setApprovalStatus("PENDING");
        t.setExperienceYear(year);
        t.setSpecialization(specialization);
        t.setCvUrl(cvUrl);

        teacherService.updateTeacher(t);

         session.setAttribute("PENDING_TEACHER", t);

         response.sendRedirect(request.getContextPath() + "/teacherRegister");
    }
}
