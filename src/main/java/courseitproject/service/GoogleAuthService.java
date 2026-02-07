/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.service;

import courseitproject.config.GoogleConfig;
import courseitproject.model.GoogleUser;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.net.URI;
import java.util.stream.Collectors;

public class GoogleAuthService {

    public String getAccessToken(String code) throws Exception {
        URL url = URI.create(GoogleConfig.TOKEN_URL).toURL();
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        String params
                = "code=" + code
                + "&client_id=" + GoogleConfig.CLIENT_ID
                + "&client_secret=" + GoogleConfig.CLIENT_SECRET
                + "&redirect_uri=" + GoogleConfig.REDIRECT_URI
                + "&grant_type=authorization_code";

        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes());
        }

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
        );

        String response = br.lines().collect(Collectors.joining());
        JsonObject json = JsonParser.parseString(response).getAsJsonObject();

        return json.get("access_token").getAsString();
    }

    public GoogleUser getUserInfo(String accessToken) throws Exception {
        URL url = new URL(GoogleConfig.USER_INFO_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
        );

        String response = br.lines().collect(Collectors.joining());
        JsonObject json = JsonParser.parseString(response).getAsJsonObject();

        GoogleUser user = new GoogleUser();
        user.setSub(json.get("sub").getAsString());
        user.setEmail(json.get("email").getAsString());
        user.setName(json.get("name").getAsString());

        return user;
    }
}
