package courseitproject.model;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

@Entity
@Table(name = "MockExam")
@NamedQueries({
    @NamedQuery(name = "MockExam.findAll", query = "SELECT m FROM MockExam m"),
    @NamedQuery(name = "MockExam.findByExamId", query = "SELECT m FROM MockExam m WHERE m.examId = :examId")
})
public class MockExam implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "exam_id")
    private Integer examId;

    @Column(name = "title", columnDefinition = "NVARCHAR(255)")
    private String title;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "duration_minutes")
    private Integer durationMinutes;

    @Column(name = "cost_coins")
    private Integer costCoins;

    @Column(name = "category", columnDefinition = "NVARCHAR(100)")
    private String category;

    @Column(name = "difficulty", columnDefinition = "NVARCHAR(30)")
    private String difficulty;

    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "examId", fetch = jakarta.persistence.FetchType.EAGER)
    private Collection<MockQuestion> questionCollection;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "examId")
    private Collection<MockAttempt> attemptCollection;

    public MockExam() {
    }

    public Integer getExamId() {
        return examId;
    }

    public void setExamId(Integer examId) {
        this.examId = examId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(Integer durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public Integer getCostCoins() {
        return costCoins;
    }

    public void setCostCoins(Integer costCoins) {
        this.costCoins = costCoins;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Collection<MockQuestion> getQuestionCollection() {
        return questionCollection;
    }

    public void setQuestionCollection(Collection<MockQuestion> questionCollection) {
        this.questionCollection = questionCollection;
    }

    public Collection<MockAttempt> getAttemptCollection() {
        return attemptCollection;
    }

    public void setAttemptCollection(Collection<MockAttempt> attemptCollection) {
        this.attemptCollection = attemptCollection;
    }
}
