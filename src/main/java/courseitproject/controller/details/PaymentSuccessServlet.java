package courseitproject.controller.details;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/payment-success")
public class PaymentSuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // 1. Xóa toàn bộ sản phẩm trong giỏ hàng sau khi đã mua thành công
        session.removeAttribute("cart");
        session.setAttribute("cartSize", 0);
        
        // 2. Chuyển hướng hiển thị giao diện JSP báo thành công
        request.getRequestDispatcher("/views/details/payment-success.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Form "Xác nhận đã chuyển khoản" bên giao diện gọi qua đây
        doGet(request, response); 
    }
}