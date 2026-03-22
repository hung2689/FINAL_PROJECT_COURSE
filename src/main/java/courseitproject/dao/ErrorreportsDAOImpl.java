package courseitproject.dao;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Errorreports;
import jakarta.persistence.EntityManager;
import java.util.List;

public class ErrorreportsDAOImpl extends GenericDAO<Errorreports> implements IErrorreportsDAO {

    // Gọi constructor của GenericDAO và truyền class Errorreports vào
    public ErrorreportsDAOImpl() {
        super(Errorreports.class);
    }

    @Override
    public boolean insertReport(Errorreports report) {
        EntityManager em = getEntityManager(); // Hàm này thừa kế từ BaseDAO
        try {
            em.getTransaction().begin();
            
            // Gọi hàm save() có sẵn từ GenericDAO
            super.save(em, report); 
            
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); // Hoàn tác nếu có lỗi
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close(); // Luôn nhớ đóng EntityManager để giải phóng bộ nhớ
        }
    }

    @Override
    public List<Errorreports> getAllReports() {
        EntityManager em = getEntityManager();
        try {
            // Không dùng super.findAll(em) vì mình cần sắp xếp ORDER BY created_at DESC
            String jpql = "SELECT e FROM Errorreports e ORDER BY e.createdAt DESC";
            return em.createQuery(jpql, Errorreports.class).getResultList();
        } finally {
            em.close();
        }
    }

    // ĐÃ SỬA: Thêm khai báo EntityManager và đóng kết nối ở finally
    @Override
    public boolean updateStatus(int id, String newStatus) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            
            Errorreports report = em.find(Errorreports.class, id);
            if (report != null) {
                report.setStatus(newStatus); // Cập nhật trạng thái
                em.merge(report);
            }
            
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close(); // Giải phóng bộ nhớ
        }
    }
}