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
 
       

        Part cvPart = request.getPart("cv");
        String cvUrl = null;

        if (cvPart != null && cvPart.getSize() > 0) {
            cvUrl = uploadService.uploadCv(cvPart);
        }

         Teacher t = new Teacher();
        t.setTeacherId(user.getUserId());
        t.setApprovalStatus("PENDING");
         t.setCvUrl(cvUrl);

        teacherService.updateTeacher(t);
        sendWebhook(request, response, user.getFullName(), user.getEmail(), cvUrl);
         session.setAttribute("PENDING_TEACHER", t);

         response.sendRedirect(request.getContextPath() + "/teacherRegister");
    }
    
     protected void sendWebhook (HttpServletRequest request, HttpServletResponse response,String name,String email,String cvUrl)
            throws ServletException, IOException {

       request.setCharacterEncoding("UTF-8");

       
        try {

            String webhookUrl = "http://localhost:5678/webhook/teacher-apply";

            URL url = new URL(webhookUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            String jsonInputString =
                    "{"
                            + "\"name\":\"" + name + "\","
                            + "\"email\":\"" + email + "\","
                            + "\"cv_url\":\"" + cvUrl + "\""
                            + "}";

            OutputStream os = conn.getOutputStream();
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);

            int responseCode = conn.getResponseCode();

            System.out.println("Send to n8n webhook");
            System.out.println("Response Code: " + responseCode);

            conn.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
