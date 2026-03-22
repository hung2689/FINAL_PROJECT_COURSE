package courseitproject.dao;

import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DashboardStatsDAO {

    public List<Map<String, Object>> getCourseCategoryDistribution() {
        EntityManager em = JPAUtil.getEntityManager();
        List<Map<String, Object>> resultList = new ArrayList<>();
        try {
            String sql = "SELECT cat.name, COUNT(c.course_id) AS total_courses " +
                         "FROM CourseCategory cat " +
                         "LEFT JOIN Course c ON cat.category_id = c.category_id " +
                         "GROUP BY cat.name " +
                         "ORDER BY total_courses DESC";

            @SuppressWarnings("unchecked")
            List<Object[]> rows = em.createNativeQuery(sql).getResultList();
            for (Object[] row : rows) {
                Map<String, Object> map = new HashMap<>();
                map.put("categoryName", row[0]);
                map.put("totalCourses", ((Number) row[1]).intValue());
                resultList.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return resultList;
    }

    public Map<String, List<Object>> getLoginActivity(String filter) {
        EntityManager em = JPAUtil.getEntityManager();
        Map<String, List<Object>> result = new HashMap<>();
        List<Object> labels = new ArrayList<>();
        List<Object> data = new ArrayList<>();
        result.put("labels", labels);
        result.put("data", data);
        
        try {
            if ("today".equals(filter)) {
                // Group by hour
                String sql = "SELECT DATEPART(HOUR, access_time) AS hr, COUNT(*) AS total " +
                             "FROM StudyLog " +
                             "WHERE DATE(access_time) = CURRENT_DATE() " +
                             "GROUP BY DATEPART(HOUR, access_time) " +
                             "ORDER BY hr";
                @SuppressWarnings("unchecked")
            List<Object[]> rows = em.createNativeQuery(sql).getResultList();
                Map<Integer, Integer> hourMap = new HashMap<>();
                for (Object[] row : rows) {
                    hourMap.put(((Number) row[0]).intValue(), ((Number) row[1]).intValue());
                }
                
                // 24 hours of the day
                for (int i = 0; i < 24; i++) {
                    String labelStr = (i == 0) ? "12AM" : (i < 12) ? i + "AM" : (i == 12) ? "12PM" : (i - 12) + "PM";
                    labels.add(labelStr);
                    data.add(hourMap.getOrDefault(i, 0));
                }

            } else if ("30days".equals(filter)) {
                // Approximate 4 weeks
                String sql = "SELECT FLOOR(DATEDIFF(CURRENT_TIMESTAMP(), access_time) / 7) AS weeks_ago, COUNT(*) AS total " +
                             "FROM StudyLog " +
                             "WHERE access_time >= DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 28 DAY) " +
                             "GROUP BY FLOOR(DATEDIFF(CURRENT_TIMESTAMP(), access_time) / 7) " +
                             "ORDER BY weeks_ago DESC";
                @SuppressWarnings("unchecked")
            List<Object[]> rows = em.createNativeQuery(sql).getResultList();
                Map<Integer, Integer> weekMap = new HashMap<>();
                for (Object[] row : rows) {
                    weekMap.put(((Number) row[0]).intValue(), ((Number) row[1]).intValue());
                }
                
                String[] labelsStr = {"Week 1", "Week 2", "Week 3", "Week 4"};
                int[] weeksAgo = {3, 2, 1, 0}; // 0 is current week
                for (int i = 0; i < weeksAgo.length; i++) {
                    labels.add(labelsStr[i]);
                    data.add(weekMap.getOrDefault(weeksAgo[i], 0));
                }

            } else {
                // 7 days (default)
                String sql = "SELECT DATE(access_time) AS d, COUNT(*) AS total " +
                             "FROM StudyLog " +
                             "WHERE access_time >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 DAY) " +
                             "GROUP BY DATE(access_time) " +
                             "ORDER BY d ASC";
                @SuppressWarnings("unchecked")
            List<Object[]> rows = em.createNativeQuery(sql).getResultList();
                
                // Format directly in java to guarantee Mon, Tue etc.
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("EEE", java.util.Locale.US);
                
                // We want to generate the last 7 days and match the results
                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.add(java.util.Calendar.DAY_OF_YEAR, -6);
                
                Map<String, Integer> dateMap = new HashMap<>();
                for (Object[] row : rows) {
                    Object dateObj = row[0];
                    String key = "";
                    if (dateObj instanceof java.util.Date) {
                        key = new java.text.SimpleDateFormat("yyyy-MM-dd").format((java.util.Date) dateObj);
                    } else if (dateObj instanceof java.time.LocalDate) {
                        key = ((java.time.LocalDate) dateObj).toString();
                    } else if (dateObj != null) {
                        key = dateObj.toString();
                    }
                    dateMap.put(key, ((Number) row[1]).intValue());
                }
                
                for(int i=0; i<7; i++) {
                    java.util.Date d = cal.getTime();
                    String key = new java.text.SimpleDateFormat("yyyy-MM-dd").format(d);
                    labels.add(sdf.format(d));
                    data.add(dateMap.getOrDefault(key, 0));
                    cal.add(java.util.Calendar.DAY_OF_YEAR, 1);
                }
            }

            result.put("labels", labels);
            result.put("data", data);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return result;
    }

    public void recordStudentLogin(int studentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            // Check if there's already a log for today
            String checkSql = "SELECT log_id FROM StudyLog WHERE student_id = :sid AND DATE(access_time) = CURRENT_DATE()";
            java.util.List<?> existing = em.createNativeQuery(checkSql)
                                         .setParameter("sid", studentId)
                                         .getResultList();
            if (existing == null || existing.isEmpty()) {
                String insertSql = "INSERT INTO StudyLog (student_id, study_time, access_time) VALUES (:sid, 0, CURRENT_TIMESTAMP())";
                em.createNativeQuery(insertSql)
                  .setParameter("sid", studentId)
                  .executeUpdate();
            } else {
                String updateSql = "UPDATE StudyLog SET access_time = CURRENT_TIMESTAMP() WHERE log_id = :lid";
                int logId = ((Number) existing.get(0)).intValue();
                em.createNativeQuery(updateSql)
                  .setParameter("lid", logId)
                  .executeUpdate();
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
