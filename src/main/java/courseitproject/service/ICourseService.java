/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.service;

import courseitproject.model.Course;
import courseitproject.model.CourseCategory;
import courseitproject.model.Teacher;
import java.util.List;

public interface ICourseService {

    List<Course> findAll();

    Course findById(int id);

    void createCourse(Course c);

    void updateCourse(Course c);

    void deleteCourse(int id);

    public long countActiveCourses();

    public List<Course> findAllPaging(int page);

    public long countStudentsByCourse(int courseId);

    public String findTeacherNameByCourse(Course course);

    public CourseCategory findCourseCategoryById(int id);

    public Course findCourseByName(String name);

    public void assignTeacherToCourse(int courseId, int teacherId);

    public Teacher getTeacherByCourseId(int courseId);

    public void hardDeleteCourse(int id);
}
