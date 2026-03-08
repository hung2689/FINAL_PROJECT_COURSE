
package courseitproject.model;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;


@Entity
@Table(name = "CourseOrder")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CourseOrder.findAll", query = "SELECT c FROM CourseOrder c"),
    @NamedQuery(name = "CourseOrder.findByOrderId", query = "SELECT c FROM CourseOrder c WHERE c.orderId = :orderId"),
    @NamedQuery(name = "CourseOrder.findByTotalAmount", query = "SELECT c FROM CourseOrder c WHERE c.totalAmount = :totalAmount"),
    @NamedQuery(name = "CourseOrder.findByStatus", query = "SELECT c FROM CourseOrder c WHERE c.status = :status"),
    @NamedQuery(name = "CourseOrder.findByVnpTxnRef", query = "SELECT c FROM CourseOrder c WHERE c.vnpTxnRef = :vnpTxnRef"),
    @NamedQuery(name = "CourseOrder.findByCreatedAt", query = "SELECT c FROM CourseOrder c WHERE c.createdAt = :createdAt")})
public class CourseOrder implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "order_id")
    private Integer orderId;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Column(name = "total_amount")
    private BigDecimal totalAmount;
    @Size(max = 50)
    @Column(name = "status")
    private String status;
    @Size(max = 100)
    @Column(name = "vnp_txn_ref")
    private String vnpTxnRef;
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @JoinColumn(name = "student_id", referencedColumnName = "student_id")
    @ManyToOne(optional = false)
    private Student studentId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "order")
    private Collection<CourseOrderItem> courseOrderItemCollection;

    public CourseOrder() {
    }

    public CourseOrder(Integer orderId) {
        this.orderId = orderId;
    }

    public CourseOrder(Integer orderId, BigDecimal totalAmount) {
        this.orderId = orderId;
        this.totalAmount = totalAmount;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getVnpTxnRef() {
        return vnpTxnRef;
    }

    public void setVnpTxnRef(String vnpTxnRef) {
        this.vnpTxnRef = vnpTxnRef;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Student getStudentId() {
        return studentId;
    }

    public void setStudentId(Student studentId) {
        this.studentId = studentId;
    }

    @XmlTransient
    public Collection<CourseOrderItem> getCourseOrderItemCollection() {
        return courseOrderItemCollection;
    }

    public void setCourseOrderItemCollection(Collection<CourseOrderItem> courseOrderItemCollection) {
        this.courseOrderItemCollection = courseOrderItemCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderId != null ? orderId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CourseOrder)) {
            return false;
        }
        CourseOrder other = (CourseOrder) object;
        if ((this.orderId == null && other.orderId != null) || (this.orderId != null && !this.orderId.equals(other.orderId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.CourseOrder[ orderId=" + orderId + " ]";
    }

}
