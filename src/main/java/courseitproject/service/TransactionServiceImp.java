package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.CoursePayment;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class TransactionServiceImp implements ITransactionService {

    private final GenericDAO<CoursePayment> paymentDAO = new GenericDAO<>(CoursePayment.class);

    @Override
    public double getTotalRevenue() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            java.math.BigDecimal revenue = em.createQuery(
                    "SELECT SUM(p.amount) FROM CoursePayment p WHERE p.status = 'SUCCESS'", java.math.BigDecimal.class)
                    .getSingleResult();
            return revenue != null ? revenue.doubleValue() : 0.0;
        } finally {
            em.close();
        }
    }

    @Override
    public long getTotalTransactions() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(p) FROM CoursePayment p", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long getSuccessfulPayments() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(p) FROM CoursePayment p WHERE p.status = 'SUCCESS'", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long getFailedPayments() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(p) FROM CoursePayment p WHERE p.status = 'FAILED'", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Object[]> getWeeklyRevenue() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            LocalDate startDate = LocalDate.now().minusDays(6);
            List<Object[]> queryResults = em.createQuery(
                    "SELECT CAST(p.createdAt AS date), SUM(p.amount) FROM CoursePayment p "
                            + "WHERE p.status = 'SUCCESS' AND p.createdAt >= :startDate "
                            + "GROUP BY CAST(p.createdAt AS date)",
                    Object[].class)
                    .setParameter("startDate", java.sql.Date.valueOf(startDate))
                    .getResultList();

            Map<LocalDate, Double> revenueMap = new HashMap<>();
            for (Object[] row : queryResults) {
                LocalDate dateKey;
                if (row[0] instanceof java.sql.Date) {
                    dateKey = ((java.sql.Date) row[0]).toLocalDate();
                } else if (row[0] instanceof LocalDate) {
                    dateKey = (LocalDate) row[0];
                } else if (row[0] instanceof java.util.Date) {
                    dateKey = new java.sql.Date(((java.util.Date) row[0]).getTime()).toLocalDate();
                } else {
                    dateKey = LocalDate.parse(row[0].toString());
                }

                Number amount = (Number) row[1];
                revenueMap.put(dateKey, amount != null ? amount.doubleValue() : 0.0);
            }

            List<Object[]> fullResults = new ArrayList<>();
            for (int i = 6; i >= 0; i--) {
                LocalDate date = LocalDate.now().minusDays(i);
                double dailyRevenue = revenueMap.getOrDefault(date, 0.0);

                // gửi ngày thật thay vì weekday
                fullResults.add(new Object[] { date.toString(), dailyRevenue });
            }
            return fullResults;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Object[]> getMonthlyRevenue() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            LocalDate startDate = LocalDate.now().minusDays(29);
            List<Object[]> queryResults = em.createQuery(
                    "SELECT CAST(p.createdAt AS date), SUM(p.amount) FROM CoursePayment p "
                            + "WHERE p.status = 'SUCCESS' AND p.createdAt >= :startDate "
                            + "GROUP BY CAST(p.createdAt AS date)",
                    Object[].class)
                    .setParameter("startDate", java.sql.Date.valueOf(startDate))
                    .getResultList();

            Map<LocalDate, Double> revenueMap = new HashMap<>();
            for (Object[] row : queryResults) {
                LocalDate dateKey;
                if (row[0] instanceof java.sql.Date) {
                    dateKey = ((java.sql.Date) row[0]).toLocalDate();
                } else if (row[0] instanceof LocalDate) {
                    dateKey = (LocalDate) row[0];
                } else if (row[0] instanceof java.util.Date) {
                    dateKey = new java.sql.Date(((java.util.Date) row[0]).getTime()).toLocalDate();
                } else {
                    dateKey = LocalDate.parse(row[0].toString());
                }

                Number amount = (Number) row[1];
                revenueMap.put(dateKey, amount != null ? amount.doubleValue() : 0.0);
            }

            List<Object[]> fullResults = new ArrayList<>();
            for (int i = 29; i >= 0; i--) {
                LocalDate date = LocalDate.now().minusDays(i);
                double dailyRevenue = revenueMap.getOrDefault(date, 0.0);
                fullResults.add(new Object[] { String.valueOf(date.getDayOfMonth()), dailyRevenue });
            }
            return fullResults;
        } finally {
            em.close();
        }
    }

    @Override
    public List<CoursePayment> getRecentTransactions(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT p FROM CoursePayment p ORDER BY p.createdAt DESC", CoursePayment.class)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public CoursePayment getTransactionDetail(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<CoursePayment> results = em.createQuery(
                    "SELECT p FROM CoursePayment p "
                            + "JOIN FETCH p.studentId s "
                            + "JOIN FETCH s.users u "
                            + "WHERE p.paymentId = :id",
                    CoursePayment.class)
                    .setParameter("id", id)
                    .getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
}
