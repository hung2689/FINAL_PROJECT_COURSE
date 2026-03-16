package courseitproject.service;

import courseitproject.model.Enrollment;
import java.util.List;

public interface IEnrollmentService {
    List<Enrollment> getCoursesByStudentId(int studentId);

    List<Enrollment> getEnrollmentsByStudent(int studentId, int offset, int limit);

    int countEnrollmentsByStudent(int studentId);

    boolean isStudentEnrolled(int studentId, int courseId);
}
