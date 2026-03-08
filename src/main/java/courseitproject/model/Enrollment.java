package courseitproject.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.time.LocalDateTime;

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
    private LocalDateTime enrollmentDate;

    @Size(max = 30)
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
    public Enrollment() {}

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

    public LocalDateTime getEnrollmentDate() {
        return enrollmentDate;
    }

    public void setEnrollmentDate(LocalDateTime enrollmentDate) {
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
        if (!(obj instanceof Enrollment)) return false;
        Enrollment other = (Enrollment) obj;
        return enrollmentId != null && enrollmentId.equals(other.enrollmentId);
    }

    @Override
    public String toString() {
        return "Enrollment[id=" + enrollmentId + "]";
    }
    // Thêm hàm này vào class Enrollment
    public String getFormattedEnrollmentDate() {
        if (this.enrollmentDate == null) return "";
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return this.enrollmentDate.format(formatter);
    }
// Thêm vào class Enrollment
public String getFormattedDate() {
    if (this.enrollmentDate == null) return "";
    return this.enrollmentDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
}
}