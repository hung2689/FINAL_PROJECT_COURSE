package courseitproject.service;

import courseitproject.model.Candidates;
import courseitproject.model.TeacherJob;
import courseitproject.model.Users;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.Date;

public class TeacherJobApplyService {

    private final courseitproject.dao.CandidatesDAO candidatesDAO = new courseitproject.dao.CandidatesDAO();

    public boolean applyForJob(Users user, TeacherJob job, String cvUrl) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            // Check if user has already applied for this job using the new DAO
            if (candidatesDAO.existsByUserIdAndJobId(em, user, job)) {
                return false; // Already applied
            }

            tx.begin();

            Candidates c = new Candidates();
            c.setUserId(user);
            c.setName(user.getFullName());
            c.setEmail(user.getEmail());
            c.setCvText(cvUrl);
            c.setDecision("PENDING");
            c.setCreatedAt(new Date());
            c.setJobId(job);

            candidatesDAO.save(em, c);

            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
}

