package courseitproject.dao;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Candidates;
import courseitproject.model.TeacherJob;
import courseitproject.model.Users;
import jakarta.persistence.EntityManager;

import java.util.List;

public class CandidatesDAO extends GenericDAO<Candidates> {

    public CandidatesDAO() {
        super(Candidates.class);
    }

    /**
     * Check if a candidate already exists for the given user and job.
     */
    public boolean existsByUserIdAndJobId(EntityManager em, Users user, TeacherJob job) {
        String jpql = "SELECT c FROM Candidates c WHERE c.userId = :user AND c.jobId = :job";
        List<Candidates> existing = em.createQuery(jpql, Candidates.class)
                .setParameter("user", user)
                .setParameter("job", job)
                .getResultList();

        return !existing.isEmpty();
    }
}
