package courseitproject.controller.cart;

import courseitproject.model.Course;
import courseitproject.service.CourseServiceImp;
import courseitproject.service.ICourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {

    private final ICourseService courseService = new CourseServiceImp();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String courseIdParam = request.getParameter("id");

        if (courseIdParam != null && !courseIdParam.isEmpty()) {
            try {
                int courseId = Integer.parseInt(courseIdParam);
                Course course = courseService.getCourseById(courseId); 

                if (course != null) {
                    HttpSession session = request.getSession();

                    @SuppressWarnings("unchecked")
                    Map<Integer, Course> cart = (Map<Integer, Course>) session.getAttribute("cart");
                    if (cart == null) {
                        cart = new HashMap<>();
                    }

                    // KIỂM TRA: Nếu khóa học CHƯA CÓ trong giỏ
                    if (!cart.containsKey(courseId)) {
                        cart.put(courseId, course);
                        session.setAttribute("cart", cart);
                        session.setAttribute("cartSize", cart.size());
                        
                        // Gửi thông báo THÀNH CÔNG
                        session.setAttribute("toastType", "success");
                        session.setAttribute("toastMsg", "Course successfully added to cart!");
                    } 
                    // Nếu khóa học ĐÃ CÓ trong giỏ
                    else {
                        // Gửi thông báo LỖI (Trùng lặp)
                        session.setAttribute("toastType", "error");
                        session.setAttribute("toastMsg", "This course is already in your cart!");
                    }
                }
            } catch (NumberFormatException e) {
                System.out.println("Lỗi parse ID khóa học: " + e.getMessage());
            }
        }

        // Quay lại trang cũ
        String referer = request.getHeader("Referer");
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/shop");
        }
    }
}