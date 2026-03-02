package courseitproject.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {
    "/shop",
    "/login",
    "/otpRegister",
    "/reset",
    "/otpverify"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(
            jakarta.servlet.ServletRequest request,
            jakarta.servlet.ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        String mode = req.getParameter("mode");

       

        /* =====================
           2️⃣ CHẶN OTP (forget + register)
           /login?mode=otp
           /otpRegister
        ====================== */
        if ((uri.contains("/login") && "otp".equals(mode))
                || uri.contains("/otpRegister") ||uri.contains("/otpverify")) {
            if (session == null || session.getAttribute("REG_EMAIL") == null) {
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }
        }

        /* =====================
           3️⃣ CHẶN RESET PASSWORD
           /login?mode=reset
           /reset
        ====================== */
        if ((uri.contains("/login") && "reset".equals(mode))
                || uri.contains("/reset")) {
            if (session == null
                    || session.getAttribute("ALLOW_RESET_PASSWORD") == null) {

                res.sendRedirect(req.getContextPath() + "/forget");
                return;
            }
        }

        // OK → cho đi tiếp
        chain.doFilter(request, response);
    }
}
