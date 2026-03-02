package courseitproject.service;

import courseitproject.model.Enrollment;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class EnrollmentServiceImp implements IEnrollmentService {

    @Override
    public List<Enrollment> getCoursesByStudentId(int studentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT e FROM Enrollment e "
                            + "JOIN FETCH e.courseId c "
                            + "WHERE e.studentId.studentId = :sid "
                            + "ORDER BY e.enrollmentDate DESC",
                    Enrollment.class)
                    .setParameter("sid", studentId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Enrollment> getEnrollmentsByStudent(int studentId, int offset, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT e FROM Enrollment e "
                            + "JOIN FETCH e.courseId c "
                            + "WHERE e.studentId.studentId = :sid "
                            + "ORDER BY e.enrollmentDate DESC",
                    Enrollment.class)
                    .setParameter("sid", studentId)
                    .setFirstResult(offset)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public int countEnrollmentsByStudent(int studentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(e) FROM Enrollment e "
                            + "JOIN e.studentId s "
                            + "WHERE s.studentId = :sid",
                    Long.class)
                    .setParameter("sid", studentId)
                    .getSingleResult();
            return count == null ? 0 : count.intValue();
        } finally {
            em.close();
        }
    }
}
