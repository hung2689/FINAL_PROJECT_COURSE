 

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
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;

 

 @Entity
@Table(name = "CartItem")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CartItem.findAll", query = "SELECT c FROM CartItem c"),
    @NamedQuery(name = "CartItem.findByCartItemId", query = "SELECT c FROM CartItem c WHERE c.cartItemId = :cartItemId"),
    @NamedQuery(name = "CartItem.findByAddedAt", query = "SELECT c FROM CartItem c WHERE c.addedAt = :addedAt")})
public class CartItem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "cart_item_id")
    private Integer cartItemId;
    @Column(name = "added_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedAt;
    @JoinColumn(name = "cart_id", referencedColumnName = "cart_id")
    @ManyToOne(optional = false)
    private Cart cartId;
    @JoinColumn(name = "course_id", referencedColumnName = "course_id")
    @ManyToOne(optional = false)
     private Course courseId;
 

    public CartItem() {
    }

    public CartItem(Integer cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Integer getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(Integer cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Date getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(Date addedAt) {
        this.addedAt = addedAt;
    }

    public Cart getCartId() {
        return cartId;
    }

    public void setCartId(Cart cartId) {
        this.cartId = cartId;
    }

     public Course getCourseId() {
        return courseId;
    }

    public void setCourseId(Course courseId) {
        this.courseId = courseId;
 
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (cartItemId != null ? cartItemId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CartItem)) {
            return false;
        }
        CartItem other = (CartItem) object;
        if ((this.cartItemId == null && other.cartItemId != null) || (this.cartItemId != null && !this.cartItemId.equals(other.cartItemId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.CartItem[ cartItemId=" + cartItemId + " ]";
    }
 
}
