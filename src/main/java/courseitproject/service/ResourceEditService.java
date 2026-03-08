package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Lesson;
import courseitproject.model.LessonResource;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class ResourceEditService extends GenericDAO<LessonResource> {

    public ResourceEditService() {
        super(LessonResource.class);
    }

    public LessonResource create(Lesson lesson, String title, String url, String type) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        LessonResource resource = new LessonResource();
        resource.setLessonId(lesson);
        resource.setTitle(title);
        resource.setUrl(url);
        resource.setResourceType(type);
        try {
            tx.begin();
            em.persist(resource);
            tx.commit();
            return resource;
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

    public boolean update(int resourceId, String title, String url) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            LessonResource resource = em.find(LessonResource.class, resourceId);
            if (resource != null) {
                resource.setTitle(title);
                resource.setUrl(url);
                em.merge(resource);
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

    public boolean delete(int resourceId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            LessonResource resource = em.find(LessonResource.class, resourceId);
            if (resource != null) {
                em.remove(resource);
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
    public static void main(String[] args) {
        ResourceEditService r = new ResourceEditService();
        r.delete(4);
    }
}
