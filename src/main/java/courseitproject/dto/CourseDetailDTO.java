package courseitproject.dto;

import courseitproject.model.Course;
import courseitproject.model.Teacher;
import java.util.List;

public class CourseDetailDTO {
    private Course course;
    private List<Teacher> teachers;
    private List<SectionDTO> sections;
    private int totalLessons;
    private int totalDuration;
    private boolean enrolled;

    public CourseDetailDTO() {
    }

    public CourseDetailDTO(Course course, List<Teacher> teachers, List<SectionDTO> sections, int totalLessons,
            int totalDuration, boolean enrolled) {
        this.course = course;
        this.teachers = teachers;
        this.sections = sections;
        this.totalLessons = totalLessons;
        this.totalDuration = totalDuration;
        this.enrolled = enrolled;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public List<Teacher> getTeachers() {
        return teachers;
    }

    public void setTeachers(List<Teacher> teachers) {
        this.teachers = teachers;
    }

    public List<SectionDTO> getSections() {
        return sections;
    }

    public void setSections(List<SectionDTO> sections) {
        this.sections = sections;
    }

    public int getTotalLessons() {
        return totalLessons;
    }

    public void setTotalLessons(int totalLessons) {
        this.totalLessons = totalLessons;
    }

    public int getTotalDuration() {
        return totalDuration;
    }

    public void setTotalDuration(int totalDuration) {
        this.totalDuration = totalDuration;
    }

    public boolean isEnrolled() {
        return enrolled;
    }

    public void setEnrolled(boolean enrolled) {
        this.enrolled = enrolled;
    }
}
