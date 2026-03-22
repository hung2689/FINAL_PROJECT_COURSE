package courseitproject.service;

import courseitproject.model.Role;
import courseitproject.model.Users;
import java.util.List;
import java.util.Map;

public interface IUserService {

    Users findUserByEmail(String email);

    Users findUserByUsername(String username);

    public List<Users> findAll();

    public Users findUserById(int id);

    public void register(Users user, String roleName);

    public void UserSendEmail(String email);

    public boolean UserVerifyRegister(String email, String otp);

    public Users createGoogleUser(Users user);

    public void completeProfile(
            int userId,
            String username,
            String fullName,
            String roleName);

    boolean updatePasswordByEmail(String email, String hashedPassword);
      public Role findOneRoleByUserId(int userId) ;

    public List<Role> findRolesByUserId(int userId);

    boolean updateFullName(int id, String fullName);

    boolean checkPassword(int id, String plainPassword);

    boolean updatePassword(int id, String newHashedPassword);

    // ===== Admin User Management =====
    long countAll();

    long countByStatus(String status);

    long countByRole(String roleName);

    List<Users> findAllPaging(int page, int pageSize);

    Map<Integer, String> findRoleMapForUsers(List<Users> users);

    boolean updateStatus(int userId, String status);

    boolean deleteUser(int id);

    void save(Users user, String roleName);

    void update(Users user, String roleName);

    // ===== NEW METHODS ADDED FOR CRUD =====

    courseitproject.search.utils.SearchResult<Users> searchUsers(
            courseitproject.search.criteria.UserSearchCriteria criteria, 
            int page, 
            int pageSize, 
            java.util.Comparator<Users> comparator
    );

    List<Users> getAllUsers();

    Users getUserById(int id);

    boolean addUser(Users user, String roleName);

    boolean updateUser(Users user, String roleName);

    Users getUserByUsername(String username);

    boolean existsByEmail(String email);

    boolean updateStudyCoins(int userId, int coins, java.util.Date lastLoginDate);
}
