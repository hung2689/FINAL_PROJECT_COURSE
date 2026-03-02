package courseitproject.service;

import courseitproject.model.Student;
import java.sql.Date;

public interface IStudentService {
    Student getStudentById(int id);

    boolean updateStudent(int id, Date dob, String level);
}
