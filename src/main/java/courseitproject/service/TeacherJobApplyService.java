package courseitproject.service;

import courseitproject.model.Candidates;
import courseitproject.model.TeacherJob;
import courseitproject.model.Users;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class TeacherJobApplyService {

    private final courseitproject.dao.CandidatesDAO candidatesDAO = new courseitproject.dao.CandidatesDAO();

    public boolean applyForJob(Users user, TeacherJob job, String cvUrl) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            Candidates existing = candidatesDAO.findLatestByUserIdAndJobId(em, user, job);

            if (existing != null) {
                if (!"PENDING".equals(existing.getDecision())) {
                    tx.rollback();
                    return false; // Đã chấm (ACCEPTED/REJECTED) -> Chặn đứng
                }

                // Ghi đè CV bản nháp (PENDING)
                existing.setCvText(cvUrl);
                existing.setCreatedAt(new java.util.Date());
                existing.setScore(null);
                existing.setSkillsCount(null);
                existing.setProjectsCount(null);

                candidatesDAO.update(em, existing);
            } else {
                // Tạo mới hoàn toàn
                Candidates c = new Candidates();
                c.setUserId(user);
                c.setName(user.getFullName());
                c.setEmail(user.getEmail());
                c.setCvText(cvUrl);
                c.setDecision("PENDING");
                c.setCreatedAt(new java.util.Date());
                c.setJobId(job);

                candidatesDAO.save(em, c);
            }

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

