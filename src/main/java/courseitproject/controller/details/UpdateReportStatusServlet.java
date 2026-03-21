/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package courseitproject.controller.details;

import courseitproject.dao.ErrorreportsDAOImpl;
import courseitproject.dao.IErrorreportsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Lenovo
 */
@WebServlet(name="UpdateReportStatusServlet", urlPatterns={"/update-report-status"})
public class UpdateReportStatusServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateReportStatusServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateReportStatusServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);
try {
            // 1. Lấy ID của lỗi từ cái Form ẩn trong Modal gửi lên
            String reportIdStr = request.getParameter("reportId");
            
            if (reportIdStr != null && !reportIdStr.isEmpty()) {
                int reportId = Integer.parseInt(reportIdStr);

                // 2. Gọi DAO để cập nhật trạng thái
                IErrorreportsDAO dao = new ErrorreportsDAOImpl();
                
                // CẬP NHẬT TRẠNG THÁI THÀNH "RESOLVED"
                // (Bạn kiểm tra xem trong DAO của bạn đã có hàm updateStatus chưa nhé)
                dao.updateStatus(reportId, "RESOLVED"); 
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi khi update status: " + e.getMessage());
        }

        // 3. Xử lý xong thì "đá" người dùng về lại trang danh sách lỗi
        response.sendRedirect(request.getContextPath() + "/admin-support");
    }
    

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
