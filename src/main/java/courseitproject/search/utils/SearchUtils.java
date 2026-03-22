package courseitproject.search.utils;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class SearchUtils {

    /**
     * Paginates and optionally sorts a given pre-filtered list of items.
     * @param data The fully filtered data to paginate.
     * @param page The requested page number (1-based).
     * @param pageSize Number of items per page.
     * @param comparator An optional comparator for sorting; if null, elements maintain current order.
     * @param <T> The data type.
     * @return A paginated sublist wrapped securely.
     */
    public static <T> List<T> paginateAndSort(List<T> data, int page, int pageSize, Comparator<T> comparator) {
        if (data == null || data.isEmpty()) {
            return List.of();
        }

        int p = Math.max(page, 1);
        int size = Math.max(pageSize, 1);

        return data.stream()
                .sorted(comparator != null ? comparator : (a, b) -> 0)
                .skip((long) (p - 1) * size)
                .limit(size)
                .collect(Collectors.toList());
    }
}
