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
     * Tìm hồ sơ mới nhất của user cho job này
     */
    public Candidates findLatestByUserIdAndJobId(EntityManager em, Users user, TeacherJob job) {
        String jpql = "SELECT c FROM Candidates c WHERE c.userId = :user AND c.jobId = :job ORDER BY c.createdAt DESC";
        List<Candidates> existing = em.createQuery(jpql, Candidates.class)
                .setParameter("user", user)
                .setParameter("job", job)
                .setMaxResults(1)
                .getResultList();

        return existing.isEmpty() ? null : existing.get(0);
    }
}
