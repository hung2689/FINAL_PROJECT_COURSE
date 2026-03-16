/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.admin;

import courseitproject.dto.CandidateDTO;
import courseitproject.service.CandidateServiceImp;
import courseitproject.service.ICandidateService;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CadidatesAdminServlet", urlPatterns = { "/candidatesAdmin" })
public class CadidatesAdminServlet extends HttpServlet {

    private final ICandidateService candidateService = new CandidateServiceImp();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filter = request.getParameter("filter");
        if (filter == null) {
            filter = "Waiting";
        }

        List<CandidateDTO> allCandidates = candidateService.getCandidates();
        List<CandidateDTO> filteredCandidates = new ArrayList<>();

        for (CandidateDTO c : allCandidates) {
            String status = c.getStatus() == null ? "PENDING" : c.getStatus();
            if ("All".equals(filter)) {
                filteredCandidates.add(c);
            } else if ("Waiting".equals(filter) && "PENDING".equalsIgnoreCase(status)) {
                filteredCandidates.add(c);
            } else if ("Interview".equals(filter) && "INTERVIEWING".equalsIgnoreCase(status)) {
                filteredCandidates.add(c);
            } else if ("Accept".equals(filter) && "APPROVED".equalsIgnoreCase(status)) {
                filteredCandidates.add(c);
            } else if ("Reject".equals(filter) && "REJECTED".equalsIgnoreCase(status)) {
                filteredCandidates.add(c);
            }
        }

        int pageSize = 10;
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int totalCandidates = filteredCandidates.size();
        int totalPages = (int) Math.ceil((double) totalCandidates / pageSize);
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        }

        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalCandidates);

        List<CandidateDTO> pagedCandidates = new ArrayList<>();
        if (startIndex < totalCandidates) {
            pagedCandidates = filteredCandidates.subList(startIndex, endIndex);
        }

        request.setAttribute("candidatesList", pagedCandidates);
        request.setAttribute("currentFilter", filter);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCandidates", totalCandidates);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("startIndex", startIndex);
        request.setAttribute("endIndex", endIndex);

        long waitingCount = candidateService.countWaitingCandidates();
        long interviewingCount = candidateService.countInterviewingCandidates();
        long acceptedCount = candidateService.countAcceptedCandidates();
        long rejectedCount = candidateService.countRejectedCandidates();

        request.setAttribute("waitingCount", waitingCount);
        request.setAttribute("interviewingCount", interviewingCount);
        request.setAttribute("acceptedCount", acceptedCount);
        request.setAttribute("rejectedCount", rejectedCount);

        request.getRequestDispatcher("/views/admin/candidates/candidatesManagement.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String candidateIdStr = request.getParameter("candidateId");

        if (action != null && candidateIdStr != null) {
            try {
                int candidateId = Integer.parseInt(candidateIdStr);
                boolean success = false;

                if ("approve".equals(action)) {
                    success = candidateService.approveCandidate(candidateId);
                    if (success) {
                        request.getSession().setAttribute("SUCCESS", "Candidate approved successfully.");
                    } else {
                        request.getSession().setAttribute("ERROR", "Failed to approve candidate.");
                    }
                } else if ("reject".equals(action)) {
                    success = candidateService.rejectCandidate(candidateId);
                    if (success) {
                        request.getSession().setAttribute("SUCCESS", "Candidate rejected successfully.");
                    } else {
                        request.getSession().setAttribute("ERROR", "Failed to reject candidate.");
                    }
                } else if ("scheduleInterview".equals(action)) {
                    String interviewDate = request.getParameter("interviewDate");
                    String interviewTime = request.getParameter("interviewTime");
                    if (interviewDate != null && interviewTime != null) {
                        LocalDateTime dateTime = LocalDateTime.parse(interviewDate + "T" + interviewTime,
                                DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                        success = candidateService.scheduleInterview(candidateId, dateTime);
                        if (success) {
                            request.getSession().setAttribute("SUCCESS",
                                    "Interview scheduled successfully and email sent.");
                        } else {
                            request.getSession().setAttribute("ERROR", "Failed to schedule interview.");
                        }
                    } else {
                        request.getSession().setAttribute("ERROR", "Invalid date or time.");
                    }
                }
            } catch (Exception e) {
                request.getSession().setAttribute("ERROR", "Error configuring candidate.");
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/candidatesAdmin");
    }

}
