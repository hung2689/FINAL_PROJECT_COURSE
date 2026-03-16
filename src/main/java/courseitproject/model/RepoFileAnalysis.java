/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "RepoFileAnalysis")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RepoFileAnalysis.findAll", query = "SELECT r FROM RepoFileAnalysis r"),
    @NamedQuery(name = "RepoFileAnalysis.findByFileId", query = "SELECT r FROM RepoFileAnalysis r WHERE r.fileId = :fileId"),
    @NamedQuery(name = "RepoFileAnalysis.findByFileName", query = "SELECT r FROM RepoFileAnalysis r WHERE r.fileName = :fileName"),
    @NamedQuery(name = "RepoFileAnalysis.findBySummary", query = "SELECT r FROM RepoFileAnalysis r WHERE r.summary = :summary"),
    @NamedQuery(name = "RepoFileAnalysis.findByAiScore", query = "SELECT r FROM RepoFileAnalysis r WHERE r.aiScore = :aiScore")})
public class RepoFileAnalysis implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "file_id")
    private Integer fileId;
    @Size(max = 500)
    @Column(name = "file_name", length = 500)
    private String fileName;
    @Column(name = "summary", columnDefinition = "NVARCHAR(MAX)")
    private String summary;
    @Column(name = "ai_score")
    private Integer aiScore;
    @JoinColumn(name = "submission_id", referencedColumnName = "submission_id")
    @ManyToOne(optional = false)
    private RepoSubmission submissionId;

    public RepoFileAnalysis() {
    }

    public RepoFileAnalysis(Integer fileId) {
        this.fileId = fileId;
    }

    public Integer getFileId() {
        return fileId;
    }

    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public Integer getAiScore() {
        return aiScore;
    }

    public void setAiScore(Integer aiScore) {
        this.aiScore = aiScore;
    }

    public RepoSubmission getSubmissionId() {
        return submissionId;
    }

    public void setSubmissionId(RepoSubmission submissionId) {
        this.submissionId = submissionId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (fileId != null ? fileId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RepoFileAnalysis)) {
            return false;
        }
        RepoFileAnalysis other = (RepoFileAnalysis) object;
        if ((this.fileId == null && other.fileId != null) || (this.fileId != null && !this.fileId.equals(other.fileId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.RepoFileAnalysis[ fileId=" + fileId + " ]";
    }
    
}
