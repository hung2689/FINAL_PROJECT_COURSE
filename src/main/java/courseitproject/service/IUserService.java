package courseitproject.service;

import courseitproject.model.Role;
import courseitproject.model.Users;
import java.util.List;

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

    public List<Role> findRolesByUserId(int userId);

    boolean updateFullName(int id, String fullName);

    boolean checkPassword(int id, String plainPassword);

    boolean updatePassword(int id, String newHashedPassword);
}
