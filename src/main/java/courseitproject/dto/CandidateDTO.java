package courseitproject.dto;

import java.util.Date;

public class CandidateDTO {
    private Integer id;
    private String candidateName;
    private String email;
    private Integer skillCount;
    private Integer projectCount;
    private Date appliedDate;
    private String status;
    private String cvUrl;

    public CandidateDTO() {
    }

    public CandidateDTO(Integer id, String candidateName, String email, Integer skillCount, Integer projectCount,
            Date appliedDate, String status, String cvUrl) {
        this.id = id;
        this.candidateName = candidateName;
        this.email = email;
        this.skillCount = skillCount;
        this.projectCount = projectCount;
        this.appliedDate = appliedDate;
        this.status = status;
        this.cvUrl = cvUrl;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCandidateName() {
        return candidateName;
    }

    public void setCandidateName(String candidateName) {
        this.candidateName = candidateName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getSkillCount() {
        return skillCount;
    }

    public void setSkillCount(Integer skillCount) {
        this.skillCount = skillCount;
    }

    public Integer getProjectCount() {
        return projectCount;
    }

    public void setProjectCount(Integer projectCount) {
        this.projectCount = projectCount;
    }

    public Date getAppliedDate() {
        return appliedDate;
    }

    public void setAppliedDate(Date appliedDate) {
        this.appliedDate = appliedDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCvUrl() {
        return cvUrl;
    }

    public void setCvUrl(String cvUrl) {
        this.cvUrl = cvUrl;
    }
}
