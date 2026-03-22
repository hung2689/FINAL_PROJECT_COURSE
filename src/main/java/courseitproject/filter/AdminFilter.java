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
import java.util.Set;

@WebFilter(filterName = "AdminFilter", urlPatterns = {
    "/courseAdmin", "/userAdmin", "/admin/users",
    "/candidatesAdmin", "/transactionAdmin", "/admin/transaction-detail",
    "/jobAdmin", "/adminDashboard",
    "/lessonAdmin", "/sectionAdmin", "/resourceAdmin", "/assignmentAdmin",
    "/api/dashboard/charts", "/api/dashboard/dropout-rate"
})
public class AdminFilter implements Filter {

    private IUserService userService;
    private static final Set<String> TEACHER_ALLOWED_ROUTES = Set.of(
            "/lessonAdmin", "/sectionAdmin", "/resourceAdmin", "/assignmentAdmin"
    );
    private static final Set<String> ADMIN_ONLY_ROUTES = Set.of(
            "/courseAdmin", "/userAdmin", "/admin/users",
            "/candidatesAdmin", "/transactionAdmin", "/admin/transaction-detail",
            "/jobAdmin", "/adminDashboard",
            "/api/dashboard/charts", "/api/dashboard/dropout-rate"
    );

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

        // 1) Check session-cached role first (set during login) — NO DB call
        String cachedRole = (String) session.getAttribute("ROLE");
        String uri = req.getRequestURI();
        
        boolean isTeacherAllowedRoute = TEACHER_ALLOWED_ROUTES.stream().anyMatch(uri::contains);
        boolean isAdminAllowedRoute = ADMIN_ONLY_ROUTES.stream().anyMatch(uri::contains) || isTeacherAllowedRoute;

        if ((isAdminAllowedRoute && RoleName.ADMIN.matches(cachedRole)) || (isTeacherAllowedRoute && RoleName.TEACHER.matches(cachedRole))) {
            chain.doFilter(request, response);
            return;
        }

        // 2) Fallback: query DB only if session has no ROLE (safety net)
        Role role = userService.findOneRoleByUserId(user.getUserId());

        if (role == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        boolean isAdmin = RoleName.ADMIN.matches(role.getRoleName());
        boolean isTeacher = RoleName.TEACHER.matches(role.getRoleName());

        if (!(isAdminAllowedRoute && isAdmin) && !(isTeacherAllowedRoute && isTeacher)) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Cache for future requests so we don't hit DB again
        session.setAttribute("ROLE", role.getRoleName());
        chain.doFilter(request, response);
    }
}
