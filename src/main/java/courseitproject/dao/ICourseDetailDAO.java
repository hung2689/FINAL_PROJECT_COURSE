package courseitproject.dao;

import courseitproject.model.Course;

public interface ICourseDetailDAO {
    Course findCourseWithFullDetails(int courseId);

    boolean isStudentEnrolled(int studentId, int courseId);

    courseitproject.model.LessonResource getLessonResourceById(int resourceId);
}
