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

        
        double totalUSD = 0;
        for (Course c : cart.values()) {
            totalUSD += c.getPrice().doubleValue();
        }
        long totalVND = (long) (totalUSD * 25000);

       
        request.setAttribute("finalTotal", totalVND);

    
        CourseOrderService orderService = new CourseOrderService();
        CourseOrder newOrder = new CourseOrder();

        newOrder.setTotalAmount(new BigDecimal(totalUSD));
        newOrder.setStatus("PENDING");
        newOrder.setCreatedAt(new Date());

        if (user != null) {
            Student currentStudent = new Student();
            currentStudent.setStudentId(user.getUserId());
            newOrder.setStudentId(currentStudent);
        }

     
        int generatedOrderId = orderService.save(newOrder);

        
        request.setAttribute("orderId", generatedOrderId);

      
        if (generatedOrderId != -1) {
            EntityManager em = JPAUtil.getEntityManager();
            try {
                em.getTransaction().begin();
                CourseOrder savedOrder = em.getReference(CourseOrder.class, generatedOrderId);

                for (Course c : cart.values()) {
                    CourseOrderItem item = new CourseOrderItem();
                    item.setOrderId(savedOrder);
                    Course managedCourse = em.getReference(Course.class, c.getCourseId());
                    item.setCourseId(managedCourse);
                    item.setPrice(c.getPrice());
                    em.persist(item);
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
        } else {
          
            request.setAttribute("errorMessage", "Error generating order ID. It returned -1");
        }

        // 3. Username and Transfer Content
        String username = "KHACH";
        if (user != null && user.getUsername() != null) {
            username = user.getUsername().toUpperCase().replaceAll("\\s+", "");
        }

        String transferContent = username + "CK" + (System.currentTimeMillis() % 10000);
        request.setAttribute("transferContent", transferContent);

        // Forward to checkout JSP
        request.getRequestDispatcher("/views/details/checkout.jsp").forward(request, response);
    }
}