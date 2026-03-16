package courseitproject.service;

import courseitproject.model.TeacherJob;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
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
    public TeacherJob findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(TeacherJob.class, id);
        } finally {
            em.close();
        }
    }
    public static void main(String[] args) {
        TeacherJobServiceImp t = new TeacherJobServiceImp();
        System.out.println(t.findById(7));
    }
}

