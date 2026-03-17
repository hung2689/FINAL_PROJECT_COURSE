package courseitproject.controller.details;

import courseitproject.service.RoadmapNodeService;
import courseitproject.model.Course;
import courseitproject.service.ICourseService;
import courseitproject.service.CourseServiceImp;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "RoadmapServlet", urlPatterns = {"/roadmap"})
public class RoadmapServlet extends HttpServlet {

    // 1. Sử dụng Service an toàn tuyệt đối đã được kiểm chứng trong project 
    private final ICourseService courseService = new CourseServiceImp();

  @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    try {
        // 1. Lấy lựa chọn ngành học từ form (nếu không có, mặc định là "se")
        String major = request.getParameter("major");
        if (major == null || major.isEmpty()) {
            major = "se"; // Mặc định là Software Engineering
        }

        // 2. Chuẩn bị biến chứa Lộ trình và Tên Lộ Trình
        int[] roadmapIds;
        String roadmapName = "";

        // 3. Phân nhánh Lộ trình dựa theo chuyên ngành (Sử dụng ID từ DB SQL)
        switch (major) {
            case "ai": // Artificial Intelligence
                roadmapIds = new int[]{25, 8, 9, 10}; // Python -> Calc -> Linear -> Prob
                roadmapName = "Artificial Intelligence";
                break;
            case "ds": // Data Science
                roadmapIds = new int[]{26, 25, 9, 10, 12}; // SQL -> Python -> Linear -> Prob -> Stat
                roadmapName = "Data Science";
                break;
            case "cs": // Computer Science
                roadmapIds = new int[]{7, 11, 1, 3, 6}; // Git -> Discrete Math -> OOP -> DSA -> Design Patterns
                roadmapName = "Computer Science";
                break;
            case "is": // Information Systems
                roadmapIds = new int[]{22, 23, 26, 1, 2}; // HTML -> CSS -> SQL -> OOP -> Spring
                roadmapName = "Information Systems";
                break;
            case "ns": // Network & Security
                roadmapIds = new int[]{7, 26, 1, 4}; // Git -> SQL -> OOP -> Microservices
                roadmapName = "Network & Security";
                break;
            case "se": // Software Engineering (Mặc định)
            default:
                roadmapIds = new int[]{22, 23, 26, 1, 2, 4}; // HTML -> CSS -> SQL -> OOP -> Spring -> Micro
                roadmapName = "Software Engineering";
                break;
        }

        // 4. Lấy tất cả khóa học và lọc ra các môn đúng theo roadmapIds
     List<Course> allCourses = courseService.filterAll(null, null, false, false, null, null, 1, 100);
        List<Course> roadmapCourses = new ArrayList<>();

        if (allCourses != null) {
            for (int id : roadmapIds) {
                for (Course c : allCourses) {
                    if (c.getCourseId() != null && c.getCourseId() == id) {
                        roadmapCourses.add(c);
                        break; // Đảm bảo giữ đúng thứ tự khóa học như trong mảng roadmapIds
                    }
                }
            }
        }

        // 5. Gửi dữ liệu sang trang JSP
        request.setAttribute("courseList", roadmapCourses);
        request.setAttribute("roadmapName", roadmapName); // Gửi tên ngành sang để hiển thị
        request.setAttribute("totalCourses", roadmapCourses.size()); // Gửi tổng số môn học
        
        request.setAttribute("completionPercent", 0); // Hiện tại là 0. Sau này có thể tính toán từ Database để thay số 0 này.
        request.getRequestDispatcher("/views/home/roadmap.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating roadmap");
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}