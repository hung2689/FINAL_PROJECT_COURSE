package courseitproject.service;

import courseitproject.model.CourseCategory;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class CourseCategoryServiceImp
        implements ICourseCategoryService {

    @Override
    public List<CourseCategory> getAll() {

        EntityManager em =
                JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT c FROM CourseCategory c ORDER BY c.categoryId",
                    CourseCategory.class
            ).getResultList();

        } finally {

            em.close();
        }
    }
}