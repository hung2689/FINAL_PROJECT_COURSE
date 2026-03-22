package courseitproject.controller.student;

import courseitproject.dao.ErrorreportsDAOImpl;
import courseitproject.dao.IErrorreportsDAO;
import courseitproject.model.Errorreports;
import courseitproject.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet(name = "SubmitErrorServlet", urlPatterns = {"/submit-error"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class SubmitErrorServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("USER");
        String studentName = "Anonymous";
        if (user != null) {
            studentName = user.getEmail(); // Defaulting to email, could be username
        }

        String description = request.getParameter("description");
        Part filePart = request.getPart("errorImage");

        String dbImagePath = null;

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

            // Save to application directory
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

            File fileSaveDir = new File(uploadFilePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs();
            }

            String filePath = uploadFilePath + File.separator + uniqueFileName;
            filePart.write(filePath);

            dbImagePath = UPLOAD_DIR + "/" + uniqueFileName;
        }

        // Insert into DB
        IErrorreportsDAO dao = new ErrorreportsDAOImpl();
        Errorreports report = new Errorreports(studentName, description, dbImagePath);
        dao.insertReport(report);

        // Redirect back to the previous page
        String referer = request.getHeader("Referer");
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
