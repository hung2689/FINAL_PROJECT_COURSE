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
    private static final String GROQ_API_KEY = System.getenv("GROQ_API_KEY") != null
            ? System.getenv("GROQ_API_KEY") : "MISSING_KEY";
    private static final String GROQ_MODEL = "llama-3.1-8b-instant";
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
        String prompt
                = "You are a FAIR and EXPERIENCED programming teacher reviewing a student's source code file.\n\n"
                + "Your job is to evaluate this file FAIRLY. Students are learning, so give credit for what they did correctly.\n\n"
                + "================ HOW TO GRADE ================\n"
                + "1. First, understand what this file is supposed to do\n"
                + "2. Identify what the student did CORRECTLY (give credit!)\n"
                + "3. Identify what needs improvement\n"
                + "4. Give a FAIR score based on overall quality\n\n"
                + "================ SCORING GUIDE ================\n"
                + "- 80-100: Code works correctly, well-structured, minor issues only\n"
                + "- 60-79: Code mostly works, has some issues but shows understanding\n"
                + "- 40-59: Code partially works, missing important parts\n"
                + "- 20-39: Code has major problems but shows some effort\n"
                + "- 0-19: Code is broken, empty, or completely wrong\n\n"
                + "IMPORTANT RULES:\n"
                + "- If the code WORKS and does its job → minimum 50 points\n"
                + "- If the student shows understanding of the concept → give credit\n"
                + "- Do NOT give 0 just because error handling is missing\n"
                + "- Simple but working code deserves at least 60 points\n\n"
                + "================ OUTPUT FORMAT ================\n"
                + "SCORE: [0-100]\n\n"
                + "SUMMARY:\n"
                + "[Brief description of what this file does]\n\n"
                + "Strengths:\n"
                + "- [What the student did well - be specific]\n"
                + "- [Another good point]\n\n"
                + "Weaknesses:\n"
                + "- [What needs fixing - be specific but constructive]\n"
                + "- [Another issue]\n\n"
                + "Improvements:\n"
                + "- [Specific suggestion to make the code better]\n"
                + "- [Another suggestion]\n\n"
                + "================ SOURCE CODE ================\n"
                + "File: " + fileName + "\n\n"
                + truncatedContent;

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
     * Grade an assignment based on combined file summaries and assignment
     * criteria.
     */
    public GradingResult gradeAssignment(String description, String expectedOutput,
            String criteria, String summaries) {

        String truncatedSummaries = truncate(summaries, MAX_SUMMARY_CHARS);

        String prompt
                = "You are a FAIR and SUPPORTIVE programming teacher grading a student's project.\n\n"
                + "Look at the OVERALL project holistically. Give credit for what students did correctly.\n\n"
                + "================ ASSIGNMENT INFO ================\n"
                + "Assignment: " + description + "\n"
                + "Expected Output: " + expectedOutput + "\n"
                + "Grading Criteria: " + criteria + "\n\n"
                + "================ STUDENT'S WORK ================\n"
                + truncatedSummaries + "\n\n"
                + "================ HOW TO GRADE ================\n"
                + "1. Read ALL the file summaries to understand the WHOLE project\n"
                + "2. Check if the project matches the assignment topic\n"
                + "3. Identify what features the student implemented\n"
                + "4. Give a FAIR overall score\n\n"
                + "================ SCORING GUIDE ================\n"
                + "- 80-100: Project meets most requirements, code works well\n"
                + "- 60-79: Project partially meets requirements, shows good understanding\n"
                + "- 40-59: Project shows effort but missing key features\n"
                + "- 20-39: Project has major gaps but student tried\n"
                + "- 0-19: ONLY if project is completely unrelated to the assignment\n\n"
                + "IMPORTANT RULES:\n"
                + "- If the project WORKS and is related to the assignment → minimum 50\n"
                + "- Give credit for effort and partial implementations\n"
                + "- A simple but working project deserves at least 60\n"
                + "- Only give below 20 if the project is TOTALLY unrelated\n\n"
                + "================ OUTPUT FORMAT ================\n"
                + "SCORE: [0-100]\n\n"
                + "FEEDBACK:\n\n"
                + "Overview:\n"
                + "[2-3 sentences about what the student built and how it relates to the assignment]\n\n"
                + "Strengths:\n"
                + "- [Specific thing the student did well]\n"
                + "- [Another positive point]\n"
                + "- [Give at least 2-3 strengths]\n\n"
                + "Weaknesses:\n"
                + "- [Specific issue - be constructive, not harsh]\n"
                + "- [Another issue]\n\n"
                + "Suggestions for Improvement:\n"
                + "- [Specific actionable advice to improve the project]\n"
                + "- [Another suggestion]\n"
                + "- [Help the student learn, not punish them]\n";

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
    private static final int MAX_RETRIES = 2; // Giảm từ 5 xuống 2 để web khỏi bị treo quá lâu
    private static final long DEFAULT_RATE_LIMIT_WAIT_MS = 10_000; // Giảm từ 30s xuống 10s

    private String callGroqAPI(String prompt) {
        // Build request body in OpenAI chat format
        // System message anchors the AI's behavior for consistent scoring
        JsonObject systemMessage = new JsonObject();
        systemMessage.addProperty("role", "system");
        systemMessage.addProperty("content",
                "You are a fair and experienced programming teacher who grades student assignments. "
                + "You always give credit for what students did correctly. "
                + "You are supportive but honest. You provide detailed feedback with strengths, weaknesses, and specific suggestions. "
                + "You NEVER give 0 points unless the submission is completely empty or totally unrelated. "
                + "A working project always deserves at least 50 points. "
                + "You must be consistent: same code = same score every time.");

        JsonObject userMessage = new JsonObject();
        userMessage.addProperty("role", "user");
        userMessage.addProperty("content", prompt);

        JsonArray messages = new JsonArray();
        messages.add(systemMessage);
        messages.add(userMessage);

        JsonObject requestBody = new JsonObject();
        requestBody.addProperty("model", GROQ_MODEL);
        requestBody.add("messages", messages);
        requestBody.addProperty("max_tokens", 2048);
        requestBody.addProperty("temperature", 0);   // 0 = fully deterministic, no randomness
        requestBody.addProperty("top_p", 1);          // Use full probability distribution
        requestBody.addProperty("seed", 42);          // Fixed seed for reproducible results

        String jsonBody = gson.toJson(requestBody);

        for (int attempt = 1; attempt <= MAX_RETRIES; attempt++) {
            try {
                HttpRequest request = HttpRequest.newBuilder()
                        .uri(URI.create(API_URL))
                        .header("Content-Type", "application/json")
                        .header("Authorization", "Bearer " + GROQ_API_KEY)
                        .timeout(Duration.ofSeconds(HTTP_TIMEOUT_SECONDS))
                        .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                        .build();

                LOG.info("[AI] Sending request to Groq (" + GROQ_MODEL + "), attempt "
                        + attempt + "/" + MAX_RETRIES + ", body: " + jsonBody.length() + " bytes");

                HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

                int statusCode = response.statusCode();
                String body = response.body();

                LOG.info("[AI] Response status: " + statusCode);

                // Handle rate limiting with retry
                if (statusCode == 429) {
                    long waitMs = DEFAULT_RATE_LIMIT_WAIT_MS;

                    // Try to parse retry-after header or x-ratelimit-reset-tokens
                    String retryAfter = response.headers().firstValue("retry-after").orElse(null);
                    String resetTokens = response.headers().firstValue("x-ratelimit-reset-tokens").orElse(null);

                    if (retryAfter != null) {
                        try {
                            waitMs = (long) (Double.parseDouble(retryAfter) * 1000);
                        } catch (NumberFormatException ignored) {
                        }
                    } else if (resetTokens != null) {
                        waitMs = parseResetTime(resetTokens);
                    }

                    // Add extra buffer time
                    waitMs = Math.max(waitMs, 5_000) + 2_000;

                    if (attempt < MAX_RETRIES) {
                        LOG.warning("[AI] Rate limited (429). Waiting " + waitMs + "ms before retry "
                                + (attempt + 1) + "/" + MAX_RETRIES + "...");
                        Thread.sleep(waitMs);
                        continue;
                    } else {
                        LOG.severe("[AI] Rate limited (429) after " + MAX_RETRIES + " attempts. Giving up.");
                        return "ERROR: Rate limited after " + MAX_RETRIES + " retries";
                    }
                }

                if (statusCode != 200) {
                    String errorMsg = extractErrorMessage(body);
                    LOG.severe("[AI] API error " + statusCode + ": " + errorMsg);
                    return "ERROR: Groq API returned " + statusCode + " - " + errorMsg;
                }

                return extractTextFromResponse(body);

            } catch (java.net.http.HttpTimeoutException e) {
                LOG.severe("[AI] Request timed out on attempt " + attempt);
                if (attempt < MAX_RETRIES) {
                    try {
                        Thread.sleep(5_000);
                    } catch (InterruptedException ignored) {
                    }
                    continue;
                }
                return "ERROR: Request timed out after " + MAX_RETRIES + " attempts";
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                return "ERROR: Interrupted during rate limit wait";
            } catch (Exception e) {
                LOG.log(Level.SEVERE, "[AI] Request failed on attempt " + attempt, e);
                if (attempt < MAX_RETRIES) {
                    try {
                        Thread.sleep(3_000);
                    } catch (InterruptedException ignored) {
                    }
                    continue;
                }
                return "ERROR: " + e.getClass().getSimpleName() + " - " + e.getMessage();
            }
        }
        return "ERROR: Exhausted all retry attempts";
    }

    /**
     * Parse Groq rate limit reset time strings like "58.705s", "1m30s", etc.
     */
    private long parseResetTime(String resetStr) {
        try {
            long totalMs = 0;
            java.util.regex.Matcher minMatcher = Pattern.compile("(\\d+)m").matcher(resetStr);
            if (minMatcher.find()) {
                totalMs += Long.parseLong(minMatcher.group(1)) * 60_000;
            }
            java.util.regex.Matcher secMatcher = Pattern.compile("([\\d.]+)s").matcher(resetStr);
            if (secMatcher.find()) {
                totalMs += (long) (Double.parseDouble(secMatcher.group(1)) * 1000);
            }
            java.util.regex.Matcher msMatcher = Pattern.compile("(\\d+)ms").matcher(resetStr);
            if (msMatcher.find()) {
                totalMs += Long.parseLong(msMatcher.group(1));
            }
            return totalMs > 0 ? totalMs : DEFAULT_RATE_LIMIT_WAIT_MS;
        } catch (Exception e) {
            return DEFAULT_RATE_LIMIT_WAIT_MS;
        }
    }

    // ==================== RESPONSE PARSING ====================
    /**
     * Extract the text content from Groq's OpenAI-format JSON response. Format:
     * { "choices": [{ "message": { "content": "..." } }] }
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
        if (s == null) {
            return "";
        }
        if (s.length() <= maxLength) {
            return s;
        }
        return s.substring(0, maxLength) + "\n... [TRUNCATED]";
    }

    // ==================== RESULT DTO ====================
    public static class FileAnalysisResult {

        private int score;
        private String summary;

        public int getScore() {
            return score;
        }

        public void setScore(int score) {
            this.score = score;
        }

        public String getSummary() {
            return summary;
        }

        public void setSummary(String summary) {
            this.summary = summary;
        }
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
