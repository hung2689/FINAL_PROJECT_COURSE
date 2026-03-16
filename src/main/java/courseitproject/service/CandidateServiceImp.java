package courseitproject.service;

import courseitproject.dao.base.GenericDAO;
import courseitproject.dto.CandidateDTO;
import courseitproject.model.Candidates;
import courseitproject.utils.EmailUtil;
import courseitproject.utils.JPAUtil;
import jakarta.persistence.EntityManager;
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
                dto.setCvUrl(c.getCvText());
                dtoList.add(dto);
            }
            return dtoList;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean approveCandidate(int candidateId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Candidates c = candidatesDAO.findById(em, candidateId);
            if (c != null) {
                c.setDecision("APPROVED");
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
