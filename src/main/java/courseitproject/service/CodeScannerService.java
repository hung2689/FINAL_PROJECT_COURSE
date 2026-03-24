package courseitproject.service;

import java.io.File;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CodeScannerService {

    private static final Logger LOG = Logger.getLogger(CodeScannerService.class.getName());

    // Maximum file size to read (skip huge generated/minified files)
    private static final long MAX_FILE_SIZE = 100_000; // 100KB

    // Maximum number of files to read to avoid AI rate limits (infinite loading)
    private static final int MAX_FILES_TO_SCAN = 15;

    private static final Set<String> SKIP_DIRS = Set.of(
            ".git", "node_modules", "target", "build",
            ".idea", ".vscode", "dist", "out", "bin", ".gradle"
    );

    public Map<String, String> scanRepositoryFiles(String repoPath, String allowedExtensionsStr) {
        Map<String, String> fileContents = new HashMap<>();
        String[] extensions = allowedExtensionsStr == null || allowedExtensionsStr.trim().isEmpty()
                ? new String[] { ".java", ".jsp", ".html", ".js", ".css" }
                : allowedExtensionsStr.split(",");

        File root = new File(repoPath);
        if (!root.exists() || !root.isDirectory()) {
            LOG.warning("[Scanner] Repository path does not exist or is not a directory: " + repoPath);
            return fileContents;
        }

        scanRecursively(root, root, extensions, fileContents);
        
        if (fileContents.size() >= MAX_FILES_TO_SCAN) {
            LOG.warning("[Scanner] Reached MAX_FILES_TO_SCAN (" + MAX_FILES_TO_SCAN + "). Some files were skipped.");
        }
        
        LOG.info("[Scanner] Scanned " + fileContents.size() + " files from: " + repoPath);
        return fileContents;
    }

    private void scanRecursively(File root, File current, String[] extensions, Map<String, String> fileContents) {
        if (fileContents.size() >= MAX_FILES_TO_SCAN) {
            return;
        }

        if (current.isDirectory()) {
            String name = current.getName();
            // Skip common non-source directories
            if (SKIP_DIRS.contains(name)) {
                return;
            }
            File[] files = current.listFiles();
            if (files != null) {
                for (File file : files) {
                    if (fileContents.size() >= MAX_FILES_TO_SCAN) {
                        return;
                    }
                    scanRecursively(root, file, extensions, fileContents);
                }
            }
        } else {
            // Skip files that are too large (likely generated/minified)
            if (current.length() > MAX_FILE_SIZE) {
                LOG.info("[Scanner] Skipping large file: " + current.getName() + " (" + current.length() + " bytes)");
                return;
            }

            for (String ext : extensions) {
                if (current.getName().toLowerCase().endsWith(ext.trim().toLowerCase())) {
                    try {
                        String content = Files.readString(current.toPath());
                        // Use relative path from repo root as key to avoid collisions
                        String relativePath = root.toPath().relativize(current.toPath()).toString();
                        fileContents.put(relativePath, content);
                        break;
                    } catch (Exception e) {
                        LOG.log(Level.WARNING, "[Scanner] Failed to read file: " + current.getAbsolutePath(), e);
                    }
                }
            }
        }
    }
}
