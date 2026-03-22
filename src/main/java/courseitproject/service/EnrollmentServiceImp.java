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
            // 1. Tìm thông tin Enrollment
            Enrollment enrollment = em.find(Enrollment.class, enrollmentId);
            if (enrollment == null) {
                System.out.println("❌ [Error] Enrollment info not found for ID: " + enrollmentId);
                return;
            }

            // =========================================================
            // [BƯỚC 1] BỎ QUA 7 NGÀY ĐẦU (GRACE PERIOD)
            // Lọc học viên mới để tránh AI thiếu dữ liệu phân tích
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

            // Lấy StudentId và CourseId
            int studentId = enrollment.getStudentId().getStudentId();
            int courseId = enrollment.getCourseId().getCourseId();

            // =========================================================
            // [BƯỚC 2] TRUY VẤN DỮ LIỆU & TÍNH TOÁN CÁC CHỈ SỐ
            // =========================================================
            // count_problem: Số bài Quiz đã làm
            String sqlProblem = "SELECT COUNT(*) FROM QuizResult qr JOIN Quiz q ON qr.quiz_id = q.quiz_id "
                    + "JOIN Lesson l ON q.lesson_id = l.lesson_id WHERE qr.student_id = :sid AND l.course_id = :cid";
            int countProblem = ((Number) em.createNativeQuery(sqlProblem).setParameter("sid", studentId).setParameter("cid", courseId).getSingleResult()).intValue();

            // count_video: Số bài học đã hoàn thành
            String sqlVideo = "SELECT COUNT(*) FROM LearningProgress lp JOIN Lesson l ON lp.lesson_id = l.lesson_id "
                    + "WHERE lp.student_id = :sid AND l.course_id = :cid";
            int countVideo = ((Number) em.createNativeQuery(sqlVideo).setParameter("sid", studentId).setParameter("cid", courseId).getSingleResult()).intValue();

            // count_access & active_days: Từ bảng StudyLog
            int countAccess = ((Number) em.createNativeQuery("SELECT COUNT(*) FROM StudyLog WHERE student_id = :sid")
                    .setParameter("sid", studentId).getSingleResult()).intValue();
            int activeDays = ((Number) em.createNativeQuery("SELECT COUNT(DISTINCT CAST(access_time AS DATE)) FROM StudyLog WHERE student_id = :sid")
                    .setParameter("sid", studentId).getSingleResult()).intValue();

            // === CÁC CHỈ SỐ THỜI GIAN (TIME FEATURES) ===
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
            // [BƯỚC 3] GỌI AI PHÂN TÍCH (PYTHON API)
            // =========================================================
            String jsonToAI = String.format(Locale.US,
                    "{\"count_access\": %d, \"count_video\": %d, \"count_problem\": %d, \"active_days\": %d, \"days_since_last_login\": %d, \"study_time_last_7_days\": %d, \"trend_score\": %d}",
                    countAccess, countVideo, countProblem, activeDays, daysSinceLastLogin, studyTimeLast7Days, trendScore
            );
            double dropoutRisk = AIPredictorUtil.callAIPredictAPI(jsonToAI);

            // =========================================================
            // [BƯỚC 4] LƯU KẾT QUẢ VÀO BẢNG AI_Prediction
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
            // [BƯỚC 5] LOGIC GỬI EMAIL CẢNH BÁO (CÓ CHỐNG SPAM)
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
                    alertType = (riskPercent >= 95) ? "🚨 MỨC ĐỘ NGUY HIỂM" : "⚠️ CẢNH BÁO";
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
                                alertType = (riskPercent >= 95) ? "🚨 MỨC ĐỘ NGUY HIỂM (Nhắc lại)" : "⚠️ CẢNH BÁO (Nhắc lại)";
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

            // =========================================================
            // [BƯỚC 6] THỰC THI GỬI EMAIL (FORM HTML CHUẨN)
            // =========================================================
            if (shouldSendEmail) {
                Users user = em.find(Users.class, studentId);
                if (user != null && user.getEmail() != null) {
                    String courseName = enrollment.getCourseId().getTitle();
                    EmailUtil emailService = new EmailUtil();

                    String subject = alertType + " - Tiến độ học tập khóa: " + courseName;
                    
                    // Xử lý text hiển thị số ngày vắng mặt để tránh lỗi "vắng 999 ngày"
                    String displayAbsentText = "";
                    if (daysSinceLastLogin == 999) {
                        displayAbsentText = "Chưa từng vào học từ lúc đăng ký";
                    } else {
                        displayAbsentText = "Đã vắng mặt " + daysSinceLastLogin + " ngày";
                    }
                    
                    // Xây dựng nội dung HTML chuẩn Đại học
                    String content = "<div style=\"font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 800px; margin: 0 auto;\">"
                            + "<p>Thân gửi <strong>" + user.getFullName() + "</strong> , Mã số học viên: <strong>" + user.getUserId() + "</strong></p>"
                            + "<p>Phòng Chăm sóc Học viên DevLearn thông báo đến bạn về tình trạng gián đoạn tiến độ học tập:</p>"
                            
                            // Sử dụng biến displayAbsentText đã xử lý ở trên
                            + "<p>Khóa học: <strong>" + courseName + "</strong> - Tình trạng: <strong>Cảnh báo rủi ro " + String.format("%.0f", riskPercent) + "% (" + displayAbsentText + ")</strong></p>"
                            
                            + "<p>Bạn lưu ý kiểm tra lại tiến độ học tập hàng ngày trên hệ thống DevLearn để theo kịp lộ trình nhé. Trong trường hợp bạn gặp khó khăn làm gián đoạn việc học, vui lòng làm theo hướng dẫn sau:</p>"
                            + "<p>1. Nếu gặp lỗi kỹ thuật không thể xem video hoặc nộp bài, học viên cần gửi mail cho bộ phận Hỗ trợ Kỹ thuật (<a href=\"mailto:support@devlearn.edu.vn\">support@devlearn.edu.vn</a>) trong vòng 24 giờ kể từ thời điểm phát sinh lỗi để đề nghị xử lý.</p>"
                            + "<p>2. Đối với các thắc mắc về kiến thức bài giảng, học viên liên hệ trực tiếp với Giảng viên phụ trách qua mục Thảo luận hoặc qua email với nội dung gồm: <em>Họ tên, mã học viên, tên khóa học - bài học, nội dung cần giải đáp</em>.</p>"
                            + "<p>Trong trường hợp đã liên hệ Giảng viên đúng quy định nhưng sau 48 giờ làm việc không nhận được phản hồi, học viên vui lòng ngay sau đó chuyển tiếp email đã làm việc với Giảng viên qua email Phòng Chăm sóc Học viên (<a href=\"mailto:cskh@devlearn.edu.vn\">cskh@devlearn.edu.vn</a>) để được hỗ trợ xử lý kịp thời.</p>"
                            + "<p>3. Học viên được miễn trừ cảnh báo tiến độ do có lý do cá nhân chính đáng (đã được phê duyệt bảo lưu) vui lòng chủ động liên hệ Giảng viên để được hỗ trợ mở lại bài tập và bài kiểm tra theo đúng quy định khi quay trở lại.</p>"
                            + "<p>Ngoài ra, học viên cần chú ý thời gian kết thúc quyền truy cập khóa học. Hệ thống sẽ tự động khóa truy cập nếu khóa học hết hạn hoặc nếu tiến độ của bạn vượt quá ngưỡng rủi ro cho phép (fail attendance). Bạn hãy nhanh chóng quay lại học tập để duy trì tiến độ nhé.</p>"
                            + "<p style=\"font-style: italic; color: #555; font-size: 0.9em; border-top: 1px solid #eee; padding-top: 10px;\">Lưu ý: Đây là email tự động từ Hệ thống AI Giám sát Học tập. Mọi thắc mắc cần được hỗ trợ, học viên vui lòng email phòng Chăm sóc Học viên hoặc gọi số điện thoại hotline (giờ làm việc). Email: <a href=\"mailto:cskh@devlearn.edu.vn\">cskh@devlearn.edu.vn</a></p>"
                            + "<p>Thân mến,<br><strong>Phòng Chăm sóc Học viên DevLearn</strong></p>"
                            + "</div>";

                    try {
                        emailService.send(user.getEmail(), subject, content);
                        System.out.println("📧 [Email Sent] Successfully delivered HTML email to: " + user.getEmail());
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

    // =========================================================
    // HÀM 2: QUÉT TOÀN BỘ HỌC VIÊN ĐANG ACTIVE
    // =========================================================
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
