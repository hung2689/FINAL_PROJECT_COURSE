package courseitproject.dao.base;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class BaseDAO {

    protected static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("courseManager");

    protected EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
}
