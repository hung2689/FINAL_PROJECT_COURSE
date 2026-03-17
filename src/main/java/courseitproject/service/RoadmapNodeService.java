/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.service;



import courseitproject.dao.base.GenericDAO;
import courseitproject.dao.base.GenericDAO;
import courseitproject.model.RoadmapNode;
import jakarta.persistence.EntityManager;
import java.util.List;

public class RoadmapNodeService extends GenericDAO<RoadmapNode> {

    public RoadmapNodeService() {
        super(RoadmapNode.class);
    }

    // Lấy danh sách Roadmap, xếp theo thứ tự node_id tăng dần
    public List<RoadmapNode> findAllOrdered(EntityManager em) {
        return em.createQuery("SELECT r FROM RoadmapNode r ORDER BY r.id ASC", RoadmapNode.class)
                 .getResultList();
    }
}
