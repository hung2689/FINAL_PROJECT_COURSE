/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.auther;

import courseitproject.model.GoogleUser;
import courseitproject.model.Role;
import courseitproject.model.RoleName;
import courseitproject.model.Users;
import courseitproject.service.GoogleAuthService;
import courseitproject.service.IUserService;
import courseitproject.service.UserServiceImp;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "GoogleLoginServlet", urlPatterns = {"/login-google"})
public class GoogleLoginServlet extends HttpServlet {

    private GoogleAuthService googleService;
    private IUserService userService;

    @Override
    public void init() {
        googleService = new GoogleAuthService();
        userService = new UserServiceImp();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {
            String code = req.getParameter("code");
            if (code == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            String accessToken = googleService.getAccessToken(code);
            GoogleUser ggUser = googleService.getUserInfo(accessToken);

            Users user = userService.findUserByEmail(ggUser.getEmail());

            if (user == null) {
                user = new Users();
                user.setEmail(ggUser.getEmail());
                user.setFullName(ggUser.getName());
                user.setProvider("GOOGLE");
                user.setProviderId(ggUser.getSub());
                user.setEmailVerified(false);
                user.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

                userService.createGoogleUser(user);
            }
            user = userService.findUserByEmail(user.getEmail());
            
            java.time.LocalDate today = java.time.LocalDate.now();
            boolean isFirstLoginToday = false;
            // Handle lastLoginDate for Google Users
            if (user.getLastLoginDate() == null || !new java.sql.Date(user.getLastLoginDate().getTime()).toLocalDate().isEqual(today)) {
                int currentCoins = user.getStudyCoins() != null ? user.getStudyCoins() : 0;
                user.setStudyCoins(currentCoins + 20);
                user.setLastLoginDate(java.sql.Date.valueOf(today));
                isFirstLoginToday = true;
                userService.updateStudyCoins(user.getUserId(), user.getStudyCoins(), user.getLastLoginDate());
            }

            req.getSession().setAttribute("USER", user);
            if (isFirstLoginToday) {
                req.getSession().setAttribute("toastMessage", "Chúc mừng! Bạn được +20 xu nhờ đăng nhập hôm nay!");
            }


            if (!user.getEmailVerified()) {
                resp.sendRedirect(req.getContextPath() + "/complete-profile");
            } else {
                postCheck(req, resp, user);
            }

        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    protected void postCheck(HttpServletRequest request, HttpServletResponse response, Users user)
            throws ServletException, IOException {
        List<Role> roleList = userService.findRolesByUserId(user.getUserId());
        boolean isStudent = false;
        boolean isAdmin = false;
        boolean isTeacher = false;

        for (Role r : roleList) {
            if (RoleName.STUDENT.matches(r.getRoleName())) {
                isStudent = true;
            }
            if (RoleName.ADMIN.matches(r.getRoleName())) {
                isAdmin = true;
            }
            if (RoleName.TEACHER.matches(r.getRoleName())) {
                isTeacher = true;
            }
        }

        if (isAdmin) {
            request.getSession().setAttribute("ROLE", RoleName.ADMIN.name());
            response.sendRedirect(request.getContextPath() + "/courseAdmin");
        } else if (isTeacher) {
            request.getSession().setAttribute("ROLE", RoleName.TEACHER.name());
            response.sendRedirect(request.getContextPath() + "/teacherDashboard");
        } else if (isStudent) {
            request.getSession().setAttribute("ROLE", RoleName.STUDENT.name());
            new courseitproject.dao.DashboardStatsDAO().recordStudentLogin(user.getUserId());
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.getSession().setAttribute("ROLE", "OTHER");
            response.sendRedirect(request.getContextPath() + "/shop");
        }
    }

}
