package courseitproject.controller.exam;

import courseitproject.model.MockAttempt;
import courseitproject.model.MockQuestion;
import courseitproject.model.Users;
import courseitproject.service.IMockExamService;
import courseitproject.service.MockExamServiceImp;
import courseitproject.utils.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ExamResultServlet", urlPatterns = {"/exam-result"})
public class ExamResultServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        Users user = (Users) request.getSession().getAttribute("USER");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int attemptId = Integer.parseInt(request.getParameter("attemptId"));
            
            EntityManager em = JPAUtil.getEntityManager();
            MockAttempt attempt;
            try {
                attempt = em.find(MockAttempt.class, attemptId);
            } finally {
                em.close();
            }
            
            if (attempt == null || !attempt.getUserId().getUserId().equals(user.getUserId())) {
                response.sendRedirect(request.getContextPath() + "/mock-exams");
                return;
            }

            // Must be COMPLETED to view results
            if (!"COMPLETED".equals(attempt.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/exam-room?attemptId=" + attemptId);
                return;
            }

            request.setAttribute("attempt", attempt);
            request.setAttribute("exam", attempt.getExamId());
            
            request.getRequestDispatcher("/views/exam/exam-result.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/mock-exams");
        }
    }
}
