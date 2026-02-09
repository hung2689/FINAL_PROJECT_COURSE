/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.auther;

import courseitproject.model.Users;
import courseitproject.service.IUserService;
import courseitproject.service.UserServiceImp;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "CompleteProfile", urlPatterns = {"/complete-profile"})
public class CompleteProfile extends HttpServlet {

    private IUserService userService;

    @Override
    public void init() {
        userService = new UserServiceImp();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("views/auth/complete-profile.jsp").forward(req, resp);
            req.removeAttribute("ERROR");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        String role = req.getParameter("role");
        String username = req.getParameter("username");
        String fullname = req.getParameter("fullname");
        if(userService.findUserByUsername(username)!=null){
            req.setAttribute("ERROR", "this user is duplicate");
            req.getRequestDispatcher("views/auth/complete-profile.jsp").forward(req, resp);
        }
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("USER");
        if (user == null) {
            req.setAttribute("error", "vui lòng đăng nhập");
            req.getRequestDispatcher("views/auth/login.jsp").forward(req, resp);
            return;
        }

        try {
            userService.completeProfile(user.getUserId(), username, fullname, role);

// reload user mới từ DB
            user = userService.findUserById(user.getUserId());
            session.setAttribute("USER", user);

            if ("TEACHER".equalsIgnoreCase(role)) {
                session.setAttribute("PENDING_TEACHER_USER", user);
                resp.sendRedirect(req.getContextPath() + "/teacherRegister");
                return;
            }

            req.setAttribute("registerSuccess", "true");
            req.getRequestDispatcher("/views/auth/registerOtp.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("userError", e.toString());
            req.getRequestDispatcher("/views/auth/register.jsp")
                    .forward(req, resp);
        }

    }

}
