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
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "Recommendation")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Recommendation.findAll", query = "SELECT r FROM Recommendation r"),
    @NamedQuery(name = "Recommendation.findByRecommendationId", query = "SELECT r FROM Recommendation r WHERE r.recommendationId = :recommendationId"),
    @NamedQuery(name = "Recommendation.findByReason", query = "SELECT r FROM Recommendation r WHERE r.reason = :reason")})
public class Recommendation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "recommendation_id")
    private Integer recommendationId;
    @Size(max = 255)
    @Column(name = "reason")
    private String reason;
    @JoinColumn(name = "course_id", referencedColumnName = "course_id")
    @ManyToOne(optional = false)
    private Course courseId;
    @JoinColumn(name = "student_id", referencedColumnName = "student_id")
    @ManyToOne(optional = false)
    private Student studentId;

    public Recommendation() {
    }

    public Recommendation(Integer recommendationId) {
        this.recommendationId = recommendationId;
    }

    public Integer getRecommendationId() {
        return recommendationId;
    }

    public void setRecommendationId(Integer recommendationId) {
        this.recommendationId = recommendationId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (recommendationId != null ? recommendationId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Recommendation)) {
            return false;
        }
        Recommendation other = (Recommendation) object;
        if ((this.recommendationId == null && other.recommendationId != null) || (this.recommendationId != null && !this.recommendationId.equals(other.recommendationId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.Recommendation[ recommendationId=" + recommendationId + " ]";
    }
    
}
