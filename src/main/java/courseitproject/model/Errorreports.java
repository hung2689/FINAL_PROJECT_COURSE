
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
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;


@Entity
@Table(name = "Error_reports")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Errorreports.findAll", query = "SELECT e FROM Errorreports e"),
    @NamedQuery(name = "Errorreports.findById", query = "SELECT e FROM Errorreports e WHERE e.id = :id"),
    @NamedQuery(name = "Errorreports.findByStudentName", query = "SELECT e FROM Errorreports e WHERE e.studentName = :studentName"),
    @NamedQuery(name = "Errorreports.findByDescription", query = "SELECT e FROM Errorreports e WHERE e.description = :description"),
    @NamedQuery(name = "Errorreports.findByImagePath", query = "SELECT e FROM Errorreports e WHERE e.imagePath = :imagePath"),
    @NamedQuery(name = "Errorreports.findByStatus", query = "SELECT e FROM Errorreports e WHERE e.status = :status"),
    @NamedQuery(name = "Errorreports.findByCreatedAt", query = "SELECT e FROM Errorreports e WHERE e.createdAt = :createdAt")})
public class Errorreports implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Size(max = 100)
    @Column(name = "student_name")
    private String studentName;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "description")
    private String description;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "image_path")
    private String imagePath;
    @Size(max = 50)
    @Column(name = "status")
    private String status;
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public Errorreports() {
    }

    public Errorreports(Integer id) {
        this.id = id;
    }

    public Errorreports(Integer id, String description, String imagePath) {
        this.id = id;
        this.description = description;
        this.imagePath = imagePath;
    }
     public Errorreports(String studentName, String description, String imagePath) {
        this.studentName = studentName;
        this.description = description;
        this.imagePath = imagePath;
        this.status = "PENDING"; // Gán mặc định trạng thái là PENDING
        this.createdAt = new Date(); // Tự động lấy thời gian hiện tại lúc tạo
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
        if (!(object instanceof Errorreports)) {
            return false;
        }
        Errorreports other = (Errorreports) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.Errorreports[ id=" + id + " ]";
    }

}
