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
       public boolean UserVerifyRegister(String email,String otp);

}
