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
import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "TeacherJob")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TeacherJob.findAll", query = "SELECT t FROM TeacherJob t"),
    @NamedQuery(name = "TeacherJob.findByJobId", query = "SELECT t FROM TeacherJob t WHERE t.jobId = :jobId"),
    @NamedQuery(name = "TeacherJob.findByTitle", query = "SELECT t FROM TeacherJob t WHERE t.title = :title"),
    @NamedQuery(name = "TeacherJob.findByDescription", query = "SELECT t FROM TeacherJob t WHERE t.description = :description"),
    @NamedQuery(name = "TeacherJob.findByLocation", query = "SELECT t FROM TeacherJob t WHERE t.location = :location"),
    @NamedQuery(name = "TeacherJob.findByJobType", query = "SELECT t FROM TeacherJob t WHERE t.jobType = :jobType"),
    @NamedQuery(name = "TeacherJob.findBySalaryMin", query = "SELECT t FROM TeacherJob t WHERE t.salaryMin = :salaryMin"),
    @NamedQuery(name = "TeacherJob.findBySalaryMax", query = "SELECT t FROM TeacherJob t WHERE t.salaryMax = :salaryMax"),
    @NamedQuery(name = "TeacherJob.findBySalaryUnit", query = "SELECT t FROM TeacherJob t WHERE t.salaryUnit = :salaryUnit"),
    @NamedQuery(name = "TeacherJob.findByStatus", query = "SELECT t FROM TeacherJob t WHERE t.status = :status"),
    @NamedQuery(name = "TeacherJob.findByCreatedAt", query = "SELECT t FROM TeacherJob t WHERE t.createdAt = :createdAt"),
    @NamedQuery(name = "TeacherJob.findByUpdatedAt", query = "SELECT t FROM TeacherJob t WHERE t.updatedAt = :updatedAt"),
    @NamedQuery(name = "TeacherJob.findByRequirements", query = "SELECT t FROM TeacherJob t WHERE t.requirements = :requirements"),
    @NamedQuery(name = "TeacherJob.findByBenefits", query = "SELECT t FROM TeacherJob t WHERE t.benefits = :benefits"),
    @NamedQuery(name = "TeacherJob.findByJobCategory", query = "SELECT t FROM TeacherJob t WHERE t.jobCategory = :jobCategory")})
public class TeacherJob implements Serializable {

    @Size(max = 255)
    @Column(name = "title")
    private String title;
    @Size(max = 2147483647)
    @Column(name = "description")
    private String description;
    @Size(max = 255)
    @Column(name = "location")
    private String location;
    @Size(max = 255)
    @Column(name = "job_type")
    private String jobType;
    @Size(max = 255)
    @Column(name = "salary_unit")
    private String salaryUnit;
    @Size(max = 255)
    @Column(name = "status")
    private String status;
    @Size(max = 255)
    @Column(name = "requirements")
    private String requirements;
    @Size(max = 255)
    @Column(name = "benefits")
    private String benefits;
    @Size(max = 255)
    @Column(name = "job_category")
    private String jobCategory;
    @OneToMany(mappedBy = "jobId")
    private Collection<Candidates> candidatesCollection;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "job_id")
    private Integer jobId;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "salary_min")
    private BigDecimal salaryMin;
    @Column(name = "salary_max")
    private BigDecimal salaryMax;
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @Column(name = "updated_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;

    public TeacherJob() {
    }

    public TeacherJob(Integer jobId) {
        this.jobId = jobId;
    }

    public Integer getJobId() {
        return jobId;
    }

    public void setJobId(Integer jobId) {
        this.jobId = jobId;
    }


    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public BigDecimal getSalaryMin() {
        return salaryMin;
    }

    public void setSalaryMin(BigDecimal salaryMin) {
        this.salaryMin = salaryMin;
    }

    public BigDecimal getSalaryMax() {
        return salaryMax;
    }

    public void setSalaryMax(BigDecimal salaryMax) {
        this.salaryMax = salaryMax;
    }

    public String getSalaryUnit() {
        return salaryUnit;
    }

    public void setSalaryUnit(String salaryUnit) {
        this.salaryUnit = salaryUnit;
    }


    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }


    public String getJobCategory() {
        return jobCategory;
    }

    public void setJobCategory(String jobCategory) {
        this.jobCategory = jobCategory;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (jobId != null ? jobId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TeacherJob)) {
            return false;
        }
        TeacherJob other = (TeacherJob) object;
        if ((this.jobId == null && other.jobId != null) || (this.jobId != null && !this.jobId.equals(other.jobId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.TeacherJob[ jobId=" + jobId + " ]";
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

   

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRequirements() {
        return requirements;
    }

    public void setRequirements(String requirements) {
        this.requirements = requirements;
    }

    public String getBenefits() {
        return benefits;
    }

    public void setBenefits(String benefits) {
        this.benefits = benefits;
    }

  

    @XmlTransient
    public Collection<Candidates> getCandidatesCollection() {
        return candidatesCollection;
    }

    public void setCandidatesCollection(Collection<Candidates> candidatesCollection) {
        this.candidatesCollection = candidatesCollection;
    }
    
}
