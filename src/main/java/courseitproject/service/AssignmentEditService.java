package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Assignment;
import courseitproject.model.Lesson;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class AssignmentEditService extends GenericDAO<Assignment> {

    public AssignmentEditService() {
        super(Assignment.class);
    }

    public Assignment create(Lesson lesson, String title, String description, String criteria, String expectedOutput, String fileExtensions) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        Assignment assignment = new Assignment();
        assignment.setLessonId(lesson);
        assignment.setTitle(title);
        assignment.setDescription(description);
        assignment.setCriteria(criteria);
        assignment.setExpectedOutput(expectedOutput);
        assignment.setFileExtensions(fileExtensions);
        try {
            tx.begin();
            em.persist(assignment);
            tx.commit();
            return assignment;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public boolean update(int assignmentId, String title, String description, String criteria, String expectedOutput, String fileExtensions) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Assignment assignment = em.find(Assignment.class, assignmentId);
            if (assignment != null) {
                assignment.setTitle(title);
                assignment.setDescription(description);
                assignment.setCriteria(criteria);
                assignment.setExpectedOutput(expectedOutput);
                assignment.setFileExtensions(fileExtensions);
                em.merge(assignment);
                tx.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean delete(int assignmentId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Assignment assignment = em.find(Assignment.class, assignmentId);
            if (assignment != null) {
                em.remove(assignment);
                tx.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
