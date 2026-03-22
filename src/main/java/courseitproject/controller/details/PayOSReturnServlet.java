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

                // Add Reward Study Coins
                try {
                    if (order.getStudentId() != null && order.getStudentId().getUsers() != null) {
                        Users user = order.getStudentId().getUsers();
                        int bonusCoins = order.getTotalAmount() != null ? order.getTotalAmount().intValue() * 10 : 100;
                        int currentCoins = user.getStudyCoins() != null ? user.getStudyCoins() : 0;
                        user.setStudyCoins(currentCoins + bonusCoins);
                        courseitproject.service.IUserService tempUserService = new courseitproject.service.UserServiceImp();
                        tempUserService.updateStudyCoins(user.getUserId(), user.getStudyCoins(), user.getLastLoginDate());
                        
                        // Update the active session so UI reflects immediately
                        jakarta.servlet.http.HttpSession session = request.getSession(false);
                        if (session != null) {
                             Users sessionUser = (Users) session.getAttribute("USER");
                             if (sessionUser != null && sessionUser.getUserId().equals(user.getUserId())) {
                                 sessionUser.setStudyCoins(user.getStudyCoins());
                                 session.setAttribute("USER", sessionUser);
                             }
                        }
                    }
                } catch (Exception e) {
                    System.err.println("Error adding study coins on purchase: " + e.getMessage());
                }

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
            EntityManager em = JPAUtil.getEntityManager();
            try {
                // Fetch the user from the Student entity rather than the session layer
                // so callbacks work purely via Order IDs even if the user swaps
                // browsers/devices.
                CourseOrder reloadedOrder = em.find(CourseOrder.class, orderId);

                if (reloadedOrder != null && reloadedOrder.getStudentId() != null
                        && reloadedOrder.getStudentId().getUsers() != null) {

                    Users user = reloadedOrder.getStudentId().getUsers();

                    if (user.getEmail() != null && !user.getEmail().trim().isEmpty()) {
                        String toEmail = user.getEmail();
                        String fullName = (user.getFullName() != null && !user.getFullName().trim().isEmpty())
                                ? user.getFullName()
                                : user.getUsername();

                        long totalVND = (long) (reloadedOrder.getTotalAmount().doubleValue() * 25000);
                        String formattedAmount = String.format("%,d", totalVND);

                        String subject = "Payment Success Confirmation - DevLearn";
                        String htmlBill = "<div style='font-family: Arial, sans-serif; padding: 20px; background-color: #f8f9fa;'>"
                                + "<div style='background-color: white; padding: 30px; border-radius: 12px; max-width: 500px; margin: auto; box-shadow: 0 4px 15px rgba(0,0,0,0.05);'>"
                                + "<h2 style='color: #10B981; text-align: center; margin-bottom: 20px;'>Payment Successful!</h2>"
                                + "<p style='color: #333;'>Hello <b>" + fullName + "</b>,</p>"
                                + "<p style='color: #555; line-height: 1.6;'>Thank you for enrolling in the course. Below are your invoice details:</p>"
                                + "<table style='width: 100%; border-collapse: collapse; margin-top: 20px; margin-bottom: 25px;'>"
                                + "<tr><td style='padding: 12px 0; border-bottom: 1px dashed #ccc; color: #666;'>Order ID:</td><td style='padding: 12px 0; border-bottom: 1px dashed #ccc; text-align: right; color: #333;'><b>#"
                                + orderId + "</b></td></tr>"
                                + "<tr><td style='padding: 12px 0; border-bottom: 1px dashed #ccc; color: #666;'>Payment Method:</td><td style='padding: 12px 0; border-bottom: 1px dashed #ccc; text-align: right; color: #333;'><b>payOS (VietQR)</b></td></tr>"
                                + "<tr><td style='padding: 12px 0; border-bottom: 1px solid #eee; color: #333; font-weight: bold;'>Total Amount:</td><td style='padding: 12px 0; border-bottom: 1px solid #eee; text-align: right; color: #e11d48; font-size: 18px;'><b>"
                                + formattedAmount + " VNĐ</b></td></tr>"
                                + "</table>"
                                + "</div></div>";

                        EmailUtil emailUtil = new EmailUtil();
                        emailUtil.sendHtml(toEmail, subject, htmlBill);
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                if (em != null && em.isOpen()) {
                    em.close();
                }
            }
        }).start();
    }
}