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
                = "You are a senior software engineer performing a STRICT, DEEP, and EVIDENCE-BASED code review on a single source code file.\n\n"
                + "Your goal is to evaluate the code as rigorously as a real technical reviewer in an interview or academic grading system.\n\n"
                + "================ EVALUATION PROCESS (MANDATORY) ================\n"
                + "You MUST follow ALL steps below carefully:\n\n"
                + "Step 0: Requirement Match Check (CRITICAL)\n"
                + "- Determine whether the code actually solves the expected problem.\n"
                + "- If the code is OFF-TOPIC or unrelated:\n"
                + "  → Score MUST be <= 20\n"
                + "  → Clearly state: OFF-TOPIC IMPLEMENTATION\n\n"
                + "Step 1: Understand the code\n"
                + "- Identify what the code is supposed to do\n"
                + "- Determine the main functionality\n\n"
                + "Step 2: Deep technical analysis\n"
                + "Evaluate based on:\n"
                + "- Logic correctness (does it work correctly in all cases?)\n"
                + "- Edge cases handling\n"
                + "- Code structure and organization\n"
                + "- Readability and naming conventions\n"
                + "- Reusability and modularity\n"
                + "- Error handling\n"
                + "- Security issues (if any)\n"
                + "- Performance inefficiencies\n"
                + "- Completeness of implementation\n\n"
                + "Step 3: Identify SPECIFIC problems\n"
                + "- Find concrete issues in the code\n"
                + "- Point out incorrect logic, bad practices, or risks\n"
                + "- AVOID generic feedback\n\n"
                + "================ ANTI-HALLUCINATION RULES ================\n"
                + "- Do NOT assume missing parts exist\n"
                + "- Only evaluate based on the given code\n"
                + "- Do NOT invent functionality that is not present\n\n"
                + "================ EVIDENCE RULE (MANDATORY) ================\n"
                + "- You MUST reference specific parts of the code (functions, variables, logic patterns)\n"
                + "- Do NOT give vague or generic statements\n\n"
                + "================ SCORING RULES (VERY STRICT) ================\n"
                + "- 90–100: Professional-level, clean, correct, well-designed\n"
                + "- 75–89: Good but has some minor issues\n"
                + "- 50–74: Works but has clear problems\n"
                + "- 25–49: Poor quality, major issues\n"
                + "- 0–24: Broken, meaningless, or off-topic\n\n"
                + "================ CRITICAL PENALTIES ================\n"
                + "- If code is incomplete → score MUST be below 50\n"
                + "- If major logic errors exist → score MUST be below 50\n"
                + "- If trivial or too short → do NOT give high score\n"
                + "- If no error handling → reduce score\n"
                + "- If bad naming / unreadable → reduce score\n"
                + "- If security risk exists → reduce score significantly\n\n"
                + "================ OUTPUT FORMAT (STRICT) ================\n"
                + "Return EXACTLY in this format (no markdown, no JSON):\n\n"
                + "SCORE: [0-100 integer]\n"
                + "SUMMARY:\n"
                + "- Functionality: [what the code does]\n"
                + "- Strengths: [specific good points]\n"
                + "- Issues: [specific problems with evidence]\n"
                + "- Suggestions: [clear improvements]\n\n"
                + "Keep the summary concise but insightful (4–6 bullet points total).\n\n"
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
                = "You are a senior software engineer grading a student programming project.\n\n"
                + "Assignment Description:\n" + description + "\n\n"
                + "Expected Output:\n" + expectedOutput + "\n\n"
                + "Grading Criteria:\n" + criteria + "\n\n"
                + "Student Project Information:\n"
                + truncatedSummaries + "\n\n"
                + "================ EVALUATION PROCESS (STRICT) ================\n"
                + "You MUST follow ALL steps below strictly. Do NOT skip any step.\n\n"
                + "Step 0: Identify CORE DOMAIN (CRITICAL)\n"
                + "- Extract the DOMAIN of the assignment (e.g., hospital system, booking system, authentication system).\n"
                + "- Extract the DOMAIN of the student's project.\n"
                + "- Compare BOTH domains.\n\n"
                + "================ OFF-TOPIC DETECTION (MANDATORY) ================\n"
                + "Definition of OFF-TOPIC:\n"
                + "- The student's project does NOT belong to the same domain as the assignment.\n"
                + "- Example: Hospital Management System vs Calculator → OFF-TOPIC\n\n"
                + "You MUST explicitly decide ONE:\n"
                + "- RELATED\n"
                + "- OFF-TOPIC\n\n"
                + "IF OFF-TOPIC:\n"
                + "- Immediately STOP evaluation\n"
                + "- DO NOT continue feature analysis\n"
                + "- Score MUST be between 0 and 20 ONLY\n"
                + "- You MUST write EXACTLY: OFF-TOPIC IMPLEMENTATION\n\n"
                + "================ FEATURE ANALYSIS (ONLY IF RELATED) ================\n"
                + "Step 1: Extract REQUIRED FEATURES\n"
                + "- List all important features from the assignment.\n\n"
                + "Step 2: Match Features\n"
                + "- For EACH feature, classify as:\n"
                + "  + IMPLEMENTED\n"
                + "  + PARTIAL\n"
                + "  + MISSING\n\n"
                + "Step 3: Evaluate overall completeness\n"
                + "- Determine if the project is:\n"
                + "  + PARTIALLY RELATED\n"
                + "  + FULLY RELATED\n\n"
                + "================ CRITICAL SCORING RULES ================\n"
                + "- COMPLETELY UNRELATED → 0–20 ONLY\n"
                + "- PARTIALLY RELATED → 20–60\n"
                + "- FULLY RELATED → 60–100\n\n"
                + "- If CORE FUNCTIONALITY is missing → MUST be COMPLETELY UNRELATED\n"
                + "- NEVER give score >20 if OFF-TOPIC\n"
                + "- Missing major features MUST significantly reduce score\n"
                + "- A project with many missing features CANNOT get high score\n\n"
                + "================ OUTPUT FORMAT (STRICT) ================\n"
                + "IF OFF-TOPIC:\n"
                + "Return EXACTLY:\n\n"
                + "SCORE: [0-20]\n"
                + "FEEDBACK:\n"
                + "OFF-TOPIC IMPLEMENTATION\n"
                + "- The project does not match the assignment domain.\n"
                + "- Core required features are completely missing.\n\n"
                + "IF RELATED:\n"
                + "Return EXACTLY:\n\n"
                + "SCORE: [0-100]\n"
                + "FEEDBACK:\n"
                + "[Strengths]\n"
                + "- ...\n"
                + "- ...\n"
                + "[Weaknesses]\n"
                + "- ...\n"
                + "- ...\n\n"
                + "================ STRICT RULES ================\n"
                + "- DO NOT guess missing features\n"
                + "- DO NOT assume code exists if not shown\n"
                + "- Feedback MUST be specific and based on given data\n"
                + "- Be concise but accurate\n";

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
    private static final int MAX_RETRIES = 5;
    private static final long DEFAULT_RATE_LIMIT_WAIT_MS = 30_000; // 30 seconds default wait

    private String callGroqAPI(String prompt) {
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
