package courseitproject.controller.details;

import courseitproject.utils.PayOSUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/payos-payment")
public class PayOSPaymentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thông tin đơn hàng từ giao diện Checkout JSP
        String orderIdStr = request.getParameter("orderId");
        String amountStr = request.getParameter("amount");

        if (orderIdStr == null || amountStr == null) {
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);
        // Chú ý: Tiền của payOS là VND chuẩn, không cần nhân hay chia 100 như VNPAY
        int amount = Integer.parseInt(amountStr); 
        String description = "Thanh toan DH " + orderId;

        // CHÚ Ý: Đổi chữ "courseitproject" cho khớp chính xác với URL trình duyệt của bạn (hoa/thường)
        String returnUrl = "http://localhost:9999/CourseITProject/payos-return";
        String cancelUrl = "http://localhost:9999/CourseITProject/checkout";

        // Tạo link
        String checkoutUrl = PayOSUtil.createPaymentLink(orderId, amount, description, returnUrl, cancelUrl);

        if (checkoutUrl != null) {
            // Chuyển hướng sang màn hình QR của payOS
            response.sendRedirect(checkoutUrl); 
        } else {
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}