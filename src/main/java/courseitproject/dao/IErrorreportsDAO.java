package courseitproject.dao;

import courseitproject.model.Errorreports;
import java.util.List;

public interface IErrorreportsDAO {
    boolean insertReport(Errorreports report);
    List<Errorreports> getAllReports();
boolean updateStatus(int id, String newStatus);
        }