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
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "SubscriptionPlan")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SubscriptionPlan.findAll", query = "SELECT s FROM SubscriptionPlan s"),
    @NamedQuery(name = "SubscriptionPlan.findByPlanId", query = "SELECT s FROM SubscriptionPlan s WHERE s.planId = :planId"),
    @NamedQuery(name = "SubscriptionPlan.findByName", query = "SELECT s FROM SubscriptionPlan s WHERE s.name = :name"),
    @NamedQuery(name = "SubscriptionPlan.findByPrice", query = "SELECT s FROM SubscriptionPlan s WHERE s.price = :price"),
    @NamedQuery(name = "SubscriptionPlan.findByDuration", query = "SELECT s FROM SubscriptionPlan s WHERE s.duration = :duration")})
public class SubscriptionPlan implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "plan_id")
    private Integer planId;
    @Size(max = 255)
    @Column(name = "name")
    private String name;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "price")
    private BigDecimal price;
    @Column(name = "duration")
    private Integer duration;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "planId")
    private Collection<Subscription> subscriptionCollection;

    public SubscriptionPlan() {
    }

    public SubscriptionPlan(Integer planId) {
        this.planId = planId;
    }

    public Integer getPlanId() {
        return planId;
    }

    public void setPlanId(Integer planId) {
        this.planId = planId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    @XmlTransient
    public Collection<Subscription> getSubscriptionCollection() {
        return subscriptionCollection;
    }

    public void setSubscriptionCollection(Collection<Subscription> subscriptionCollection) {
        this.subscriptionCollection = subscriptionCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (planId != null ? planId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SubscriptionPlan)) {
            return false;
        }
        SubscriptionPlan other = (SubscriptionPlan) object;
        if ((this.planId == null && other.planId != null) || (this.planId != null && !this.planId.equals(other.planId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.SubscriptionPlan[ planId=" + planId + " ]";
    }
    
}
