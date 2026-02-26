/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.model;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "Teacher")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Teacher.findAll", query = "SELECT t FROM Teacher t"),
    @NamedQuery(name = "Teacher.findByTeacherId", query = "SELECT t FROM Teacher t WHERE t.teacherId = :teacherId"),
    @NamedQuery(name = "Teacher.findBySpecialization", query = "SELECT t FROM Teacher t WHERE t.specialization = :specialization"),
    @NamedQuery(name = "Teacher.findByExperienceYear", query = "SELECT t FROM Teacher t WHERE t.experienceYear = :experienceYear"),
    @NamedQuery(name = "Teacher.findByApprovalStatus", query = "SELECT t FROM Teacher t WHERE t.approvalStatus = :approvalStatus"),
    @NamedQuery(name = "Teacher.findByCvUrl", query = "SELECT t FROM Teacher t WHERE t.cvUrl = :cvUrl")})
public class Teacher implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "teacher_id")
    private Integer teacherId;
    @Size(max = 255)
    @Column(name = "specialization")
    private String specialization;
    @Column(name = "experience_year")
    private Integer experienceYear;
    @Size(max = 255)
    @Column(name = "approval_status")
    private String approvalStatus;
    @Size(max = 255)
    @Column(name = "cv_url")
    private String cvUrl;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "teacherId")
    private Collection<CourseTeacher> courseTeacherCollection;
    @MapsId
    @JoinColumn(name = "teacher_id")
    @OneToOne(optional = false)
    private Users users;

    public Teacher() {
    }

    public Teacher(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public Integer getExperienceYear() {
        return experienceYear;
    }

    public void setExperienceYear(Integer experienceYear) {
        this.experienceYear = experienceYear;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getCvUrl() {
        return cvUrl;
    }

    public void setCvUrl(String cvUrl) {
        this.cvUrl = cvUrl;
    }

    @XmlTransient
    public Collection<CourseTeacher> getCourseTeacherCollection() {
        return courseTeacherCollection;
    }

    public void setCourseTeacherCollection(Collection<CourseTeacher> courseTeacherCollection) {
        this.courseTeacherCollection = courseTeacherCollection;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (teacherId != null ? teacherId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Teacher)) {
            return false;
        }
        Teacher other = (Teacher) object;
        if ((this.teacherId == null && other.teacherId != null) || (this.teacherId != null && !this.teacherId.equals(other.teacherId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.Teacher[ teacherId=" + teacherId + " ]";
    }

}
