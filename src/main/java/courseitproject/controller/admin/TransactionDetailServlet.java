package courseitproject.controller.admin;

import courseitproject.model.CourseOrder;
import courseitproject.model.CourseOrderItem;
import courseitproject.model.CoursePayment;
import courseitproject.service.ITransactionService;
import courseitproject.service.TransactionServiceImp;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "TransactionDetailServlet", urlPatterns = { "/admin/transaction-detail" })
public class TransactionDetailServlet extends HttpServlet {

    private final ITransactionService transactionService = new TransactionServiceImp();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/transactionAdmin");
            return;
        }

        int paymentId;
        try {
            paymentId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/transactionAdmin");
            return;
        }

        // 1. Get the payment with student info
        CoursePayment payment = transactionService.getTransactionDetail(paymentId);
        if (payment == null) {
            response.sendRedirect(request.getContextPath() + "/transactionAdmin");
            return;
        }
        request.setAttribute("payment", payment);

        // 2. Try to find the related CourseOrder by vnpTxnRef to get course info
        if (payment.getVnpTxnRef() != null && !payment.getVnpTxnRef().isEmpty()) {
            EntityManager em = JPAUtil.getEntityManager();
            try {
                List<CourseOrder> orders = em.createQuery(
                        "SELECT o FROM CourseOrder o "
                                + "LEFT JOIN FETCH o.courseOrderItemCollection oi "
                                + "LEFT JOIN FETCH oi.courseId c "
                                + "WHERE o.vnpTxnRef = :txnRef",
                        CourseOrder.class)
                        .setParameter("txnRef", payment.getVnpTxnRef())
                        .getResultList();
                if (!orders.isEmpty()) {
                    CourseOrder order = orders.get(0);
                    request.setAttribute("order", order);

                    // Extract first course name for display
                    if (order.getCourseOrderItemCollection() != null
                            && !order.getCourseOrderItemCollection().isEmpty()) {
                        CourseOrderItem firstItem = order.getCourseOrderItemCollection().iterator().next();
                        request.setAttribute("courseName", firstItem.getCourseId().getTitle());
                        request.setAttribute("coursePrice", firstItem.getPrice());
                    }
                }
            } finally {
                em.close();
            }
        }

        request.getRequestDispatcher("/views/admin/transaction/transaction-detail.jsp")
                .forward(request, response);
    }
}
