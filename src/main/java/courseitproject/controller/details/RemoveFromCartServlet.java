package courseitproject.controller.details;

import courseitproject.model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

@WebServlet("/removeFromCart")
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String courseIdParam = request.getParameter("id");
        
        if (courseIdParam != null && !courseIdParam.isEmpty()) {
            try {
                int courseId = Integer.parseInt(courseIdParam);
                HttpSession session = request.getSession();
                
                @SuppressWarnings("unchecked")
                Map<Integer, Course> cart = (Map<Integer, Course>) session.getAttribute("cart");
                
                if (cart != null && cart.containsKey(courseId)) {
                    cart.remove(courseId);
                    
                    session.setAttribute("cart", cart);
                    session.setAttribute("cartSize", cart.size());
                    
                    // Truyền thông báo xóa thành công sang giao diện
                    session.setAttribute("toastType", "success");
                    session.setAttribute("toastMsg", "Course removed from cart successfully!");
                }
            } catch (NumberFormatException e) {
                System.out.println("Lỗi ID: " + e.getMessage());
            }
        }
        
        // Quay lại trang Giỏ hàng sau khi xóa
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}