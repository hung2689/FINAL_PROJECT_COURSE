package courseitproject.dao.base;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;

public class BaseDAO {

    protected static final EntityManagerFactory emf;

    static {
        Map<String, String> properties = new HashMap<>();
        
        // Dynamically override DB connection with environment variables if present on Render
        String dbUrl = System.getenv("DB_URL");
        if (dbUrl != null && !dbUrl.isEmpty()) {
            properties.put("jakarta.persistence.jdbc.url", dbUrl);
        }
        
        String dbUser = System.getenv("DB_USER");
        if (dbUser != null && !dbUser.isEmpty()) {
            properties.put("jakarta.persistence.jdbc.user", dbUser);
        }
        
        String dbPassword = System.getenv("DB_PASSWORD");
        if (dbPassword != null && !dbPassword.isEmpty()) {
            properties.put("jakarta.persistence.jdbc.password", dbPassword);
        }

        emf = Persistence.createEntityManagerFactory("courseManager", properties);
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
}
