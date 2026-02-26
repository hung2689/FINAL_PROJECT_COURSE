package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Course;
import courseitproject.model.CourseCategory;
import courseitproject.model.CourseTeacher;
import courseitproject.model.Teacher;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

public class CourseServiceImp implements ICourseService {

    private final GenericDAO<Course> courseDAO
            = new GenericDAO<>(Course.class);
    private final GenericDAO<CourseCategory> courseCategoryDAO
            = new GenericDAO<>(CourseCategory.class);
    private final GenericDAO<CourseTeacher> courseTeacherDAO
            = new GenericDAO<>(CourseTeacher.class);

    @Override
    public Teacher getTeacherByCourseId(int courseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<?> result = em.createNativeQuery(
                    "SELECT teacher_id FROM Course_Teacher WHERE course_id = ?")
                    .setParameter(1, courseId)
                    .getResultList();

            if (result.isEmpty()) {
                return null;
            }

            int teacherId = ((Number) result.get(0)).intValue();

            return em.find(Teacher.class, teacherId);

        } finally {
            em.close();
        }
    }

    @Override
    public void assignTeacherToCourse(int courseId, int teacherId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            Course course = em.find(Course.class, courseId);
            Teacher teacher = em.find(Teacher.class, teacherId);

            // Xóa teacher cũ của course
            em.createQuery("DELETE FROM CourseTeacher ct WHERE ct.courseId.courseId = :courseId")
                    .setParameter("courseId", courseId)
                    .executeUpdate();

            // Tạo bản ghi mới
            CourseTeacher courseTeacher = new CourseTeacher();
            courseTeacher.setCourseId(course);
            courseTeacher.setTeacherId(teacher);
            courseTeacher.setRole("MAIN"); // nếu có role

            em.persist(courseTeacher);

            em.getTransaction().commit();

        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // ===== FIND ALL ACTIVE =====
    @Override
    public List<Course> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT DISTINCT c FROM Course c "
                    + "LEFT JOIN FETCH c.courseTeacherList ct "
                    + "LEFT JOIN FETCH ct.teacherId t "
                    + "LEFT JOIN FETCH t.user "
                    + "WHERE c.status = 'ACTIVE' "
                    + "ORDER BY c.courseId DESC",
                    Course.class
            ).getResultList();
        } finally {
            em.close();
        }
    }

    // ===== FIND BY ID =====
    @Override
    public Course findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return courseDAO.findById(em, id);
        } finally {
            em.close();
        }
    }

    @Override
    public CourseCategory findCourseCategoryById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return courseCategoryDAO.findById(em, id);
        } finally {
            em.close();
        }
    }

    // ===== CREATE =====
    @Override
    public void createCourse(Course c) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            c.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));
            c.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));

            courseDAO.save(em, c);

            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // ===== UPDATE =====
    @Override
    public void updateCourse(Course c) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            c.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));

            courseDAO.update(em, c);

            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // ===== SOFT DELETE =====
    @Override
    public void deleteCourse(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            Course c = courseDAO.findById(em, id);
            if (c != null) {
                c.setStatus("INACTIVE");
                c.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                courseDAO.update(em, c);
            }

            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void hardDeleteCourse(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            // 1️⃣ Xóa bảng trung gian trước
            em.createQuery("DELETE FROM CourseTeacher ct WHERE ct.courseId.courseId = :courseId")
                    .setParameter("courseId", id)
                    .executeUpdate();

            // 2️⃣ Xóa course
            Course c = em.find(Course.class, id);
            if (c != null) {
                em.remove(c);
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Course> findAllPaging(int page) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT c FROM Course c "
                    + "ORDER BY c.courseId ASC",
                    Course.class
            )
                    .setFirstResult((page - 1) * 10)
                    .setMaxResults(10)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public String findTeacherNameByCourse(Course course) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT u.fullName FROM CourseTeacher ct "
                    + "JOIN ct.teacherId t "
                    + "JOIN t.users u "
                    + "WHERE ct.courseId = :course",
                    String.class
            )
                    .setParameter("course", course)
                    .setMaxResults(1)
                    .getSingleResult();

        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public long countActiveCourses() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(c) FROM Course c",
                    Long.class
            ).getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countStudentsByCourse(int courseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(e) FROM Enrollment e "
                    + "WHERE e.courseId.courseId = :courseId",
                    Long.class
            )
                    .setParameter("courseId", courseId)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public Course findCourseByName(String name) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return courseDAO.findOneByField(em, "name", name);
        } finally {
            em.close();
        }
    }

    public static void main(String[] args) {
        CourseServiceImp d = new CourseServiceImp();
        d.findAllPaging(1).forEach(System.out::print);
    }

}
