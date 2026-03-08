package courseitproject.controller.admin;

import courseitproject.model.Users;
import courseitproject.service.IUserService;
import courseitproject.service.UserServiceImp;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
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
            default:
                listUser(request, response);
        }
    }

    protected void listUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }

            long totalUsers = userService.countAll();
            int PAGE_SIZE = 10;
            int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);

            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }
            if (currentPage < 1) {
                currentPage = 1;
            }

            List<Users> list = userService.findAllPaging(currentPage, PAGE_SIZE);
            Map<Integer, String> roleMap = userService.findRoleMapForUsers(list);

            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("users", list);
            request.setAttribute("roleMap", roleMap);

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

            if (status == null) {
                status = "INACTIVE";
            }

            Users user = new Users();
            user.setUserId(userId);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setStatus(status);

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
                    + "\"status\":\"" + user.getStatus() + "\""
                    + "}";
            out.print(json);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\"", "\\\"");
    }
}
