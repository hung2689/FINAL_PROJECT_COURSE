package courseitproject.controller.recruitment;

import courseitproject.model.TeacherJob;
import courseitproject.service.ITeacherJobService;
import courseitproject.service.TeacherJobServiceImp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TeacherJobServlet", urlPatterns = {"/teacher-jobs"})
public class TeacherJobServlet extends HttpServlet {

    private final ITeacherJobService teacherJobService = new TeacherJobServiceImp();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<TeacherJob> jobs = teacherJobService.findAllOpenJobs();
        req.setAttribute("jobs", jobs);
        req.getRequestDispatcher("/views/recruitment/teacher-jobs.jsp")
                .forward(req, resp);
    }
}

