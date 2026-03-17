package courseitproject.service;

import courseitproject.dao.RepoSubmissionDAO;
import courseitproject.model.Assignment;
import courseitproject.model.RepoFileAnalysis;
import courseitproject.model.RepoSubmission;
import courseitproject.model.Student;
import courseitproject.utils.GitCloneUtil;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;

import java.io.File;
import java.util.Date;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AssignmentSubmissionService {

    private static final Logger LOG = Logger.getLogger(AssignmentSubmissionService.class.getName());

    // Safe maximum lengths to avoid SQL Server "string or binary data would be truncated" errors.
    // These should be less than or equal to the corresponding NVARCHAR column sizes.
    private static final int MAX_DB_SUMMARY_LENGTH = 2000000;
    private static final int MAX_DB_FEEDBACK_LENGTH = 2000000;

    private final RepoSubmissionDAO submissionDAO = new RepoSubmissionDAO();
    private final CodeScannerService codeScanner = new CodeScannerService();
    private final GeminiService geminiService = new GeminiService();

    /**
     * Create a new submission record and return its ID.
     * This runs synchronously so the servlet can immediately return the ID.
     */
    public int createSubmission(int studentId, int assignmentId, String githubUrl) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            Student student = em.find(Student.class, studentId);
            if (student == null) {
                LOG.severe("[Submission] Student not found: " + studentId);
                em.getTransaction().rollback();
                return -1;
            }

            Assignment assignment = em.find(Assignment.class, assignmentId);
            if (assignment == null) {
                LOG.severe("[Submission] Assignment not found: " + assignmentId);
                em.getTransaction().rollback();
                return -1;
            }

            RepoSubmission submission = new RepoSubmission();
            submission.setGithubUrl(githubUrl);
            submission.setStatus("PENDING");
            submission.setSubmittedAt(new Date());
            submission.setStudentId(student);
            submission.setAssignmentId(assignment);

            submissionDAO.save(em, submission);
            em.getTransaction().commit();

            LOG.info("[Submission] Created submission ID: " + submission.getSubmissionId());
            return submission.getSubmissionId();

        } catch (Exception e) {
            LOG.log(Level.SEVERE, "[Submission] Error creating submission", e);
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            return -1;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Process the submission asynchronously (clone, scan, grade).
     * This updates the submission status as it progresses.
     */
    public void processSubmissionAsync(int submissionId) {
        String repoPath = null;
        String githubUrl;
        Assignment assignment;

        // 1. Initial read and validation
        EntityManager em = JPAUtil.getEntityManager();
        try {
            RepoSubmission submission = em.find(RepoSubmission.class, submissionId);
            if (submission == null) {
                LOG.severe("[Submission] Submission not found for async processing: " + submissionId);
                return;
            }
            githubUrl = submission.getGithubUrl();
            assignment = submission.getAssignmentId();
        } finally {
            if (em.isOpen()) {
                em.close();
            }
        }

        LOG.info("[Submission] Starting async processing for submission " + submissionId);

        try {
            // ===== 1. Clone GitHub repository =====
            updateStatus(submissionId, "CLONING");

            repoPath = System.getProperty("java.io.tmpdir") + File.separator
                    + "repos" + File.separator + "submission_" + submissionId;

            LOG.info("[Submission] Cloning repository to: " + repoPath);
            boolean cloned = GitCloneUtil.cloneRepository(githubUrl, repoPath);

            if (!cloned) {
                LOG.warning("[Submission] Clone FAILED for URL: " + githubUrl);
                failSubmission(submissionId, "Failed to clone GitHub repository. Please verify the URL is public and correct.");
                return;
            }
            LOG.info("[Submission] Clone successful.");

            // ===== 2. Scan source code files =====
            updateStatus(submissionId, "ANALYZING");

            String extensions = assignment.getFileExtensions();
            LOG.info("[Submission] Scanning files with extensions: " + extensions);

            Map<String, String> files = codeScanner.scanRepositoryFiles(repoPath, extensions);
            LOG.info("[Submission] Found " + files.size() + " source files to analyze.");

            if (files.isEmpty()) {
                LOG.warning("[Submission] No matching source files found.");
                failSubmission(submissionId, "No matching source files found in the repository. Expected file types: " 
                        + (extensions != null ? extensions : ".java,.jsp,.html,.js,.css"));
                return;
            }

            // ===== 3. Analyze each file with AI =====
            updateStatus(submissionId, "GRADING");
            StringBuilder allSummaries = new StringBuilder();

            for (Map.Entry<String, String> entry : files.entrySet()) {
                String fileName = entry.getKey();
                String fileContent = entry.getValue();

                LOG.info("[Submission] Analyzing file: " + fileName + " (" + fileContent.length() + " chars)");

                GeminiService.FileAnalysisResult result = geminiService.analyzeCodeFile(fileName, fileContent);

                // Save file analysis
                saveFileAnalysis(submissionId, fileName, result.getSummary(), result.getScore());

                allSummaries.append("FILE: ").append(fileName)
                        .append("\nSCORE: ").append(result.getScore())
                        .append("\nSUMMARY: ").append(result.getSummary()).append("\n\n");
            }

            // ===== 4. Final grading =====
            LOG.info("[Submission] Starting final grading...");

            String criteriaStr = assignment.getCriteria() != null ? assignment.getCriteria()
                    : "Check code completeness, correctness, and code quality.";
            String descStr = assignment.getDescription() != null ? assignment.getDescription() : "";
            String expectedStr = assignment.getExpectedOutput() != null ? assignment.getExpectedOutput() : "";

            GeminiService.GradingResult gradingResult = geminiService.gradeAssignment(
                    descStr, expectedStr, criteriaStr, allSummaries.toString());

            LOG.info("[Submission] Grading complete! Score: " + gradingResult.getScore());

            // ===== 5. Save final result =====
            finishSubmission(submissionId, gradingResult.getScore(), gradingResult.getFeedback());

            LOG.info("[Submission] Processing completed successfully for submission " + submissionId);

        } catch (Exception e) {
            LOG.log(Level.SEVERE, "[Submission] EXCEPTION during processing", e);
            failSubmission(submissionId, "An unexpected error occurred during grading: " + e.getMessage());
        } finally {
            // Cleanup cloned repository
            if (repoPath != null) {
                try {
                    File repoDir = new File(repoPath);
                    if (repoDir.exists()) {
                        GitCloneUtil.deleteDirectory(repoDir);
                        LOG.info("[Submission] Cleaned up repo at: " + repoPath);
                    }
                } catch (Exception cleanupEx) {
                    LOG.log(Level.WARNING, "[Submission] Failed to cleanup repo", cleanupEx);
                }
            }
        }
    }

    private void updateStatus(int submissionId, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            RepoSubmission submission = em.find(RepoSubmission.class, submissionId);
            if (submission != null) {
                submission.setStatus(status);
                submissionDAO.update(em, submission);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            LOG.severe("Failed to update status to " + status + ": " + e.getMessage());
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    private void saveFileAnalysis(int submissionId, String fileName, String fileSummary, Integer score) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String safeSummary = truncateForDb(fileSummary, MAX_DB_SUMMARY_LENGTH);

            em.getTransaction().begin();
            RepoSubmission submission = em.find(RepoSubmission.class, submissionId);
            if (submission != null) {
                RepoFileAnalysis fileAnalysis = new RepoFileAnalysis();
                fileAnalysis.setFileName(fileName);
                fileAnalysis.setSummary(safeSummary);
                fileAnalysis.setAiScore(score);
                fileAnalysis.setSubmissionId(submission);
                em.persist(fileAnalysis);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            LOG.severe("Failed to save file analysis: " + e.getMessage());
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    private void failSubmission(int submissionId, String feedback) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String safeFeedback = truncateForDb(feedback, MAX_DB_FEEDBACK_LENGTH);

            em.getTransaction().begin();
            RepoSubmission submission = em.find(RepoSubmission.class, submissionId);
            if (submission != null) {
                submission.setStatus("FAILED");
                submission.setFeedback(safeFeedback);
                submissionDAO.update(em, submission);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            LOG.severe("Failed to mark submission as FAILED: " + e.getMessage());
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    private void finishSubmission(int submissionId, int score, String feedback) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String safeFeedback = truncateForDb(feedback, MAX_DB_FEEDBACK_LENGTH);

            em.getTransaction().begin();
            RepoSubmission submission = em.find(RepoSubmission.class, submissionId);
            if (submission != null) {
                submission.setStatus("DONE");
                submission.setScore(score);
                submission.setFeedback(safeFeedback);
                submissionDAO.update(em, submission);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            LOG.severe("Failed to finish submission: " + e.getMessage());
            // As a safety net, ensure the submission is not left in a non-terminal state.
            try {
                failSubmission(submissionId, "Grading completed but failed to save feedback: " + e.getMessage());
            } catch (Exception ignored) {
                // If even marking FAILED fails, we have already logged the original error.
            }
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    /**
     * Truncate a string to fit safely into a database text column.
     */
    private String truncateForDb(String value, int maxLength) {
        if (value == null) {
            return null;
        }
        if (value.length() <= maxLength) {
            return value;
        }
        return value.substring(0, maxLength);
    }

    /**
     * Legacy method - kept for backward compatibility.
     */
    public boolean processSubmission(int studentId, int assignmentId, String githubUrl) {
        int submissionId = createSubmission(studentId, assignmentId, githubUrl);
        if (submissionId <= 0) {
            return false;
        }
        processSubmissionAsync(submissionId);
        // Check result
        EntityManager em = JPAUtil.getEntityManager();
        try {
            RepoSubmission sub = em.find(RepoSubmission.class, submissionId);
            return sub != null && "DONE".equals(sub.getStatus());
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
