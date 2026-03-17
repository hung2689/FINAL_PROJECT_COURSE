package courseitproject.service;

import courseitproject.model.TeacherJob;
import java.util.List;

public interface ITeacherJobService {

    List<TeacherJob> findAllOpenJobs();

    List<TeacherJob> findAllJobs();

    List<TeacherJob> findAllJobsPaging(int page, int pageSize);

    TeacherJob findById(int id);

    void createJob(TeacherJob job);

    void updateJob(TeacherJob job);

    void deleteJob(int id);

    long countAllJobs();
}
