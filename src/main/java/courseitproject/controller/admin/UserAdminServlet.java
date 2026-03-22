package courseitproject.controller.admin;

import courseitproject.model.Users;
import courseitproject.model.Teacher;
import courseitproject.model.Student;
import courseitproject.service.IUserService;
import courseitproject.service.UserServiceImp;
import courseitproject.utils.JPAUtil;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UserAdminServlet", urlPatterns = {"/userAdmin", "/admin/users"})
public class UserAdminServlet extends HttpServlet {

    private IUserService userService;

    @Override
    public void init() {
        userService = new UserServiceImp();
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
                getUpdateUser(request, response);
                break;
            case "getTeacherById":
                getTeacherById(request, response);
                break;
            case "getStudentById":
                getStudentById(request, response);
                break;
            default:
                listUser(request, response);
        }
    }

    protected void listUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            courseitproject.search.criteria.UserSearchCriteria criteria = new courseitproject.search.criteria.UserSearchCriteria();
            int PAGE_SIZE = 10000;

            java.util.Comparator<Users> sortDesc = (u1, u2) -> {
                if(u1.getCreatedAt() == null || u2.getCreatedAt() == null) return 0;
                return u2.getCreatedAt().compareTo(u1.getCreatedAt());
            };

            courseitproject.search.utils.SearchResult<Users> result = 
                    userService.searchUsers(criteria, 1, PAGE_SIZE, sortDesc);

            List<Users> list = result.getData();
            Map<Integer, String> roleMap = userService.findRoleMapForUsers(list);

            request.setAttribute("totalUsers", result.getTotalItems());
            request.setAttribute("users", list);
            request.setAttribute("roleMap", roleMap);

            // Load teachers list
            EntityManager em = JPAUtil.getEntityManager();
            try {
                List<Teacher> teachers = em.createQuery(
                        "SELECT t FROM Teacher t JOIN FETCH t.users ORDER BY t.teacherId DESC", Teacher.class)
                        .getResultList();
                request.setAttribute("teachers", teachers);

                List<Student> students = em.createQuery(
                        "SELECT s FROM Student s JOIN FETCH s.users ORDER BY s.studentId DESC", Student.class)
                        .getResultList();
                request.setAttribute("students", students);
            } finally {
                em.close();
            }

            request.getRequestDispatcher("/views/admin/user/userManagement.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", e.getMessage());
            request.getRequestDispatcher("/views/admin/user/userManagement.jsp").forward(request, response);
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
                postAddUser(request, response);
                break;
            case "update":
                postUpdateUser(request, response);
                break;
            case "updateTeacher":
                postUpdateTeacher(request, response);
                break;
            case "updateStudent":
                postUpdateStudent(request, response);
                break;
            case "delete":
                postDelete(request, response);
                break;
            default:
                listUser(request, response);
        }
    }

    protected void postDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String rawId = request.getParameter("user_id");
            if (rawId == null || rawId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            int userId = Integer.parseInt(rawId);
            userService.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", e.getMessage());
            listUser(request, response);
        }
    }

    protected void postAddUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String roleName = request.getParameter("role");
            String status = request.getParameter("status");
            String studyCoinsStr = request.getParameter("studyCoins");

            if (status == null) {
                status = "ACTIVE";
            }

            Users user = new Users();
            user.setFullName(fullName);
            user.setEmail(email);
            // generate default username from email
            user.setUsername(email != null && email.contains("@") ? email.split("@")[0] : "");
            user.setEmailVerified(true);
            user.setStatus(status);

            if (studyCoinsStr != null && !studyCoinsStr.isEmpty()) {
                user.setStudyCoins(Integer.parseInt(studyCoinsStr));
            } else {
                user.setStudyCoins(0);
            }

            if (password != null && !password.isEmpty()) {
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                user.setPassword(hashedPassword);
            }

            userService.save(user, roleName);
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", e.getMessage());
            listUser(request, response);
        }
    }

    protected void postUpdateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String rawId = request.getParameter("user_id");
            if (rawId == null || rawId.isEmpty()) {
                throw new Exception("User ID is required");
            }
            int userId = Integer.parseInt(rawId);

            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String roleName = request.getParameter("role");
            String status = request.getParameter("status");
            String studyCoinsStr = request.getParameter("studyCoins");

            if (status == null) {
                status = "INACTIVE";
            }

            Users user = new Users();
            user.setUserId(userId);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setStatus(status);

            if (studyCoinsStr != null && !studyCoinsStr.isEmpty()) {
                user.setStudyCoins(Integer.parseInt(studyCoinsStr));
            }

            if (password != null && !password.isEmpty()) {
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                user.setPassword(hashedPassword);
            }

            userService.update(user, roleName);
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", e.getMessage());
            listUser(request, response);
        }
    }

    protected void getUpdateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String rawId = request.getParameter("id");
            int id = Integer.parseInt(rawId);

            Users user = userService.findUserById(id);
            if (user == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            List<courseitproject.model.Role> roles = userService.findRolesByUserId(id);
            String roleName = "USER";
            for (courseitproject.model.Role r : roles) {
                if ("ADMIN".equals(r.getRoleName())) {
                    roleName = "ADMIN";
                    break;
                } else if ("TEACHER".equals(r.getRoleName())) {
                    roleName = "TEACHER";
                } else if ("STUDENT".equals(r.getRoleName()) && !"TEACHER".equals(roleName)) {
                    roleName = "STUDENT";
                }
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            PrintWriter out = response.getWriter();
            String json = "{"
                    + "\"userId\":" + user.getUserId() + ","
                    + "\"fullName\":\"" + escapeJson(user.getFullName()) + "\","
                    + "\"email\":\"" + escapeJson(user.getEmail()) + "\","
                    + "\"role\":\"" + roleName + "\","
                    + "\"status\":\"" + user.getStatus() + "\","
                    + "\"studyCoins\":" + (user.getStudyCoins() != null ? user.getStudyCoins() : 0)
                    + "}";
            out.print(json);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // ===== Teacher CRUD =====

    protected void getTeacherById(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            EntityManager em = JPAUtil.getEntityManager();
            try {
                Teacher t = em.find(Teacher.class, id);
                if (t == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                String json = "{"
                        + "\"teacherId\":" + t.getTeacherId() + ","
                        + "\"fullName\":\"" + escapeJson(t.getUsers().getFullName()) + "\","
                        + "\"email\":\"" + escapeJson(t.getUsers().getEmail()) + "\","
                        + "\"specialization\":\"" + escapeJson(t.getSpecialization()) + "\","
                        + "\"experienceYear\":" + (t.getExperienceYear() != null ? t.getExperienceYear() : 0) + ","
                        + "\"approvalStatus\":\"" + escapeJson(t.getApprovalStatus()) + "\","
                        + "\"cvUrl\":\"" + escapeJson(t.getCvUrl()) + "\""
                        + "}";
                out.print(json);
                out.flush();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void postUpdateTeacher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int teacherId = Integer.parseInt(request.getParameter("teacher_id"));
            String specialization = request.getParameter("specialization");
            String expYearStr = request.getParameter("experienceYear");
            String approvalStatus = request.getParameter("approvalStatus");
            String cvUrl = request.getParameter("cvUrl");

            EntityManager em = JPAUtil.getEntityManager();
            EntityTransaction tx = em.getTransaction();
            try {
                tx.begin();
                Teacher t = em.find(Teacher.class, teacherId);
                if (t == null) {
                    throw new Exception("Teacher not found with ID: " + teacherId);
                }
                if (specialization != null) t.setSpecialization(specialization);
                if (expYearStr != null && !expYearStr.isEmpty()) {
                    t.setExperienceYear(Integer.parseInt(expYearStr));
                }
                if (approvalStatus != null) t.setApprovalStatus(approvalStatus);
                if (cvUrl != null) t.setCvUrl(cvUrl);
                em.merge(t);
                tx.commit();
            } catch (Exception e) {
                if (tx.isActive()) tx.rollback();
                throw e;
            } finally {
                em.close();
            }
            response.sendRedirect(request.getContextPath() + "/admin/users?view=teachers");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", e.getMessage());
            listUser(request, response);
        }
    }

    // ===== Student CRUD =====

    protected void getStudentById(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            EntityManager em = JPAUtil.getEntityManager();
            try {
                Student s = em.find(Student.class, id);
                if (s == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                String dateStr = s.getDateOfBirth() != null
                        ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(s.getDateOfBirth()) : "";
                String json = "{"
                        + "\"studentId\":" + s.getStudentId() + ","
                        + "\"fullName\":\"" + escapeJson(s.getUsers().getFullName()) + "\","
                        + "\"email\":\"" + escapeJson(s.getUsers().getEmail()) + "\","
                        + "\"level\":\"" + escapeJson(s.getLevel()) + "\","
                        + "\"dateOfBirth\":\"" + dateStr + "\""
                        + "}";
                out.print(json);
                out.flush();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void postUpdateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int studentId = Integer.parseInt(request.getParameter("student_id"));
            String level = request.getParameter("level");
            String dobStr = request.getParameter("dateOfBirth");

            EntityManager em = JPAUtil.getEntityManager();
            EntityTransaction tx = em.getTransaction();
            try {
                tx.begin();
                Student s = em.find(Student.class, studentId);
                if (s == null) {
                    throw new Exception("Student not found with ID: " + studentId);
                }
                if (level != null) s.setLevel(level);
                if (dobStr != null && !dobStr.isEmpty()) {
                    s.setDateOfBirth(java.sql.Date.valueOf(dobStr));
                }
                em.merge(s);
                tx.commit();
            } catch (Exception e) {
                if (tx.isActive()) tx.rollback();
                throw e;
            } finally {
                em.close();
            }
            response.sendRedirect(request.getContextPath() + "/admin/users?view=students");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", e.getMessage());
            listUser(request, response);
        }
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\"", "\\\"");
    }
}
