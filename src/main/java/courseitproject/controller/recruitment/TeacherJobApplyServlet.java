package courseitproject.controller.recruitment;

import courseitproject.model.TeacherJob;
import courseitproject.model.Users;
import courseitproject.service.FileUploadService;
import courseitproject.service.ITeacherJobService;
import courseitproject.service.TeacherJobApplyService;
import courseitproject.service.TeacherJobServiceImp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet(name = "TeacherJobApplyServlet", urlPatterns = {"/teacher-apply"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class TeacherJobApplyServlet extends HttpServlet {

    private FileUploadService uploadService;
    private final ITeacherJobService teacherJobService = new TeacherJobServiceImp();
    private final TeacherJobApplyService applyService = new TeacherJobApplyService();

    @Override
    public void init() throws ServletException {
        uploadService = new FileUploadService(getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("USER");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String jobIdStr = req.getParameter("jobId");
        if (jobIdStr == null) {
            resp.sendRedirect(req.getContextPath() + "/teacher-jobs");
            return;
        }

        int jobId = Integer.parseInt(jobIdStr);
        TeacherJob job = teacherJobService.findById(jobId);
        if (job == null) {
            resp.sendRedirect(req.getContextPath() + "/teacher-jobs");
            return;
        }

        req.setAttribute("job", job);
        req.getRequestDispatcher("/views/recruitment/teacher-apply.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("USER");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String jobIdStr = req.getParameter("jobId");
        if (jobIdStr == null) {
            resp.sendRedirect(req.getContextPath() + "/teacher-jobs");
            return;
        }
        int jobId = Integer.parseInt(jobIdStr);
        TeacherJob job = teacherJobService.findById(jobId);
        if (job == null) {
            resp.sendRedirect(req.getContextPath() + "/teacher-jobs");
            return;
        }

        Part cvPart = req.getPart("cv");
        String cvUrl = null;
        if (cvPart != null && cvPart.getSize() > 0) {
            cvUrl = uploadService.uploadCv(cvPart);
        }

        boolean success = applyService.applyForJob(user, job, cvUrl);
        if (success) {
            sendWebhook(user, cvUrl, job);
            session.setAttribute("toastType", "success");
            session.setAttribute("toastMsg", "Your application has been submitted.");
        } else {
            session.setAttribute("toastType", "error");
            session.setAttribute("toastMsg", "You have already applied for this job.");
        }
        resp.sendRedirect(req.getContextPath() + "/teacher-jobs");
    }

    private void sendWebhook(Users user, String cvUrl, TeacherJob jobId) {
        try {
            String webhookUrl = "https://monocular-valene-oversocially.ngrok-free.dev/webhook/teacher-apply";

            URL url = new URL(webhookUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // Use Gson to properly escape HTML and special characters
            com.google.gson.JsonObject json = new com.google.gson.JsonObject();
            json.addProperty("name", user.getFullName());
            json.addProperty("user_id", user.getUserId());
            json.addProperty("email", user.getEmail());
            json.addProperty("cv_url", cvUrl != null ? cvUrl : "");
            json.addProperty("job_category", jobId.getJobCategory());
            json.addProperty("description", jobId.getDescription());
            json.addProperty("job_id", jobId.getJobId());
            json.addProperty("requirements", jobId.getRequirements());

            String jsonInputString = json.toString();

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            System.out.println("Send to n8n webhook - response code: " + responseCode);
            conn.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
