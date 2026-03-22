package courseitproject.service;

import courseitproject.dao.AIPredictionDAO;
import java.util.Map;

/**
 * Service layer for AI Prediction / Dropout Risk analytics.
 */
public class AIPredictionService {

    private final AIPredictionDAO dao;

    public AIPredictionService() {
        this.dao = new AIPredictionDAO();
    }

    /**
     * Get dropout risk statistics.
     *
     * @param days number of days to look back (7, 30), or 0 for all time
     * @return Map with totalStudents, highRisk, mediumRisk, lowRisk, dropoutRate
     */
    public Map<String, Object> getDropoutRiskStats(int days) {
        return dao.getDropoutRiskStats(days);
    }

    /**
     * Get a list of all students and their risk predictions.
     *
     * @param days number of days to look back
     * @return List of students (id, name, email, score) 
     */
    public java.util.List<Map<String, Object>> getAllStudentRiskPredictions(int days) {
        return dao.getAllStudentRiskPredictions(days);
    }
}
