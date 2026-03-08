package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Course;
import courseitproject.model.Section;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;

public class SectionEditService extends GenericDAO<Section> {

    public SectionEditService() {
        super(Section.class);
    }

    public int getNextOrderIndex(int courseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {

            Integer max = em.createQuery(
                    "SELECT MAX(s.orderIndex) FROM Section s WHERE s.courseId.courseId = :cid",
                    Integer.class)
                    .setParameter("cid", courseId)
                    .getSingleResult();

            return (max == null) ? 1 : max + 1;

        } finally {
            em.close();
        }
    }

    public static void main(String[] args) {
        SectionEditService y = new SectionEditService();
        System.out.println(y.getNextOrderIndex(10));
    }

    public Section create(Course course, String title, int orderIndex) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        Section section = new Section();
        section.setCourseId(course);
        section.setTitle(title);
        section.setOrderIndex(orderIndex);
        try {
            tx.begin();
            em.persist(section);
            tx.commit();
            return section;
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

    public boolean update(int sectionId, String title) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Section section = em.find(Section.class, sectionId);
            if (section != null) {
                section.setTitle(title);
                em.merge(section);
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

    public boolean delete(int sectionId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            // 1. Delete all LessonResources for all Lessons in this Section
            Query delResources = em.createQuery(
                    "DELETE FROM LessonResource lr WHERE lr.lessonId IN "
                    + "(SELECT l FROM Lesson l WHERE l.sectionId.sectionId = :sectionId)");
            delResources.setParameter("sectionId", sectionId);
            delResources.executeUpdate();

            // 2. Delete all Quizzes for all Lessons in this Section (assuming Quiz might
            // exist based on Lesson model)
            Query delQuizzes = em.createQuery(
                    "DELETE FROM Quiz q WHERE q.lessonId IN "
                    + "(SELECT l FROM Lesson l WHERE l.sectionId.sectionId = :sectionId)");
            delQuizzes.setParameter("sectionId", sectionId);
            delQuizzes.executeUpdate();

            // Delete all LearningProgresses for all Lessons in this Section
            Query delProgress = em.createQuery(
                    "DELETE FROM LearningProgress lp WHERE lp.lessonId IN "
                    + "(SELECT l FROM Lesson l WHERE l.sectionId.sectionId = :sectionId)");
            delProgress.setParameter("sectionId", sectionId);
            delProgress.executeUpdate();

            // 3. Delete all Lessons in this Section
            Query delLessons = em.createQuery(
                    "DELETE FROM Lesson l WHERE l.sectionId.sectionId = :sectionId");
            delLessons.setParameter("sectionId", sectionId);
            delLessons.executeUpdate();

            // 4. Delete the Section itself
            Section section = em.find(Section.class, sectionId);
            if (section != null) {
                em.remove(section);
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
