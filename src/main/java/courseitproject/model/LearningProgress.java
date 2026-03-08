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
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "LearningProgress")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LearningProgress.findAll", query = "SELECT l FROM LearningProgress l"),
    @NamedQuery(name = "LearningProgress.findByProgressId", query = "SELECT l FROM LearningProgress l WHERE l.progressId = :progressId"),
    @NamedQuery(name = "LearningProgress.findByCompletionPercent", query = "SELECT l FROM LearningProgress l WHERE l.completionPercent = :completionPercent"),
    @NamedQuery(name = "LearningProgress.findByLastAccess", query = "SELECT l FROM LearningProgress l WHERE l.lastAccess = :lastAccess")})
public class LearningProgress implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "progress_id")
    private Integer progressId;
    @Column(name = "completion_percent")
    private Integer completionPercent;
    @Column(name = "last_access")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastAccess;
    @JoinColumn(name = "lesson_id", referencedColumnName = "lesson_id")
    @ManyToOne(optional = false)
    private Lesson lessonId;
    @JoinColumn(name = "student_id", referencedColumnName = "student_id")
    @ManyToOne(optional = false)
    private Student studentId;

    public LearningProgress() {
    }

    public LearningProgress(Integer progressId) {
        this.progressId = progressId;
    }

    public Integer getProgressId() {
        return progressId;
    }

    public void setProgressId(Integer progressId) {
        this.progressId = progressId;
    }

    public Integer getCompletionPercent() {
        return completionPercent;
    }

    public void setCompletionPercent(Integer completionPercent) {
        this.completionPercent = completionPercent;
    }

    public Date getLastAccess() {
        return lastAccess;
    }

    public void setLastAccess(Date lastAccess) {
        this.lastAccess = lastAccess;
    }

    public Lesson getLessonId() {
        return lessonId;
    }

    public void setLessonId(Lesson lessonId) {
        this.lessonId = lessonId;
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
        hash += (progressId != null ? progressId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LearningProgress)) {
            return false;
        }
        LearningProgress other = (LearningProgress) object;
        if ((this.progressId == null && other.progressId != null) || (this.progressId != null && !this.progressId.equals(other.progressId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.LearningProgress[ progressId=" + progressId + " ]";
    }
    
}
