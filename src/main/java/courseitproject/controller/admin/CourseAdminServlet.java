package courseitproject.controller.admin;

import courseitproject.model.Course;
import courseitproject.model.CourseCategory;
import courseitproject.model.Teacher;
import courseitproject.service.CourseServiceImp;
import courseitproject.service.FileUploadService;
import courseitproject.service.ICourseService;
import courseitproject.service.ITeacherService;
import courseitproject.service.TeacherServiceImp;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author ASUS
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet(name = "CourseAdminServlet", urlPatterns = {"/courseAdmin"})

public class CourseAdminServlet extends HttpServlet {

    private ICourseService courseService;
    private FileUploadService uploadService;
    private ITeacherService teacherService;

    @Override
    public void init() {
        courseService = new CourseServiceImp();
        uploadService = new FileUploadService(getServletContext());
        teacherService = new TeacherServiceImp();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "getById":
                getUpdateCourse(request, response);
                break;
            case "add":
                break;
            case "update":

                break;
            case "delete":

                break;
            default:
                listCourse(request, response);

        }

    }

    protected void listCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            int currentPage = 1;
            String pageParam = request.getParameter("page");

            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }
            long totalCourses = courseService.countActiveCourses();
            int totalPages = (int) Math.ceil((double) totalCourses / 10);

            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }

            if (currentPage < 1) {
                currentPage = 1;
            }
            List<Course> list = courseService.findAllPaging(currentPage);

            Map<Integer, String> teacherMap = new HashMap<>();
            Map<Integer, Long> studentCountMap = new HashMap<>();

            for (Course c : list) {
                Long count = courseService.countStudentsByCourse(c.getCourseId());
                studentCountMap.put(c.getCourseId(), count);

                String name = courseService.findTeacherNameByCourse(c);
                teacherMap.put(c.getCourseId(), name);
            }

            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCourses", totalCourses);
            request.setAttribute("list", list);
            request.setAttribute("studentCountMap", studentCountMap);
            request.setAttribute("teacherMap", teacherMap);

            request.getRequestDispatcher("views/admin/course/courseManagement.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.toString());
            request.getRequestDispatcher("views/admin/course/courseManagement.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                postAddCourse(request, response);
                break;
            case "update":
                postUpdateCourse(request, response);
                break;
            case "delete":
                postDelete(request, response);
                break;
            default:
                listCourse(request, response);

        }
    }

    protected void postDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String rawId = request.getParameter("course_id");

            if (rawId == null || rawId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/courseAdmin");
                return;
            }

            int courseId = Integer.parseInt(rawId);

            courseService.hardDeleteCourse(courseId);

            response.sendRedirect(request.getContextPath() + "/courseAdmin");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", e.getMessage());
            request.getRequestDispatcher("views/admin/course/courseManagement.jsp")
                    .forward(request, response);
        }
    }

    protected void postUpdateCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // ===== 1. LẤY & VALIDATE ID =====
            String courseIdRaw = request.getParameter("course_id");
            if (courseIdRaw == null || courseIdRaw.trim().isEmpty()) {
                throw new Exception("Course ID is required");
            }

            int course_id = Integer.parseInt(courseIdRaw);

            Course course = courseService.findById(course_id);
            if (course == null) {
                throw new Exception("Course not found");
            }

            // ===== 2. LẤY DATA TỪ FORM =====
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String raw_price = request.getParameter("price");
            String level = request.getParameter("level");
            String raw_category_id = request.getParameter("category_id");
            String status = request.getParameter("status");
            String teacher_id_raw = request.getParameter("teacher_id");

            if (status == null) {
                status = "INACTIVE";
            }

            // ===== 3. VALIDATE & PARSE =====
            BigDecimal price;
            try {
                price = new BigDecimal(raw_price);
            } catch (Exception e) {
                throw new Exception("Invalid price format");
            }

            int category_id;
            try {
                category_id = Integer.parseInt(raw_category_id);
            } catch (Exception e) {
                throw new Exception("Invalid category ID");
            }

            // ===== 4. VALIDATE TEACHER (TRƯỚC KHI UPDATE) =====
            Integer teacher_id = null;

            if (teacher_id_raw != null && !teacher_id_raw.trim().isEmpty()) {

                try {
                    teacher_id = Integer.parseInt(teacher_id_raw);
                } catch (Exception e) {
                    throw new Exception("Invalid teacher ID");
                }

                Teacher teacher = teacherService.findTeacherById(teacher_id);

                if (teacher == null) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/courseAdmin?modal=update&courseId=" + course_id + "&error=teacher"
                    );
                    return;
                }
            }

            // ===== 5. UPLOAD ẢNH NẾU CÓ =====
            Part filePart = request.getPart("url");
            if (filePart != null && filePart.getSize() > 0) {
                String imgUrl = uploadService.uploadCv(filePart);
                course.setThumbnailUrl(imgUrl);
            }

            // ===== 6. UPDATE COURSE =====
            course.setTitle(title);
            course.setDescription(description);
            course.setPrice(price);
            course.setLevel(level);
            course.setCategoryId(new CourseCategory(category_id));
            course.setStatus(status);

            courseService.updateCourse(course);

            // ===== 7. ASSIGN TEACHER NẾU CÓ =====
            if (teacher_id != null) {
                courseService.assignTeacherToCourse(course_id, teacher_id);
            }

            response.sendRedirect(request.getContextPath() + "/courseAdmin");

        } catch (Exception e) {

            e.printStackTrace();
            request.setAttribute("ERROR", e.getMessage());
            request.getRequestDispatcher("views/admin/course/courseManagement.jsp")
                    .forward(request, response);
        }
    }

    protected void getUpdateCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String rawId = request.getParameter("id");
            int id = Integer.parseInt(rawId);

            Course course = courseService.findById(id);

            if (course == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            Teacher teacher = courseService.getTeacherByCourseId(id);
            Integer teacherId = (teacher != null) ? teacher.getTeacherId() : null;
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            PrintWriter out = response.getWriter();

            String json = "{"
                    + "\"courseId\":" + course.getCourseId() + ","
                    + "\"title\":\"" + escapeJson(course.getTitle()) + "\","
                    + "\"description\":\"" + escapeJson(course.getDescription()) + "\","
                    + "\"price\":" + course.getPrice() + ","
                    + "\"level\":\"" + course.getLevel() + "\","
                    + "\"categoryId\":" + course.getCategoryId().getCategoryId() + ","
                    + "\"thumbnailUrl\":\"" + escapeJson(course.getThumbnailUrl()) + "\","
                    + "\"status\":\"" + course.getStatus() + "\","
                    + "\"teacherId\":" + (teacherId != null ? teacherId : "null")
                    + "}";
            out.print(json);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void postAddCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // ===== 1. LẤY DATA TỪ FORM =====
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String raw_price = request.getParameter("price");
            String level = request.getParameter("level");
            String raw_category_id = request.getParameter("category_id");
            String status = request.getParameter("status");
            if (status == null) {
                status = "INACTIVE";
            }
            Part filePart = request.getPart("url");

            //    PARSE DATA  
            BigDecimal price = new BigDecimal(raw_price);
            int category_id = Integer.parseInt(raw_category_id);
            String imgUrl = uploadService.uploadCv(filePart);

            // tao course object
            Course course = new Course();
            course.setTitle(title);
            course.setDescription(description);
            course.setPrice(price);
            course.setLevel(level);
            course.setCategoryId(new CourseCategory(category_id));
            course.setThumbnailUrl(imgUrl);
            course.setStatus(status);

            courseService.createCourse(course);
            response.sendRedirect(request.getContextPath() + "/courseAdmin");
        } catch (Exception e) {
        }

    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\"", "\\\"");
    }
}
