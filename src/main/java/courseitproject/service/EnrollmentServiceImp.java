package courseitproject.service;

import courseitproject.model.*;
import courseitproject.utils.AIPredictorUtil;
import courseitproject.utils.EmailUtil;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import java.sql.Timestamp;

import java.util.Date;
import java.util.List;
import java.util.Locale;

public class EnrollmentServiceImp implements IEnrollmentService {

    // ===============================
    // GET ALL ENROLLMENTS BY STUDENT
    // ===============================
    @Override
    public List<Enrollment> getCoursesByStudentId(int studentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT e FROM Enrollment e "
                    + "JOIN FETCH e.courseId "
                    + "WHERE e.studentId.studentId = :sid "
                    + "ORDER BY e.enrollmentDate DESC",
                    Enrollment.class)
                    .setParameter("sid", studentId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    // ===============================
    // PAGINATION
    // ===============================
    @Override
    public List<Enrollment> getEnrollmentsByStudent(int studentId, int offset, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT e FROM Enrollment e "
                    + "LEFT JOIN FETCH e.courseId "
                    + "WHERE e.studentId.studentId = :sid "
                    + "ORDER BY e.enrollmentDate DESC",
                    Enrollment.class)
                    .setParameter("sid", studentId)
                    .setFirstResult(offset)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    // ===============================
    // COUNT
    // ===============================
    @Override
    public int countEnrollmentsByStudent(int studentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(e) FROM Enrollment e "
                    + "WHERE e.studentId.studentId = :sid",
                    Long.class)
                    .setParameter("sid", studentId)
                    .getSingleResult();

            return count == null ? 0 : count.intValue();
        } finally {
            em.close();
        }
    }

    // ===============================
    // CHECK ENROLLMENT
    // ===============================
    @Override
    public boolean isStudentEnrolled(int studentId, int courseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(e) FROM Enrollment e "
                    + "WHERE e.studentId.studentId = :sid "
                    + "AND e.courseId.courseId = :cid",
                    Long.class)
                    .setParameter("sid", studentId)
                    .setParameter("cid", courseId)
                    .getSingleResult();

            return count != null && count > 0;
        } finally {
            em.close();
        }
    }

    // ==================================================
    // ENROLL SINGLE COURSE (BUY NOW)
    // ==================================================
    public void enrollSingleCourse(int studentId, int courseId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            Student student = em.find(Student.class, studentId);
            Course course = em.find(Course.class, courseId);

            if (student == null || course == null) {
                em.getTransaction().rollback();
                return;
            }

            boolean alreadyEnrolled = em.createQuery(
                    "SELECT COUNT(e) > 0 FROM Enrollment e "
                    + "WHERE e.studentId.studentId = :sid "
                    + "AND e.courseId.courseId = :cid",
                    Boolean.class)
                    .setParameter("sid", studentId)
                    .setParameter("cid", courseId)
                    .getSingleResult();

            if (!alreadyEnrolled) {
                Enrollment enrollment = new Enrollment();
                enrollment.setStudentId(student);
                enrollment.setCourseId(course);
                enrollment.setEnrollmentDate(new Date());

                em.persist(enrollment);
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ==================================================
    // ENROLL FROM ORDER (SAU KHI THANH TOÁN)
    // ==================================================
    public void enrollFromOrder(int orderId) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            CourseOrder order = em.find(CourseOrder.class, orderId);

            if (order == null || !"PAID".equals(order.getStatus())) {
                em.getTransaction().rollback();
                return;
            }

            Student student = order.getStudentId();

            // FIX: Correct JPQL entity property paths (oi.courseId and oi.orderId.orderId)
            List<CourseOrderItem> items = em.createQuery(
                    "SELECT oi FROM CourseOrderItem oi "
                    + "JOIN FETCH oi.courseId "
                    + "WHERE oi.orderId.orderId = :oid",
                    CourseOrderItem.class)
                    .setParameter("oid", orderId)
                    .getResultList();

            for (CourseOrderItem item : items) {
                Course course = item.getCourseId();

                boolean alreadyEnrolled = em.createQuery(
                        "SELECT COUNT(e) > 0 FROM Enrollment e "
                        + "WHERE e.studentId.studentId = :sid "
                        + "AND e.courseId.courseId = :cid",
                        Boolean.class)
                        .setParameter("sid", student.getStudentId())
                        .setParameter("cid", course.getCourseId())
                        .getSingleResult();

                if (!alreadyEnrolled) {
                    Enrollment enrollment = new Enrollment();
                    enrollment.setStudentId(student);
                    enrollment.setCourseId(course);
                    enrollment.setEnrollmentDate(new Date());

                    em.persist(enrollment);
                }
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void checkAndWarnDropoutRisk(int enrollmentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // 1. Find Enrollment information
            Enrollment enrollment = em.find(Enrollment.class, enrollmentId);
            if (enrollment == null) {
                System.out.println("❌ [Error] Enrollment info not found for ID: " + enrollmentId);
                return;
            }

            // =========================================================
            // [STEP 1] GRACE PERIOD (7 DAYS)
            // Filter new students to avoid insufficient data for AI
            // =========================================================
            Date enrollDate = enrollment.getEnrollmentDate();
            if (enrollDate != null) {
                long diffInMillies = Math.abs(new Date().getTime() - enrollDate.getTime());
                long diffInDays = java.util.concurrent.TimeUnit.DAYS.convert(diffInMillies, java.util.concurrent.TimeUnit.MILLISECONDS);

                if (diffInDays < 7) {
                    System.out.println("⏳ [Skip] ID " + enrollmentId + " enrolled only " + diffInDays + " days ago (Min 7 days required). Skipping.");
                    return;
                }
            }

            // Get StudentId and CourseId
            int studentId = enrollment.getStudentId().getStudentId();
            int courseId = enrollment.getCourseId().getCourseId();

            // =========================================================
            // 2. DATA QUERY & TIME-BASED FEATURES
            // =========================================================
            // count_problem: Number of Quiz attempts
            String sqlProblem = "SELECT COUNT(*) FROM QuizResult qr JOIN Quiz q ON qr.quiz_id = q.quiz_id "
                    + "JOIN Lesson l ON q.lesson_id = l.lesson_id WHERE qr.student_id = :sid AND l.course_id = :cid";
            int countProblem = ((Number) em.createNativeQuery(sqlProblem).setParameter("sid", studentId).setParameter("cid", courseId).getSingleResult()).intValue();

            // count_video: Number of Lessons completed
            String sqlVideo = "SELECT COUNT(*) FROM LearningProgress lp JOIN Lesson l ON lp.lesson_id = l.lesson_id "
                    + "WHERE lp.student_id = :sid AND l.course_id = :cid";
            int countVideo = ((Number) em.createNativeQuery(sqlVideo).setParameter("sid", studentId).setParameter("cid", courseId).getSingleResult()).intValue();

            // count_access & active_days: From StudyLog table
            int countAccess = ((Number) em.createNativeQuery("SELECT COUNT(*) FROM StudyLog WHERE student_id = :sid")
                    .setParameter("sid", studentId).getSingleResult()).intValue();
            int activeDays = ((Number) em.createNativeQuery("SELECT COUNT(DISTINCT CAST(access_time AS DATE)) FROM StudyLog WHERE student_id = :sid")
                    .setParameter("sid", studentId).getSingleResult()).intValue();

            // === TIME FEATURES ===
            String timeFeatureSql
                    = "SELECT "
                    + "   ISNULL(DATEDIFF(day, MAX(access_time), GETDATE()), 999) AS days_since_last_login, "
                    + "   ISNULL(SUM(CASE WHEN access_time >= DATEADD(day, -7, GETDATE()) THEN study_time ELSE 0 END), 0) AS study_time_last_7_days, "
                    + "   ISNULL(SUM(CASE WHEN access_time >= DATEADD(day, -14, GETDATE()) AND access_time < DATEADD(day, -7, GETDATE()) THEN study_time ELSE 0 END), 0) AS study_time_prev_7_days "
                    + "FROM StudyLog WHERE student_id = :sid";

            Object[] timeFeatures = (Object[]) em.createNativeQuery(timeFeatureSql)
                    .setParameter("sid", studentId)
                    .getSingleResult();

            int daysSinceLastLogin = ((Number) timeFeatures[0]).intValue();
            int studyTimeLast7Days = ((Number) timeFeatures[1]).intValue();
            int studyTimePrev7Days = ((Number) timeFeatures[2]).intValue();
            int trendScore = studyTimeLast7Days - studyTimePrev7Days;

            // =========================================================
            // 3. CALL AI ANALYSIS (PYTHON API)
            // =========================================================
            String jsonToAI = String.format(Locale.US,
                    "{\"count_access\": %d, \"count_video\": %d, \"count_problem\": %d, \"active_days\": %d, \"days_since_last_login\": %d, \"study_time_last_7_days\": %d, \"trend_score\": %d}",
                    countAccess, countVideo, countProblem, activeDays, daysSinceLastLogin, studyTimeLast7Days, trendScore
            );
            double dropoutRisk = AIPredictorUtil.callAIPredictAPI(jsonToAI);

            // =========================================================
            // 4. SAVE RESULTS TO AI_Prediction TABLE
            // =========================================================
            String level = (dropoutRisk >= 0.8) ? "HIGH" : (dropoutRisk >= 0.5 ? "MEDIUM" : "LOW");

            em.getTransaction().begin();
            String insertSql = "INSERT INTO AI_Prediction (student_id, predicted_level, risk_score, created_at) VALUES (:sid, :lvl, :score, :time)";
            em.createNativeQuery(insertSql)
                    .setParameter("sid", studentId)
                    .setParameter("lvl", level)
                    .setParameter("score", dropoutRisk * 100)
                    .setParameter("time", new Timestamp(System.currentTimeMillis()))
                    .executeUpdate();
            em.getTransaction().commit();

            // =========================================================
            // 5. EMAIL NOTIFICATION LOGIC (ANTI-SPAM)
            // =========================================================
            double riskPercent = dropoutRisk * 100;
            boolean shouldSendEmail = false;
            String alertType = "";

            if (riskPercent >= 80) {
                String currentIdSql = "SELECT MAX(prediction_id) FROM AI_Prediction WHERE student_id = :sid";
                int currentId = ((Number) em.createNativeQuery(currentIdSql).setParameter("sid", studentId).getSingleResult()).intValue();

                String checkHighSql = "SELECT COUNT(*) FROM AI_Prediction WHERE student_id = :sid AND risk_score >= 80 AND prediction_id < :currentId";
                int countHigh = ((Number) em.createNativeQuery(checkHighSql).setParameter("sid", studentId).setParameter("currentId", currentId).getSingleResult()).intValue();

                if (countHigh == 0) {
                    shouldSendEmail = true;
                    alertType = (riskPercent >= 95) ? "🔥 RED ALERT" : "⚠️ WARNING";
                    System.out.println("🚨 [Alert] First-time high risk detected. Preparing to send email...");
                } else {
                    String lastLowSql = "SELECT MAX(created_at) FROM AI_Prediction WHERE student_id = :sid AND risk_score < 80";
                    Object lastLowObj = em.createNativeQuery(lastLowSql).setParameter("sid", studentId).getSingleResult();

                    if (lastLowObj != null) {
                        String prevWarnSql = "SELECT MAX(created_at) FROM AI_Prediction WHERE student_id = :sid AND risk_score >= 80 AND created_at < :lastLow";
                        Object prevWarnObj = em.createNativeQuery(prevWarnSql).setParameter("sid", studentId).setParameter("lastLow", lastLowObj).getSingleResult();

                        if (prevWarnObj != null) {
                            String checkTimeSql = "SELECT DATEDIFF(day, :prevWarnDate, GETDATE())";
                            int daysSinceLastWarn = ((Number) em.createNativeQuery(checkTimeSql).setParameter("prevWarnDate", prevWarnObj).getSingleResult()).intValue();

                            if (daysSinceLastWarn >= 7) {
                                shouldSendEmail = true;
                                alertType = (riskPercent >= 95) ? "🔥 RED ALERT (Repeated)" : "⚠️ WARNING (Repeated)";
                                System.out.println("🔄 [Alert] Repeated risk after " + daysSinceLastWarn + " days. Sending reminder email!");
                            } else {
                                System.out.println("⏭️ [Skip] Repeated risk but only " + daysSinceLastWarn + " days since last warning. Anti-spam triggered.");
                            }
                        }
                    } else {
                        System.out.println("⏭️ [Skip] Continuous high risk without improvement. Anti-spam triggered.");
                    }
                }
            }

            // 6. EXECUTE EMAIL SENDING
            if (shouldSendEmail) {
                Users user = em.find(Users.class, studentId);
                if (user != null && user.getEmail() != null) {
                    String courseName = enrollment.getCourseId().getTitle();
                    EmailUtil emailService = new EmailUtil();

                    String subject = alertType + " - Course: " + courseName;
                    String content = "Hello " + user.getFullName() + ",\n\n"
                            + "Our system has detected your engagement level is currently at: " + alertType + " (" + String.format("%.2f", riskPercent) + "%).\n"
                            + "Please log in and continue your learning path to stay on track!\n\n"
                            + "Best regards,\nDevLearn System.";

                    try {
                        emailService.send(user.getEmail(), subject, content);
                        System.out.println("📧 [Email Sent] Successfully delivered to: " + user.getEmail());
                    } catch (Exception e) {
                        System.out.println("❌ [Error] Email delivery failed: " + e.getMessage());
                    }
                }
            }

            System.out.println("✅ [Done] AI process completed for Enrollment: " + enrollmentId);

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // Method 2: Batch scan all active students
    public void checkAllActiveStudentsRisk() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // 1. Get list of ALL active Enrollment IDs
            List<Integer> activeEnrollmentIds = em.createQuery(
                    "SELECT e.enrollmentId FROM Enrollment e WHERE e.status = 'ACTIVE'",
                    Integer.class)
                    .getResultList();

            System.out.println("🔍 [AI Scheduler] Found " + activeEnrollmentIds.size() + " active students. Starting batch analysis...");

            // 2. Loop through each student
            for (Integer eId : activeEnrollmentIds) {
                System.out.println("---------------------------------------------------");
                System.out.println("➡️ Analyzing risk for Enrollment ID: " + eId);

                checkAndWarnDropoutRisk(eId);
            }

            System.out.println("===================================================");
            System.out.println("✅ [AI Scheduler] ALL STUDENTS SCANNED SUCCESSFULLY!");
            System.out.println("===================================================");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
