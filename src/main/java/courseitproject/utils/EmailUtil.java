/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.utils;

import courseitproject.config.EmailInformationConfig;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
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
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", EmailInformationConfig.MAIL_HOST);
        props.put("mail.smtp.port", EmailInformationConfig.MAIL_PORT);
        this.from=EmailInformationConfig.MAIL_USERNAME;
        this.session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EmailInformationConfig.MAIL_USERNAME, EmailInformationConfig.APP_PASSWORD);
            }
        });
 
    }
    public void send(String to , String subject , String content){
        try {
            Message message = new MimeMessage(session);
             message.setFrom(new InternetAddress(
                    EmailInformationConfig.MAIL_USERNAME,
                    "Dev Learn"
            ));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setText(content);
            Transport.send(message);
        } catch (Exception e) {
            throw  new RuntimeException(e);
        }
    }
    public static void main(String[] args) {
       EmailUtil em = new EmailUtil();
       em.send("phamduyhung0809@gmail.com", "Chó Đoàn Nhât", "CHó lê nhật");
    }
}
