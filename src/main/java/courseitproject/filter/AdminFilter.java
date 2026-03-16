package courseitproject.filter;

import courseitproject.model.Users;
import courseitproject.model.Role;
import courseitproject.service.IUserService;
import courseitproject.service.UserServiceImp;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/courseAdmin", "/userAdmin", "/admin/users",
    "/candidatesAdmin   ", "/transactionAdmin", "/admin/transaction-detail"})
public class AdminFilter implements Filter {

    private IUserService userService;

    @Override
    public void init(FilterConfig filterConfig) {
        userService = new UserServiceImp();
    }

    @Override
    public void doFilter(jakarta.servlet.ServletRequest request,
            jakarta.servlet.ServletResponse response,
            FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        if (session == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Users user = (Users) session.getAttribute("USER");

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Role role = userService.findOneRoleByUserId(user.getUserId());

        if (role == null || !"ADMIN".equalsIgnoreCase(role.getRoleName())) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        chain.doFilter(request, response);
    }
}
