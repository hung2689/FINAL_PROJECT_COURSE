package courseitproject.service;

import courseitproject.dto.CandidateDTO;
import java.time.LocalDateTime;
import java.util.List;

public interface ICandidateService {

    boolean updateCandidateFromN8n(int userId, int jobId, int score, String decision, int skillsCount, int projectsCount, String name, String cvUrl, String email);

    List<CandidateDTO> getCandidates();

    boolean approveCandidate(int candidateId);

    boolean rejectCandidate(int candidateId);

    boolean scheduleInterview(int candidateId, LocalDateTime interviewTime);

    long countWaitingCandidates();

    long countInterviewingCandidates();

    long countAcceptedCandidates();

    long countRejectedCandidates();
}
