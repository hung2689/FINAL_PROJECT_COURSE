package courseitproject.service;

import courseitproject.model.TeacherJob;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.Date;
import java.util.List;

public class TeacherJobServiceImp implements ITeacherJobService {

    @Override
    public List<TeacherJob> findAllOpenJobs() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT j FROM TeacherJob j WHERE j.status IS NULL OR j.status = 'OPEN' ORDER BY j.createdAt DESC",
                            TeacherJob.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<TeacherJob> findAllJobs() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT j FROM TeacherJob j ORDER BY j.createdAt DESC",
                            TeacherJob.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<TeacherJob> findAllJobsPaging(int page, int pageSize) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT j FROM TeacherJob j ORDER BY j.createdAt DESC",
                            TeacherJob.class)
                    .setFirstResult((page - 1) * pageSize)
                    .setMaxResults(pageSize)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public TeacherJob findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(TeacherJob.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void createJob(TeacherJob job) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            job.setCreatedAt(new Date());
            job.setUpdatedAt(new Date());
            em.persist(job);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void updateJob(TeacherJob job) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            job.setUpdatedAt(new Date());
            em.merge(job);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void deleteJob(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            TeacherJob job = em.find(TeacherJob.class, id);
            if (job != null) {
                em.remove(job);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public long countAllJobs() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(j) FROM TeacherJob j", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public static void main(String[] args) {
        TeacherJobServiceImp t = new TeacherJobServiceImp();
        System.out.println(t.findById(7));
    }
}

