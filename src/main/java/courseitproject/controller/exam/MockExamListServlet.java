package courseitproject.controller.exam;

import courseitproject.model.MockExam;
import courseitproject.service.IMockExamService;
import courseitproject.service.MockExamServiceImp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "MockExamListServlet", urlPatterns = {"/mock-exams"})
public class MockExamListServlet extends HttpServlet {

    private final IMockExamService mockService = new MockExamServiceImp();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Ensure user is logged in
        if (request.getSession().getAttribute("USER") == null) {
            request.getSession().setAttribute("msg", "Vui lòng đăng nhập để vào phòng thi ảo!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<MockExam> exams = mockService.getAllExams();
        request.setAttribute("examList", exams);
        
        request.getRequestDispatcher("/views/exam/mock-exams.jsp").forward(request, response);
    }
}
