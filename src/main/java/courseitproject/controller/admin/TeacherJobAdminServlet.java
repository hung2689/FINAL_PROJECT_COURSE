package courseitproject.controller.admin;

import courseitproject.model.TeacherJob;
import courseitproject.service.ITeacherJobService;
import courseitproject.service.TeacherJobServiceImp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "TeacherJobAdminServlet", urlPatterns = {"/jobAdmin"})
public class TeacherJobAdminServlet extends HttpServlet {

    private ITeacherJobService jobService;

    @Override
    public void init() {
        jobService = new TeacherJobServiceImp();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "getById":
                getJobById(request, response);
                break;
            default:
                listJobs(request, response);
        }
    }

    protected void listJobs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int pageSize = 10;
            int currentPage = 1;
            String pageParam = request.getParameter("page");

            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) currentPage = 1;
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            long totalJobs = jobService.countAllJobs();
            int totalPages = (int) Math.ceil((double) totalJobs / pageSize);

            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }

            List<TeacherJob> jobs = jobService.findAllJobsPaging(currentPage, pageSize);

            // Count by status
            List<TeacherJob> allJobs = jobService.findAllJobs();
            long openCount = allJobs.stream()
                    .filter(j -> j.getStatus() == null || "OPEN".equalsIgnoreCase(j.getStatus()))
                    .count();
            long closedCount = allJobs.stream()
                    .filter(j -> "CLOSED".equalsIgnoreCase(j.getStatus()))
                    .count();

            request.setAttribute("jobs", jobs);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalJobs", totalJobs);
            request.setAttribute("openCount", openCount);
            request.setAttribute("closedCount", closedCount);

            request.getRequestDispatcher("/views/admin/jobs/jobManagement.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.toString());
            request.getRequestDispatcher("/views/admin/jobs/jobManagement.jsp")
                    .forward(request, response);
        }
    }

    protected void getJobById(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String rawId = request.getParameter("id");
            int id = Integer.parseInt(rawId);
            TeacherJob job = jobService.findById(id);

            if (job == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();

            String json = "{"
                    + "\"jobId\":" + job.getJobId() + ","
                    + "\"title\":\"" + escapeJson(job.getTitle()) + "\","
                    + "\"description\":\"" + escapeJson(job.getDescription()) + "\","
                    + "\"location\":\"" + escapeJson(job.getLocation()) + "\","
                    + "\"jobType\":\"" + escapeJson(job.getJobType()) + "\","
                    + "\"salaryMin\":" + (job.getSalaryMin() != null ? job.getSalaryMin() : "null") + ","
                    + "\"salaryMax\":" + (job.getSalaryMax() != null ? job.getSalaryMax() : "null") + ","
                    + "\"salaryUnit\":\"" + escapeJson(job.getSalaryUnit()) + "\","
                    + "\"status\":\"" + escapeJson(job.getStatus()) + "\","
                    + "\"requirements\":\"" + escapeJson(job.getRequirements()) + "\","
                    + "\"benefits\":\"" + escapeJson(job.getBenefits()) + "\","
                    + "\"jobCategory\":\"" + escapeJson(job.getJobCategory()) + "\""
                    + "}";
            out.print(json);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                postAddJob(request, response);
                break;
            case "update":
                postUpdateJob(request, response);
                break;
            case "delete":
                postDeleteJob(request, response);
                break;
            default:
                listJobs(request, response);
        }
    }

    protected void postAddJob(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            TeacherJob job = new TeacherJob();
            job.setTitle(request.getParameter("title"));
            job.setDescription(request.getParameter("description"));
            job.setLocation(request.getParameter("location"));
            job.setJobType(request.getParameter("jobType"));
            job.setJobCategory(request.getParameter("jobCategory"));
            job.setRequirements(request.getParameter("requirements"));
            job.setBenefits(request.getParameter("benefits"));
            job.setStatus(request.getParameter("status"));

            String salaryMinRaw = request.getParameter("salaryMin");
            String salaryMaxRaw = request.getParameter("salaryMax");
            if (salaryMinRaw != null && !salaryMinRaw.isEmpty()) {
                job.setSalaryMin(new BigDecimal(salaryMinRaw));
            }
            if (salaryMaxRaw != null && !salaryMaxRaw.isEmpty()) {
                job.setSalaryMax(new BigDecimal(salaryMaxRaw));
            }
            job.setSalaryUnit(request.getParameter("salaryUnit"));

            jobService.createJob(job);
            request.getSession().setAttribute("SUCCESS", "Job created successfully!");
            response.sendRedirect(request.getContextPath() + "/jobAdmin");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Failed to create job: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/jobAdmin");
        }
    }

    protected void postUpdateJob(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String jobIdRaw = request.getParameter("jobId");
            if (jobIdRaw == null || jobIdRaw.trim().isEmpty()) {
                throw new Exception("Job ID is required");
            }
            int jobId = Integer.parseInt(jobIdRaw);
            TeacherJob job = jobService.findById(jobId);
            if (job == null) {
                throw new Exception("Job not found");
            }

            job.setTitle(request.getParameter("title"));
            job.setDescription(request.getParameter("description"));
            job.setLocation(request.getParameter("location"));
            job.setJobType(request.getParameter("jobType"));
            job.setJobCategory(request.getParameter("jobCategory"));
            job.setRequirements(request.getParameter("requirements"));
            job.setBenefits(request.getParameter("benefits"));
            job.setStatus(request.getParameter("status"));

            String salaryMinRaw = request.getParameter("salaryMin");
            String salaryMaxRaw = request.getParameter("salaryMax");
            if (salaryMinRaw != null && !salaryMinRaw.isEmpty()) {
                job.setSalaryMin(new BigDecimal(salaryMinRaw));
            } else {
                job.setSalaryMin(null);
            }
            if (salaryMaxRaw != null && !salaryMaxRaw.isEmpty()) {
                job.setSalaryMax(new BigDecimal(salaryMaxRaw));
            } else {
                job.setSalaryMax(null);
            }
            job.setSalaryUnit(request.getParameter("salaryUnit"));

            jobService.updateJob(job);
            request.getSession().setAttribute("SUCCESS", "Job updated successfully!");
            response.sendRedirect(request.getContextPath() + "/jobAdmin");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Failed to update job: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/jobAdmin");
        }
    }

    protected void postDeleteJob(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String rawId = request.getParameter("jobId");
            if (rawId == null || rawId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/jobAdmin");
                return;
            }
            int jobId = Integer.parseInt(rawId);
            jobService.deleteJob(jobId);
            request.getSession().setAttribute("SUCCESS", "Job deleted successfully!");
            response.sendRedirect(request.getContextPath() + "/jobAdmin");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Failed to delete job: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/jobAdmin");
        }
    }

    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                     .replace("\"", "\\\"")
                     .replace("\n", "\\n")
                     .replace("\r", "\\r")
                     .replace("\t", "\\t");
    }
}
