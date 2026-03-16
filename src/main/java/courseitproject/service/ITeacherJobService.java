package courseitproject.service;

import courseitproject.model.TeacherJob;
import java.util.List;

public interface ITeacherJobService {

    List<TeacherJob> findAllOpenJobs();

    TeacherJob findById(int id);
}

