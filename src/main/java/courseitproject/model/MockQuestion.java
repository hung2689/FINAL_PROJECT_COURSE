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
import java.io.Serializable;

@Entity
@Table(name = "MockQuestion")
public class MockQuestion implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "question_id")
    private Integer questionId;

    @JoinColumn(name = "exam_id", referencedColumnName = "exam_id")
    @ManyToOne(optional = false)
    private MockExam examId;

    @Column(name = "content", columnDefinition = "NVARCHAR(MAX)")
    private String content;

    @Column(name = "option_a", columnDefinition = "NVARCHAR(MAX)")
    private String optionA;

    @Column(name = "option_b", columnDefinition = "NVARCHAR(MAX)")
    private String optionB;

    @Column(name = "option_c", columnDefinition = "NVARCHAR(MAX)")
    private String optionC;

    @Column(name = "option_d", columnDefinition = "NVARCHAR(MAX)")
    private String optionD;

    @Column(name = "correct_answer")
    private String correctAnswer;

    public MockQuestion() {
    }

    public Integer getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public MockExam getExamId() {
        return examId;
    }

    public void setExamId(MockExam examId) {
        this.examId = examId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getOptionA() {
        return optionA;
    }

    public void setOptionA(String optionA) {
        this.optionA = optionA;
    }

    public String getOptionB() {
        return optionB;
    }

    public void setOptionB(String optionB) {
        this.optionB = optionB;
    }

    public String getOptionC() {
        return optionC;
    }

    public void setOptionC(String optionC) {
        this.optionC = optionC;
    }

    public String getOptionD() {
        return optionD;
    }

    public void setOptionD(String optionD) {
        this.optionD = optionD;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }
}
