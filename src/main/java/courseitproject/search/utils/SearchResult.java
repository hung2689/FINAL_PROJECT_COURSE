package courseitproject.search.utils;

import java.util.List;

public class SearchResult<T> {
    private List<T> data;
    private long totalItems;

    public SearchResult() {
    }

    public SearchResult(List<T> data, long totalItems) {
        this.data = data;
        this.totalItems = totalItems;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

    public long getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(long totalItems) {
        this.totalItems = totalItems;
    }
}
