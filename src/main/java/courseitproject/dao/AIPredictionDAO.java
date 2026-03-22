package courseitproject.dao;

import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.HashMap;
import java.util.Map;

/**
 * DAO for querying AI_Prediction dropout risk statistics.
 * Uses native SQL for SQL Server aggregate queries.
 */
public class AIPredictionDAO {

    /**
     * Get dropout risk summary stats with optional day filter.
     *
     * @param days number of days to look back (7, 30), or 0 for all time
     * @return Map with keys: totalStudents, highRisk, mediumRisk, lowRisk, dropoutRate
     */
    public Map<String, Object> getDropoutRiskStats(int days) {
        EntityManager em = JPAUtil.getEntityManager();
        Map<String, Object> result = new HashMap<>();
        try {
            // Build a subquery that picks only the LATEST prediction per student
            String dateFilter = "";
            if (days > 0) {
                dateFilter = " AND created_at >= DATEADD(day, -" + days + ", GETDATE()) ";
            }

            String sql =
                "WITH LatestPrediction AS ( " +
                "    SELECT student_id, risk_score, predicted_level, " +
                "           ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY created_at DESC) AS rn " +
                "    FROM AI_Prediction " +
                "    WHERE 1=1 " + dateFilter +
                ") " +
                "SELECT " +
                "    COUNT(*) AS total_students, " +
                "    SUM(CASE WHEN risk_score >= 70 THEN 1 ELSE 0 END) AS high_risk, " +
                "    SUM(CASE WHEN risk_score >= 30 AND risk_score < 70 THEN 1 ELSE 0 END) AS medium_risk, " +
                "    SUM(CASE WHEN risk_score < 30 THEN 1 ELSE 0 END) AS low_risk, " +
                "    CAST(SUM(CASE WHEN risk_score >= 70 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0) AS DECIMAL(5,2)) AS dropout_rate " +
                "FROM LatestPrediction WHERE rn = 1";

            Object[] row = (Object[]) em.createNativeQuery(sql).getSingleResult();

            int totalStudents = ((Number) row[0]).intValue();
            int highRisk      = row[1] != null ? ((Number) row[1]).intValue() : 0;
            int mediumRisk    = row[2] != null ? ((Number) row[2]).intValue() : 0;
            int lowRisk       = row[3] != null ? ((Number) row[3]).intValue() : 0;
            double dropoutRate = row[4] != null ? ((Number) row[4]).doubleValue() : 0.0;

            result.put("totalStudents", totalStudents);
            result.put("highRisk", highRisk);
            result.put("mediumRisk", mediumRisk);
            result.put("lowRisk", lowRisk);
            result.put("dropoutRate", dropoutRate);

        } catch (Exception e) {
            // Return zeros on error (e.g. empty table)
            result.put("totalStudents", 0);
            result.put("highRisk", 0);
            result.put("mediumRisk", 0);
            result.put("lowRisk", 0);
            result.put("dropoutRate", 0.0);
            e.printStackTrace();
        } finally {
            em.close();
        }
        return result;
    }

    /**
     * Get a list of all students and their risk predictions.
     *
     * @param days number of days to look back
     * @return List of students (id, name, email, score) 
     */
    public java.util.List<Map<String, Object>> getAllStudentRiskPredictions(int days) {
        EntityManager em = JPAUtil.getEntityManager();
        java.util.List<Map<String, Object>> resultList = new java.util.ArrayList<>();
        try {
            String dateFilter = "";
            if (days > 0) {
                dateFilter = " AND created_at >= DATEADD(day, -" + days + ", GETDATE()) ";
            }

            String sql =
                "WITH LatestPrediction AS ( " +
                "    SELECT student_id, risk_score, predicted_level, " +
                "           ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY created_at DESC) AS rn " +
                "    FROM AI_Prediction " +
                "    WHERE 1=1 " + dateFilter +
                ") " +
                "SELECT " +
                "    u.user_id, " +
                "    u.full_name, " +
                "    u.email, " +
                "    p.risk_score " +
                "FROM LatestPrediction p " +
                "JOIN Users u ON p.student_id = u.user_id " +
                "WHERE p.rn = 1 " +
                "ORDER BY p.risk_score DESC";

            java.util.List<Object[]> rows = em.createNativeQuery(sql).getResultList();
            
            for (Object[] row : rows) {
                Map<String, Object> map = new HashMap<>();
                map.put("userId", row[0]);
                map.put("fullName", row[1]);
                map.put("email", row[2]);
                map.put("riskScore", row[3]);
                resultList.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return resultList;
    }
}
