/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.utils;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import java.security.SecureRandom;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;


public class OtpUtil {

    SecureRandom random = new SecureRandom();

    Cache<String, String> otpCache
            = Caffeine.newBuilder()
                    .expireAfterWrite(5, TimeUnit.MINUTES) // OTP hết hạn sau 5 phút
                    .maximumSize(1000)
                    .build();

    public String generateAndStore(String email) {
        String Otp = generateOtp();
        otpCache.put(email, Otp);
        return Otp;

    }

    public boolean verify(String email, String otp) {
        String stored = otpCache.getIfPresent(email);
        if (stored == null) {
            return false;
        }
        boolean ok = stored.equals(otp);
        if (ok) {
            otpCache.invalidate(email);
        }
        return ok;

    }

    private String generateOtp() {
        StringBuilder sb = new StringBuilder(6);
        for (int i = 0; i < 6; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        OtpUtil o = new OtpUtil();
        String otp = o.generateAndStore("phamduyhung0809@gmail.com");
        EmailUtil email = new EmailUtil();
        email.send("phamduyhung0809@gmail.com", "MÃ XÁC THỰC OTP", otp);
        Scanner sc = new Scanner(System.in);
        String enOtp = sc.nextLine();
        if (o.verify("phamduyhung0809@gmail.com", enOtp)) {
            System.out.println("good");
        } else {
            System.out.println("bad");
        }
    }
}
