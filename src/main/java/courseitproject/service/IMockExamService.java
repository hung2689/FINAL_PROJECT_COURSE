package courseitproject.service;

import courseitproject.model.MockAttempt;
import courseitproject.model.MockExam;
import courseitproject.model.MockQuestion;
import java.util.List;

public interface IMockExamService {
    List<MockExam> getAllExams();
    MockExam getExamById(int examId);
    List<MockQuestion> getQuestionsByExamId(int examId);
    
    // Core exam entry logic
    MockAttempt enterExam(int userId, int examId);
    
    // Find active attempt for resume capability
    MockAttempt getActiveAttempt(int userId, int examId);
    
    // Submit exam
    MockAttempt submitExam(int attemptId, java.util.Map<Integer, String> userAnswers);
}
