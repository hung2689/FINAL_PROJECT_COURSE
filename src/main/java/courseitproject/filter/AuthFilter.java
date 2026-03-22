package courseitproject.filter;

import java.io.IOException;
import java.util.Set;
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
    "/otpverify",
    "/submit-error" // Đã thêm đường dẫn này vào để Filter nhận diện
})
public class AuthFilter implements Filter {

    private static final Set<String> OTP_PATHS = Set.of("/otpRegister", "/otpverify");
    private static final Set<String> RESET_PATHS = Set.of("/reset");

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
           [THÊM MỚI] CHO PHÉP SUBMIT-ERROR ĐI TIẾP MÀ KHÔNG BỊ CHẶN
        ====================== */
        if (uri.contains("/submit-error")) {
            chain.doFilter(request, response);
            return;
        }
         // OTP pages: require REG_EMAIL in session
        boolean isOtpPage = (uri.contains("/login") && "otp".equals(mode))
                || OTP_PATHS.stream().anyMatch(uri::contains);
 
        if (isOtpPage) {
            if (session == null || session.getAttribute("REG_EMAIL") == null) {
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }
        }

        // Reset pages: require ALLOW_RESET_PASSWORD in session
        boolean isResetPage = (uri.contains("/login") && "reset".equals(mode))
                || RESET_PATHS.stream().anyMatch(uri::contains);

        if (isResetPage) {
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
 }

 