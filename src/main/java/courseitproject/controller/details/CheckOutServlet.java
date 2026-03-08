
package courseitproject.controller.details;

import courseitproject.model.Course;
import courseitproject.model.CourseOrder;
import courseitproject.model.CourseOrderItem;
import courseitproject.model.Student;
import courseitproject.model.Users;
import courseitproject.service.CourseOrderService;
import courseitproject.utils.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Map;

@WebServlet("/checkout")
public class CheckOutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        @SuppressWarnings("unchecked")
        Map<Integer, Course> cart = (Map<Integer, Course>) session.getAttribute("cart");
        
        Users user = (Users) session.getAttribute("USER");
        if (user == null) {
            user = (Users) session.getAttribute("user");
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // 1. Tính tổng tiền USD rồi đổi sang VND
        double totalUSD = 0;
        for (Course c : cart.values()) {
            totalUSD += c.getPrice().doubleValue(); 
        }
        long totalVND = (long) (totalUSD * 25000);

        // ==========================================
        // TẠO ĐƠN HÀNG VÀ LƯU VÀO DATABASE
        // ==========================================
        CourseOrderService orderService = new CourseOrderService();
        CourseOrder newOrder = new CourseOrder();

        newOrder.setTotalAmount(new BigDecimal(totalUSD));
        newOrder.setStatus("PENDING");
        newOrder.setCreatedAt(new Date());

        // Gắn Student vào đơn hàng
        Student currentStudent = new Student();
        currentStudent.setStudentId(user.getUserId()); 
        newOrder.setStudentId(currentStudent); 

        // Lưu đơn hàng tổng và lấy ID
        int generatedOrderId = orderService.save(newOrder); 
        
        // ==========================================================
        // BƯỚC MỚI QUAN TRỌNG: LƯU CHI TIẾT GIỎ HÀNG (CourseOrderItem)
        // ==========================================================
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            // Lấy lại đơn hàng vừa lưu để làm khóa ngoại
            CourseOrder savedOrder = em.getReference(CourseOrder.class, generatedOrderId);
            
            // Duyệt giỏ hàng và lưu từng khóa học vào bảng CourseOrderItem
            for (Course c : cart.values()) {
                CourseOrderItem item = new CourseOrderItem();
                item.setOrder(savedOrder);   // Gắn đơn hàng cha
                item.setCourse(c);           // Gắn ID khóa học
                item.setPrice(c.getPrice()); // Lưu lại giá tiền
                
                em.persist(item); // Lưu xuống Database
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
        // ==========================================================

        // 2. LẤY TÊN ĐĂNG NHẬP LÀM NỘI DUNG CHUYỂN KHOẢN
        String username = "KHACH";
        if (user != null && user.getUsername() != null) {
            username = user.getUsername().toUpperCase().replaceAll("\\s+", "");
        }
        
        String transferContent = username + "CK" + (System.currentTimeMillis() % 10000);
        
        // 3. Gửi dữ liệu sang giao diện
        request.setAttribute("finalTotal", totalVND);
        request.setAttribute("transferContent", transferContent);
        request.setAttribute("orderId", generatedOrderId); 
        
        request.getRequestDispatcher("/views/details/checkout.jsp").forward(request, response);
    }
}