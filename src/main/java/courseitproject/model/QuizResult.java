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
@Table(name = "QuizResult")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "QuizResult.findAll", query = "SELECT q FROM QuizResult q"),
    @NamedQuery(name = "QuizResult.findByResultId", query = "SELECT q FROM QuizResult q WHERE q.resultId = :resultId"),
    @NamedQuery(name = "QuizResult.findByScore", query = "SELECT q FROM QuizResult q WHERE q.score = :score"),
    @NamedQuery(name = "QuizResult.findByAttemptTime", query = "SELECT q FROM QuizResult q WHERE q.attemptTime = :attemptTime")})
public class QuizResult implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "result_id")
    private Integer resultId;
    @Column(name = "score")
    private Integer score;
    @Column(name = "attempt_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date attemptTime;
    @JoinColumn(name = "quiz_id", referencedColumnName = "quiz_id")
    @ManyToOne(optional = false)
    private Quiz quizId;
    @JoinColumn(name = "student_id", referencedColumnName = "student_id")
    @ManyToOne(optional = false)
    private Student studentId;

    public QuizResult() {
    }

    public QuizResult(Integer resultId) {
        this.resultId = resultId;
    }

    public Integer getResultId() {
        return resultId;
    }

    public void setResultId(Integer resultId) {
        this.resultId = resultId;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Date getAttemptTime() {
        return attemptTime;
    }

    public void setAttemptTime(Date attemptTime) {
        this.attemptTime = attemptTime;
    }

    public Quiz getQuizId() {
        return quizId;
    }

    public void setQuizId(Quiz quizId) {
        this.quizId = quizId;
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
        hash += (resultId != null ? resultId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof QuizResult)) {
            return false;
        }
        QuizResult other = (QuizResult) object;
        if ((this.resultId == null && other.resultId != null) || (this.resultId != null && !this.resultId.equals(other.resultId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.QuizResult[ resultId=" + resultId + " ]";
    }
    
}
