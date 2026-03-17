package courseitproject.controller.details;

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
            // SỬ DỤNG HÀM getAllCourses(1) ĐỂ LẤY DATA THAY VÌ findAll()
            // Hàm này sẽ lấy an toàn 10 khóa học mới nhất có status là ACTIVE
            List<Course> suggestedCourses = courseService.getAllCourses(1);
            
            // In ra console để theo dõi xem lấy được bao nhiêu khóa học
            if (suggestedCourses != null) {
                System.out.println("Đã lấy thành công " + suggestedCourses.size() + " khóa học gợi ý!");
            }
            
            // Gửi danh sách gợi ý này sang file JSP
            request.setAttribute("suggestedCourses", suggestedCourses);
            
        } catch (Exception e) {
            System.out.println("Lỗi load khóa học gợi ý: " + e.getMessage());
            e.printStackTrace();
        }

        // Chuyển hướng sang giao diện Giỏ hàng
        request.getRequestDispatcher("/views/details/cart.jsp").forward(request, response);
    }
}