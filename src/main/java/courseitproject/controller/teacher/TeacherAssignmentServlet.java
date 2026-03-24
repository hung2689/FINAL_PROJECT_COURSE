package courseitproject.controller.teacher;

import courseitproject.dao.TeacherAssignmentDAO;
import courseitproject.model.RepoSubmission;
import courseitproject.model.Users;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "TeacherAssignmentServlet", urlPatterns = {"/teacher/assignments"})
public class TeacherAssignmentServlet extends HttpServlet {

    private final TeacherAssignmentDAO dao = new TeacherAssignmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("USER");
        String role = (String) session.getAttribute("ROLE");

        if (user == null || !"TEACHER".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<RepoSubmission> submissions = dao.getSubmissionsByTeacher(em, user.getUserId());
            request.setAttribute("submissions", submissions);
            request.getRequestDispatcher("/views/teacher/teacher-assignments.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Có khả năng sẽ dùng để Override điểm AI trong tương lai
    }
}
