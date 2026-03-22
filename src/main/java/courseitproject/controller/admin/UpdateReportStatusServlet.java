package courseitproject.controller.admin;

import courseitproject.dao.ErrorreportsDAOImpl;
import courseitproject.dao.IErrorreportsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateReportStatusServlet", urlPatterns = {"/update-report-status"})
public class UpdateReportStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String reportIdStr = request.getParameter("reportId");
        
        if (reportIdStr != null && !reportIdStr.isEmpty()) {
            try {
                int reportId = Integer.parseInt(reportIdStr);
                IErrorreportsDAO dao = new ErrorreportsDAOImpl();
                // Admin clicks "Mark as Resolved", so we update status to RESOLVED
                dao.updateStatus(reportId, "RESOLVED");
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // Redirect back to the support management page
        response.sendRedirect(request.getContextPath() + "/admin-support");
    }
}
