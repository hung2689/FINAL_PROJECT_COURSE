package courseitproject.service;

import courseitproject.dao.CourseDetailDAOImpl;
import courseitproject.dao.ICourseDetailDAO;
import courseitproject.dto.CourseDetailDTO;
import courseitproject.dto.LessonDTO;
import courseitproject.dto.SectionDTO;
import courseitproject.model.Course;
import courseitproject.model.CourseTeacher;
import courseitproject.model.Lesson;
import courseitproject.model.LessonResource;
import courseitproject.model.Section;
import courseitproject.model.Teacher;
import courseitproject.service.ICourseDetailService;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class CourseDetailServiceImpl implements ICourseDetailService {

    private final ICourseDetailDAO courseDetailDAO;

    public CourseDetailServiceImpl() {
        this.courseDetailDAO = new CourseDetailDAOImpl();
    }

    @Override
    public CourseDetailDTO getCourseDetail(int courseId, Integer studentId) {

        Course course = courseDetailDAO.findCourseWithFullDetails(courseId);
        if (course == null) {
            return null;
        }

        List<Teacher> teachers = new ArrayList<>();

        if (course.getCourseTeacherCollection() != null) {
            for (CourseTeacher ct : course.getCourseTeacherCollection()) {
                if (ct.getTeacherId() != null) {
                    teachers.add(ct.getTeacherId());
                }
            }
        }

        boolean isEnrolled = false;
        if (studentId != null) {
            isEnrolled = courseDetailDAO.isStudentEnrolled(studentId, courseId);
        }

        int[] stats = new int[2];
        // stats[0] = totalLessons
        // stats[1] = totalDuration

        List<SectionDTO> sectionDTOs = buildSectionDTOs(course, stats);

        return new CourseDetailDTO(
                course,
                teachers,
                sectionDTOs,
                stats[0],
                stats[1],
                isEnrolled);
    }

    @Override
    public boolean isTeacherOfCourse(int teacherId, int courseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {

            Long count = em.createQuery(
                    "SELECT COUNT(ct) FROM CourseTeacher ct "
                    + "WHERE ct.teacherId.teacherId = :tid "
                    + "AND ct.courseId.courseId = :cid",
                    Long.class)
                    .setParameter("tid", teacherId)
                    .setParameter("cid", courseId)
                    .getSingleResult();

            return count > 0;

        } finally {
            em.close();
        }
    }

    @Override
    public LessonResource getLessonResourceById(int resourceId) {
        return courseDetailDAO.getLessonResourceById(resourceId);
    }

    private List<SectionDTO> buildSectionDTOs(Course course, int[] stats) {

        List<SectionDTO> sectionDTOs = new ArrayList<>();

        if (course.getSectionCollection() == null) {
            return sectionDTOs;
        }

        List<Section> sortedSections = course.getSectionCollection().stream()
                .sorted(Comparator.comparingInt(Section::getOrderIndex))
                .toList();

        for (Section section : sortedSections) {

            List<LessonDTO> lessonDTOs = new ArrayList<>();

            if (section.getLessonCollection() != null) {

                List<Lesson> sortedLessons = section.getLessonCollection().stream()
                        .sorted(Comparator.comparingInt(Lesson::getOrderIndex))
                        .toList();

                for (Lesson lesson : sortedLessons) {

                    stats[0]++; // totalLessons

                    List<LessonResource> resources = new ArrayList<>();

                    if (lesson.getLessonResourceCollection() != null) {

                        resources.addAll(lesson.getLessonResourceCollection());

                        for (Lesson resLesson : sortedLessons) {
                            for (LessonResource res : resLesson.getLessonResourceCollection()) {

                                if ("VIDEO".equalsIgnoreCase(res.getResourceType())
                                        && res.getDuration() != null) {

                                    stats[1] += res.getDuration(); // totalDuration
                                }
                            }
                        }
                    }

                    lessonDTOs.add(new LessonDTO(lesson, resources));
                }
            }

            sectionDTOs.add(new SectionDTO(section, lessonDTOs));
        }

        return sectionDTOs;
    }

    public static void main(String[] args) {
        CourseDetailServiceImpl c = new CourseDetailServiceImpl();
        System.out.println(c.isTeacherOfCourse(3, 5));
    }
}
