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
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "candidates")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Candidates.findAll", query = "SELECT c FROM Candidates c"),
    @NamedQuery(name = "Candidates.findById", query = "SELECT c FROM Candidates c WHERE c.id = :id"),
    @NamedQuery(name = "Candidates.findByName", query = "SELECT c FROM Candidates c WHERE c.name = :name"),
    @NamedQuery(name = "Candidates.findByEmail", query = "SELECT c FROM Candidates c WHERE c.email = :email"),
    @NamedQuery(name = "Candidates.findByScore", query = "SELECT c FROM Candidates c WHERE c.score = :score"),
    @NamedQuery(name = "Candidates.findByDecision", query = "SELECT c FROM Candidates c WHERE c.decision = :decision"),
    @NamedQuery(name = "Candidates.findBySkillsCount", query = "SELECT c FROM Candidates c WHERE c.skillsCount = :skillsCount"),
    @NamedQuery(name = "Candidates.findByProjectsCount", query = "SELECT c FROM Candidates c WHERE c.projectsCount = :projectsCount"),
    @NamedQuery(name = "Candidates.findByCvText", query = "SELECT c FROM Candidates c WHERE c.cvText = :cvText"),
    @NamedQuery(name = "Candidates.findByCreatedAt", query = "SELECT c FROM Candidates c WHERE c.createdAt = :createdAt")})
public class Candidates implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Size(max = 100)
    @Column(name = "name")
    private String name;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 100)
    @Column(name = "email")
    private String email;
    @Column(name = "score")
    private Integer score;
    @Size(max = 10)
    @Column(name = "decision")
    private String decision;
    @Column(name = "skills_count")
    private Integer skillsCount;
    @Column(name = "projects_count")
    private Integer projectsCount;
    @Size(max = 2147483647)
    @Column(name = "cv_text")
    private String cvText;
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public Candidates() {
    }

    public Candidates(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
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

    public Integer getProjectsCount() {
        return projectsCount;
    }

    public void setProjectsCount(Integer projectsCount) {
        this.projectsCount = projectsCount;
    }

    public String getCvText() {
        return cvText;
    }

    public void setCvText(String cvText) {
        this.cvText = cvText;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Candidates)) {
            return false;
        }
        Candidates other = (Candidates) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.Candidates[ id=" + id + " ]";
    }
    
}
