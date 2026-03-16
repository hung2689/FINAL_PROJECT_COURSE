package courseitproject.dao;

import courseitproject.dao.base.GenericDAO;
import courseitproject.model.RepoSubmission;
import jakarta.persistence.EntityManager;

public class RepoSubmissionDAO extends GenericDAO<RepoSubmission> {
    public RepoSubmissionDAO() {
        super(RepoSubmission.class);
    }

    public RepoSubmission findByGithubUrl(EntityManager em, String githubUrl) {
        return findOneByField(em, "githubUrl", githubUrl);
    }
}
