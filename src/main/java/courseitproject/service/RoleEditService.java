package courseitproject.service;

import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public class RoleEditService {

    /**
     * Checks if a user has a specific role safely using an efficient DB query.
     *
     * @param userId   The ID of the user
     * @param roleName The name of the role (e.g., "ADMIN")
     * @return true if the user has the role, false otherwise
     */
    public boolean userHasRole(Integer userId, String roleName) {
        if (userId == null || roleName == null) {
            return false;
        }

        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(ur) FROM UserRole ur "
                    + "WHERE ur.userId.userId = :userId "
                    + "AND ur.roleId.roleName = :roleName";

            Long count = em.createQuery(jpql, Long.class)
                    .setParameter("userId", userId)
                    .setParameter("roleName", roleName)
                    .getSingleResult();

            return count != null && count > 0;
        } catch (NoResultException e) {
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Checks if a user has any of the specified roles.
     *
     * @param userId    The ID of the user
     * @param roleNames The role names to check (e.g., "ADMIN", "TEACHER")
     * @return true if the user has at least one of the roles
     */
    public boolean userHasAnyRole(Integer userId, String... roleNames) {
        if (userId == null || roleNames == null || roleNames.length == 0) {
            return false;
        }

        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(ur) FROM UserRole ur "
                    + "WHERE ur.userId.userId = :userId "
                    + "AND ur.roleId.roleName IN :roleNames";

            Long count = em.createQuery(jpql, Long.class)
                    .setParameter("userId", userId)
                    .setParameter("roleNames", java.util.Arrays.asList(roleNames))
                    .getSingleResult();

            return count != null && count > 0;
        } catch (NoResultException e) {
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
