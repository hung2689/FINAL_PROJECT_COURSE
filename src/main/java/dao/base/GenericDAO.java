package courseitproject.dao.base;

import jakarta.persistence.EntityManager;
import java.util.List;

public class GenericDAO<T> extends BaseDAO {

    protected final Class<T> entityClass;

    public GenericDAO(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    // ===== FIND ALL =====
    public List<T> findAll(EntityManager em) {
        return em.createQuery(
                "SELECT e FROM " + entityClass.getName() + " e",
                entityClass
        ).getResultList();
    }

    // ===== FIND BY ID =====
    public T findById(EntityManager em, Object id) {
        return em.find(entityClass, id);
    }

    // ===== SAVE =====
    public void save(EntityManager em, T entity) {
        em.persist(entity);
    }

    // ===== UPDATE =====
    public T update(EntityManager em, T entity) {
        return em.merge(entity);
    }

    // ===== DELETE =====
    public void delete(EntityManager em, T entity) {
        em.remove(entity);
    }

    // ===== FIND ONE BY FIELD =====
    public T findOneByField(EntityManager em, String field, Object value) {
        return em.createQuery(
                "SELECT e FROM " + entityClass.getName()
                + " e WHERE e." + field + " = :value",
                entityClass
        )
        .setParameter("value", value)
        .getResultStream()
        .findFirst()
        .orElse(null);
    }
}
