package courseitproject.service;

import courseitproject.model.CourseOrder;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;

public class CourseOrderService {
    
    public CourseOrder findById(int orderId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(CourseOrder.class, orderId);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public void updateStatus(int orderId, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            CourseOrder order = em.find(CourseOrder.class, orderId);
            if (order != null) {
                order.setStatus(status);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public int save(CourseOrder order) {
        // 1. Khởi tạo công cụ kết nối (EntityManager)
        EntityManager em = JPAUtil.getEntityManager(); 
        
        try {
            em.getTransaction().begin();
            
            // 2. Lưu đối tượng vào Database
            em.persist(order); 
            
            // 3. Ép JPA chạy lệnh Insert ngay lập tức để lấy ID tự tăng
            em.flush(); 
            
            em.getTransaction().commit();
            
            // 4. Trả về ID vừa được tạo
            return order.getOrderId(); 
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return -1; // Trả về -1 nếu có lỗi xảy ra
        } finally {
            // 5. Luôn nhớ đóng kết nối để tránh tràn bộ nhớ
            if (em != null && em.isOpen()) {
                em.close(); 
            }
        }
    }
}