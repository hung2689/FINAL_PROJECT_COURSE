/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.model;



import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Table;
import java.util.List;
@Entity
@Table(name = "RoadmapNode")
public class RoadmapNode {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "node_id")
    private int id;
    private String title;
    private String subtitle;
    private String icon;
    private String description;
    private int progress;
    private String status;
    // Annotation này giúp lấy danh sách gạch đầu dòng từ bảng NodeDetail
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "NodeDetail", joinColumns = @JoinColumn(name = "node_id"))
    @Column(name = "content")
    private List<String> details; // Chứa các gạch đầu dòng

    // Constructors
    public RoadmapNode() {}

    public RoadmapNode(int id, String title, String subtitle, String icon, String description, int progress, String status, List<String> details) {
        this.id = id;
        this.title = title;
        this.subtitle = subtitle;
        this.icon = icon;
        this.description = description;
        this.progress = progress;
        this.status = status;
        this.details = details;
    }

    // Getters và Setters... (Bạn tự generate trong IDE nhé)
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getSubtitle() { return subtitle; }
    public String getIcon() { return icon; }
    public String getDescription() { return description; }
    public int getProgress() { return progress; }
    public String getStatus() { return status; }
    public List<String> getDetails() { return details; }
}
