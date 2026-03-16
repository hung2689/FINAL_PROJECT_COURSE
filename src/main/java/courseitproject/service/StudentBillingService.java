package courseitproject.service;

import courseitproject.model.CourseOrder;
import courseitproject.model.CourseOrderItem;
import courseitproject.model.CoursePayment;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;

import java.util.Collections;
import java.util.List;

public class StudentBillingService {

    /**
     * Get all orders for a student, ordered by created_at DESC.
     */
    public List<CourseOrder> getOrdersByStudentId(int studentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT o FROM CourseOrder o "
                            + "WHERE o.studentId.studentId = :sid "
                            + "ORDER BY o.createdAt DESC",
                    CourseOrder.class)
                    .setParameter("sid", studentId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }

    /**
     * Get a single order by ID, with order items + course eagerly fetched.
     */
    public CourseOrder getOrderDetail(int orderId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<CourseOrder> results = em.createQuery(
                    "SELECT DISTINCT o FROM CourseOrder o "
                            + "LEFT JOIN FETCH o.courseOrderItemCollection items "
                            + "LEFT JOIN FETCH items.courseId "
                            + "WHERE o.orderId = :oid",
                    CourseOrder.class)
                    .setParameter("oid", orderId)
                    .getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }

    /**
     * Get the payment record associated with an order (via vnp_txn_ref = orderId).
     */
    public CoursePayment getPaymentByOrderId(int orderId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<CoursePayment> results = em.createQuery(
                    "SELECT p FROM CoursePayment p "
                            + "WHERE p.vnpTxnRef = :ref "
                            + "ORDER BY p.createdAt DESC",
                    CoursePayment.class)
                    .setParameter("ref", String.valueOf(orderId))
                    .getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }

    /**
     * Get the first teacher name for a course.
     */
    public String getInstructorName(int courseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<String> results = em.createQuery(
                    "SELECT u.fullName FROM CourseTeacher ct "
                            + "JOIN ct.teacherId t "
                            + "JOIN t.users u "
                            + "WHERE ct.courseId.courseId = :cid",
                    String.class)
                    .setParameter("cid", courseId)
                    .setMaxResults(1)
                    .getResultList();
            return results.isEmpty() ? "Unknown" : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return "Unknown";
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
}
