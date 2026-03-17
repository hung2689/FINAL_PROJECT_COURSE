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
@Table(name = "Assignment")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Assignment.findAll", query = "SELECT a FROM Assignment a"),
    @NamedQuery(name = "Assignment.findByAssignmentId", query = "SELECT a FROM Assignment a WHERE a.assignmentId = :assignmentId"),
    @NamedQuery(name = "Assignment.findByTitle", query = "SELECT a FROM Assignment a WHERE a.title = :title"),
    @NamedQuery(name = "Assignment.findByDescription", query = "SELECT a FROM Assignment a WHERE a.description = :description"),
    @NamedQuery(name = "Assignment.findByFileExtensions", query = "SELECT a FROM Assignment a WHERE a.fileExtensions = :fileExtensions"),
    @NamedQuery(name = "Assignment.findByCriteria", query = "SELECT a FROM Assignment a WHERE a.criteria = :criteria"),
    @NamedQuery(name = "Assignment.findByCreatedAt", query = "SELECT a FROM Assignment a WHERE a.createdAt = :createdAt"),
    @NamedQuery(name = "Assignment.findByExpectedOutput", query = "SELECT a FROM Assignment a WHERE a.expectedOutput = :expectedOutput")})
public class Assignment implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "assignment_id")
    private Integer assignmentId;
    @Size(max = 255)
    @Column(name = "title")
    private String title;
    @Column(name = "description", columnDefinition="nvarchar(MAX)")
    private String description;
    @Size(max = 255)
    @Column(name = "file_extensions")
    private String fileExtensions;
    @Column(name = "criteria", columnDefinition="nvarchar(MAX)")
    private String criteria;
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @Column(name = "expected_output", columnDefinition="nvarchar(MAX)")
    private String expectedOutput;
    @JoinColumn(name = "lesson_id", referencedColumnName = "lesson_id")
    @ManyToOne(optional = false)
    private Lesson lessonId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "assignmentId")
    private Collection<RepoSubmission> repoSubmissionCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "assignmentId")
    private Collection<AssignmentCriteria> assignmentCriteriaCollection;

    public Assignment() {
    }

    public Assignment(Integer assignmentId) {
        this.assignmentId = assignmentId;
    }

    public Integer getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(Integer assignmentId) {
        this.assignmentId = assignmentId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFileExtensions() {
        return fileExtensions;
    }

    public void setFileExtensions(String fileExtensions) {
        this.fileExtensions = fileExtensions;
    }

    public String getCriteria() {
        return criteria;
    }

    public void setCriteria(String criteria) {
        this.criteria = criteria;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getExpectedOutput() {
        return expectedOutput;
    }

    public void setExpectedOutput(String expectedOutput) {
        this.expectedOutput = expectedOutput;
    }

    public Lesson getLessonId() {
        return lessonId;
    }

    public void setLessonId(Lesson lessonId) {
        this.lessonId = lessonId;
    }

    @XmlTransient
    public Collection<RepoSubmission> getRepoSubmissionCollection() {
        return repoSubmissionCollection;
    }

    public void setRepoSubmissionCollection(Collection<RepoSubmission> repoSubmissionCollection) {
        this.repoSubmissionCollection = repoSubmissionCollection;
    }

    @XmlTransient
    public Collection<AssignmentCriteria> getAssignmentCriteriaCollection() {
        return assignmentCriteriaCollection;
    }

    public void setAssignmentCriteriaCollection(Collection<AssignmentCriteria> assignmentCriteriaCollection) {
        this.assignmentCriteriaCollection = assignmentCriteriaCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (assignmentId != null ? assignmentId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Assignment)) {
            return false;
        }
        Assignment other = (Assignment) object;
        if ((this.assignmentId == null && other.assignmentId != null) || (this.assignmentId != null && !this.assignmentId.equals(other.assignmentId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.Assignment[ assignmentId=" + assignmentId + " ]";
    }
    
}
