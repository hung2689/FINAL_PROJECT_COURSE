package courseitproject.dao;

import courseitproject.model.RepoSubmission;
import jakarta.persistence.EntityManager;
import java.util.List;

public class TeacherAssignmentDAO {

    public List<RepoSubmission> getSubmissionsByTeacher(EntityManager em, int teacherId) {
        String jpql = "SELECT DISTINCT r FROM RepoSubmission r " +
                      "JOIN FETCH r.assignmentId a " +
                      "JOIN FETCH a.lessonId l " +
                      "JOIN FETCH l.courseId c " +
                      "JOIN FETCH r.studentId s " +
                      "JOIN FETCH s.users u " +
                      "JOIN c.courseTeacherCollection ct " +
                      "WHERE ct.teacherId.teacherId = :teacherId " +
                      "ORDER BY r.submittedAt DESC";
        return em.createQuery(jpql, RepoSubmission.class)
                 .setParameter("teacherId", teacherId)
                 .getResultList();
    }
}
