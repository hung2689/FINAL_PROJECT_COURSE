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

        String orderIdStr = request.getParameter("orderId");
        String amountStr = request.getParameter("amount");

        // DEBUG để kiểm tra dữ liệu nhận được
        System.out.println("orderId = " + orderIdStr);
        System.out.println("amount = " + amountStr);

        // kiểm tra null hoặc rỗng
        if (orderIdStr == null || orderIdStr.isEmpty()
                || amountStr == null || amountStr.isEmpty()) {

            System.out.println("Missing orderId or amount");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        int orderId;
        int amount;

        try {
            orderId = Integer.parseInt(orderIdStr);

            // phòng trường hợp amount có dạng 2500000.0
            amount = (int) Double.parseDouble(amountStr);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        // description nên ngắn cho PayOS
        String description = "DH " + orderId;

        String returnUrl = "http://localhost:9999/CourseITProject/payos-return";
        String cancelUrl = "http://localhost:9999/CourseITProject/checkout";

        String checkoutUrl = PayOSUtil.createPaymentLink(
                orderId,
                amount,
                description,
                returnUrl,
                cancelUrl
        );

        if (checkoutUrl != null && !checkoutUrl.isEmpty()) {

            System.out.println("Redirect to PayOS: " + checkoutUrl);
            response.sendRedirect(checkoutUrl);

        } else {

            System.out.println("PayOS URL null -> back to checkout");
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}