package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.*;
import courseitproject.utils.EmailUtil;
import courseitproject.utils.JPAUtil;
import courseitproject.utils.OtpUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

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

            if ("STUDENT".equalsIgnoreCase(roleName)) {
                Student st = new Student();
                st.setStudentId(user.getUserId());
                st.setUsers(user);
                st.setLevel("BEGINNER");
                studentDAO.save(em, st);
            }

            if ("TEACHER".equalsIgnoreCase(roleName)) {
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
        System.out.println(dao.findUserById(5));

    }

    @Override
    public void UserSendEmail(String email) {
        String otp = otputil.generateAndStore(email);
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
                + "If you did not create an account on DevLearn, please ignore this email.\n"
                + "\n"
                + "Best regards,\n"
                + "DevLearn Team\n"
                + "Empowering your programming journey");
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

            // xóa role USER
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

            if ("STUDENT".equalsIgnoreCase(roleName)) {
                Student st = new Student();
                st.setStudentId(userId);
                st.setUsers(user);
                st.setLevel("BEGINNER");
                studentDAO.save(em, st);
            }

            if ("TEACHER".equalsIgnoreCase(roleName)) {
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
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean checkPassword(int id, String plainPassword) {
        Users user = findUserById(id);
        if (user == null || user.getPassword() == null)
            return false;
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
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

}
