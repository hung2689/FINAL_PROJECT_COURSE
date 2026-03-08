package courseitproject.service;

import courseitproject.dto.CourseDetailDTO;

public interface ICourseDetailService {
    CourseDetailDTO getCourseDetail(int courseId, Integer studentId);
 public boolean isTeacherOfCourse(int userId, int courseId) ;
    courseitproject.model.LessonResource getLessonResourceById(int resourceId);
}
