package courseitproject.dao;

import courseitproject.dao.ICourseDetailDAO;
import courseitproject.dao.base.BaseDAO;
import courseitproject.model.Course;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.Collection;

public class CourseDetailDAOImpl extends BaseDAO implements ICourseDetailDAO {

    @Override
    public Course findCourseWithFullDetails(int courseId) {
        EntityManager em = getEntityManager();
        try {
            Course course = em.find(Course.class, courseId);
            if (course == null)
                return null;

            // Manual fetch to guarantee data is fully hydrated and bypass Fetch/Lazy
            // evaluation bugs
            String sectionJpql = "SELECT s FROM Section s WHERE s.courseId = :courseId ORDER BY s.orderIndex ASC";
            TypedQuery<courseitproject.model.Section> sQuery = em.createQuery(sectionJpql,
                    courseitproject.model.Section.class);
            sQuery.setParameter("courseId", courseId);
            java.util.List<courseitproject.model.Section> sections = sQuery.getResultList();

            for (courseitproject.model.Section section : sections) {
                String lessonJpql = "SELECT l FROM Lesson l WHERE l.sectionId.sectionId = :sectionId ORDER BY l.orderIndex ASC";
                TypedQuery<courseitproject.model.Lesson> lQuery = em.createQuery(lessonJpql,
                        courseitproject.model.Lesson.class);
                lQuery.setParameter("sectionId", section.getSectionId());
                java.util.List<courseitproject.model.Lesson> lessons = lQuery.getResultList();

                for (courseitproject.model.Lesson lesson : lessons) {
                    String resJpql = "SELECT r FROM LessonResource r WHERE r.lessonId.lessonId = :lessonId";
                    TypedQuery<courseitproject.model.LessonResource> rQuery = em.createQuery(resJpql,
                            courseitproject.model.LessonResource.class);
                    rQuery.setParameter("lessonId", lesson.getLessonId());
                    java.util.List<courseitproject.model.LessonResource> resources = rQuery.getResultList();
                    lesson.setLessonResourceCollection(resources);

                    String assJpql = "SELECT a FROM Assignment a WHERE a.lessonId.lessonId = :lessonId";
                    TypedQuery<courseitproject.model.Assignment> aQuery = em.createQuery(assJpql,
                            courseitproject.model.Assignment.class);
                    aQuery.setParameter("lessonId", lesson.getLessonId());
                    java.util.List<courseitproject.model.Assignment> assignments = aQuery.getResultList();
                    lesson.setAssignmentCollection(assignments);
                }
                section.setLessonCollection(lessons);
            }
            course.setSectionCollection(sections);

            // Load teachers separately
            if (course.getCourseTeacherCollection() != null) {
                course.getCourseTeacherCollection().size();
                for (courseitproject.model.CourseTeacher ct : course.getCourseTeacherCollection()) {
                    if (ct.getTeacherId() != null && ct.getTeacherId().getUsers() != null) {
                        ct.getTeacherId().getUsers().getFullName(); // Initialize Teacher's user details
                    }
                }
            }

            return course;

        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean isStudentEnrolled(int studentId, int courseId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(e) FROM Enrollment e " +
                    "WHERE e.studentId.studentId = :studentId " +
                    "AND e.courseId.courseId = :courseId";

            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("studentId", studentId);
            query.setParameter("courseId", courseId);

            Long count = query.getSingleResult();
            return count != null && count > 0;

        } finally {
            em.close();
        }
    }

    @Override
    public courseitproject.model.LessonResource getLessonResourceById(int resourceId) {
        EntityManager em = getEntityManager();
        try {
            return em.find(courseitproject.model.LessonResource.class, resourceId);
        } finally {
            em.close();
        }
    }
}