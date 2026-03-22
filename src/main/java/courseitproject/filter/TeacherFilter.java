package courseitproject.filter;

import courseitproject.model.Users;
import courseitproject.model.Role;
import courseitproject.model.RoleName;
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

@WebFilter(filterName = "TeacherFilter", urlPatterns = {
    "/teacherDashboard"
})
public class TeacherFilter implements Filter {

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

        // 1) Check session-cached role first — NO DB call
        String cachedRole = (String) session.getAttribute("ROLE");
        if (RoleName.TEACHER.matches(cachedRole)) {
            chain.doFilter(request, response);
            return;
        }

        // 2) Fallback: query DB only if session has no ROLE
        Role role = userService.findOneRoleByUserId(user.getUserId());

        if (role == null || !RoleName.TEACHER.matches(role.getRoleName())) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        session.setAttribute("ROLE", role.getRoleName());
        chain.doFilter(request, response);
    }
}
