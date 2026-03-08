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
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "LessonResource")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LessonResource.findAll", query = "SELECT l FROM LessonResource l"),
    @NamedQuery(name = "LessonResource.findByResourceId", query = "SELECT l FROM LessonResource l WHERE l.resourceId = :resourceId"),
    @NamedQuery(name = "LessonResource.findByResourceType", query = "SELECT l FROM LessonResource l WHERE l.resourceType = :resourceType"),
    @NamedQuery(name = "LessonResource.findByUrl", query = "SELECT l FROM LessonResource l WHERE l.url = :url"),
    @NamedQuery(name = "LessonResource.findByDuration", query = "SELECT l FROM LessonResource l WHERE l.duration = :duration"),
    @NamedQuery(name = "LessonResource.findByFileSize", query = "SELECT l FROM LessonResource l WHERE l.fileSize = :fileSize"),
    @NamedQuery(name = "LessonResource.findByCreatedAt", query = "SELECT l FROM LessonResource l WHERE l.createdAt = :createdAt"),
    @NamedQuery(name = "LessonResource.findByTitle", query = "SELECT l FROM LessonResource l WHERE l.title = :title")})
public class LessonResource implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "resource_id")
    private Integer resourceId;
    @Size(max = 255)
    @Column(name = "resource_type")
    private String resourceType;
    @Size(max = 255)
    @Column(name = "url")
    private String url;
    @Column(name = "duration")
    private Integer duration;
    @Column(name = "file_size")
    private Integer fileSize;
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @Size(max = 255)
    @Column(name = "title")
    private String title;
    @JoinColumn(name = "lesson_id", referencedColumnName = "lesson_id")
    @ManyToOne(optional = false)
    private Lesson lessonId;

    public LessonResource() {
    }

    public LessonResource(Integer resourceId) {
        this.resourceId = resourceId;
    }

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }

    public String getResourceType() {
        return resourceType;
    }

    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Integer getFileSize() {
        return fileSize;
    }

    public void setFileSize(Integer fileSize) {
        this.fileSize = fileSize;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Lesson getLessonId() {
        return lessonId;
    }

    public void setLessonId(Lesson lessonId) {
        this.lessonId = lessonId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (resourceId != null ? resourceId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LessonResource)) {
            return false;
        }
        LessonResource other = (LessonResource) object;
        if ((this.resourceId == null && other.resourceId != null) || (this.resourceId != null && !this.resourceId.equals(other.resourceId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "courseitproject.model.LessonResource[ resourceId=" + resourceId + " ]";
    }
    
}
