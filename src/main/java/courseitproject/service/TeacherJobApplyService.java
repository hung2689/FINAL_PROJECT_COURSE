package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Candidates;
import courseitproject.model.TeacherJob;
import courseitproject.model.Users;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.Date;

public class TeacherJobApplyService {

    private final GenericDAO<Candidates> candidatesDAO = new GenericDAO<>(Candidates.class);

    public void applyForJob(Users user, TeacherJob job, String cvUrl) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
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

