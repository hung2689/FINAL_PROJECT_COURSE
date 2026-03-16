package courseitproject.service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class GeminiService {

    private static final Logger LOG = Logger.getLogger(GeminiService.class.getName());

    // ===== GROQ API Configuration =====
    private static final String GROQ_API_KEY = "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";
    private static final String GROQ_MODEL = "llama-3.3-70b-versatile";
    private static final String API_URL = "https://api.groq.com/openai/v1/chat/completions";

    // Limits to prevent exceeding token limits
    private static final int MAX_FILE_CHARS = 12_000;
    private static final int MAX_SUMMARY_CHARS = 25_000;
    private static final int HTTP_TIMEOUT_SECONDS = 120;

    private final Gson gson = new Gson();
    private final HttpClient httpClient = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(30))
            .build();

    // ==================== PUBLIC API ====================

    /**
     * Analyze a single source code file and return its score and summary.
     */
    public FileAnalysisResult analyzeCodeFile(String fileName, String content) {
        String truncatedContent = truncate(content, MAX_FILE_CHARS);
        String prompt = "Analyze the following source code file (" + fileName
                + ") and evaluate its code quality, logic, and structure.\n"
                + "You MUST provide the output EXACTLY in the following plain text format without any markdown or JSON:\n"
                + "SCORE: [an integer between 0 and 100]\n"
                + "SUMMARY: [2-3 sentences summarizing functionality and any major issues]\n\n"
                + "Source Code:\n" + truncatedContent;

        LOG.info("[AI] Analyzing file: " + fileName + " (" + content.length() + " chars)");

        String result = callGroqAPI(prompt);
        FileAnalysisResult res = new FileAnalysisResult();

        if (result.startsWith("ERROR:")) {
            LOG.warning("[AI] Analysis failed for " + fileName + ": " + result);
            res.setScore(0);
            res.setSummary("Could not analyze file: " + fileName);
            return res;
        }

        Matcher scoreMatcher = Pattern.compile("SCORE:\\s*(\\d+)").matcher(result);
        if (scoreMatcher.find()) {
            int score = Integer.parseInt(scoreMatcher.group(1));
            res.setScore(Math.min(100, Math.max(0, score)));
        } else {
            res.setScore(100);
        }

        Matcher sumMatcher = Pattern.compile("SUMMARY:\\s*(.*)", Pattern.DOTALL).matcher(result);
        if (sumMatcher.find()) {
            res.setSummary(sumMatcher.group(1).trim());
        } else {
            res.setSummary(result);
        }

        return res;
    }

    /**
     * Grade an assignment based on combined file summaries and assignment criteria.
     */
    public GradingResult gradeAssignment(String description, String expectedOutput,
            String criteria, String summaries) {

        String truncatedSummaries = truncate(summaries, MAX_SUMMARY_CHARS);

        String prompt = "You are a senior software engineer grading a student project.\n\n"
                + "Assignment Description: " + description + "\n"
                + "Expected Output: " + expectedOutput + "\n"
                + "Grading Criteria: " + criteria + "\n"
                + "Student Project Summary:\n" + truncatedSummaries + "\n\n"
                + "Evaluate the project. You MUST provide the output EXACTLY in the following plain text format "
                + "without any markdown or JSON. Do not add anything else:\n"
                + "SCORE: [an integer between 0 and 100]\n"
                + "FEEDBACK: [your detailed feedback and criteria breakdown]";

        LOG.info("[AI] Grading assignment. Summaries length: " + summaries.length() + " chars");

        String response = callGroqAPI(prompt);

        if (response.startsWith("ERROR:")) {
            LOG.severe("[AI] Grading API call failed: " + response);
            GradingResult fail = new GradingResult();
            fail.setScore(0);
            fail.setFeedback("AI grading failed: " + response);
            return fail;
        }

        return parseGradingResult(response);
    }

    // ==================== GROQ API CALL ====================

    private String callGroqAPI(String prompt) {
        try {
            // Build request body in OpenAI chat format
            JsonObject userMessage = new JsonObject();
            userMessage.addProperty("role", "user");
            userMessage.addProperty("content", prompt);

            JsonArray messages = new JsonArray();
            messages.add(userMessage);

            JsonObject requestBody = new JsonObject();
            requestBody.addProperty("model", GROQ_MODEL);
            requestBody.add("messages", messages);
            requestBody.addProperty("max_tokens", 2048);
            requestBody.addProperty("temperature", 0.3);

            String jsonBody = gson.toJson(requestBody);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(API_URL))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + GROQ_API_KEY)
                    .timeout(Duration.ofSeconds(HTTP_TIMEOUT_SECONDS))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                    .build();

            LOG.info("[AI] Sending request to Groq (" + GROQ_MODEL + "), body: " + jsonBody.length() + " bytes");

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            int statusCode = response.statusCode();
            String body = response.body();

            LOG.info("[AI] Response status: " + statusCode);

            if (statusCode != 200) {
                String errorMsg = extractErrorMessage(body);
                LOG.severe("[AI] API error " + statusCode + ": " + errorMsg);
                return "ERROR: Groq API returned " + statusCode + " - " + errorMsg;
            }

            return extractTextFromResponse(body);

        } catch (java.net.http.HttpTimeoutException e) {
            LOG.severe("[AI] Request timed out");
            return "ERROR: Request timed out";
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "[AI] Request failed", e);
            return "ERROR: " + e.getClass().getSimpleName() + " - " + e.getMessage();
        }
    }

    // ==================== RESPONSE PARSING ====================

    /**
     * Extract the text content from Groq's OpenAI-format JSON response.
     * Format: { "choices": [{ "message": { "content": "..." } }] }
     */
    private String extractTextFromResponse(String json) {
        try {
            JsonObject root = JsonParser.parseString(json).getAsJsonObject();

            if (!root.has("choices")) {
                LOG.warning("[AI] Response has no 'choices' field");
                return "ERROR: No choices in response";
            }

            JsonArray choices = root.getAsJsonArray("choices");
            if (choices.isEmpty()) {
                return "ERROR: Empty choices";
            }

            JsonObject firstChoice = choices.get(0).getAsJsonObject();
            JsonObject message = firstChoice.getAsJsonObject("message");

            return message.get("content").getAsString();

        } catch (Exception e) {
            LOG.log(Level.WARNING, "[AI] Failed to parse response", e);
            return "ERROR: Failed to parse response - " + e.getMessage();
        }
    }

    /**
     * Extract error message from API error response.
     */
    private String extractErrorMessage(String json) {
        try {
            JsonObject root = JsonParser.parseString(json).getAsJsonObject();
            if (root.has("error")) {
                JsonObject error = root.getAsJsonObject("error");
                return error.has("message") ? error.get("message").getAsString() : error.toString();
            }
        } catch (Exception ignored) {
        }
        return truncate(json, 300);
    }

    /**
     * Parse SCORE and FEEDBACK from the AI grading response text.
     */
    private GradingResult parseGradingResult(String text) {
        GradingResult res = new GradingResult();
        res.setScore(0);
        res.setFeedback(text);

        LOG.info("[AI] Parsing grading result (" + text.length() + " chars)");

        Matcher scoreMatcher = Pattern.compile("SCORE:\\s*(\\d+)").matcher(text);
        if (scoreMatcher.find()) {
            int score = Integer.parseInt(scoreMatcher.group(1));
            res.setScore(Math.min(100, Math.max(0, score)));
            LOG.info("[AI] Parsed score: " + res.getScore());
        } else {
            LOG.warning("[AI] Could not parse SCORE from response");
        }

        Matcher fbMatcher = Pattern.compile("FEEDBACK:\\s*(.*)", Pattern.DOTALL).matcher(text);
        if (fbMatcher.find()) {
            res.setFeedback(fbMatcher.group(1).trim());
        }

        return res;
    }

    // ==================== UTILITY ====================

    private static String truncate(String s, int maxLength) {
        if (s == null)
            return "";
        if (s.length() <= maxLength)
            return s;
        return s.substring(0, maxLength) + "\n... [TRUNCATED]";
    }

    // ==================== RESULT DTO ====================

    public static class FileAnalysisResult {
        private int score;
        private String summary;

        public int getScore() { return score; }
        public void setScore(int score) { this.score = score; }
        public String getSummary() { return summary; }
        public void setSummary(String summary) { this.summary = summary; }
    }

    public static class GradingResult {
        private int score;
        private String feedback;

        public int getScore() {
            return score;
        }

        public void setScore(int score) {
            this.score = score;
        }

        public String getFeedback() {
            return feedback;
        }

        public void setFeedback(String feedback) {
            this.feedback = feedback;
        }
    }
}
