package com.example.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;

/**
 * AC-1: Class JwtTokenProvider khởi tạo JWT Token với thuật toán HS256.
 */
@Component
public class JwtTokenProvider {

    private static final long EXPIRATION_MS = 86_400_000L; // 24 hours
    private final Key secretKey = Keys.secretKeyFor(SignatureAlgorithm.HS256);

    /**
     * AC-2: Hàm createToken thiết lập thời hạn hết hạn (expiration) rõ ràng cho Token.
     */
    public String createToken(String username) {
        Date now = new Date();
        Date expiry = new Date(now.getTime() + EXPIRATION_MS);

        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(now)
                .setExpiration(expiry)           // expiration được thiết lập rõ ràng
                .signWith(secretKey, SignatureAlgorithm.HS256)
                .compact();
    }

    /**
     * AC-3: Hàm validateToken kiểm tra Token hợp lệ và xử lý ngoại lệ khi Token hết hạn.
     */
    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder()
                    .setSigningKey(secretKey)
                    .build()
                    .parseClaimsJws(token);
            return true;
        } catch (ExpiredJwtException e) {
            System.err.println("Token expired: " + e.getMessage());
        } catch (JwtException e) {
            System.err.println("Invalid token: " + e.getMessage());
        }
        return false;
    }

    public String getUsernameFromToken(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(secretKey)
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }
}