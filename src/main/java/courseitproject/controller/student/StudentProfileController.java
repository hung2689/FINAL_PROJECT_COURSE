package courseitproject.controller.student;

import courseitproject.service.EnrollmentServiceImp;
import courseitproject.service.IEnrollmentService;
import courseitproject.service.IStudentService;
import courseitproject.service.IUserService;
import courseitproject.service.StudentBillingService;
import courseitproject.service.StudentServiceImp;
import courseitproject.service.UserServiceImp;
import courseitproject.model.CourseOrder;
import courseitproject.model.CourseOrderItem;
import courseitproject.model.CoursePayment;
import courseitproject.model.Enrollment;
import courseitproject.model.Student;
import courseitproject.model.Users;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "StudentProfile", urlPatterns = { "/student" })
public class StudentProfileController extends HttpServlet {

    private final IUserService userService = new UserServiceImp();
    private final IStudentService studentService = new StudentServiceImp();
    private final IEnrollmentService enrollmentService = new EnrollmentServiceImp();
    private final StudentBillingService billingService = new StudentBillingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Users sessionUser = getSessionUser(request, response);
        if (sessionUser == null)
            return;

        String action = request.getParameter("action");
        if (action == null)
            action = "profile";

        switch (action) {
            case "password":
                request.getRequestDispatcher("/views/student/student-password.jsp")
                        .forward(request, response);
                break;

          case "courses": {

                final int PAGE_SIZE = 5;

                int currentPage = 1;

                try {

                    String pageParam = request.getParameter("page");

                    if (pageParam != null)

                        currentPage = Integer.parseInt(pageParam);

                    if (currentPage < 1)

                        currentPage = 1;

                } catch (NumberFormatException ignored) {

                }



                // Thêm try-catch để bắt lỗi ngầm thay vì hiển thị màn hình trắng

                try {

                    // 🔥 LẤY studentId TỪ BẢNG STUDENT

                    Student student = studentService.getStudentById(sessionUser.getUserId());

                    if (student == null) {

                        

                        request.setAttribute("enrollments", List.of());

                        request.setAttribute("currentPage", 1);

                        request.setAttribute("totalPages", 1);

                        request.setAttribute("totalRecords", 0);

                        

                        // LƯU Ý: Đảm bảo file trong thư mục /views/student/ tên chính xác là student-course.jsp

                        request.getRequestDispatcher("/views/student/student-course.jsp")

                                .forward(request, response);

                        break; // Quan trọng: break để thoát khỏi case

                    }

                    

                    int studentId = student.getStudentId();

                    // 🔥 DÙNG studentId THAY VÌ userId

                    int total = enrollmentService.countEnrollmentsByStudent(studentId);

                    int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);

                    if (totalPages < 1)

                        totalPages = 1;

                    if (currentPage > totalPages)

                        currentPage = totalPages;

                    int offset = (currentPage - 1) * PAGE_SIZE;

     

                    List<Enrollment> enrollments = enrollmentService.getEnrollmentsByStudent(studentId, offset, PAGE_SIZE);

                    

   

                    request.setAttribute("enrollments", enrollments);

                    request.setAttribute("currentPage", currentPage);

                    request.setAttribute("totalPages", totalPages);

                    request.setAttribute("totalRecords", total);

                    

                    request.getRequestDispatcher("/views/student/student-course.jsp")

                            .forward(request, response);

                            

                } catch (Exception e) {

                    // In lỗi ra console của server

                    e.printStackTrace();

                    // Hiển thị lỗi ra màn hình để bạn biết nguyên nhân thay vì màn hình trắng

                    response.setContentType("text/html; charset=UTF-8");

                    response.getWriter().println("<h3>Đã xảy ra lỗi Server:</h3>");

                    response.getWriter().println("<p>" + e.toString() + "</p>");

                }

                break;

            }

            case "billing": {
                try {
                    Student student = studentService.getStudentById(sessionUser.getUserId());
                    if (student != null) {
                        List<CourseOrder> orders = billingService.getOrdersByStudentId(student.getStudentId());
                        request.setAttribute("orders", orders);
                    } else {
                        request.setAttribute("orders", List.of());
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("orders", List.of());
                }
                request.getRequestDispatcher("/views/student/student-billing.jsp")
                        .forward(request, response);
                break;
            }

            case "billingDetail": {
                try {
                    int orderId = Integer.parseInt(request.getParameter("orderId"));
                    CourseOrder order = billingService.getOrderDetail(orderId);

                    // Security: ensure order belongs to the current student
                    if (order != null && order.getStudentId() != null
                            && order.getStudentId().getStudentId().equals(sessionUser.getUserId())) {
                        request.setAttribute("order", order);

                        // Get payment info
                        CoursePayment payment = billingService.getPaymentByOrderId(orderId);
                        request.setAttribute("payment", payment);

                        // Build instructor names map for each order item
                        Map<Integer, String> instructorMap = new HashMap<>();
                        if (order.getCourseOrderItemCollection() != null) {
                            for (CourseOrderItem item : order.getCourseOrderItemCollection()) {
                                if (item.getCourseId() != null) {
                                    String instructor = billingService.getInstructorName(item.getCourseId().getCourseId());
                                    instructorMap.put(item.getCourseId().getCourseId(), instructor);
                                }
                            }
                        }
                        request.setAttribute("instructorMap", instructorMap);
                    } else {
                        request.setAttribute("error", "Order not found or access denied.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid order ID.");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "An error occurred loading order details.");
                }
                request.getRequestDispatcher("/views/student/student-bill-detail.jsp")
                        .forward(request, response);
                break;
            }

            case "profile":
            default:
                loadProfile(request, sessionUser);
                request.getRequestDispatcher("/views/student/student-profile.jsp")
                        .forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Users sessionUser = getSessionUser(request, response);
        if (sessionUser == null)
            return;

        String action = request.getParameter("action");
        if (action == null)
            action = "";

        switch (action) {

            case "updateProfile": {
                String fullName = request.getParameter("fullName");
                String dobStr = request.getParameter("dateOfBirth");
                String level = request.getParameter("level");

                if (fullName == null || fullName.trim().isEmpty()) {
                    request.setAttribute("error", "Full name cannot be empty.");
                    loadProfile(request, sessionUser);
                    request.getRequestDispatcher("/views/student/student-profile.jsp")
                            .forward(request, response);
                    return;
                }

                int uid = sessionUser.getUserId();
                userService.updateFullName(uid, fullName.trim());

                if (dobStr != null && !dobStr.isEmpty()) {
                    Date dob = Date.valueOf(dobStr);
                    studentService.updateStudent(uid, dob, level != null ? level : "");
                } else if (level != null && !level.isEmpty()) {
                    Student s = studentService.getStudentById(uid);
                    Date existingDob = (s != null && s.getDateOfBirth() != null)
                            ? new Date(s.getDateOfBirth().getTime())
                            : null;
                    studentService.updateStudent(uid, existingDob, level);
                }

                // Refresh session user
                Users refreshed = userService.findUserById(uid);
                request.getSession().setAttribute("USER", refreshed);

                response.sendRedirect(request.getContextPath() + "/student?action=profile&success=1");
                break;
            }

            case "changePassword": {
                String oldPassword = request.getParameter("oldPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");

                int uid = sessionUser.getUserId();

                if (oldPassword == null || newPassword == null || confirmPassword == null
                        || oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                    request.setAttribute("error", "Please fill in all password fields.");
                    request.getRequestDispatcher("/views/student/student-password.jsp")
                            .forward(request, response);
                    return;
                }

                if (!userService.checkPassword(uid, oldPassword)) {
                    request.setAttribute("error", "Current password is incorrect.");
                    request.getRequestDispatcher("/views/student/student-password.jsp")
                            .forward(request, response);
                    return;
                }

                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "New passwords do not match.");
                    request.getRequestDispatcher("/views/student/student-password.jsp")
                            .forward(request, response);
                    return;
                }

                if (newPassword.length() < 6) {
                    request.setAttribute("error", "Password must be at least 6 characters.");
                    request.getRequestDispatcher("/views/student/student-password.jsp")
                            .forward(request, response);
                    return;
                }

                String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                userService.updatePassword(uid, hashed);

                response.sendRedirect(request.getContextPath() + "/student?action=password&success=1");
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/student");
                break;
        }
    }

    // ── helpers ──────────────────────────────────────────────────────────────

    private Users getSessionUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return null;
        }
        Users user = (Users) session.getAttribute("USER");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return null;
        }
        return user;
    }

    private void loadProfile(HttpServletRequest request, Users sessionUser) {
        int uid = sessionUser.getUserId();
        Users user = userService.findUserById(uid);
        Student student = studentService.getStudentById(uid);
        request.setAttribute("profileUser", user);
        request.setAttribute("profileStudent", student);
    }
}
