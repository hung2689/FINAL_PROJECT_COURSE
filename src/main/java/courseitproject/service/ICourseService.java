/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.service;

import courseitproject.model.Course;
import courseitproject.model.CourseCategory;
import courseitproject.model.Teacher;
import java.math.BigDecimal;
import java.util.List;

public interface ICourseService {

        List<Course> findAll();

        Course findById(int id);

        void createCourse(Course c);

        void updateCourse(Course c);

        void deleteCourse(int id);

        long countActiveCourses();

        List<Course> findAllPaging(int page);

        long countStudentsByCourse(int courseId);

        String findTeacherNameByCourse(Course course);

        CourseCategory findCourseCategoryById(int id);

        Course findCourseByName(String name);

        void assignTeacherToCourse(int courseId, int teacherId);

        Teacher getTeacherByCourseId(int courseId);

        void hardDeleteCourse(int id);

        List<Course> filterAll(
                        String keyword,
                        Integer categoryId,
                        boolean free,
                        boolean paid,
                        BigDecimal maxPrice,
                        String sort,
                        int page,
                        int pageSize);

        long countFilterAll(
                        String keyword,
                        Integer categoryId,
                        boolean free,
                        boolean paid,
                        BigDecimal maxPrice);

        List<Course> getAllCourses(int page);

        List<Course> searchCourses(String keyword, int page);

        List<Course> filterCourses(
                        Integer categoryId,
                        BigDecimal minPrice,
                        BigDecimal maxPrice,
                        int page);

        Course getCourseById(int id);

        BigDecimal getMaxCoursePrice();

        public List<Course> findTopByCategoryId(int categoryId);
}
