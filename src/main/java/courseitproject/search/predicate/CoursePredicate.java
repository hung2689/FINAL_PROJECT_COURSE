package courseitproject.search.predicate;

import courseitproject.model.Course;
import courseitproject.model.CourseTeacher;
import courseitproject.search.builder.BasePredicateBuilder;
import courseitproject.search.criteria.CourseSearchCriteria;

import java.util.Collection;
import java.util.function.Predicate;

public class CoursePredicate extends BasePredicateBuilder<Course> {

    private final CourseSearchCriteria criteria;

    public CoursePredicate(CourseSearchCriteria criteria) {
        this.criteria = criteria;
    }

    @Override
    protected Predicate<Course> buildPredicate() {
        Predicate<Course> predicate = defaultPredicate();

        if (criteria == null) {
            return predicate;
        }

        if (criteria.getKeyword() != null && !criteria.getKeyword().trim().isEmpty()) {
            predicate = predicate.and(c -> c.getTitle() != null &&
                    c.getTitle().toLowerCase().contains(criteria.getKeyword().toLowerCase()));
        }

        if (criteria.getCategoryId() != null) {
            predicate = predicate.and(c -> c.getCategoryId() != null &&
                    c.getCategoryId().getCategoryId().equals(criteria.getCategoryId()));
        }

        if (criteria.getMinPrice() != null) {
            predicate = predicate.and(c -> c.getPrice() != null &&
                    c.getPrice().compareTo(criteria.getMinPrice()) >= 0);
        }

        if (criteria.getMaxPrice() != null) {
            predicate = predicate.and(c -> c.getPrice() != null &&
                    c.getPrice().compareTo(criteria.getMaxPrice()) <= 0);
        }

        if (criteria.getTeacherId() != null) {
            predicate = predicate.and(c -> {
                Collection<CourseTeacher> teachers = c.getCourseTeacherCollection();
                if (teachers == null || teachers.isEmpty()) {
                    return false;
                }
                return teachers.stream().anyMatch(ct ->
                        ct.getTeacherId() != null &&
                        ct.getTeacherId().getTeacherId().equals(criteria.getTeacherId()));
            });
        }

        return predicate;
    }
}
