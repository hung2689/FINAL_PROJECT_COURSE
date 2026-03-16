package courseitproject.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "Enrollment")
@XmlRootElement
public class Enrollment implements Serializable {

    private static final long serialVersionUID = 1L;

    // =========================
    // PRIMARY KEY
    // =========================
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "enrollment_id")
    private Integer enrollmentId;

    // =========================
    // DATE (Modern API)
    // =========================
    @Column(name = "enrollment_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date enrollmentDate;
    @Size(max = 255)

    @Column(name = "status")
    private String status;

    // =========================
    // RELATIONSHIPS
    // =========================
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course courseId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private Student studentId;

    // =========================
    // CONSTRUCTORS
    // =========================
    public Enrollment() {
    }

    public Enrollment(Integer enrollmentId) {
        this.enrollmentId = enrollmentId;
    }

    // =========================
    // GETTERS & SETTERS
    // =========================
    public Integer getEnrollmentId() {
        return enrollmentId;
    }

    public void setEnrollmentId(Integer enrollmentId) {
        this.enrollmentId = enrollmentId;
    }

    public Date getEnrollmentDate() {
        return enrollmentDate;
    }

    public void setEnrollmentDate(Date enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Course getCourseId() {
        return courseId;
    }

    public void setCourseId(Course courseId) {
        this.courseId = courseId;
    }

    public Student getStudentId() {
        return studentId;
    }

    public void setStudentId(Student studentId) {
        this.studentId = studentId;
    }

    // =========================
    // HASHCODE & EQUALS
    // =========================
    @Override
    public int hashCode() {
        return enrollmentId != null ? enrollmentId.hashCode() : 0;
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Enrollment)) {
            return false;
        }
        Enrollment other = (Enrollment) obj;
        return enrollmentId != null && enrollmentId.equals(other.enrollmentId);
    }

    @Override
    public String toString() {
        return "Enrollment[id=" + enrollmentId + "]";
    }

    // Thêm hàm này vào class Enrollment
    public String getFormattedEnrollmentDate() {
        if (enrollmentDate == null) {
            return "";
        }
        return new java.text.SimpleDateFormat("dd/MM/yyyy").format(enrollmentDate);
    }
}