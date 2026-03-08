package courseitproject.filter;

import courseitproject.model.Users;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * CartAuthFilter — guards all cart-related endpoints.
 * Any request to /cart, /addToCart, /removeFromCart, or /checkout
 * from an unauthenticated user is redirected to /login.
 */
@WebFilter(urlPatterns = {
        "/cart",
        "/addToCart",
        "/removeFromCart",
        "/checkout"
})
public class CartAuthFilter implements Filter {

    @Override
    public void doFilter(
            jakarta.servlet.ServletRequest request,
            jakarta.servlet.ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Never create a new session — only check an existing one
        HttpSession session = req.getSession(false);
        Users user = (session != null) ? (Users) session.getAttribute("USER") : null;

        if (user == null) {
            // Not logged in → redirect to login page
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Logged in → continue normally
        chain.doFilter(request, response);
    }
}
