/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.auther;

import courseitproject.model.Role;
import courseitproject.model.UserRole;
import courseitproject.model.Users;
import courseitproject.service.IUserService;
import courseitproject.service.UserServiceImp;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "autherServlet", urlPatterns = {"/login", "/register", "/otpRegister", "/forget", "/reset", "/otpverify", "/logout"})
public class AutherServlet extends HttpServlet {

    private IUserService userService;

    @Override
    public void init() {
        userService = new UserServiceImp();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.contains("otpRegister")) {
            getRegisterOtp(request, response);
        } else if (uri.contains("register")) {
            getRegister(request, response);
        } else if (uri.contains("login")) {
            getLogin(request, response);
        } else if (uri.contains("forget")) {
            getForget(request, response);
        } else if (uri.contains("/logout")) {
            getLogout(request, response);
        }

    }

    protected void getLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.removeAttribute("USER");    
            session.invalidate();              
        }

         
        Cookie cookie = new Cookie("INPUT_COOKIE", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);

       
        response.sendRedirect(request.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.contains("otpRegister")) {
            postRegisterVerifyOtp(request, response);
        } else if (uri.contains("register")) {
            postRegister(request, response);
        } else if (uri.contains("login")) {
            postLogin(request, response);
        } else if (uri.contains("forget")) {
            postForget(request, response);
        } else if (uri.contains("reset")) {
            postReset(request, response);
        } else if (uri.contains("otpverify")) {
            postForgetVerifyOtp(request, response);
        } else if (uri.contains("/logout")) {
            postForgetVerifyOtp(request, response);
        }

    }

    protected void postReset(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/forget");
            return;
        }

        String email = (String) session.getAttribute("REG_EMAIL");
        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/forget");
            return;
        }

        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");

        // 1️⃣ Validate
        if (password == null || repassword == null || password.isBlank()) {
            request.setAttribute("errorPass", "Vui lòng nhập đầy đủ mật khẩu");
            request.setAttribute("mode", "reset");
            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        if (!password.equals(repassword)) {
            request.setAttribute("errorPass", "Mật khẩu không khớp");
            request.setAttribute("mode", "reset");
            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("errorPass", "Mật khẩu phải có ít nhất 6 ký tự");
            request.setAttribute("mode", "reset");
            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        String hashedPwd = BCrypt.hashpw(password, BCrypt.gensalt());

        boolean updated = userService.updatePasswordByEmail(email, hashedPwd);
        if (!updated) {
            request.setAttribute("errorPass", "Không thể cập nhật mật khẩu");
            request.setAttribute("mode", "reset");
            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        session.removeAttribute("ALLOW_RESET_PASSWORD");
        session.removeAttribute("REG_EMAIL");

        request.setAttribute("resetSuccess", "true");
        request.getRequestDispatcher("/views/auth/login.jsp?mode=success")
                .forward(request, response);
    }

    protected void getForget(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/login.jsp?mode=forgot").forward(request, response);
    }

    protected void getRegisterOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/registerOtp.jsp").forward(request, response);
    }

    protected void postForget(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        if (userService.findUserByEmail(email) == null) {
            request.setAttribute("errorForget", "Tài khoản không tồn tại");
            request.getRequestDispatcher("/views/auth/login.jsp?mode=forgot").forward(request, response);
            return;
        }
        HttpSession session = request.getSession();
        session.setAttribute("REG_EMAIL", email);
        // chuyển trang OTP

        request.setAttribute("mode", "otp");
        request.getRequestDispatcher("/views/auth/login.jsp")
                .forward(request, response);
        new Thread(() -> {
            userService.UserSendEmail(email);
        }).start();
    }

    protected void postForgetVerifyOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String otp = request.getParameter("otp");
        String email = (String) session.getAttribute("REG_EMAIL");
        if (otp == null || email == null) {
            request.setAttribute("otpError", "Please enter the OTP.");
            request.getRequestDispatcher("/views/auth/login.jsp?mode=otp").forward(request, response);
            return;
        }

        if (!userService.UserVerifyRegister(email, otp)) {
            request.setAttribute("otpError", "Invalid or expired OTP");
            request.getRequestDispatcher("/views/auth/login.jsp?mode=otp").forward(request, response);
            return;
        }
        session.setAttribute("ALLOW_RESET_PASSWORD", true);
        request.setAttribute("mode", "reset");
        request.getRequestDispatcher("/views/auth/login.jsp")
                .forward(request, response);
    }

    protected void postRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (userService.findUserByUsername(username) != null
                || userService.findUserByEmail(email) != null) {

            request.setAttribute("userError", "Username or Email already exists");
            request.getRequestDispatcher("/views/auth/register.jsp")
                    .forward(request, response);
            return;
        }
        // LƯU TẠM REGISTER DATA
        HttpSession session = request.getSession();
        session.setAttribute("REG_FULLNAME", fullname);
        session.setAttribute("REG_USERNAME", username);
        session.setAttribute("REG_EMAIL", email);
        session.setAttribute("REG_PASSWORD", password);
        session.setAttribute("REG_ROLE", role);

        // chuyển trang OTP
        response.sendRedirect(request.getContextPath() + "/otpRegister");
        new Thread(() -> {
            userService.UserSendEmail(email);
        }).start();

    }

    protected void postRegisterVerifyOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String otp = request.getParameter("otp");
        String email = (String) session.getAttribute("REG_EMAIL");
        if (otp == null || email == null) {
            request.setAttribute("otpError", "Please enter the OTP.");
            request.getRequestDispatcher("/views/auth/registerOtp.jsp").forward(request, response);
            return;
        }

        if (!userService.UserVerifyRegister(email, otp)) {
            request.setAttribute("otpError", "Invalid or expired OTP");
            request.getRequestDispatcher("/views/auth/registerOtp.jsp").forward(request, response);
            return;
        }
        // LẤY DATA TẠM
        String fullname = (String) session.getAttribute("REG_FULLNAME");
        String username = (String) session.getAttribute("REG_USERNAME");
        String password = (String) session.getAttribute("REG_PASSWORD");
        String role = (String) session.getAttribute("REG_ROLE");

        Users user = new Users();
        String hashedPwd = BCrypt.hashpw(password, BCrypt.gensalt());

        user.setUsername(username);
        user.setEmail(email);
        user.setFullName(fullname);
        user.setPassword(hashedPwd);
        user.setStatus("ACTIVE");
        user.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));
        user.setProvider("local");
        user.setEmailVerified(true);
        // XÓA SESSION TẠM
        session.removeAttribute("REG_FULLNAME");
        session.removeAttribute("REG_USERNAME");
        session.removeAttribute("REG_EMAIL");
        session.removeAttribute("REG_PASSWORD");
        session.removeAttribute("REG_ROLE");
        try {
            userService.register(user, role);
            if ("TEACHER".equalsIgnoreCase(role)) {

                // lưu user vào session để dùng ở bước tiếp
                session.setAttribute("USER", user);

                response.sendRedirect(request.getContextPath() + "/teacherRegister");
                return;
            }
            request.setAttribute("registerSuccess", "true");
            request.getRequestDispatcher("/views/auth/registerOtp.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("userError", e.toString());
            request.getRequestDispatcher("/views/auth/register.jsp")
                    .forward(request, response);
        }

    }

    protected void getRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
    }

    protected void getLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }

    protected void postLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String input = request.getParameter("input");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        // 1. Tìm user theo username hoặc email
        Users user = userService.findUserByUsername(input);
        if (user == null) {
            user = userService.findUserByEmail(input);
        }

        // 2. Không tìm thấy user
        if (user == null) {
            request.setAttribute("error", "Sai tên đăng nhập/email hoặc mật khẩu");
            request.getRequestDispatcher("views/auth/login.jsp").forward(request, response);
            return;
        }

        // 3. User đăng nhập bằng GOOGLE → chặn login thường
        if ("GOOGLE".equalsIgnoreCase(user.getProvider())) {
            request.setAttribute("error",
                    "Sai tài khoản hoặc mật khẩu");
            request.getRequestDispatcher("views/auth/login.jsp").forward(request, response);
            return;
        }

        // 4. Phòng thủ: password null (tránh BCrypt crash)
        if (user.getPassword() == null) {
            request.setAttribute("error",
                    "Tài khoản này không hỗ trợ đăng nhập bằng mật khẩu.");
            request.getRequestDispatcher("views/auth/login.jsp").forward(request, response);
            return;
        }

        // 5. Check mật khẩu
        if (!BCrypt.checkpw(password, user.getPassword())) {
            request.setAttribute("error", "Sai tên đăng nhập/email hoặc mật khẩu");
            request.getRequestDispatcher("views/auth/login.jsp").forward(request, response);
            return;
        }

        // 6. Login thành công
        HttpSession session = request.getSession();
        session.setAttribute("USER", user);

        // 7. Remember me
        if (remember != null) {
            Cookie cookie = new Cookie("INPUT_COOKIE", input);
            cookie.setMaxAge(7 * 24 * 60 * 60);
            cookie.setPath("/");
            response.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("INPUT_COOKIE", "");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
        }

        // 8. Redirect
        postCheck(request, response, user);

    }

    protected void postCheck(HttpServletRequest request, HttpServletResponse response, Users user)
            throws ServletException, IOException {
        List<Role> roleList = userService.findRolesByUserId(user.getUserId());
        boolean isStudent = false;
        boolean isAdmin = false;

        for (Role r : roleList) {
            if ("STUDENT".equalsIgnoreCase(r.getRoleName())) {
                isStudent = true;
            }
            if ("ADMIN".equalsIgnoreCase(r.getRoleName())) {
                isAdmin = true;
            }
        }

        if (isAdmin) {
            response.sendRedirect(request.getContextPath() + "/courseAdmin");
        } else if (isStudent) {
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            response.sendRedirect(request.getContextPath() + "/shop");
        }
    }

}
