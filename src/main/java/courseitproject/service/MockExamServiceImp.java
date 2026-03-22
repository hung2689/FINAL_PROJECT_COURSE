package courseitproject.service;

import courseitproject.model.*;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class MockExamServiceImp implements IMockExamService {

    @Override
    public List<MockExam> getAllExams() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT m FROM MockExam m ORDER BY m.createdAt DESC", MockExam.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public MockExam getExamById(int examId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(MockExam.class, examId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<MockQuestion> getQuestionsByExamId(int examId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT q FROM MockQuestion q WHERE q.examId.examId = :eid", MockQuestion.class)
                    .setParameter("eid", examId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public MockAttempt enterExam(int userId, int examId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            
            Users user = em.find(Users.class, userId);
            MockExam exam = em.find(MockExam.class, examId);
            
            if (user == null || exam == null) {
                tx.rollback();
                return null;
            }

            int cost = exam.getCostCoins() != null ? exam.getCostCoins() : 0;
            int currentCoins = user.getStudyCoins() != null ? user.getStudyCoins() : 0;
            
            if (currentCoins < cost) {
                // Not enough coins
                tx.rollback();
                return null; // The controller should handle null or throw custom exceptions
            }
            
            // Deduct Coins
            user.setStudyCoins(currentCoins - cost);
            em.merge(user);
            
            // Create Ticket
            MockAttempt attempt = new MockAttempt();
            attempt.setUserId(user);
            attempt.setExamId(exam);
            attempt.setCoinsDeducted(cost);
            attempt.setStartedAt(new Date());
            attempt.setStatus("IN_PROGRESS");
            attempt.setScore(0.0);
            
            em.persist(attempt);
            
            tx.commit();
            return attempt;
            
        } catch(Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public MockAttempt getActiveAttempt(int userId, int examId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<MockAttempt> activeAttempts = em.createQuery(
                "SELECT a FROM MockAttempt a WHERE a.userId.userId = :uid AND a.examId.examId = :eid AND a.status = 'IN_PROGRESS' ORDER BY a.startedAt DESC", 
                MockAttempt.class)
                .setParameter("uid", userId)
                .setParameter("eid", examId)
                .setMaxResults(1)
                .getResultList();
                
            return activeAttempts.isEmpty() ? null : activeAttempts.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public MockAttempt submitExam(int attemptId, Map<Integer, String> userAnswers) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            
            MockAttempt attempt = em.find(MockAttempt.class, attemptId);
            if (attempt == null || !"IN_PROGRESS".equals(attempt.getStatus())) {
                tx.rollback();
                return null;
            }
            
            MockExam exam = attempt.getExamId();
            List<MockQuestion> questions = getQuestionsByExamId(exam.getExamId());
            
            double totalScore = 0;
            int correctCount = 0;
            
            // Check answers
            for (MockQuestion q : questions) {
                String userAnswer = userAnswers.get(q.getQuestionId());
                if (userAnswer != null && userAnswer.equalsIgnoreCase(q.getCorrectAnswer())) {
                    correctCount++;
                }
            }
            
            // Scale to 10 points usually, or 100 points
            if (!questions.isEmpty()) {
                totalScore = (double) correctCount / questions.size() * 10.0;
            }
            
            // Close the ticket
            attempt.setStatus("COMPLETED");
            attempt.setSubmittedAt(new Date());
            attempt.setScore(totalScore);
            
            em.merge(attempt);
            tx.commit();
            
            return attempt;
            
        } catch(Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
}
