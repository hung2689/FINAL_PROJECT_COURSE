package courseitproject.controller.cart;

import courseitproject.model.Course;
import courseitproject.service.CourseServiceImp;
import courseitproject.service.ICourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // Gọi Service để lấy dữ liệu từ Database
    private final ICourseService courseService = new CourseServiceImp();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
           List<Course> suggestedCourses = courseService.findAll();

// Cắt lấy 14 khóa học đầu tiên
if (suggestedCourses != null && suggestedCourses.size() > 14) {
    suggestedCourses = suggestedCourses.subList(0, 14);
         
            }
            
            // Gửi danh sách gợi ý này sang file JSP
            request.setAttribute("suggestedCourses", suggestedCourses);
            
        } catch (Exception e) {
            System.out.println("Lỗi load khóa học gợi ý: " + e.getMessage());
        }

        // Chuyển hướng sang giao diện Giỏ hàng
        request.getRequestDispatcher("/views/details/cart.jsp").forward(request, response);
    }
}