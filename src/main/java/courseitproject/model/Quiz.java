/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "Quiz")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Quiz.findAll", query = "SELECT q FROM Quiz q"),
    @NamedQuery(name = "Quiz.findByQuizId", query = "SELECT q FROM Quiz q WHERE q.quizId = :quizId"),
    @NamedQuery(name = "Quiz.findByTotalScore", query = "SELECT q FROM Quiz q WHERE q.totalScore = :totalScore")})
public class Quiz implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "quiz_id")
    private Integer quizId;
    @Column(name = "total_score")
    private Integer totalScore;
    @JoinColumn(name = "lesson_id", referencedColumnName = "lesson_id")
    @ManyToOne(optional = false)
    private Lesson lessonId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "quizId")
    private Collection<Question> questionCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "quizId")
    private Collection<QuizResult> quizResultCollection;

    public Quiz() {
    }

    public Quiz(Integer quizId) {
        this.quizId = quizId;
    }

    public Integer getQuizId() {
        return quizId;
    }

    public void setQuizId(Integer quizId) {
        this.quizId = quizId;
    }

    public Integer getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Integer totalScore) {
        this.totalScore = totalScore;
    }

    public Lesson getLessonId() {
        return lessonId;
    }

    public void setLessonId(Lesson lessonId) {
        this.lessonId = lessonId;
    }

    @XmlTransient
    public Collection<Question> getQuestionCollection() {
        return questionCollection;
    }

    public void setQuestionCollection(Collection<Question> questionCollection) {
        this.questionCollection = questionCollection;
    }

    @XmlTransient
    public Collection<QuizResult> getQuizResultCollection() {
        return quizResultCollection;
    }

    public void setQuizResultCollection(Collection<QuizResult> quizResultCollection) {
        this.quizResultCollection = quizResultCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (quizId != null ? quizId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Quiz)) {
            return false;
        }
        Quiz other = (Quiz) object;
        if ((this.quizId == null && other.quizId != null) || (this.quizId != null && !this.quizId.equals(other.quizId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.Quiz[ quizId=" + quizId + " ]";
    }
    
}
