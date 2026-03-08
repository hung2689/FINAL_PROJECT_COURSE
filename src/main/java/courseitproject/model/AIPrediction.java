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
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "AI_Prediction")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AIPrediction.findAll", query = "SELECT a FROM AIPrediction a"),
    @NamedQuery(name = "AIPrediction.findByPredictionId", query = "SELECT a FROM AIPrediction a WHERE a.predictionId = :predictionId"),
    @NamedQuery(name = "AIPrediction.findByPredictedLevel", query = "SELECT a FROM AIPrediction a WHERE a.predictedLevel = :predictedLevel"),
    @NamedQuery(name = "AIPrediction.findByRiskScore", query = "SELECT a FROM AIPrediction a WHERE a.riskScore = :riskScore"),
    @NamedQuery(name = "AIPrediction.findByCreatedAt", query = "SELECT a FROM AIPrediction a WHERE a.createdAt = :createdAt")})
public class AIPrediction implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "prediction_id")
    private Integer predictionId;
    @Size(max = 255)
    @Column(name = "predicted_level")
    private String predictedLevel;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "risk_score")
    private BigDecimal riskScore;
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @JoinColumn(name = "student_id", referencedColumnName = "student_id")
    @ManyToOne(optional = false)
    private Student studentId;

    public AIPrediction() {
    }

    public AIPrediction(Integer predictionId) {
        this.predictionId = predictionId;
    }

    public Integer getPredictionId() {
        return predictionId;
    }

    public void setPredictionId(Integer predictionId) {
        this.predictionId = predictionId;
    }

    public String getPredictedLevel() {
        return predictedLevel;
    }

    public void setPredictedLevel(String predictedLevel) {
        this.predictedLevel = predictedLevel;
    }

    public BigDecimal getRiskScore() {
        return riskScore;
    }

    public void setRiskScore(BigDecimal riskScore) {
        this.riskScore = riskScore;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Student getStudentId() {
        return studentId;
    }

    public void setStudentId(Student studentId) {
        this.studentId = studentId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (predictionId != null ? predictionId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AIPrediction)) {
            return false;
        }
        AIPrediction other = (AIPrediction) object;
        if ((this.predictionId == null && other.predictionId != null) || (this.predictionId != null && !this.predictionId.equals(other.predictionId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.AIPrediction[ predictionId=" + predictionId + " ]";
    }
    
}
