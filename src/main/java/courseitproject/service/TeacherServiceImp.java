/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.Teacher;
import courseitproject.model.Users;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class TeacherServiceImp implements ITeacherService {

    private final GenericDAO<Teacher> teacherDAO
            = new GenericDAO<>(Teacher.class);

    @Override
    public Teacher findTeacherByEmail(String email) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return teacherDAO.findOneByField(em, "email", email);
        } finally {
            em.close();
        }
    }

    @Override
    public Teacher findTeacherByUsername(String username) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return teacherDAO.findOneByField(em, "username", username);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Teacher> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return teacherDAO.findAll(em);
        } finally {
            em.close();
        }
    }

    @Override
    public Teacher findTeacherById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT t FROM Teacher t WHERE t.teacherId = :id AND t.approvalStatus = 'APPROVED'",
                    Teacher.class)
                    .setParameter("id", id)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            em.close();
        }
    }

    @Override
    public void updateTeacher(Teacher t) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            teacherDAO.update(em, t);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

}
