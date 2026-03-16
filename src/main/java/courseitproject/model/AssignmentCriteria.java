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
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "AssignmentCriteria")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AssignmentCriteria.findAll", query = "SELECT a FROM AssignmentCriteria a"),
    @NamedQuery(name = "AssignmentCriteria.findByCriteriaId", query = "SELECT a FROM AssignmentCriteria a WHERE a.criteriaId = :criteriaId"),
    @NamedQuery(name = "AssignmentCriteria.findByName", query = "SELECT a FROM AssignmentCriteria a WHERE a.name = :name"),
    @NamedQuery(name = "AssignmentCriteria.findByMaxScore", query = "SELECT a FROM AssignmentCriteria a WHERE a.maxScore = :maxScore")})
public class AssignmentCriteria implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "criteria_id")
    private Integer criteriaId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Column(name = "max_score")
    private int maxScore;
    @JoinColumn(name = "assignment_id", referencedColumnName = "assignment_id")
    @ManyToOne(optional = false)
    private Assignment assignmentId;

    public AssignmentCriteria() {
    }

    public AssignmentCriteria(Integer criteriaId) {
        this.criteriaId = criteriaId;
    }

    public AssignmentCriteria(Integer criteriaId, String name, int maxScore) {
        this.criteriaId = criteriaId;
        this.name = name;
        this.maxScore = maxScore;
    }

    public Integer getCriteriaId() {
        return criteriaId;
    }

    public void setCriteriaId(Integer criteriaId) {
        this.criteriaId = criteriaId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getMaxScore() {
        return maxScore;
    }

    public void setMaxScore(int maxScore) {
        this.maxScore = maxScore;
    }

    public Assignment getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(Assignment assignmentId) {
        this.assignmentId = assignmentId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (criteriaId != null ? criteriaId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AssignmentCriteria)) {
            return false;
        }
        AssignmentCriteria other = (AssignmentCriteria) object;
        if ((this.criteriaId == null && other.criteriaId != null) || (this.criteriaId != null && !this.criteriaId.equals(other.criteriaId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.AssignmentCriteria[ criteriaId=" + criteriaId + " ]";
    }
    
}
