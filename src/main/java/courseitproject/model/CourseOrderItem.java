
package courseitproject.model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Table(name = "CourseOrderItem")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CourseOrderItem.findAll", query = "SELECT c FROM CourseOrderItem c"),
    @NamedQuery(name = "CourseOrderItem.findByOrderItemId", query = "SELECT c FROM CourseOrderItem c WHERE c.orderItemId = :orderItemId"),
    @NamedQuery(name = "CourseOrderItem.findByPrice", query = "SELECT c FROM CourseOrderItem c WHERE c.price = :price")})
public class CourseOrderItem implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "order_item_id")
    private Integer orderItemId;

    @Basic(optional = false)
    @NotNull
    @Column(name = "price")
    private BigDecimal price;
   
    @ManyToOne(optional = false)
    @JoinColumn(name = "course_id", referencedColumnName = "course_id")
    private Course course;

    @ManyToOne(optional = false)
    @JoinColumn(name = "order_id", referencedColumnName = "order_id")
    private CourseOrder order;

    // Constructors
    public CourseOrderItem() {
    }

    public CourseOrderItem(Integer orderItemId) {
        this.orderItemId = orderItemId;
    }

    public CourseOrderItem(Integer orderItemId, BigDecimal price) {
        this.orderItemId = orderItemId;
        this.price = price;
    }

    // ==========================================
    // GETTERS & SETTERS ĐÃ ĐƯỢC CHUẨN HÓA
    // ==========================================
    public Integer getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(Integer orderItemId) {
        this.orderItemId = orderItemId;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    // Đã thêm getOrder và setOrder chuẩn
    public CourseOrder getOrder() {
        return order;
    }

    public void setOrder(CourseOrder order) {
        this.order = order;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderItemId != null ? orderItemId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof CourseOrderItem)) {
            return false;
        }
        CourseOrderItem other = (CourseOrderItem) object;
        if ((this.orderItemId == null && other.orderItemId != null) || (this.orderItemId != null && !this.orderItemId.equals(other.orderItemId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.CourseOrderItem[ orderItemId=" + orderItemId + " ]";
    }
}