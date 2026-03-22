package courseitproject.search.criteria;

import courseitproject.model.Candidates;

public class CandidateSearchCriteria implements SearchCriteria<Candidates> {
    private Integer minScore;
    private Integer maxScore;
    private String decision;
    private Integer skillsCount;

    public CandidateSearchCriteria() {
    }

    public Integer getMinScore() {
        return minScore;
    }

    public void setMinScore(Integer minScore) {
        this.minScore = minScore;
    }

    public Integer getMaxScore() {
        return maxScore;
    }

    public void setMaxScore(Integer maxScore) {
        this.maxScore = maxScore;
    }

    public String getDecision() {
        return decision;
    }

    public void setDecision(String decision) {
        this.decision = decision;
    }

    public Integer getSkillsCount() {
        return skillsCount;
    }

    public void setSkillsCount(Integer skillsCount) {
        this.skillsCount = skillsCount;
    }
}
