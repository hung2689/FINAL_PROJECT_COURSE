package courseitproject.service;

import courseitproject.dto.CandidateDTO;
import java.time.LocalDateTime;
import java.util.List;

public interface ICandidateService {

    List<CandidateDTO> getCandidates();

    boolean approveCandidate(int candidateId);

    boolean rejectCandidate(int candidateId);

    boolean scheduleInterview(int candidateId, LocalDateTime interviewTime);

    long countWaitingCandidates();

    long countInterviewingCandidates();

    long countAcceptedCandidates();

    long countRejectedCandidates();
}
