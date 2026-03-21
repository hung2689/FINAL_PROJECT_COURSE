package courseitproject.controller.details;

import courseitproject.model.CourseOrder;
import courseitproject.model.Users;
import courseitproject.service.CourseOrderService;
import courseitproject.service.EnrollmentServiceImp;
import courseitproject.utils.EmailUtil;
import courseitproject.utils.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/payos-return")
public class PayOSReturnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Validate incoming parameters
        String code = request.getParameter("code");
        String cancel = request.getParameter("cancel");
        String status = request.getParameter("status");
        String orderCodeStr = request.getParameter("orderCode");

        if (code == null || cancel == null || status == null || orderCodeStr == null) {
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        // 2. Process if payment is successful
        if ("00".equals(code) && "false".equals(cancel) && "PAID".equals(status)) {

            int orderId;
            try {
                orderId = Integer.parseInt(orderCodeStr);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/checkout");
                return;
            }

            // Obtain services
            CourseOrderService orderService = new CourseOrderService();
            EnrollmentServiceImp enrollmentService = new EnrollmentServiceImp();

            // Retrieve Order
            CourseOrder order = orderService.findById(orderId);

            // Check Idempotency: Ignore if it's already PAID
            if (order != null && !"PAID".equals(order.getStatus())) {

                // Create Payment Record
                orderService.createPayment(
                        orderId,
                        order.getTotalAmount(),
                        "PAYOS",
                        "SUCCESS");

                // Update Order Status
                orderService.updateStatus(orderId, "PAID");

                // Trigger Enrollment process
                enrollmentService.enrollFromOrder(orderId);

                // ==========================================
                // SEND EMAIL RECEIPT
                // Without relying on HttpSession to get User
                // ==========================================
                sendReceiptEmailBackground(order, orderId);
            }

            // Redirect to Success Page regardless
            response.sendRedirect(request.getContextPath() + "/payment-success");
        } else {
            // Revert back to checkout if canceled or failed
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }

    private void sendReceiptEmailBackground(CourseOrder order, int orderId) {
        new Thread(() -> {
    
        }).start();
    }
}