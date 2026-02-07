/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.service;
import com.cloudinary.Cloudinary;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import java.util.Map;
import com.cloudinary.utils.ObjectUtils;
import courseitproject.config.CloudinaryConfig;
import java.io.IOException;

 
/**
 *
 * @author ASUS
 */
public class FileUploadService {
     private Cloudinary cloudinary;

    public FileUploadService(ServletContext ctx) {
        this.cloudinary = new CloudinaryConfig(ctx).getClient();
    }

    public String uploadCv(Part file) throws IOException {
        byte[] data = file.getInputStream().readAllBytes();

        Map res = cloudinary.uploader().upload(
            data,
            ObjectUtils.asMap(
                "resource_type", "raw",
                "folder", "cv"
            )
        );

        return res.get("secure_url").toString();
    }
}
