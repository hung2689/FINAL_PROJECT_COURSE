/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.admin;

import courseitproject.model.Candidates;
import courseitproject.model.Users;
import courseitproject.repository.CandidateRepository;
import courseitproject.service.ITeacherJobService;
import courseitproject.service.TeacherJobServiceImp;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "N8nApiServlet", urlPatterns = {"/api/candidates"})
public class N8nApiServlet extends HttpServlet {

    private ITeacherJobService jobService;
    private CandidateRepository repo;

    @Override
    public void init(){
       repo  = new CandidateRepository();
       jobService= new TeacherJobServiceImp();
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {

        

        Candidates c = new Candidates();

        c.setUserId(new Users(Integer.parseInt(req.getParameter("user_id"))));
        c.setName(req.getParameter("name"));
        c.setCvText(req.getParameter("cv_url"));
        c.setEmail(req.getParameter("email"));
        c.setScore(Integer.parseInt(req.getParameter("score")));
        c.setDecision(req.getParameter("decision"));
        c.setSkillsCount(Integer.parseInt(req.getParameter("skills_count")));
        c.setProjectsCount(Integer.parseInt(req.getParameter("projects_count")));
        
        // Find job by ID
        int jobId = Integer.parseInt(req.getParameter("job_id"));
        courseitproject.model.TeacherJob job = jobService.findById(jobId);
        if (job == null) {
            System.err.println("API Error: TeacherJob with ID " + jobId + " does not exist in the Database!");
        }
        c.setJobId(job);
        
        c.setCreatedAt(new Date());
        repo.save(c);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }
}
