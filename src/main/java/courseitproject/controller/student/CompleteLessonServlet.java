package courseitproject.controller.student;

import courseitproject.utils.JPAUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.persistence.EntityManager;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/complete-lesson")
public class CompleteLessonServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentIdStr = request.getParameter("studentId");
        String resourceIdStr = request.getParameter("resourceId"); 
        
        if (studentIdStr == null || resourceIdStr == null || studentIdStr.isEmpty() || resourceIdStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int studentId = Integer.parseInt(studentIdStr);
        int resourceId = Integer.parseInt(resourceIdStr);
        EntityManager em = JPAUtil.getEntityManager();
        
        try {
            em.getTransaction().begin();
            
            // 1. TÌM LESSON_ID BẰNG CÁCH DÙNG getResultList (Chống lỗi sập server)
            // ⚠️ CHÚ Ý: Nếu Database của bạn viết khác (ví dụ: LessionResource), hãy sửa lại dòng SQL này
            String findLessonSql = "SELECT lesson_id FROM LessonResource WHERE resource_id = :rid";
            
            List<?> results = em.createNativeQuery(findLessonSql)
                                .setParameter("rid", resourceId)
                                .getResultList();
            
            if (!results.isEmpty()) {
                int lessonId = ((Number) results.get(0)).intValue();
                
                // 2. Kiểm tra tiến độ
                String checkSql = "SELECT COUNT(*) FROM LearningProgress WHERE student_id = :sid AND lesson_id = :lid";
                int count = ((Number) em.createNativeQuery(checkSql)
                                        .setParameter("sid", studentId)
                                        .setParameter("lid", lessonId)
                                        .getSingleResult()).intValue();
                
                // 3. Lưu dữ liệu
                if (count == 0) {
                    String insertSql = "INSERT INTO LearningProgress (student_id, lesson_id, last_access) VALUES (:sid, :lid, CURRENT_TIMESTAMP())";
                    em.createNativeQuery(insertSql)
                      .setParameter("sid", studentId)
                      .setParameter("lid", lessonId)
                      .executeUpdate();
                    System.out.println("✅ [AI Tracking] Đã lưu tiến độ cho Lesson ID: " + lessonId);
                }
            } else {
System.out.println("❌ [Lỗi Data] Không tìm thấy bài học nào có resource_id là: " + resourceId);
            }
            
            em.getTransaction().commit();
            response.setStatus(HttpServletResponse.SC_OK);
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            System.out.println("❌ [LỖI NGHIÊM TRỌNG TRONG SERVLET]: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            em.close();
        }
    }
}