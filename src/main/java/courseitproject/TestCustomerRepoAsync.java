package courseitproject;

import courseitproject.service.AssignmentSubmissionService;

public class TestCustomerRepoAsync {
    public static void main(String[] args) throws Exception {
        AssignmentSubmissionService service = new AssignmentSubmissionService();
        String url = "https://github.com/hung2689/Customer.git";
        System.out.println("Submitting " + url + "...");
        
        int studentId = 42;
        int assignmentId = 18;
        
        boolean success = service.processSubmission(studentId, assignmentId, url);
        System.out.println("processSubmission returned: " + success);
        System.exit(0);
    }
}
