/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.utils;

import courseitproject.config.EmailInformationConfig;
import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author ASUS
 */
public class EmailUtil {

    private Session session;
    private String from;

    public EmailUtil() {
        Properties props = new Properties();

        // SMTP config for Gmail port 587 (STARTTLS)
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", EmailInformationConfig.MAIL_HOST);
        props.put("mail.smtp.port", EmailInformationConfig.MAIL_PORT);

        // Timeout protections (15 seconds)
        props.put("mail.smtp.connectiontimeout", "15000");
        props.put("mail.smtp.timeout", "15000");
        props.put("mail.smtp.writetimeout", "15000");

        // Debug
        props.put("mail.debug", "true");

        this.from = EmailInformationConfig.MAIL_USERNAME;
        this.session = Session.getInstance(props);
    }

    public void send(String to, String subject, String content) {
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(
                    EmailInformationConfig.MAIL_USERNAME,
                    "Dev Learn"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject, "UTF-8");
            message.setContent(content, "text/html; charset=UTF-8");

            // Pass credentials directly — bypasses Authenticator
            Transport.send(message,
                    EmailInformationConfig.MAIL_USERNAME,
                    EmailInformationConfig.APP_PASSWORD);

            System.out.println("[EmailUtil] Email sent successfully to: " + to);
        } catch (Exception e) {
            System.err.println("[EmailUtil] Failed to send email: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public void sendHtml(String to, String subject, String htmlContent) {
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EmailInformationConfig.MAIL_USERNAME, "DevLearn System"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject, "UTF-8");
            message.setContent(htmlContent, "text/html; charset=UTF-8");

            // Pass credentials directly
            Transport.send(message,
                    EmailInformationConfig.MAIL_USERNAME,
                    EmailInformationConfig.APP_PASSWORD);

            System.out.println("Đã gửi email Bill thành công tới: " + to);
        } catch (Exception e) {
            System.out.println("Lỗi khi gửi email: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        EmailUtil em = new EmailUtil();
        em.send("phamduyhung0809@gmail.com", "Chó Đoàn Nhât", "CHó lê nhật");
    }
}