package courseitproject.controller.publicsite;

import com.google.gson.Gson;
import courseitproject.model.Users;
import courseitproject.service.EnrollmentServiceImp;
import courseitproject.service.IEnrollmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/courses/*")
public class EnrollmentApiServlet extends HttpServlet {

    private IEnrollmentService enrollmentService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        enrollmentService = new EnrollmentServiceImp();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response, "GET");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response, "POST");
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response, String method) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String pathInfo = request.getPathInfo(); // /{courseId}/enrollment-status or /{courseId}/enroll
        if (pathInfo == null || pathInfo.equals("/")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(gson.toJson(Map.of("error", "Missing course ID")));
            return;
        }

        String[] parts = pathInfo.split("/");
        if (parts.length < 3) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(gson.toJson(Map.of("error", "Invalid path format")));
            return;
        }

        int courseId;
        try {
            courseId = Integer.parseInt(parts[1]);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(gson.toJson(Map.of("error", "Invalid course ID")));
            return;
        }

        String action = parts[2];

        HttpSession session = request.getSession(false);
        Users user = (session != null) ? (Users) session.getAttribute("USER") : null;

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print(gson.toJson(Map.of("error", "User not logged in", "enrolled", false)));
            return;
        }

        int studentId = user.getUserId();

        if ("GET".equals(method) && "enrollment-status".equals(action)) {
            boolean isEnrolled = enrollmentService.isStudentEnrolled(studentId, courseId);
            Map<String, Object> result = new HashMap<>();
            result.put("enrolled", isEnrolled);
            out.print(gson.toJson(result));
            return;
        }

        if ("POST".equals(method) && "enroll".equals(action)) {
            boolean alreadyEnrolled = enrollmentService.isStudentEnrolled(studentId, courseId);
            if (!alreadyEnrolled) {
                try {
                    enrollmentService.enrollSingleCourse(studentId, courseId);
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    out.print(gson.toJson(Map.of("error", "Enrollment failed")));
                    return;
                }
            }
            Map<String, Object> result = new HashMap<>();
            result.put("enrolled", true);
            out.print(gson.toJson(result));
            return;
        }

        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        out.print(gson.toJson(Map.of("error", "Endpoint not found")));
    }
}
