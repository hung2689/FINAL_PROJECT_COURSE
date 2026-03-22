package courseitproject.search.criteria;

import courseitproject.model.CourseOrder;

import java.math.BigDecimal;
import java.util.Date;

public class CourseOrderSearchCriteria implements SearchCriteria<CourseOrder> {
    private Date startDate;
    private Date endDate;
    private String status;
    private BigDecimal minAmount;
    private BigDecimal maxAmount;

    public CourseOrderSearchCriteria() {
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getMinAmount() {
        return minAmount;
    }

    public void setMinAmount(BigDecimal minAmount) {
        this.minAmount = minAmount;
    }

    public BigDecimal getMaxAmount() {
        return maxAmount;
    }

    public void setMaxAmount(BigDecimal maxAmount) {
        this.maxAmount = maxAmount;
    }
}
