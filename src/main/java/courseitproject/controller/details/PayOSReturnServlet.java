package courseitproject.controller.details;

import courseitproject.model.CourseOrder;
import courseitproject.model.Users;
import courseitproject.service.CourseOrderService;
import courseitproject.service.EnrollmentServiceImp;
import courseitproject.utils.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/payos-return")
public class PayOSReturnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy trạng thái do payOS trả về
        String code = request.getParameter("code");
        String cancel = request.getParameter("cancel");
        String status = request.getParameter("status"); 
        String orderCodeStr = request.getParameter("orderCode");

        // Nếu mã = 00, không bị hủy, và trạng thái là PAID (Đã thanh toán)
        if ("00".equals(code) && "false".equals(cancel) && "PAID".equals(status)) {
            int orderId = Integer.parseInt(orderCodeStr);

            CourseOrderService orderService = new CourseOrderService();
            EnrollmentServiceImp enrollmentService = new EnrollmentServiceImp();

            CourseOrder order = orderService.findById(orderId);
            if (order != null && !"PAID".equals(order.getStatus())) {
                orderService.updateStatus(orderId, "PAID");
                enrollmentService.enrollFromOrder(orderId);
                
                // ==========================================
                // GỬI EMAIL THÔNG BÁO (Copy lại từ code cũ)
                // ==========================================
                HttpSession session = request.getSession();
                Users user = (Users) session.getAttribute("USER");
                
                if (user != null && user.getEmail() != null) {
                    String toEmail = user.getEmail();
                    String fullName = user.getFullName() != null ? user.getFullName() : user.getUsername();
                   long totalVND = (long) (order.getTotalAmount().doubleValue() * 25000);
String formattedAmount = String.format("%,d", totalVND);
                    
                    String subject = "Xác nhận thanh toán thành công - DevLearn";
                    String htmlBill = "<div style='font-family: Arial, sans-serif; padding: 20px; background-color: #f8f9fa;'>"
                            + "<div style='background-color: white; padding: 30px; border-radius: 12px; max-width: 500px; margin: auto; box-shadow: 0 4px 15px rgba(0,0,0,0.05);'>"
                            + "<h2 style='color: #10B981; text-align: center; margin-bottom: 20px;'>Payment Successful!</h2>"
                            + "<p style='color: #333;'>Hello <b>" + fullName + "</b>,</p>"
                            + "<p style='color: #555; line-height: 1.6;'>Thank you for enrolling in the course. Below are your invoice details:</p>"
                            + "<table style='width: 100%; border-collapse: collapse; margin-top: 20px; margin-bottom: 25px;'>"
                            + "<tr><td style='padding: 12px 0; border-bottom: 1px dashed #ccc; color: #666;'>Order ID:</td><td style='padding: 12px 0; border-bottom: 1px dashed #ccc; text-align: right; color: #333;'><b>#" + orderId + "</b></td></tr>"
                            + "<tr><td style='padding: 12px 0; border-bottom: 1px dashed #ccc; color: #666;'>Payment Method:</td><td style='padding: 12px 0; border-bottom: 1px dashed #ccc; text-align: right; color: #333;'><b>payOS (VietQR)</b></td></tr>"
                            + "<tr><td style='padding: 12px 0; border-bottom: 1px solid #eee; color: #333; font-weight: bold;'>Total Amount:</td><td style='padding: 12px 0; border-bottom: 1px solid #eee; text-align: right; color: #e11d48; font-size: 18px;'><b>" + formattedAmount + " VNĐ</b></td></tr>"
                            + "</table>"
                            + "</div></div>";

                    new Thread(() -> {
                        EmailUtil emailUtil = new EmailUtil();
                        emailUtil.sendHtml(toEmail, subject, htmlBill);
                    }).start();
                }
            }
            // Chuyển sang trang báo thành công của bạn
            response.sendRedirect(request.getContextPath() + "/payment-success");
        } else {
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}