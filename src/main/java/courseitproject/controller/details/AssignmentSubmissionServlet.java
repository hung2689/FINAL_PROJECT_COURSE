package courseitproject.controller.details;

import courseitproject.model.Users;
import courseitproject.service.AssignmentSubmissionService;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AssignmentSubmissionServlet", urlPatterns = { "/submitAssignment" })
public class AssignmentSubmissionServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(AssignmentSubmissionServlet.class.getName());
    private final AssignmentSubmissionService submissionService = new AssignmentSubmissionService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Users currentUser = (Users) request.getSession().getAttribute("USER");
        if (currentUser == null) {
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "Vui lòng đăng nhập trước khi nộp bài.");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print(err.toString());
            return;
        }

        // Validate assignmentId
        String assignmentIdStr = request.getParameter("assignmentId");
        if (assignmentIdStr == null || assignmentIdStr.isEmpty()) {
            LOG.warning("[Servlet] Missing assignmentId parameter");
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "Assignment ID is required");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(err.toString());
            return;
        }

        final int assignmentId;
        try {
            assignmentId = Integer.parseInt(assignmentIdStr);
        } catch (NumberFormatException e) {
            LOG.warning("[Servlet] Invalid assignmentId: " + assignmentIdStr);
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "Invalid assignment ID");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(err.toString());
            return;
        }

        // Validate githubUrl
        String githubUrlRaw = request.getParameter("githubUrl");
        if (githubUrlRaw == null || githubUrlRaw.trim().isEmpty()) {
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "GitHub URL is required");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(err.toString());
            return;
        }
        final String githubUrl = githubUrlRaw.trim();

        // Basic URL validation
        if (!githubUrl.startsWith("https://github.com/")) {
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "Vui lòng nhập URL GitHub hợp lệ (bắt đầu bằng https://github.com/)");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(err.toString());
            return;
        }

        // studentId == userId (Student table uses user_id as PK via 1-1 mapping)
        final int studentId = currentUser.getUserId();

        LOG.info("[Servlet] Starting submission: studentId=" + studentId
                + ", assignmentId=" + assignmentId + ", url=" + githubUrl);

        try {
            // Create the submission record synchronously, then process asynchronously
            int submissionId = submissionService.createSubmission(studentId, assignmentId, githubUrl);

            if (submissionId <= 0) {
                JsonObject err = new JsonObject();
                err.addProperty("status", "error");
                err.addProperty("message", "Không thể tạo bài nộp. Vui lòng kiểm tra thông tin và thử lại.");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print(err.toString());
                return;
            }

            // Process grading asynchronously in a new thread
            new Thread(() -> {
                try {
                    submissionService.processSubmissionAsync(submissionId);
                } catch (Exception e) {
                    LOG.log(Level.SEVERE, "[Servlet] Async grading error for submission " + submissionId, e);
                }
            }).start();

            // Respond immediately with the submission ID
            JsonObject success = new JsonObject();
            success.addProperty("status", "success");
            success.addProperty("submissionId", submissionId);
            success.addProperty("message", "Đã nhận bài nộp, đang chấm điểm...");
            out.print(success.toString());

        } catch (Exception e) {
            LOG.log(Level.SEVERE, "[Servlet] Error creating submission", e);
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(err.toString());
        }
    }
}
