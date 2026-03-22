package courseitproject.controller.exam;

import courseitproject.model.MockAttempt;
import courseitproject.model.Users;
import courseitproject.service.IMockExamService;
import courseitproject.service.MockExamServiceImp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "StartExamServlet", urlPatterns = {"/start-exam"})
public class StartExamServlet extends HttpServlet {

    private final IMockExamService mockService = new MockExamServiceImp();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("USER");
        
        if (user == null) {
            session.setAttribute("toastMessage", "Phiên đăng nhập hết hạn!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int examId = Integer.parseInt(request.getParameter("examId"));
            
            // Check if user already has an active attempt, if so, redirect them there!
            MockAttempt activeAttempt = mockService.getActiveAttempt(user.getUserId(), examId);
            if (activeAttempt != null) {
                response.sendRedirect(request.getContextPath() + "/exam-room?attemptId=" + activeAttempt.getAttemptId());
                return;
            }

            // Deduct coins & create a new attempt ticket
            MockAttempt newAttempt = mockService.enterExam(user.getUserId(), examId);
            
            if (newAttempt == null) {
                // Return to mock-exams hub with error
                request.setAttribute("errorMessage", "Không đủ Điểm thưởng (xu) hoặc có lỗi xảy ra. Hãy nạp thêm!");
                request.getRequestDispatcher("/mock-exams").forward(request, response);
                return;
            }
            
            // Update the User in Session to reflect the deducted coins
            user.setStudyCoins(user.getStudyCoins() - newAttempt.getCoinsDeducted());
            session.setAttribute("USER", user);
            
            // Success! Jump to the Exam Room
            response.sendRedirect(request.getContextPath() + "/exam-room?attemptId=" + newAttempt.getAttemptId());
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/mock-exams").forward(request, response);
        }
    }
}
