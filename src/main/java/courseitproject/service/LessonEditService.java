package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Lesson;
import courseitproject.model.Section;
import courseitproject.model.Course;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;

public class LessonEditService extends GenericDAO<Lesson> {

    public LessonEditService() {
        super(Lesson.class);
    }

    public Lesson create(Section section, String title, int orderIndex) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        Lesson lesson = new Lesson();
        lesson.setSectionId(section);
        lesson.setCourseId(new Course(section.getCourseId()));
        lesson.setTitle(title);
        lesson.setOrderIndex(orderIndex);
        try {
            tx.begin();

            em.createQuery("UPDATE Lesson l SET l.orderIndex = l.orderIndex + 1 WHERE l.sectionId.sectionId = :sid AND l.orderIndex >= :idx")
              .setParameter("sid", section.getSectionId())
              .setParameter("idx", orderIndex)
              .executeUpdate();

            em.persist(lesson);
            tx.commit();
            return lesson;
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

    public int getNextOrderIndex(int sectionId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Integer max = em.createQuery(
                    "SELECT MAX(l.orderIndex) FROM Lesson l WHERE l.sectionId.sectionId = :sid",
                    Integer.class)
                    .setParameter("sid", sectionId)
                    .getSingleResult();

            return (max == null) ? 1 : max + 1;

        } finally {
            em.close();
        }
    }
    public static void main(String[] args) {
        LessonEditService t = new LessonEditService();
        System.out.println( t.getNextOrderIndex(10));
    }
    public boolean update(int lessonId, String title) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Lesson lesson = em.find(Lesson.class, lessonId);
            if (lesson != null) {
                lesson.setTitle(title);
                em.merge(lesson);
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

    public boolean delete(int lessonId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            // 1. Delete all LessonResources for this Lesson
            Query delResources = em.createQuery(
                    "DELETE FROM LessonResource lr WHERE lr.lessonId.lessonId = :lessonId");
            delResources.setParameter("lessonId", lessonId);
            delResources.executeUpdate();

            // 2. Delete all Quizzes for this Lesson
            Query delQuizzes = em.createQuery(
                    "DELETE FROM Quiz q WHERE q.lessonId.lessonId = :lessonId");
            delQuizzes.setParameter("lessonId", lessonId);
            delQuizzes.executeUpdate();

            // 3. Delete all LearningProgresses for this Lesson
            Query delProgress = em.createQuery(
                    "DELETE FROM LearningProgress lp WHERE lp.lessonId.lessonId = :lessonId");
            delProgress.setParameter("lessonId", lessonId);
            delProgress.executeUpdate();

            // 4. Delete the Lesson itself
            Lesson lesson = em.find(Lesson.class, lessonId);
            if (lesson != null) {
                em.remove(lesson);
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
