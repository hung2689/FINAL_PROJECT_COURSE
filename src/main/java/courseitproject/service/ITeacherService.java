/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.service;

import courseitproject.model.Teacher;
import java.util.List;

/**
 *
 * @author ASUS
 */
public interface ITeacherService {

    Teacher findTeacherByEmail(String email);

    Teacher findTeacherByUsername(String username);

    public List<Teacher> findAll();

    public Teacher findTeacherById(int id);
    public void updateTeacher(Teacher t);

}
