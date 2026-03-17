/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.model;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "RepoSubmission")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RepoSubmission.findAll", query = "SELECT r FROM RepoSubmission r"),
    @NamedQuery(name = "RepoSubmission.findBySubmissionId", query = "SELECT r FROM RepoSubmission r WHERE r.submissionId = :submissionId"),
    @NamedQuery(name = "RepoSubmission.findByGithubUrl", query = "SELECT r FROM RepoSubmission r WHERE r.githubUrl = :githubUrl"),
    @NamedQuery(name = "RepoSubmission.findByScore", query = "SELECT r FROM RepoSubmission r WHERE r.score = :score"),
    @NamedQuery(name = "RepoSubmission.findByFeedback", query = "SELECT r FROM RepoSubmission r WHERE r.feedback = :feedback"),
    @NamedQuery(name = "RepoSubmission.findByStatus", query = "SELECT r FROM RepoSubmission r WHERE r.status = :status"),
    @NamedQuery(name = "RepoSubmission.findBySubmittedAt", query = "SELECT r FROM RepoSubmission r WHERE r.submittedAt = :submittedAt")})
public class RepoSubmission implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "submission_id")
    private Integer submissionId;
    @Size(max = 255)
    @Column(name = "github_url")
    private String githubUrl;
    @Column(name = "score")
    private Integer score;
    @Size(max = 2147483647)
    @Column(name = "feedback", columnDefinition = "nvarchar(MAX)")
    private String feedback;
    @Size(max = 255)
    @Column(name = "status")
    private String status;
    @Column(name = "submitted_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date submittedAt;
    @JoinColumn(name = "assignment_id", referencedColumnName = "assignment_id")
    @ManyToOne(optional = false)
    private Assignment assignmentId;
    @JoinColumn(name = "student_id", referencedColumnName = "student_id")
    @ManyToOne(optional = false)
    private Student studentId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "submissionId")
    private Collection<RepoFileAnalysis> repoFileAnalysisCollection;

    public RepoSubmission() {
    }

    public RepoSubmission(Integer submissionId) {
        this.submissionId = submissionId;
    }

    public Integer getSubmissionId() {
        return submissionId;
    }

    public void setSubmissionId(Integer submissionId) {
        this.submissionId = submissionId;
    }

    public String getGithubUrl() {
        return githubUrl;
    }

    public void setGithubUrl(String githubUrl) {
        this.githubUrl = githubUrl;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(Date submittedAt) {
        this.submittedAt = submittedAt;
    }

    public Assignment getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(Assignment assignmentId) {
        this.assignmentId = assignmentId;
    }

    public Student getStudentId() {
        return studentId;
    }

    public void setStudentId(Student studentId) {
        this.studentId = studentId;
    }

    @XmlTransient
    public Collection<RepoFileAnalysis> getRepoFileAnalysisCollection() {
        return repoFileAnalysisCollection;
    }

    public void setRepoFileAnalysisCollection(Collection<RepoFileAnalysis> repoFileAnalysisCollection) {
        this.repoFileAnalysisCollection = repoFileAnalysisCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (submissionId != null ? submissionId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RepoSubmission)) {
            return false;
        }
        RepoSubmission other = (RepoSubmission) object;
        if ((this.submissionId == null && other.submissionId != null) || (this.submissionId != null && !this.submissionId.equals(other.submissionId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.RepoSubmission[ submissionId=" + submissionId + " ]";
    }
    
}
