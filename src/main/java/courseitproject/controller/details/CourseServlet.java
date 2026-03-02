package courseitproject.controller.details;

import courseitproject.model.Course;
import courseitproject.model.CourseCategory;
import courseitproject.service.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/shop")
public class CourseServlet extends HttpServlet {

    private final ICourseService courseService =
            new CourseServiceImp();

     private final ICourseCategoryService categoryService =
            new CourseCategoryServiceImp();

    private static final int PAGE_SIZE = 8;
      
    
 
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // ===== PAGE =====

            int page = 1;

            String pageParam =
                    request.getParameter("page");

            if(pageParam != null){

                page =
                Integer.parseInt(pageParam);
            }

            // ===== KEYWORD =====

            String keyword =
                    request.getParameter("keyword");


            // ===== CATEGORY =====

            String[] categoryIds =
                    request.getParameterValues("categoryId");

            List<Integer> categoryList =
                    new ArrayList<>();

            if(categoryIds != null){

                for(String id : categoryIds){

                    categoryList.add(
                            Integer.parseInt(id));
                }
            }


            // ===== FREE / PAID =====

            boolean free =
                    request.getParameter("free") != null;

            boolean paid =
                    request.getParameter("paid") != null;


            // ===== PRICE =====

            BigDecimal maxPrice = null;

            String maxPriceParam =
                    request.getParameter("maxPrice");

            if(maxPriceParam != null &&
               !maxPriceParam.isBlank()){

                maxPrice =
                        new BigDecimal(maxPriceParam);
            }


            // ===== CALL SERVICE =====
String sort = request.getParameter("sort");
            List<Course> courses =
                    courseService.filterAll(

                            keyword,

                            categoryList,

                            free,

                            paid,

                            maxPrice,
 sort,  
                            page,

                            PAGE_SIZE
                    );


            long totalCourses =
                    courseService.countFilterAll(

                            keyword,

                            categoryList,

                            free,

                            paid,

                            maxPrice
                    );


            int totalPages =
                    (int)Math.ceil(
                     (double) totalCourses / PAGE_SIZE
                    );


            BigDecimal maxCoursePrice =
                    courseService.getMaxCoursePrice();


            // ===== CATEGORY LIST =====

            List<CourseCategory> categories =
                    categoryService.getAll();


            // ===== SEND JSP =====

            request.setAttribute(
                    "courses", courses);

            request.setAttribute(
                    "categories", categories);

            request.setAttribute(
                    "currentPage", page);

      
            request.setAttribute("totalPage", totalPages);

            request.setAttribute("totalCourse", totalCourses);

            request.setAttribute(
                    "maxCoursePrice",
                    maxCoursePrice
            );


            request.getRequestDispatcher(
                    "/views/details/course-list.jsp"
            ).forward(request,response);

        }

        catch (Exception e){

            throw new ServletException(e);
        }
    }
}