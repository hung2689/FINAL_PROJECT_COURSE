
package courseitproject.service;

import courseitproject.model.*;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;

import java.time.LocalDateTime;
import java.util.List;

public class EnrollmentServiceImp implements IEnrollmentService {

    // ===============================
    // GET ALL ENROLLMENTS BY STUDENT
    // ===============================
    @Override
    public List<Enrollment> getCoursesByStudentId(int studentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT e FROM Enrollment e " +
                    "JOIN FETCH e.courseId " +
                    "WHERE e.studentId.studentId = :sid " +
                    "ORDER BY e.enrollmentDate DESC",
                    Enrollment.class)
                    .setParameter("sid", studentId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    // ===============================
    // PAGINATION
    // ===============================
   
    @Override
    public List<Enrollment> getEnrollmentsByStudent(int studentId, int offset, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT e FROM Enrollment e " +
                    "LEFT JOIN FETCH e.courseId " + // SỬA THÀNH LEFT JOIN FETCH
                    "WHERE e.studentId.studentId = :sid " +
                    "ORDER BY e.enrollmentDate DESC",
                    Enrollment.class)
                    .setParameter("sid", studentId)
                    .setFirstResult(offset)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            em.close();
        }
    }
    // ===============================
    // COUNT
    // ===============================
    @Override
    public int countEnrollmentsByStudent(int studentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(e) FROM Enrollment e " +
                    "WHERE e.studentId.studentId = :sid",
                    Long.class)
                    .setParameter("sid", studentId)
                    .getSingleResult();

            return count == null ? 0 : count.intValue();
        } finally {
            em.close();
        }
    }

    // ==================================================
    // ENROLL SINGLE COURSE (BUY NOW)
    // ==================================================
   
    public void enrollSingleCourse(int studentId, int courseId) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            Student student = em.find(Student.class, studentId);
            Course course = em.find(Course.class, courseId);

            if (student == null || course == null) {
                em.getTransaction().rollback();
                return;
            }

            // CHECK TRÙNG
            boolean alreadyEnrolled = em.createQuery(
                    "SELECT COUNT(e) > 0 FROM Enrollment e " +
                    "WHERE e.studentId.studentId = :sid " +
                    "AND e.courseId.courseId = :cid",
                    Boolean.class)
                    .setParameter("sid", studentId)
                    .setParameter("cid", courseId)
                    .getSingleResult();

            if (!alreadyEnrolled) {
                Enrollment enrollment = new Enrollment();
                enrollment.setStudentId(student);
                enrollment.setCourseId(course);
                enrollment.setEnrollmentDate(LocalDateTime.now());

                em.persist(enrollment);
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ==================================================
    // ENROLL FROM ORDER (SAU KHI THANH TOÁN)
    // ==================================================
  
    public void enrollFromOrder(int orderId) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            CourseOrder order = em.find(CourseOrder.class, orderId);

            if (order == null || !"PAID".equals(order.getStatus())) {
                em.getTransaction().rollback();
                return;
            }

            Student student = order.getStudentId();

            List<CourseOrderItem> items = em.createQuery(
                    "SELECT oi FROM CourseOrderItem oi " +
                    "JOIN FETCH oi.course " +
                    "WHERE oi.order.orderId = :oid",
                    CourseOrderItem.class)
                    .setParameter("oid", orderId)
                    .getResultList();

            for (CourseOrderItem item : items) {

                Course course = item.getCourse();

                boolean alreadyEnrolled = em.createQuery(
                        "SELECT COUNT(e) > 0 FROM Enrollment e " +
                        "WHERE e.studentId.studentId = :sid " +
                        "AND e.courseId.courseId = :cid",
                        Boolean.class)
                        .setParameter("sid", student.getStudentId())
                        .setParameter("cid", course.getCourseId())
                        .getSingleResult();

                if (!alreadyEnrolled) {
                    Enrollment enrollment = new Enrollment();
                    enrollment.setStudentId(student);
                    enrollment.setCourseId(course);
                    enrollment.setEnrollmentDate(LocalDateTime.now());

                    em.persist(enrollment);
                }
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}