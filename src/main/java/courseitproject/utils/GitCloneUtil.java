package courseitproject.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

public class GitCloneUtil {

    private static final Logger LOG = Logger.getLogger(GitCloneUtil.class.getName());
    private static final int CLONE_TIMEOUT_SECONDS = 120;

    public static boolean cloneRepository(String githubUrl, String destinationPath) {
        try {
            File destDir = new File(destinationPath);
            if (destDir.exists()) {
                deleteDirectory(destDir);
            }

            ProcessBuilder builder = new ProcessBuilder(
                    "git", "clone", "--depth=1", githubUrl, destinationPath);
            builder.redirectErrorStream(true);
            Process process = builder.start();

            // Read output in background to prevent blocking
            StringBuilder output = new StringBuilder();
            Thread reader = new Thread(() -> {
                try (BufferedReader br = new BufferedReader(
                        new InputStreamReader(process.getInputStream()))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        output.append(line).append("\n");
                    }
                } catch (Exception ignored) {}
            });
            reader.start();

            boolean finished = process.waitFor(CLONE_TIMEOUT_SECONDS, TimeUnit.SECONDS);
            if (!finished) {
                process.destroyForcibly();
                LOG.severe("[Git] Clone timed out after " + CLONE_TIMEOUT_SECONDS + "s for URL: " + githubUrl);
                return false;
            }

            int exitCode = process.exitValue();
            if (exitCode != 0) {
                LOG.warning("[Git] Clone failed (exit=" + exitCode + ") for URL: " + githubUrl
                        + "\nOutput: " + output.toString().trim());
            } else {
                LOG.info("[Git] Clone succeeded for URL: " + githubUrl);
            }
            return exitCode == 0;

        } catch (Exception e) {
            LOG.severe("[Git] Exception during clone: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static void deleteDirectory(File dir) {
        File[] allContents = dir.listFiles();
        if (allContents != null) {
            for (File file : allContents) {
                deleteDirectory(file);
            }
        }
        dir.delete();
    }
}
