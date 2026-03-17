package courseitproject.controller.student; // Đặt đúng package của bạn

import courseitproject.model.StudyLog;
import courseitproject.model.Users;
import courseitproject.utils.JPAUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.persistence.EntityManager;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

// Đây là đường dẫn mà Javascript sẽ gọi tới
@WebServlet("/api/track-study-time")
public class StudyTimeTrackingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentIdStr = request.getParameter("studentId");
        if (studentIdStr == null || studentIdStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int studentId = Integer.parseInt(studentIdStr);
        EntityManager em = JPAUtil.getEntityManager();
        
        try {
            em.getTransaction().begin();
            
            // Dùng SQL thuần để update hoặc insert cho an toàn
            String updateSql = "UPDATE StudyLog SET study_time = study_time + 1, access_time = GETDATE() " +
                               "WHERE student_id = :sid AND CAST(access_time AS DATE) = CAST(GETDATE() AS DATE)";
            
            int updatedCount = em.createNativeQuery(updateSql)
                                 .setParameter("sid", studentId)
                                 .executeUpdate();
            
            // Nếu hôm nay chưa có phút học nào -> Bắt đầu tạo mới (1 phút)
            if (updatedCount == 0) {
                String insertSql = "INSERT INTO StudyLog (student_id, study_time, access_time) VALUES (:sid, 1, GETDATE())";
                em.createNativeQuery(insertSql)
                  .setParameter("sid", studentId)
                  .executeUpdate();
            }
            
            em.getTransaction().commit();
            
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"status\": \"success\"}");
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            em.close();
        }
    }
}