package courseitproject.service;

import courseitproject.model.CourseOrder;
import courseitproject.model.Student;
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
        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            // FIX: Ensure Student exists and is managed to avoid
            // TransientPropertyValueException or EntityNotFoundException
            if (order.getStudentId() != null && order.getStudentId().getStudentId() != null) {
                Integer sId = order.getStudentId().getStudentId();
                Student managedStudent = em.find(Student.class, sId);
                if (managedStudent == null) {
                    // Create minimal Student record if it doesn't exist
                    managedStudent = new Student(sId);
                    em.persist(managedStudent);
                    em.flush();
                }
                order.setStudentId(managedStudent);
            }

            em.persist(order);
            em.flush();
            em.getTransaction().commit();

            return order.getOrderId();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return -1;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}