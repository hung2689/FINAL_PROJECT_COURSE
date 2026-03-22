package courseitproject.search.predicate;

import courseitproject.model.Users;
import courseitproject.search.builder.BasePredicateBuilder;
import courseitproject.search.criteria.UserSearchCriteria;

import java.util.function.Predicate;

public class UserPredicate extends BasePredicateBuilder<Users> {

    private final UserSearchCriteria criteria;

    public UserPredicate(UserSearchCriteria criteria) {
        this.criteria = criteria;
    }

    @Override
    protected Predicate<Users> buildPredicate() {
        Predicate<Users> predicate = defaultPredicate();

        if (criteria == null) {
            return predicate;
        }

        if (criteria.getUsername() != null && !criteria.getUsername().trim().isEmpty()) {
            predicate = predicate.and(u -> u.getUsername() != null &&
                    u.getUsername().toLowerCase().contains(criteria.getUsername().toLowerCase()));
        }

        if (criteria.getEmail() != null && !criteria.getEmail().trim().isEmpty()) {
            predicate = predicate.and(u -> u.getEmail() != null &&
                    u.getEmail().toLowerCase().contains(criteria.getEmail().toLowerCase()));
        }

        if (criteria.getRole() != null && !criteria.getRole().trim().isEmpty()) {
            predicate = predicate.and(u -> {
                String role = u.getRole();
                return role != null && role.equalsIgnoreCase(criteria.getRole());
            });
        }

        if (criteria.getStatus() != null && !criteria.getStatus().trim().isEmpty()) {
            predicate = predicate.and(u -> u.getStatus() != null &&
                    u.getStatus().equalsIgnoreCase(criteria.getStatus()));
        }

        if (criteria.getGlobalSearch() != null && !criteria.getGlobalSearch().trim().isEmpty()) {
            String term = criteria.getGlobalSearch().toLowerCase().trim();
            predicate = predicate.and(u -> {
                boolean matchUsername = u.getUsername() != null && u.getUsername().toLowerCase().contains(term);
                boolean matchEmail = u.getEmail() != null && u.getEmail().toLowerCase().contains(term);
                boolean matchFullName = u.getFullName() != null && u.getFullName().toLowerCase().contains(term);
                boolean matchId = String.valueOf(u.getUserId()).contains(term);
                return matchUsername || matchEmail || matchFullName || matchId;
            });
        }

        return predicate;
    }
}
