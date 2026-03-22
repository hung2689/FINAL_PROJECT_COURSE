package courseitproject.search.predicate;

import courseitproject.model.CourseOrder;
import courseitproject.search.builder.BasePredicateBuilder;
import courseitproject.search.criteria.CourseOrderSearchCriteria;

import java.util.function.Predicate;

public class CourseOrderPredicate extends BasePredicateBuilder<CourseOrder> {

    private final CourseOrderSearchCriteria criteria;

    public CourseOrderPredicate(CourseOrderSearchCriteria criteria) {
        this.criteria = criteria;
    }

    @Override
    protected Predicate<CourseOrder> buildPredicate() {
        Predicate<CourseOrder> predicate = defaultPredicate();

        if (criteria == null) {
            return predicate;
        }

        if (criteria.getMinAmount() != null) {
            predicate = predicate.and(o -> o.getTotalAmount() != null && o.getTotalAmount().compareTo(criteria.getMinAmount()) >= 0);
        }

        if (criteria.getMaxAmount() != null) {
            predicate = predicate.and(o -> o.getTotalAmount() != null && o.getTotalAmount().compareTo(criteria.getMaxAmount()) <= 0);
        }

        if (criteria.getStatus() != null && !criteria.getStatus().trim().isEmpty()) {
            predicate = predicate.and(o -> o.getStatus() != null && o.getStatus().equalsIgnoreCase(criteria.getStatus()));
        }

        if (criteria.getStartDate() != null) {
            // Include orders created ON or AFTER the start date
            predicate = predicate.and(o -> o.getCreatedAt() != null && !o.getCreatedAt().before(criteria.getStartDate()));
        }

        if (criteria.getEndDate() != null) {
            // Include orders created ON or BEFORE the end date
            predicate = predicate.and(o -> o.getCreatedAt() != null && !o.getCreatedAt().after(criteria.getEndDate()));
        }

        return predicate;
    }
}
