package courseitproject.controller.details; 

import courseitproject.dao.ErrorreportsDAOImpl;
import courseitproject.dao.IErrorreportsDAO;
import courseitproject.model.Errorreports;
import courseitproject.model.Users; // Đảm bảo import đúng Entity User của bạn
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

@WebServlet("/submit-error")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,  // 10MB
        maxFileSize = 1024 * 1024 * 50,       // 50MB
        maxRequestSize = 1024 * 1024 * 100    // 100MB
)
public class ReportErrorServlet extends HttpServlet {

    // Thư mục lưu trữ ảnh
    private static final String UPLOAD_DIR = "uploads/errors";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 0. Thiết lập UTF-8 để nhận tiếng Việt từ Form
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // ===== 1. LẤY DỮ LIỆU THỰC TẾ TỪ SESSION =====
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("USER"); // "USER" phải khớp với tên bạn set lúc Login
        
        String studentName;
        if (currentUser != null) {
            // Lấy tên hiển thị của User (có thể là fullName hoặc username tùy Entity của bạn)
            studentName = currentUser.getFullName(); 
        } else {
            // Nếu khách vãng lai gửi lỗi (nếu Filter cho phép)
            studentName = "Anonymous Student";
        }

        // ===== 2. Lấy mô tả lỗi =====
        String description = request.getParameter("description");
        if (description == null || description.trim().isEmpty()) {
            description = "No description provided.";
        }

        // ===== 3. Xử lý File ảnh upload =====
        Part filePart = request.getPart("errorImage");
        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect(request.getContextPath() + "/home?status=error&message=no_image");
            return;
        }

        // Đổi tên file: dùng System.nanoTime() để tránh trùng tuyệt đối nếu nhiều người gửi cùng lúc
        String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String finalFileName = System.currentTimeMillis() + "_" + submittedFileName;

        // Xác định đường dẫn lưu trữ vật lý
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR.replace("/", File.separator);

        File uploadFolder = new File(uploadFilePath);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        // Lưu file ảnh xuống ổ đĩa
        filePart.write(uploadFilePath + File.separator + finalFileName);

        // Đường dẫn tương đối để lưu vào DB (để hiển thị trên web sau này)
        String dbImagePath = UPLOAD_DIR + "/" + finalFileName;

        // ===== 4. Gọi DAO để lưu qua JPA =====
        try {
            IErrorreportsDAO dao = new ErrorreportsDAOImpl();
            
            // Sử dụng Constructor 3 tham số mà chúng ta đã thêm vào Entity hôm trước
            Errorreports newReport = new Errorreports(studentName, description, dbImagePath);
            
            boolean isSaved = dao.insertReport(newReport);

            // ===== 5. Chuyển hướng người dùng =====
            if (isSaved) {
                // Thành công: Quay về home và hiện Toast xanh
                response.sendRedirect(request.getContextPath() + "/home?status=success");
            } else {
                throw new Exception("JPA Insert Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Thất bại: Chuyển hướng kèm thông báo lỗi
            response.sendRedirect(request.getContextPath() + "/home?status=error");
        }
    }
}