package courseitproject.service;

import courseitproject.model.Student;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.sql.Date;

public class StudentServiceImp implements IStudentService {

    @Override
    public Student getStudentById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Student.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateStudent(int id, Date dob, String level) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            int updated = em.createQuery(
                    "UPDATE Student s SET s.dateOfBirth = :dob, s.level = :level WHERE s.studentId = :id")
                    .setParameter("dob", dob)
                    .setParameter("level", level)
                    .setParameter("id", id)
                    .executeUpdate();
            tx.commit();
            return updated > 0;
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
