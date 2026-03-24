package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.*;
import courseitproject.utils.EmailUtil;
import courseitproject.utils.JPAUtil;
import courseitproject.utils.OtpUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import courseitproject.model.RoleName;
import java.util.List;
import java.util.Set;

public class UserServiceImp implements IUserService {

    private final GenericDAO<Users> userDAO = new GenericDAO<>(Users.class);
    private final GenericDAO<UserRole> userRoleDAO = new GenericDAO<>(UserRole.class);
    private final GenericDAO<Student> studentDAO = new GenericDAO<>(Student.class);
    private final GenericDAO<Teacher> teacherDAO = new GenericDAO<>(Teacher.class);
    private final EmailUtil emailutil = new EmailUtil();
    private final OtpUtil otputil = new OtpUtil();

    @Override
    public void register(Users user, String roleName) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            user.setStatus("ACTIVE");
            userDAO.save(em, user);

            Role role = em.createQuery(
                    "SELECT r FROM Role r WHERE r.roleName = :name",
                    Role.class).setParameter("name", roleName)
                    .getSingleResult();

            UserRole ur = new UserRole();
            ur.setUserId(user);
            ur.setRoleId(role);
            userRoleDAO.save(em, ur);

            if (RoleName.STUDENT.matches(roleName)) {
                Student st = new Student();
                st.setStudentId(user.getUserId());
                st.setUsers(user);
                st.setLevel("BEGINNER");
                studentDAO.save(em, st);
            }

            if (RoleName.TEACHER.matches(roleName)) {
                Teacher t = new Teacher();
                t.setTeacherId(user.getUserId());
                t.setUsers(user);
                teacherDAO.save(em, t);
            }

            tx.commit();

        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Users> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return userDAO.findAll(em);
        } finally {
            em.close();
        }
    }

    @Override
    public Users findUserById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return userDAO.findById(em, id);
        } finally {
            em.close();
        }
    }

    @Override
    public Users findUserByEmail(String email) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return userDAO.findOneByField(em, "email", email);
        } finally {
            em.close();
        }
    }

    @Override
    public Users findUserByUsername(String username) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return userDAO.findOneByField(em, "username", username);
        } finally {
            em.close();
        }
    }

    public static void main(String[] args) {
        UserServiceImp dao = new UserServiceImp();
        System.out.println();
        dao.UserSendEmail("phamduyhung0809@gmail.com");
    }

    @Override
    public void UserSendEmail(String email) {
        System.out.println("[UserServiceImp] Initiating email sending process for: " + email);
        System.out.println("[UserServiceImp] Before generating OTP...");
        String otp = otputil.generateAndStore(email);
        System.out.println("[UserServiceImp] OTP successfully generated. Entering EmailUtil.send()...");

        try {
            emailutil.send(email, "Verify Your Email Address - DevLearn", "Hello,\n"
                    + "\n"
                    + "Thank you for registering an account on DevLearn.\n"
                    + "\n"
                    + "To complete your registration, please use the verification code below:\n"
                    + "\n"
                    + "Your verification code:\n"
                    + otp
                    + "\n"
                    + "This code is valid for 5 minutes.\n"
                    + "Please do not share this code with anyone.\n"
                    + "\n"
                    + "Best regards,\n"
                    + "DevLearn Team\n");
            System.out.println("[UserServiceImp] Email delivery process completed successfully for: " + email);
        } catch (Exception e) {
            System.err.println("[UserServiceImp] Fatal error caught during email delivery for: " + email);
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public boolean UserVerifyRegister(String email, String otp) {
        if (otputil.verify(email, otp)) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public Users createGoogleUser(Users user) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            user.setStatus("PENDING");
            userDAO.save(em, user);

            Role userRole = em.createQuery(
                    "SELECT r FROM Role r WHERE r.roleName = 'USER'",
                    Role.class).getSingleResult();

            UserRole ur = new UserRole();
            ur.setUserId(user);
            ur.setRoleId(userRole);
            userRoleDAO.save(em, ur);

            tx.commit();
            return user;

        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void completeProfile(
            int userId,
            String username,
            String fullName,
            String roleName) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            Users user = em.find(Users.class, userId);
            user.setUsername(username);
            user.setFullName(fullName);
            user.setStatus("ACTIVE");
            user.setEmailVerified(true);

            em.createQuery(
                    "DELETE FROM UserRole ur WHERE ur.userId.userId = :uid").setParameter("uid", userId)
                    .executeUpdate();

            Role role = em.createQuery(
                    "SELECT r FROM Role r WHERE r.roleName = :name",
                    Role.class).setParameter("name", roleName)
                    .getSingleResult();

            UserRole ur = new UserRole();
            ur.setUserId(user);
            ur.setRoleId(role);
            userRoleDAO.save(em, ur);

            if (RoleName.STUDENT.matches(roleName)) {
                Student st = new Student();
                st.setStudentId(userId);
                st.setUsers(user);
                st.setLevel("BEGINNER");
                studentDAO.save(em, st);
            }

            if (RoleName.TEACHER.matches(roleName)) {
                Teacher t = new Teacher();
                t.setTeacherId(userId);
                t.setUsers(user);
                t.setApprovalStatus("PENDING");
                teacherDAO.save(em, t);
            }

            tx.commit();

        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Role> findRolesByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT ur.roleId FROM UserRole ur WHERE ur.userId.userId = :uid",
                    Role.class).setParameter("uid", userId)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public Role findOneRoleByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT ur.roleId FROM UserRole ur WHERE ur.userId.userId = :uid",
                    Role.class)
                    .setParameter("uid", userId)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean updatePasswordByEmail(String email, String hashedPassword) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            Users user = userDAO.findOneByField(em, "email", email);
            if (user == null) {
                return false;
            }

            user.setPassword(hashedPassword);

            userDAO.update(em, user);

            tx.commit();
            return true;

        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;

        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateFullName(int id, String fullName) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            int updated = em.createQuery(
                    "UPDATE Users u SET u.fullName = :fn WHERE u.userId = :id")
                    .setParameter("fn", fullName)
                    .setParameter("id", id)
                    .executeUpdate();
            tx.commit();
            return updated > 0;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean checkPassword(int id, String plainPassword) {
        Users user = findUserById(id);
        if (user == null || user.getPassword() == null) {
            return false;
        }
        return org.mindrot.jbcrypt.BCrypt.checkpw(plainPassword, user.getPassword());
    }

    @Override
    public boolean updatePassword(int id, String newHashedPassword) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            int updated = em.createQuery(
                    "UPDATE Users u SET u.password = :pw WHERE u.userId = :id")
                    .setParameter("pw", newHashedPassword)
                    .setParameter("id", id)
                    .executeUpdate();
            tx.commit();
            return updated > 0;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // ===== Admin User Management =====
    @Override
    public long countAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(u) FROM Users u", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(u) FROM Users u WHERE u.status = :status", Long.class)
                    .setParameter("status", status)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByRole(String roleName) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(ur) FROM UserRole ur WHERE ur.roleId.roleName = :roleName", Long.class)
                    .setParameter("roleName", roleName)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Users> findAllPaging(int page, int pageSize) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT u FROM Users u ORDER BY u.createdAt DESC", Users.class)
                    .setFirstResult((page - 1) * pageSize)
                    .setMaxResults(pageSize)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public java.util.Map<Integer, String> findRoleMapForUsers(List<Users> users) {
        java.util.Map<Integer, String> roleMap = new java.util.HashMap<>();
        if (users == null || users.isEmpty()) {
            return roleMap;
        }
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<Integer> userIds = new java.util.ArrayList<>();
            for (Users u : users) {
                userIds.add(u.getUserId());
            }
            List<Object[]> results = em.createQuery(
                    "SELECT ur.userId.userId, ur.roleId.roleName FROM UserRole ur "
                            + "WHERE ur.userId.userId IN :ids",
                    Object[].class)
                    .setParameter("ids", userIds)
                    .getResultList();
            for (Object[] row : results) {
                Integer uid = (Integer) row[0];
                String rName = (String) row[1];
                if (!roleMap.containsKey(uid) || RoleName.ADMIN.matches(rName)) {
                    roleMap.put(uid, rName);
                }
            }
            return roleMap;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateStatus(int userId, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            int updated = em.createQuery(
                    "UPDATE Users u SET u.status = :status WHERE u.userId = :id")
                    .setParameter("status", status)
                    .setParameter("id", userId)
                    .executeUpdate();
            tx.commit();
            return updated > 0;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean deleteUser(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            // Clear dependencies first
            em.createQuery("DELETE FROM Student s WHERE s.users.userId = :uid")
                    .setParameter("uid", id)
                    .executeUpdate();

            em.createQuery("DELETE FROM Teacher t WHERE t.users.userId = :uid")
                    .setParameter("uid", id)
                    .executeUpdate();

            em.createQuery("DELETE FROM UserRole ur WHERE ur.userId.userId = :uid")
                    .setParameter("uid", id)
                    .executeUpdate();

            // Finally, delete the User
            int deleted = em.createQuery("DELETE FROM Users u WHERE u.userId = :uid")
                    .setParameter("uid", id)
                    .executeUpdate();

            tx.commit();
            return deleted > 0;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            System.err.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public void save(Users user, String roleName) {
        addUser(user, roleName);
    }

    @Override
    public void update(Users user, String roleName) {
        updateUser(user, roleName);
    }

    // ==========================================
    // ===== FULL CRUD IMPLEMENTATION ==========
    // ==========================================
    
    @Override
    public courseitproject.search.utils.SearchResult<Users> searchUsers(
            courseitproject.search.criteria.UserSearchCriteria criteria, 
            int page, 
            int pageSize, 
            java.util.Comparator<Users> comparator) {
        
        List<Users> allUsers = getAllUsers();
        
        courseitproject.search.predicate.UserPredicate builder = 
                new courseitproject.search.predicate.UserPredicate(criteria);
                
        java.util.function.Predicate<Users> predicate = builder.build();
        
        List<Users> filtered = allUsers.stream()
                .filter(predicate)
                .collect(java.util.stream.Collectors.toList());
                
        long totalItems = filtered.size();
        
        List<Users> pageData = courseitproject.search.utils.SearchUtils.paginateAndSort(
                filtered, page, pageSize, comparator);
                
        return new courseitproject.search.utils.SearchResult<>(pageData, totalItems);
    }
    
    private boolean validateUser(Users user, String roleName) {
        if (user == null) {
            throw new IllegalArgumentException("User object is null.");
        }
        // Allow empty username since Google users might not have completed their profiles yet
        // and older accounts might have it as null in the DB
        /* if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username cannot be null or empty.");
        } */
        if (user.getEmail() == null || !user.getEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            throw new IllegalArgumentException("Invalid email format: " + user.getEmail());
        }
        if (RoleName.fromString(roleName) == null) {
            throw new IllegalArgumentException("Invalid role: " + roleName);
        }
        Set<String> validStatuses = Set.of("ACTIVE", "PENDING", "INACTIVE");
        if (user.getStatus() == null || !validStatuses.contains(user.getStatus())) {
            throw new IllegalArgumentException("Invalid status: " + user.getStatus());
        }
        return true;
    }

    @Override
    public List<Users> getAllUsers() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<Users> users = em.createQuery("SELECT u FROM Users u ORDER BY u.createdAt DESC", Users.class)
                    .getResultList();
            return users != null ? users : java.util.Collections.emptyList();
        } catch (Exception e) {
            System.err.println("Error retrieving all users: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        } finally {
            em.close();
        }
    }

    @Override
    public Users getUserById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Users user = em.find(Users.class, id);
            return user;
        } catch (Exception e) {
            System.err.println("Error retrieving user with ID " + id + ": " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean addUser(Users user, String roleName) {
        if (!validateUser(user, roleName)) {
            return false;
        }

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            if (user.getCreatedAt() == null) {
                user.setCreatedAt(new java.util.Date());
            }
            if (user.getStatus() == null) {
                user.setStatus("ACTIVE");
            }

            userDAO.save(em, user);

            Role role = em.createQuery("SELECT r FROM Role r WHERE r.roleName = :name", Role.class)
                    .setParameter("name", roleName)
                    .getSingleResult();

            UserRole ur = new UserRole();
            ur.setUserId(user);
            ur.setRoleId(role);
            userRoleDAO.save(em, ur);

            if (RoleName.STUDENT.matches(roleName)) {
                Student st = new Student();
                st.setStudentId(user.getUserId());
                st.setUsers(user);
                st.setLevel("BEGINNER");
                studentDAO.save(em, st);
            } else if (RoleName.TEACHER.matches(roleName)) {
                Teacher t = new Teacher();
                t.setTeacherId(user.getUserId());
                t.setUsers(user);
                t.setApprovalStatus("PENDING");
                teacherDAO.save(em, t);
            }

            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException(e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateUser(Users user, String roleName) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            Users existingUser = em.find(Users.class, user.getUserId());
            if (existingUser == null) {
                System.err.println("User not found for update with ID: " + user.getUserId());
                return false;
            }

            // Apply updates
            if (user.getFullName() != null) {
                existingUser.setFullName(user.getFullName());
            }
            if (user.getEmail() != null) {
                existingUser.setEmail(user.getEmail());
            }
            if (user.getStatus() != null) {
                existingUser.setStatus(user.getStatus());
            }

            if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                existingUser.setPassword(user.getPassword());
            }

            if (user.getStudyCoins() != null) {
                existingUser.setStudyCoins(user.getStudyCoins());
            }

            // Validate state after updates
            if (!validateUser(existingUser, roleName)) {
                tx.rollback();
                return false;
            }

            Role role = em.createQuery("SELECT r FROM Role r WHERE r.roleName = :name", Role.class)
                    .setParameter("name", roleName)
                    .getSingleResult();

            List<UserRole> currentRoles = em.createQuery(
                    "SELECT ur FROM UserRole ur WHERE ur.userId.userId = :uid", UserRole.class)
                    .setParameter("uid", existingUser.getUserId())
                    .getResultList();

            boolean hasRole = false;
            for (UserRole ur : currentRoles) {
                if (ur.getRoleId().getRoleId().equals(role.getRoleId())) {
                    hasRole = true;
                } else {
                    em.remove(ur);
                }
            }

            if (!hasRole) {
                UserRole newUr = new UserRole();
                newUr.setUserId(existingUser);
                newUr.setRoleId(role);
                em.persist(newUr);

                if (RoleName.STUDENT.matches(roleName)) {
                    Student existingSt = em.find(Student.class, existingUser.getUserId());
                    if (existingSt == null) {
                        Student st = new Student();
                        st.setStudentId(existingUser.getUserId());
                        st.setUsers(existingUser);
                        st.setLevel("BEGINNER");
                        em.persist(st);
                    }
                } else if (RoleName.TEACHER.matches(roleName)) {
                    Teacher existingTeacher = em.find(Teacher.class, existingUser.getUserId());
                    if (existingTeacher == null) {
                        Teacher t = new Teacher();
                        t.setTeacherId(existingUser.getUserId());
                        t.setUsers(existingUser);
                        t.setApprovalStatus("PENDING");
                        em.persist(t);
                    }
                }
            }

            userDAO.update(em, existingUser);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException(e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public Users getUserByUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return userDAO.findOneByField(em, "username", username);
        } catch (Exception e) {
            System.err.println("Error retrieving user by username: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Users u = userDAO.findOneByField(em, "email", email);
            return u != null;
        } catch (Exception e) {
            System.err.println("Error checking if email exists: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateStudyCoins(int userId, int coins, java.util.Date lastLoginDate) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            int updated = em.createQuery(
                    "UPDATE Users u SET u.studyCoins = :coins, u.lastLoginDate = :lld WHERE u.userId = :id")
                    .setParameter("coins", coins)
                    .setParameter("lld", lastLoginDate)
                    .setParameter("id", userId)
                    .executeUpdate();
            tx.commit();
            return updated > 0;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

}
