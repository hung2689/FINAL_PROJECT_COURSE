package courseitproject.controller.details;

import courseitproject.dao.RepoSubmissionDAO;
import courseitproject.model.RepoFileAnalysis;
import courseitproject.model.RepoSubmission;
import courseitproject.model.Users;
import courseitproject.utils.JPAUtil;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.logging.Logger;

@WebServlet(name = "SubmissionStatusServlet", urlPatterns = { "/submissionStatus" })
public class SubmissionStatusServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(SubmissionStatusServlet.class.getName());
    private final RepoSubmissionDAO submissionDAO = new RepoSubmissionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Users currentUser = (Users) request.getSession().getAttribute("USER");
        if (currentUser == null) {
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "Unauthorized");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print(err.toString());
            return;
        }

        String submissionIdStr = request.getParameter("id");
        if (submissionIdStr == null || submissionIdStr.isEmpty()) {
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "Submission ID is required");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(err.toString());
            return;
        }

        int submissionId;
        try {
            submissionId = Integer.parseInt(submissionIdStr);
        } catch (NumberFormatException e) {
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "Invalid submission ID");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(err.toString());
            return;
        }

        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Force fresh read from DB (not from Hibernate cache)
            em.clear();
            RepoSubmission submission = submissionDAO.findById(em, submissionId);

            if (submission == null) {
                JsonObject err = new JsonObject();
                err.addProperty("status", "error");
                err.addProperty("message", "Submission not found");
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print(err.toString());
                return;
            }

            // Security: only allow the owner to check their submission
            if (submission.getStudentId() == null || submission.getStudentId().getStudentId() == null 
                || !submission.getStudentId().getStudentId().equals(currentUser.getUserId())) {
                JsonObject err = new JsonObject();
                err.addProperty("status", "error");
                err.addProperty("message", "Access denied");
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                out.print(err.toString());
                return;
            }

            JsonObject result = new JsonObject();
            result.addProperty("submissionId", submission.getSubmissionId());
            result.addProperty("submissionStatus", submission.getStatus());
            result.addProperty("githubUrl", submission.getGithubUrl());

            boolean isDone = "DONE".equals(submission.getStatus());
            boolean isFailed = "FAILED".equals(submission.getStatus());

            result.addProperty("completed", isDone || isFailed);

            if (isDone || isFailed) {
                result.addProperty("score", submission.getScore() != null ? submission.getScore() : 0);
                result.addProperty("feedback", submission.getFeedback() != null ? submission.getFeedback() : "");

                // Include file-by-file analysis results
                Collection<RepoFileAnalysis> fileAnalyses = submission.getRepoFileAnalysisCollection();
                JsonArray filesArray = new JsonArray();

                if (fileAnalyses != null) {
                    for (RepoFileAnalysis fa : fileAnalyses) {
                        JsonObject fileObj = new JsonObject();
                        fileObj.addProperty("fileName", fa.getFileName());
                        fileObj.addProperty("summary", fa.getSummary() != null ? fa.getSummary() : "");
                        fileObj.addProperty("aiScore", fa.getAiScore() != null ? fa.getAiScore() : 0);
                        filesArray.add(fileObj);
                    }
                }
                result.add("fileAnalyses", filesArray);
                result.addProperty("totalFiles", filesArray.size());
            }

            result.addProperty("status", "success");
            out.print(result.toString());

        } catch (Exception e) {
            LOG.severe("[SubmissionStatus] Error: " + e.getMessage());
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", "Internal server error");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(err.toString());
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
