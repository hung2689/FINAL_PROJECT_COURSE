package courseitproject.model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "MockAttempt")
public class MockAttempt implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "attempt_id")
    private Integer attemptId;

    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    @ManyToOne(optional = false)
    private Users userId;

    @JoinColumn(name = "exam_id", referencedColumnName = "exam_id")
    @ManyToOne(optional = false)
    private MockExam examId;

    @Column(name = "score")
    private Double score;

    @Column(name = "coins_deducted")
    private Integer coinsDeducted;

    @Column(name = "started_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date startedAt;

    @Column(name = "submitted_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date submittedAt;

    // "IN_PROGRESS", "COMPLETED", "CHEAT_FLAGGED"
    @Column(name = "status")
    private String status;

    public MockAttempt() {
    }

    public Integer getAttemptId() {
        return attemptId;
    }

    public void setAttemptId(Integer attemptId) {
        this.attemptId = attemptId;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    public MockExam getExamId() {
        return examId;
    }

    public void setExamId(MockExam examId) {
        this.examId = examId;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Integer getCoinsDeducted() {
        return coinsDeducted;
    }

    public void setCoinsDeducted(Integer coinsDeducted) {
        this.coinsDeducted = coinsDeducted;
    }

    public Date getStartedAt() {
        return startedAt;
    }

    public void setStartedAt(Date startedAt) {
        this.startedAt = startedAt;
    }

    public Date getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(Date submittedAt) {
        this.submittedAt = submittedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
