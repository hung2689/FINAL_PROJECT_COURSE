package courseitproject;

import courseitproject.model.Users;
import courseitproject.dao.base.BaseDAO;
import jakarta.persistence.EntityManager;
import java.util.List;

public class TestMySQLConnection {
    public static void main(String[] args) {
        System.out.println("Testing MySQL Connection on Railway...");
        
        BaseDAO baseDAO = new BaseDAO();
        EntityManager em = null;
        try {
            em = baseDAO.getEntityManager();
            
            System.out.println("Connection successful! Fetching users...");
            List<Users> users = em.createQuery("SELECT u FROM Users u", Users.class).getResultList();
            
            System.out.println("Found " + users.size() + " users.");
            for (Users u : users) {
                System.out.println("- " + u.getUsername() + " (" + u.getEmail() + ")");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Test failed: " + e.getMessage());
        } finally {
            if (em != null) {
                em.close();
            }
            System.exit(0);
        }
    }
}
