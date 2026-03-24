package courseitproject.dao;

import courseitproject.model.RepoSubmission;
import jakarta.persistence.EntityManager;
import java.util.List;

public class TeacherAssignmentDAO {

    public List<RepoSubmission> getSubmissionsByTeacher(EntityManager em, int teacherId) {
        String jpql = "SELECT r FROM RepoSubmission r " +
                      "JOIN r.assignmentId a " +
                      "JOIN a.lessonId l " +
                      "JOIN l.courseId c " +
                      "JOIN c.courseTeacherCollection ct " +
                      "WHERE ct.teacherId.teacherId = :teacherId " +
                      "ORDER BY r.submittedAt DESC";
        return em.createQuery(jpql, RepoSubmission.class)
                 .setParameter("teacherId", teacherId)
                 .getResultList();
    }
}
