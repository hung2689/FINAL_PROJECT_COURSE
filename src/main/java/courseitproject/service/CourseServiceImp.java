package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Course;
import courseitproject.model.CourseCategory;
import courseitproject.model.CourseTeacher;
import courseitproject.model.Teacher;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

public class CourseServiceImp implements ICourseService {

    private static final int PAGE_SIZE = 10;
    private final GenericDAO<Course> courseDAO = new GenericDAO<>(Course.class);
    private final GenericDAO<CourseCategory> courseCategoryDAO = new GenericDAO<>(CourseCategory.class);
    private final GenericDAO<CourseTeacher> courseTeacherDAO = new GenericDAO<>(CourseTeacher.class);

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
                            + "LEFT JOIN FETCH t.users "
                            + "WHERE c.status = 'ACTIVE' "
                            + "ORDER BY c.courseId DESC",
                    Course.class).getResultList();
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
                    "SELECT DISTINCT c FROM Course c "
                            + "WHERE c.status = 'ACTIVE' "
                            + "ORDER BY c.courseId DESC",
                    Course.class)
                    .setFirstResult((page - 1) * PAGE_SIZE)
                    .setMaxResults(PAGE_SIZE)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    public List<Course> getCoursePaging(int page, int size) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT DISTINCT c FROM Course c "
                            + "LEFT JOIN FETCH c.categoryId "
                            + "WHERE c.status='active' "
                            + "ORDER BY c.courseId DESC",
                    Course.class)
                    .setFirstResult((page - 1) * size)
                    .setMaxResults(size)
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
                    String.class)
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
    public long countStudentsByCourse(int courseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(e) FROM Enrollment e "
                            + "WHERE e.courseId.courseId = :courseId",
                    Long.class)
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

    @Override
    public long countActiveCourses() {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(c) FROM Course c WHERE LOWER(c.status)='active'",
                    Long.class).getSingleResult();

        } finally {
            em.close();
        }
    }

    public List<Course> searchCourse(String keyword, int page, int size) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT DISTINCT c FROM Course c "
                            + "LEFT JOIN FETCH c.categoryId "
                            + "WHERE LOWER(c.status)='active' "
                            + "AND LOWER(c.title) LIKE :kw "
                            + "ORDER BY c.courseId DESC",
                    Course.class)
                    .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                    .setFirstResult((page - 1) * size)
                    .setMaxResults(size)
                    .getResultList();

        } finally {

            em.close();

        }

    }

    public long countSearchCourse(String keyword) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(c) FROM Course c "
                            + "WHERE LOWER(c.status)='active' "
                            + "AND LOWER(c.title) LIKE :kw",
                    Long.class)
                    .setParameter("kw",
                            "%" + keyword.toLowerCase() + "%")
                    .getSingleResult();

        } finally {

            em.close();

        }

    }

    public List<Course> searchSuggest(String keyword) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT c FROM Course c "
                            + "WHERE LOWER(c.title) LIKE :k "
                            + "AND LOWER(c.status)='active' "
                            + "ORDER BY c.title",
                    Course.class)
                    .setParameter(
                            "k",
                            keyword.toLowerCase().trim() + "%")
                    .setMaxResults(6)
                    .getResultList();

        } finally {

            em.close();

        }

    }

    public List<Course> getCourseByCategories(
            String[] ids,
            int page,
            int size) {

        EntityManager em = JPAUtil.getEntityManager();

        String jpql = "SELECT c FROM Course c "
                + "WHERE c.status='ACTIVE' "
                + "AND c.categoryId.categoryId IN :ids";

        return em.createQuery(jpql, Course.class)
                .setParameter("ids",
                        Arrays.stream(ids)
                                .map(Integer::parseInt)
                                .toList())
                .setFirstResult((page - 1) * size)
                .setMaxResults(size)
                .getResultList();

    }

    public long countCourseByCategories(
            String[] ids) {

        EntityManager em = JPAUtil.getEntityManager();

        String jpql = "SELECT COUNT(c) FROM Course c "
                + "WHERE c.status='ACTIVE' "
                + "AND c.categoryId.categoryId IN :ids";

        return em.createQuery(jpql, Long.class)
                .setParameter("ids",
                        Arrays.stream(ids)
                                .map(Integer::parseInt)
                                .toList())
                .getSingleResult();

    }

    public List<Course> filterPrice(
            BigDecimal maxPrice,
            boolean free,
            boolean paid,
            int page,
            int size) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            String jpql = "SELECT c FROM Course c "
                    + "WHERE LOWER(c.status)='active'";

            // FREE
            if (free) {

                jpql += " AND c.price = 0";

            }

            // PAID
            if (paid) {

                jpql += " AND c.price > 0";

            }

            // MAX PRICE
            if (maxPrice != null) {

                jpql += " AND c.price <= :maxPrice";

            }

            TypedQuery<Course> query = em.createQuery(
                    jpql,
                    Course.class);

            if (maxPrice != null) {

                query.setParameter(
                        "maxPrice",
                        maxPrice);

            }

            query.setFirstResult(
                    (page - 1) * size);

            query.setMaxResults(size);

            return query.getResultList();

        } finally {

            em.close();

        }

    }

    public long countFilterPrice(
            BigDecimal maxPrice,
            boolean free,
            boolean paid) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            String jpql = "SELECT COUNT(c) FROM Course c "
                    + "WHERE LOWER(c.status)='active'";

            // FREE
            if (free) {

                jpql += " AND c.price = 0";

            }

            // PAID
            if (paid) {

                jpql += " AND c.price > 0";

            }

            // MAX PRICE
            if (maxPrice != null) {

                jpql += " AND c.price <= :maxPrice";

            }

            TypedQuery<Long> query = em.createQuery(
                    jpql,
                    Long.class);

            if (maxPrice != null) {

                query.setParameter(
                        "maxPrice",
                        maxPrice);

            }

            return query.getSingleResult();

        } finally {

            em.close();

        }

    }

    @Override
    public Course getCourseById(int id) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.find(Course.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Course> filterAll(
            String keyword,
            Integer categoryId,
            boolean free,
            boolean paid,
            BigDecimal maxPrice,
            String sort,
            int page,
            int pageSize) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // ===== STEP 1: Get IDs with pagination (no JOIN FETCH) =====
            StringBuilder idJpql = new StringBuilder(
                    "SELECT c.courseId FROM Course c "
                            + "WHERE LOWER(c.status)='active' ");

            // keyword
            if (keyword != null && !keyword.isBlank()) {
                idJpql.append(" AND LOWER(c.title) LIKE :keyword ");
            }

            // category
            if (categoryId != null) {
                idJpql.append(" AND c.categoryId.categoryId = :categoryId ");
            }

            // free paid
            if (free && !paid) {
                idJpql.append(" AND c.price = 0 ");
            } else if (!free && paid) {
                idJpql.append(" AND c.price > 0 ");
            }

            // price
            if (maxPrice != null) {
                idJpql.append(" AND c.price <= :maxPrice ");
            }

            // sort
            if ("price_asc".equals(sort)) {
                idJpql.append(" ORDER BY c.price ASC ");
            } else if ("price_desc".equals(sort)) {
                idJpql.append(" ORDER BY c.price DESC ");
            } else if ("popular".equals(sort)) {
                idJpql.append(" ORDER BY c.courseId ASC ");
            } else {
                idJpql.append(" ORDER BY c.createdAt DESC ");
            }

            TypedQuery<Integer> idQuery = em.createQuery(idJpql.toString(), Integer.class);

            if (keyword != null && !keyword.isBlank()) {
                idQuery.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
            }
            if (categoryId != null) {
                idQuery.setParameter("categoryId", categoryId);
            }
            if (maxPrice != null) {
                idQuery.setParameter("maxPrice", maxPrice);
            }

            idQuery.setFirstResult((page - 1) * pageSize);
            idQuery.setMaxResults(pageSize);

            List<Integer> ids = idQuery.getResultList();

            if (ids.isEmpty()) {
                return new java.util.ArrayList<>();
            }

            // ===== STEP 2: Fetch full entities by IDs (with JOIN FETCH) =====
            StringBuilder fetchJpql = new StringBuilder(
                    "SELECT c FROM Course c "
                            + "LEFT JOIN FETCH c.categoryId "
                            + "WHERE c.courseId IN :ids ");

            // preserve sort order
            if ("price_asc".equals(sort)) {
                fetchJpql.append(" ORDER BY c.price ASC ");
            } else if ("price_desc".equals(sort)) {
                fetchJpql.append(" ORDER BY c.price DESC ");
            } else if ("popular".equals(sort)) {
                fetchJpql.append(" ORDER BY c.courseId ASC ");
            } else {
                fetchJpql.append(" ORDER BY c.createdAt DESC ");
            }

            return em.createQuery(fetchJpql.toString(), Course.class)
                    .setParameter("ids", ids)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public long countFilterAll(
            String keyword,
            Integer categoryId,
            boolean free,
            boolean paid,
            BigDecimal maxPrice) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            String jpql = "SELECT COUNT(c) FROM Course c WHERE "
                    + "LOWER(c.status)='active' ";

            if (keyword != null
                    && !keyword.isBlank()) {

                jpql += " AND LOWER(c.title) LIKE :keyword ";

            }

            if (categoryId != null) {

                jpql += " AND c.categoryId.id = :categoryId ";

            }

            if (free && !paid) {

                jpql += " AND c.price=0 ";

            } else if (!free && paid) {

                jpql += " AND c.price>0 ";

            }

            if (maxPrice != null) {

                jpql += " AND c.price <= :maxPrice ";

            }

            var query = em.createQuery(jpql,
                    Long.class);

            if (keyword != null
                    && !keyword.isBlank()) {

                query.setParameter(
                        "keyword",
                        "%" + keyword.toLowerCase() + "%");

            }

            if (categoryId != null) {

                query.setParameter(
                        "categoryId",
                        categoryId);

            }

            if (maxPrice != null) {

                query.setParameter(
                        "maxPrice",
                        maxPrice);

            }

            return query.getSingleResult();

        } finally {

            em.close();

        }

    }

    @Override
    public BigDecimal getMaxCoursePrice() {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            BigDecimal maxPrice = em.createQuery(
                    "SELECT MAX(c.price) FROM Course c",
                    BigDecimal.class).getSingleResult();

            return maxPrice != null ? maxPrice : BigDecimal.ZERO;

        } finally {
            em.close();
        }
    }

    @Override
    public List<Course> getAllCourses(int page) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT c FROM Course c "
                            + "LEFT JOIN FETCH c.categoryId "
                            + "WHERE LOWER(c.status)='active' "
                            + "ORDER BY c.createdAt DESC",
                    Course.class)
                    .setFirstResult((page - 1) * PAGE_SIZE)
                    .setMaxResults(PAGE_SIZE)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Course> filterCourses(
            Integer categoryId,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            int page) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            StringBuilder jpql = new StringBuilder(
                    "SELECT c FROM Course c "
                            + "LEFT JOIN FETCH c.categoryId "
                            + "WHERE LOWER(c.status)='active' ");

            if (categoryId != null) {

                jpql.append(
                        " AND c.categoryId.categoryId = :cid ");
            }

            if (minPrice != null) {

                jpql.append(
                        " AND c.price >= :minPrice ");
            }

            if (maxPrice != null) {

                jpql.append(
                        " AND c.price <= :maxPrice ");
            }

            jpql.append(
                    " ORDER BY c.createdAt DESC");

            TypedQuery<Course> query = em.createQuery(
                    jpql.toString(),
                    Course.class);

            if (categoryId != null) {

                query.setParameter(
                        "cid",
                        categoryId);
            }

            if (minPrice != null) {

                query.setParameter(
                        "minPrice",
                        minPrice);
            }

            if (maxPrice != null) {

                query.setParameter(
                        "maxPrice",
                        maxPrice);
            }

            query.setFirstResult(
                    (page - 1) * PAGE_SIZE);

            query.setMaxResults(
                    PAGE_SIZE);

            return query.getResultList();

        } finally {

            em.close();
        }
    }

    @Override
    public List<Course> searchCourses(
            String keyword,
            int page) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT c FROM Course c "
                            + "LEFT JOIN FETCH c.categoryId "
                            + "WHERE LOWER(c.status)='active' "
                            + "AND LOWER(c.title) LIKE :kw "
                            + "ORDER BY c.createdAt DESC",
                    Course.class)
                    .setParameter(
                            "kw",
                            "%" + keyword.toLowerCase() + "%")
                    .setFirstResult((page - 1) * PAGE_SIZE)
                    .setMaxResults(PAGE_SIZE)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    public static void main(String[] args) {
        CourseServiceImp d = new CourseServiceImp();
    }

    @Override
    public List<Course> findTopByCategoryId(int categoryId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT c FROM Course c "
                            + "WHERE c.categoryId.categoryId = :categoryId "
                            + "AND c.status = 'ACTIVE' "
                            + "ORDER BY c.courseId ASC",
                    Course.class)
                    .setParameter("categoryId", categoryId)
                    .getResultList();

        } finally {
            em.close();
        }
    }

}
