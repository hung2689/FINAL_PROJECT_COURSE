/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.admin;

import courseitproject.service.ITransactionService;
import courseitproject.service.TransactionServiceImp;
import courseitproject.model.CoursePayment;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "TransactionAdminSevlet", urlPatterns = { "/transactionAdmin" })
public class TransactionAdminSevlet extends HttpServlet {

    private final ITransactionService transactionService = new TransactionServiceImp();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Fetch Statistics
        double totalRevenue = transactionService.getTotalRevenue();
        long totalTransactions = transactionService.getTotalTransactions();
        long successPayments = transactionService.getSuccessfulPayments();
        long failedPayments = transactionService.getFailedPayments();

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalTransactions", totalTransactions);
        request.setAttribute("successPayments", successPayments);
        request.setAttribute("failedPayments", failedPayments);

        // 2. Fetch Recent Transactions
        List<CoursePayment> recentTransactions = transactionService.getRecentTransactions(10);
        request.setAttribute("recentTransactions", recentTransactions);

        // 3. Fetch Chart Data
        List<Object[]> weeklyDataList = transactionService.getWeeklyRevenue();
        List<Object[]> monthlyDataList = transactionService.getMonthlyRevenue();

        // Convert Chart Data to JSON Strings
        String weeklyCategories = getCategoriesJson(weeklyDataList);
        String weeklySeries = getSeriesJson(weeklyDataList);

        String monthlyCategories = getCategoriesJson(monthlyDataList);
        String monthlySeries = getSeriesJson(monthlyDataList);

        request.setAttribute("weeklyCategories", weeklyCategories);
        request.setAttribute("weeklySeries", weeklySeries);
        request.setAttribute("monthlyCategories", monthlyCategories);
        request.setAttribute("monthlySeries", monthlySeries);

        request.getRequestDispatcher("views/admin/transaction/transactionManagement.jsp").forward(request, response);
    }

    private String getCategoriesJson(List<Object[]> data) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < data.size(); i++) {
            sb.append("\"").append(String.valueOf(data.get(i)[0])).append("\"");
            if (i < data.size() - 1)
                sb.append(", ");
        }
        sb.append("]");
        return sb.toString();
    }

    private String getSeriesJson(List<Object[]> data) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < data.size(); i++) {
            Object amount = data.get(i)[1];
            sb.append(amount != null ? amount.toString() : "0");
            if (i < data.size() - 1)
                sb.append(", ");
        }
        sb.append("]");
        return sb.toString();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
