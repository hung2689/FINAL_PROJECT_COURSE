/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.admin;

import courseitproject.model.Candidates;
import courseitproject.repository.CandidateRepository;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "N8nApiServlet", urlPatterns = {"/api/candidates"})
public class N8nApiServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {

        CandidateRepository repo = new CandidateRepository();

        Candidates c = new Candidates();

        c.setName(req.getParameter("name"));
        c.setEmail(req.getParameter("email"));
        c.setScore(Integer.parseInt(req.getParameter("score")));
        c.setDecision(req.getParameter("decision"));
        c.setSkillsCount(Integer.parseInt(req.getParameter("skills_count")));
        c.setProjectsCount(Integer.parseInt(req.getParameter("projects_count")));
        c.setCreatedAt(new Date());
        repo.save(c);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

       req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }
}
