
package courseitproject.controller.search;

import courseitproject.model.Course;
import courseitproject.service.CourseServiceImp;
import com.google.gson.Gson;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/searchSuggest")
public class SearchSuggestServlet extends HttpServlet {

@Override
protected void doGet(
HttpServletRequest request,
HttpServletResponse response)
throws IOException {

String keyword =
request.getParameter("keyword");

CourseServiceImp service =
new CourseServiceImp();

List<Course> list =
service.searchSuggest(keyword);

response.setContentType("application/json;charset=UTF-8");

PrintWriter out =
response.getWriter();

out.print("[");

for(int i=0;i<list.size();i++){

out.print("\""+list.get(i).getTitle()+"\"");

if(i < list.size()-1){

out.print(",");

}

}

out.print("]");

}

}

