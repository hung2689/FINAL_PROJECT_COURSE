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
import java.util.List;

@WebServlet(name = "ExamRoomServlet", urlPatterns = {"/exam-room"})
public class ExamRoomServlet extends HttpServlet {

    private final IMockExamService mockService = new MockExamServiceImp();

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
            
            // Just double check DB directly for attempt to prevent tamper
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

            if ("COMPLETED".equals(attempt.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/exam-result?attemptId=" + attemptId);
                return;
            }

            // Load Exam Questions
            List<MockQuestion> questions = mockService.getQuestionsByExamId(attempt.getExamId().getExamId());
            
            request.setAttribute("attempt", attempt);
            request.setAttribute("exam", attempt.getExamId());
            request.setAttribute("questions", questions);
            
            // Forward to the Focus Mode UI
            request.getRequestDispatcher("/views/exam/exam-room.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/mock-exams");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        Users user = (Users) request.getSession().getAttribute("USER");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int attemptId = Integer.parseInt(request.getParameter("attemptId"));
            
            // Collect answers. Form sends: q_1=A, q_2=C...
            java.util.Map<Integer, String> userAnswers = new java.util.HashMap<>();
            for (String paramName : request.getParameterMap().keySet()) {
                if (paramName.startsWith("q_")) {
                    int qId = Integer.parseInt(paramName.substring(2));
                    String val = request.getParameter(paramName);
                    userAnswers.put(qId, val);
                }
            }
            
            MockAttempt completedAttempt = mockService.submitExam(attemptId, userAnswers);
            
            if (completedAttempt != null) {
                // Return to Results Page
                response.sendRedirect(request.getContextPath() + "/exam-result?attemptId=" + completedAttempt.getAttemptId());
            } else {
                response.sendRedirect(request.getContextPath() + "/mock-exams?error=submit_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/mock-exams?error=server_error");
        }
    }
}

