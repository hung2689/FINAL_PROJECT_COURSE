package courseitproject.dto;

import courseitproject.model.Lesson;
import courseitproject.model.LessonResource;
import java.util.List;

public class LessonDTO {
    private Lesson lesson;
    private List<LessonResource> resources;

    public LessonDTO() {
    }

    public LessonDTO(Lesson lesson, List<LessonResource> resources) {
        this.lesson = lesson;
        this.resources = resources;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    public List<LessonResource> getResources() {
        return resources;
    }

    public void setResources(List<LessonResource> resources) {
        this.resources = resources;
    }
}
