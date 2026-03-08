/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.model;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "Student")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Student.findAll", query = "SELECT s FROM Student s"),
    @NamedQuery(name = "Student.findByStudentId", query = "SELECT s FROM Student s WHERE s.studentId = :studentId"),
    @NamedQuery(name = "Student.findByDateOfBirth", query = "SELECT s FROM Student s WHERE s.dateOfBirth = :dateOfBirth"),
    @NamedQuery(name = "Student.findByLevel", query = "SELECT s FROM Student s WHERE s.level = :level")})
public class Student implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "student_id")
    private Integer studentId;
    @Column(name = "date_of_birth")
    @Temporal(TemporalType.DATE)
    private Date dateOfBirth;
    @Size(max = 255)
    @Column(name = "level")
    private String level;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Collection<CourseOrder> courseOrderCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Collection<Enrollment> enrollmentCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Collection<Subscription> subscriptionCollection;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Cart cart;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Collection<LearningProgress> learningProgressCollection;
    @JoinColumn(name = "student_id", referencedColumnName = "user_id", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Users users;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Collection<Recommendation> recommendationCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Collection<StudyLog> studyLogCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Collection<AIPrediction> aIPredictionCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Collection<QuizResult> quizResultCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentId")
    private Collection<CoursePayment> coursePaymentCollection;

    public Student() {
    }

    public Student(Integer studentId) {
        this.studentId = studentId;
    }

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

    @XmlTransient
    public Collection<CourseOrder> getCourseOrderCollection() {
        return courseOrderCollection;
    }

    public void setCourseOrderCollection(Collection<CourseOrder> courseOrderCollection) {
        this.courseOrderCollection = courseOrderCollection;
    }

    @XmlTransient
    public Collection<Enrollment> getEnrollmentCollection() {
        return enrollmentCollection;
    }

    public void setEnrollmentCollection(Collection<Enrollment> enrollmentCollection) {
        this.enrollmentCollection = enrollmentCollection;
    }

    @XmlTransient
    public Collection<Subscription> getSubscriptionCollection() {
        return subscriptionCollection;
    }

    public void setSubscriptionCollection(Collection<Subscription> subscriptionCollection) {
        this.subscriptionCollection = subscriptionCollection;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    @XmlTransient
    public Collection<LearningProgress> getLearningProgressCollection() {
        return learningProgressCollection;
    }

    public void setLearningProgressCollection(Collection<LearningProgress> learningProgressCollection) {
        this.learningProgressCollection = learningProgressCollection;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    @XmlTransient
    public Collection<Recommendation> getRecommendationCollection() {
        return recommendationCollection;
    }

    public void setRecommendationCollection(Collection<Recommendation> recommendationCollection) {
        this.recommendationCollection = recommendationCollection;
    }

    @XmlTransient
    public Collection<StudyLog> getStudyLogCollection() {
        return studyLogCollection;
    }

    public void setStudyLogCollection(Collection<StudyLog> studyLogCollection) {
        this.studyLogCollection = studyLogCollection;
    }

    @XmlTransient
    public Collection<AIPrediction> getAIPredictionCollection() {
        return aIPredictionCollection;
    }

    public void setAIPredictionCollection(Collection<AIPrediction> aIPredictionCollection) {
        this.aIPredictionCollection = aIPredictionCollection;
    }

    @XmlTransient
    public Collection<QuizResult> getQuizResultCollection() {
        return quizResultCollection;
    }

    public void setQuizResultCollection(Collection<QuizResult> quizResultCollection) {
        this.quizResultCollection = quizResultCollection;
    }

    @XmlTransient
    public Collection<CoursePayment> getCoursePaymentCollection() {
        return coursePaymentCollection;
    }

    public void setCoursePaymentCollection(Collection<CoursePayment> coursePaymentCollection) {
        this.coursePaymentCollection = coursePaymentCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (studentId != null ? studentId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Student)) {
            return false;
        }
        Student other = (Student) object;
        if ((this.studentId == null && other.studentId != null) || (this.studentId != null && !this.studentId.equals(other.studentId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.Student[ studentId=" + studentId + " ]";
    }
    
}
