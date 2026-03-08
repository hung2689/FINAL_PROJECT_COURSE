package courseitproject.repository;

 import courseitproject.model.Candidates;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class CandidateRepository {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("courseManager");

    public void save(Candidates candidate) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(candidate);
        em.getTransaction().commit();
        em.close();
    }
   public static void main(String[] args) {

        CandidateRepository repo = new CandidateRepository();

        Candidates c = new Candidates();
        c.setName("Nguyen Van A");
        c.setEmail("a@gmail.com");
        c.setScore(85);
        c.setDecision("PASS");
        
        repo.save(c);
    }
}