package courseitproject.search.builder;

import java.util.function.Predicate;

public abstract class BasePredicateBuilder<T> {

    /**
     * Builds the final dynamic predicate based on the underlying criteria.
     * @return Predicate ignoring null and empty fields.
     */
    public Predicate<T> build() {
        return buildPredicate();
    }

    protected abstract Predicate<T> buildPredicate();

    /**
     * The default baseline predicate which is always true.
     * Use .and() on this to continuously chain logic.
     * @return A true-returning predicate.
     */
    protected Predicate<T> defaultPredicate() {
        return t -> true;
    }
}
