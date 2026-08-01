package com.example.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;

/**
 * AC-1: Class JwtTokenProvider khởi tạo JWT Token với thuật toán HS256.
 * AC-2: Hàm createToken thiết lập thời hạn hết hạn (expiration) rõ ràng.
 * AC-3 (THIẾU): Không có hàm validateToken → AI sẽ báo NOT_FOUND cho AC-3.
 */
@Component
public class JwtTokenProviderIncomplete {

    private static final long EXPIRATION_MS = 86_400_000L;
    private final Key secretKey = Keys.secretKeyFor(SignatureAlgorithm.HS256);

    /**
     * AC-2: createToken có setExpiration → AC-2 được cover.
     */
    public String createToken(String username) {
        Date now = new Date();
        Date expiry = new Date(now.getTime() + EXPIRATION_MS);

        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(now)
                .setExpiration(expiry)
                .signWith(secretKey, SignatureAlgorithm.HS256)
                .compact();
    }

    // validateToken bị cố tình bỏ đi để test AC-3 NOT_FOUND
}