package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.dto.CandidateDTO;
import courseitproject.model.Candidates;
import courseitproject.model.Role;
import courseitproject.model.Teacher;
import courseitproject.model.UserRole;
import courseitproject.model.Users;
import courseitproject.utils.EmailUtil;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CandidateServiceImp implements ICandidateService {

    private final GenericDAO<Candidates> candidatesDAO = new GenericDAO<>(Candidates.class);
    private final EmailUtil emailUtil = new EmailUtil();

    @Override
    public List<CandidateDTO> getCandidates() {
        EntityManager em = JPAUtil.getEntityManager();
        List<CandidateDTO> dtoList = new ArrayList<>();
        try {
            List<Candidates> candidatesList = em.createQuery("SELECT c FROM Candidates c", Candidates.class)
                    .getResultList();
            for (Candidates c : candidatesList) {
                CandidateDTO dto = new CandidateDTO();
                dto.setId(c.getId());
                if (c.getUserId() != null) {
                    dto.setCandidateName(c.getUserId().getFullName());
                    dto.setEmail(c.getUserId().getEmail());
                } else {
                    dto.setCandidateName(c.getName());
                    dto.setEmail(c.getEmail());
                }
                dto.setSkillCount(c.getSkillsCount());
                dto.setProjectCount(c.getProjectsCount());
                dto.setAppliedDate(c.getCreatedAt());
                dto.setStatus(c.getDecision());
                String rawCv = c.getCvText();
                if (rawCv != null) {
                    dto.setCvUrl(rawCv.trim().replace("\r", "").replace("\n", ""));
                } else {
                    dto.setCvUrl("");
                }
                dtoList.add(dto);
            }
            return dtoList;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateCandidateFromN8n(int userId, int jobId, int score, String decision, int skillsCount, int projectsCount, String name, String cvUrl, String email) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            List<Candidates> existing = em.createQuery(
                    "SELECT c FROM Candidates c WHERE c.userId.userId = :uid AND c.jobId.jobId = :jid ORDER BY c.createdAt DESC",
                    Candidates.class)
                    .setParameter("uid", userId)
                    .setParameter("jid", jobId)
                    .getResultList();

            if (cvUrl != null) {
                cvUrl = cvUrl.trim().replace("\r", "").replace("\n", "");
            }

            if (!existing.isEmpty()) {
                Candidates c = existing.get(0);
                c.setScore(score);
                c.setDecision(decision);
                c.setSkillsCount(skillsCount);
                c.setProjectsCount(projectsCount);
                if (name != null && !name.trim().isEmpty()) c.setName(name);
                if (email != null && !email.trim().isEmpty()) c.setEmail(email);
                if (cvUrl != null && !cvUrl.isEmpty()) c.setCvText(cvUrl);
                em.merge(c);
            } else {
                Candidates c = new Candidates();
                c.setUserId(new Users(userId));
                c.setName(name);
                c.setCvText(cvUrl);
                c.setEmail(email);
                c.setScore(score);
                c.setDecision(decision);
                c.setSkillsCount(skillsCount);
                c.setProjectsCount(projectsCount);
                c.setJobId(em.find(courseitproject.model.TeacherJob.class, jobId));
                c.setCreatedAt(new java.util.Date());
                em.persist(c);
            }

            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean approveCandidate(int candidateId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            // 1) Update candidate decision
            Candidates c = candidatesDAO.findById(em, candidateId);
            if (c == null) {
                tx.rollback();
                return false;
            }
            c.setDecision("APPROVED");
            candidatesDAO.update(em, c);

            // 2) Get the associated user
            Users user = c.getUserId();
            if (user == null) {
                // Candidate has no linked user account — just approve the record
                tx.commit();
                return true;
            }
            int userId = user.getUserId();

            // 3) Create Teacher record if not exists
            Teacher teacher = em.find(Teacher.class, userId);
            if (teacher == null) {
                teacher = new Teacher();
                teacher.setTeacherId(userId);
                teacher.setUsers(user);
                teacher.setApprovalStatus("APPROVED");
                teacher.setCvUrl(c.getCvText()); // CV URL from the application
                em.persist(teacher);
            } else {
                teacher.setApprovalStatus("APPROVED");
                if (c.getCvText() != null && !c.getCvText().isEmpty()) {
                    teacher.setCvUrl(c.getCvText());
                }
                em.merge(teacher);
            }

            // 4) Assign TEACHER role if not already assigned
            List<UserRole> existingRoles = em.createQuery(
                    "SELECT ur FROM UserRole ur WHERE ur.userId.userId = :uid AND ur.roleId.roleName = :rn",
                    UserRole.class)
                    .setParameter("uid", userId)
                    .setParameter("rn", "TEACHER")
                    .getResultList();

            if (existingRoles.isEmpty()) {
                Role teacherRole = em.createQuery(
                        "SELECT r FROM Role r WHERE r.roleName = :name", Role.class)
                        .setParameter("name", "TEACHER")
                        .getSingleResult();

                UserRole ur = new UserRole();
                ur.setUserId(user);
                ur.setRoleId(teacherRole);
                em.persist(ur);
            }

            tx.commit();
            return true;

        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean rejectCandidate(int candidateId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Candidates c = candidatesDAO.findById(em, candidateId);
            if (c != null) {
                c.setDecision("REJECTED");
                candidatesDAO.update(em, c);
                em.getTransaction().commit();
                return true;
            }
            em.getTransaction().rollback();
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean scheduleInterview(int candidateId, LocalDateTime interviewTime) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Candidates c = candidatesDAO.findById(em, candidateId);
            if (c != null) {
                Date date = Date.from(interviewTime.atZone(ZoneId.systemDefault()).toInstant());
                c.setInterviewTime(date);
                c.setDecision("INTERVIEWING");
                candidatesDAO.update(em, c);
                em.getTransaction().commit();

                // Send email
                String email = c.getUserId() != null ? c.getUserId().getEmail() : c.getEmail();
                String name = c.getUserId() != null ? c.getUserId().getFullName() : c.getName();

                if (email != null && !email.isEmpty()) {
                    String formattedTime = interviewTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

                    String subject = "Interview Invitation - HR Team";

                    String body = "<html>"
                            + "<body style='font-family: Arial, sans-serif; line-height:1.6;'>"
                            + "<h2 style='color:#2c3e50;'>Interview Invitation</h2>"
                            + "<p>Dear <b>" + name + "</b>,</p>"
                            + "<p>Thank you for your interest in joining our company. "
                            + "After reviewing your application, we are pleased to invite you to attend an interview.</p>"
                            + "<table style='border-collapse: collapse; width: 400px;'>"
                            + "<tr>"
                            + "<td style='border:1px solid #ccc; padding:8px;'><b>Candidate Name</b></td>"
                            + "<td style='border:1px solid #ccc; padding:8px;'>" + name + "</td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td style='border:1px solid #ccc; padding:8px;'><b>Interview Time</b></td>"
                            + "<td style='border:1px solid #ccc; padding:8px;'>" + formattedTime + "</td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td style='border:1px solid #ccc; padding:8px;'><b>Location</b></td>"
                            + "<td style='border:1px solid #ccc; padding:8px;'>Online / Company Office</td>"
                            + "</tr>"
                            + "</table>"
                            + "<p>Please make sure to attend the interview on time. "
                            + "If you have any questions or need to reschedule, please reply to this email.</p>"
                            + "<p>We look forward to meeting you.</p>"
                            + "<p>Best regards,<br>"
                            + "<b>HR Team</b><br>"
                            + "Recruitment Department</p>"
                            + "</body>"
                            + "</html>";
                    try {
                        emailUtil.send(email, subject, body);
                    } catch (Exception ex) {
                        System.err.println("Failed to send interview email to " + email);
                        ex.printStackTrace();
                    }
                }

                return true;
            }
            em.getTransaction().rollback();
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public long countWaitingCandidates() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em
                    .createQuery("SELECT COUNT(c) FROM Candidates c WHERE c.decision IS NULL OR c.decision = 'PENDING'",
                            Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countInterviewingCandidates() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(c) FROM Candidates c WHERE c.decision = 'INTERVIEWING'", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countAcceptedCandidates() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(c) FROM Candidates c WHERE c.decision = 'APPROVED'", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countRejectedCandidates() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(c) FROM Candidates c WHERE c.decision = 'REJECTED'", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }
}
