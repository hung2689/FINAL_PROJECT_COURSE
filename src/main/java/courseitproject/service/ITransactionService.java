package courseitproject.service;

import courseitproject.model.CoursePayment;

import java.util.List;

public interface ITransactionService {

    double getTotalRevenue();

    long getTotalTransactions();

    long getSuccessfulPayments();

    long getFailedPayments();

    List<Object[]> getWeeklyRevenue();

    List<Object[]> getMonthlyRevenue();

    List<CoursePayment> getRecentTransactions(int limit);

    CoursePayment getTransactionDetail(int id);

}
