/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package courseitproject.controller.publicsite;

import courseitproject.model.Course;
import courseitproject.service.CourseServiceImp;
import courseitproject.service.ICourseService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private ICourseService courseService;

    @Override
    public void init() {
        courseService = new CourseServiceImp();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Course> freeCourse = courseService.findTopByCategoryId(4);
        List<Course> softWareCourse = courseService.findTopByCategoryId(1);
        List<Course> foreignCourse = courseService.findTopByCategoryId(3);
        List<Course> mathCourse = courseService.findTopByCategoryId(2);
        
        request.setAttribute("FREE", freeCourse);
        request.setAttribute("SOFT", softWareCourse);
        request.setAttribute("FOREIGN", foreignCourse);
        request.setAttribute("MATH", mathCourse);
         request.getRequestDispatcher("views/home/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
