package courseitproject.controller.student;

import courseitproject.utils.JPAUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.persistence.EntityManager;
import java.io.IOException;

@WebServlet("/api/submit-quiz-result")
public class SubmitQuizResultServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentIdStr = request.getParameter("studentId");
        String quizIdStr = request.getParameter("quizId");
        String scoreStr = request.getParameter("score"); 
        
        if (studentIdStr == null || quizIdStr == null || studentIdStr.isEmpty() || quizIdStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int studentId = Integer.parseInt(studentIdStr);
        int quizId = Integer.parseInt(quizIdStr);
        
        // Vì trong CSDL của bạn cột score là kiểu [int], ta phải ép về số nguyên
        int score = 0;
        if (scoreStr != null && !scoreStr.isEmpty()) {
            score = (int) Math.round(Double.parseDouble(scoreStr)); 
        }
        
        EntityManager em = JPAUtil.getEntityManager();
        
        try {
            em.getTransaction().begin();
            
            // Đã dùng chính xác cột attempt_time và bảng QuizResult theo file SQL của bạn!
            String insertSql = "INSERT INTO QuizResult (student_id, quiz_id, score, attempt_time) VALUES (:sid, :qid, :score, CURRENT_TIMESTAMP())";
            
            em.createNativeQuery(insertSql)
              .setParameter("sid", studentId)
              .setParameter("qid", quizId)
              .setParameter("score", score)
              .executeUpdate();
              
            System.out.println("✅ [AI Tracking] Học viên " + studentId + " vừa nộp bài Quiz " + quizId + " (Điểm: " + score + ")");
            
            em.getTransaction().commit();
            response.setStatus(HttpServletResponse.SC_OK);
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            System.out.println("❌ [Lỗi lưu Quiz]: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            em.close();
        }
    }
}