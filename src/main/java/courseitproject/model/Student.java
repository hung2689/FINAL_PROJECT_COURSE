package courseitproject.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

@Entity
@Table(name = "Student")
@XmlRootElement
public class Student implements Serializable {

    private static final long serialVersionUID = 1L;

    // =========================
    // PRIMARY KEY (Shared PK)
    // =========================
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "student_id")
    private Integer studentId;

    // =========================
    // BASIC FIELDS
    // =========================
    @Column(name = "date_of_birth")
    @Temporal(TemporalType.DATE)
    private Date dateOfBirth;

    @Size(max = 255)
    @Column(name = "level")
    private String level;

    // =========================
    // RELATIONSHIPS
    // =========================

    // 🔹 Student - Users (Shared Primary Key)
    @JoinColumn(name = "student_id", referencedColumnName = "user_id",
                insertable = false, updatable = false)
    @OneToOne(optional = false, fetch = FetchType.LAZY)
    private Users users;

    // 🔹 Student - Cart (1-1)
    // Nếu student bị xóa thì cart cũng xóa theo
    @OneToOne(mappedBy = "studentId",
              cascade = CascadeType.ALL,
              fetch = FetchType.LAZY)
    private Cart cart;

    // 🔹 Student - Enrollment (1-n)
    // KHÔNG cascade vì là dữ liệu lịch sử
    @OneToMany(mappedBy = "studentId",
               fetch = FetchType.LAZY)
    private Collection<Enrollment> enrollmentCollection;

    // 🔹 Student - CourseOrder (1-n)
    @OneToMany(mappedBy = "studentId",
               fetch = FetchType.LAZY)
    private Collection<CourseOrder> courseOrderCollection;

    // 🔹 Student - CoursePayment (1-n)
    @OneToMany(mappedBy = "studentId",
               fetch = FetchType.LAZY)
    private Collection<CoursePayment> coursePaymentCollection;

    // =========================
    // CONSTRUCTORS
    // =========================
    public Student() {
    }

    public Student(Integer studentId) {
        this.studentId = studentId;
    }

    // =========================
    // GETTERS & SETTERS
    // =========================
    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    @XmlTransient
    public Collection<Enrollment> getEnrollmentCollection() {
        return enrollmentCollection;
    }

    public void setEnrollmentCollection(Collection<Enrollment> enrollmentCollection) {
        this.enrollmentCollection = enrollmentCollection;
    }

    @XmlTransient
    public Collection<CourseOrder> getCourseOrderCollection() {
        return courseOrderCollection;
    }

    public void setCourseOrderCollection(Collection<CourseOrder> courseOrderCollection) {
        this.courseOrderCollection = courseOrderCollection;
    }

    @XmlTransient
    public Collection<CoursePayment> getCoursePaymentCollection() {
        return coursePaymentCollection;
    }

    public void setCoursePaymentCollection(Collection<CoursePayment> coursePaymentCollection) {
        this.coursePaymentCollection = coursePaymentCollection;
    }

    // =========================
    // EQUALS & HASHCODE
    // =========================
    @Override
    public int hashCode() {
        return (studentId != null ? studentId.hashCode() : 0);
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Student)) {
            return false;
        }
        Student other = (Student) object;
        return (this.studentId != null && this.studentId.equals(other.studentId));
    }

    @Override
    public String toString() {
        return "Student[ studentId=" + studentId + " ]";
    }
}