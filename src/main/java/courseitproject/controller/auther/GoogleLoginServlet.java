/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.auther;

import courseitproject.model.GoogleUser;
import courseitproject.model.Users;
import courseitproject.service.GoogleAuthService;
import courseitproject.service.IUserService;
import courseitproject.service.UserServiceImp;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "GoogleLoginServlet", urlPatterns = {"/login-google"})
public class GoogleLoginServlet extends HttpServlet {

    private   GoogleAuthService googleService  ;
    private  IUserService userService ;
    
    public void init(){
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

                userService.register(user,"USER");
            }

            req.getSession().setAttribute("USER", user);

            if (!user.getEmailVerified()) {
                resp.sendRedirect("complete-profile.jsp");
            } else {
                resp.sendRedirect(req.getContextPath()+"/shop");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=google");
        }
    }
}