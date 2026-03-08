package courseitproject.dto;

import courseitproject.model.Section;
import java.util.List;

public class SectionDTO {
    private Section section;
    private List<LessonDTO> lessons;

    public SectionDTO() {
    }

    public SectionDTO(Section section, List<LessonDTO> lessons) {
        this.section = section;
        this.lessons = lessons;
    }

    public Section getSection() {
        return section;
    }

    public void setSection(Section section) {
        this.section = section;
    }

    public List<LessonDTO> getLessons() {
        return lessons;
    }

    public void setLessons(List<LessonDTO> lessons) {
        this.lessons = lessons;
    }
}
