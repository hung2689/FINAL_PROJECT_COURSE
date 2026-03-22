package courseitproject.search.predicate;

import courseitproject.model.Candidates;
import courseitproject.search.builder.BasePredicateBuilder;
import courseitproject.search.criteria.CandidateSearchCriteria;

import java.util.function.Predicate;

public class CandidatePredicate extends BasePredicateBuilder<Candidates> {

    private final CandidateSearchCriteria criteria;

    public CandidatePredicate(CandidateSearchCriteria criteria) {
        this.criteria = criteria;
    }

    @Override
    protected Predicate<Candidates> buildPredicate() {
        Predicate<Candidates> predicate = defaultPredicate();

        if (criteria == null) {
            return predicate;
        }

        if (criteria.getMinScore() != null) {
            predicate = predicate.and(c -> c.getScore() != null && c.getScore() >= criteria.getMinScore());
        }

        if (criteria.getMaxScore() != null) {
            predicate = predicate.and(c -> c.getScore() != null && c.getScore() <= criteria.getMaxScore());
        }

        if (criteria.getDecision() != null && !criteria.getDecision().trim().isEmpty()) {
            predicate = predicate.and(c -> c.getDecision() != null && c.getDecision().equalsIgnoreCase(criteria.getDecision()));
        }

        if (criteria.getSkillsCount() != null) {
            predicate = predicate.and(c -> c.getSkillsCount() != null && c.getSkillsCount().equals(criteria.getSkillsCount()));
        }

        return predicate;
    }
}
