/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.auther;

import courseitproject.model.Role;
import courseitproject.model.Student;
import courseitproject.model.Teacher;
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
import java.time.LocalDateTime;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "autherServlet", urlPatterns = {"/login", "/register", "/otpRegister"})
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
        }

    }

    protected void getRegisterOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/registerOtp.jsp").forward(request, response);
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
        }

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

        // gửi OTP
        userService.UserSendEmail(email);

        // chuyển trang OTP
        response.sendRedirect(request.getContextPath() + "/otpRegister");

    }

    protected void postRegisterVerifyOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String otp = request.getParameter("otp");
        String email = (String) session.getAttribute("REG_EMAIL");

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
        user.setCreatedAt(LocalDateTime.now());

        // XÓA SESSION TẠM
        session.removeAttribute("REG_FULLNAME");
        session.removeAttribute("REG_USERNAME");
        session.removeAttribute("REG_EMAIL");
        session.removeAttribute("REG_PASSWORD");
        session.removeAttribute("REG_ROLE");
        try {
            userService.register(user, role);
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
        Users user = userService.findUserByUsername(input);
        if (user == null) {
            user = userService.findUserByEmail(input);
        }
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("USER", user);
            if (remember != null) {
                Cookie cookies = new Cookie("INPUT_COOKIE", input);
                cookies.setMaxAge(7 * 24 * 60 * 60);
                cookies.setPath("/");
                response.addCookie(cookies);
            } else {
                Cookie c = new Cookie("INPUT_COOKIE", "");
                c.setMaxAge(0);
                c.setPath("/");
                response.addCookie(c);
            }
            response.sendRedirect(request.getContextPath()+"/shop");

        }else {
            request.setAttribute("error", "Invalid username/email or password");
            request.getRequestDispatcher("views/auth/login.jsp").forward(request, response);
        }
    }

}
