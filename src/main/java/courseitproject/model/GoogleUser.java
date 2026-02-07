/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.model;

/**
 *
 * @author ASUS
 */
public class GoogleUser {
     private String sub;
    private String email;
    private String name;

    public GoogleUser(String sub, String email, String name) {
        this.sub = sub;
        this.email = email;
        this.name = name;
    }

    public GoogleUser() {
    }

    public String getSub() {
        return sub;
    }

    public void setSub(String sub) {
        this.sub = sub;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
}
