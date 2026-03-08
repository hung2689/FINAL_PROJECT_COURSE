/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "CoursePayment")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CoursePayment.findAll", query = "SELECT c FROM CoursePayment c"),
    @NamedQuery(name = "CoursePayment.findByPaymentId", query = "SELECT c FROM CoursePayment c WHERE c.paymentId = :paymentId"),
    @NamedQuery(name = "CoursePayment.findByAmount", query = "SELECT c FROM CoursePayment c WHERE c.amount = :amount"),
    @NamedQuery(name = "CoursePayment.findByPaymentMethod", query = "SELECT c FROM CoursePayment c WHERE c.paymentMethod = :paymentMethod"),
    @NamedQuery(name = "CoursePayment.findByVnpTxnRef", query = "SELECT c FROM CoursePayment c WHERE c.vnpTxnRef = :vnpTxnRef"),
    @NamedQuery(name = "CoursePayment.findByStatus", query = "SELECT c FROM CoursePayment c WHERE c.status = :status"),
    @NamedQuery(name = "CoursePayment.findByCreatedAt", query = "SELECT c FROM CoursePayment c WHERE c.createdAt = :createdAt")})
public class CoursePayment implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "payment_id")
    private Integer paymentId;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private BigDecimal amount;
    @Size(max = 50)
    @Column(name = "payment_method")
    private String paymentMethod;
    @Size(max = 100)
    @Column(name = "vnp_txn_ref")
    private String vnpTxnRef;
    @Size(max = 50)
    @Column(name = "status")
    private String status;
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @JoinColumn(name = "student_id", referencedColumnName = "student_id")
    @ManyToOne(optional = false)
    private Student studentId;

    public CoursePayment() {
    }

    public CoursePayment(Integer paymentId) {
        this.paymentId = paymentId;
    }

    public CoursePayment(Integer paymentId, BigDecimal amount) {
        this.paymentId = paymentId;
        this.amount = amount;
    }

    public Integer getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Integer paymentId) {
        this.paymentId = paymentId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getVnpTxnRef() {
        return vnpTxnRef;
    }

    public void setVnpTxnRef(String vnpTxnRef) {
        this.vnpTxnRef = vnpTxnRef;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (paymentId != null ? paymentId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CoursePayment)) {
            return false;
        }
        CoursePayment other = (CoursePayment) object;
        if ((this.paymentId == null && other.paymentId != null) || (this.paymentId != null && !this.paymentId.equals(other.paymentId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.CoursePayment[ paymentId=" + paymentId + " ]";
    }
    
}
