/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import jakarta.servlet.http.Part;

/**
 * Avatar validation utility
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class AvatarValidate {

    // Allowed image extensions
    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".png", ".gif"};

    // Max file size: 10MB
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024;

    /**
     * Check if avatar path is valid
     *
     * @param avatarPath Path to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidAvatarPath(String avatarPath) {
        return avatarPath != null && !avatarPath.trim().isEmpty();
    }

    /**
     * Validate uploaded avatar file
     *
     * @param avatarPart Uploaded file part
     * @return true if valid, false otherwise
     */
    public static boolean isValidAvatarFile(Part avatarPart) {
        if (avatarPart == null || avatarPart.getSize() == 0) {
            return false;
        }

        // Check file size
        if (avatarPart.getSize() > MAX_FILE_SIZE) {
            return false;
        }

        // Check file extension
        String fileName = extractFileName(avatarPart);
        return isValidImageExtension(fileName);
    }

    /**
     * Check if file extension is valid image type
     *
     * @param fileName File name to check
     * @return true if valid image extension
     */
    public static boolean isValidImageExtension(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return false;
        }

        String lowerFileName = fileName.toLowerCase();
        for (String ext : ALLOWED_EXTENSIONS) {
            if (lowerFileName.endsWith(ext)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Extract filename from Part header
     *
     * @param part File part
     * @return Filename
     */
    private static String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) {
            return "";
        }

        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    /**
     * Get file extension from filename
     *
     * @param fileName File name
     * @return File extension (e.g., ".jpg")
     */
    public static String getFileExtension(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return "";
        }

        int lastDotIndex = fileName.lastIndexOf(".");
        if (lastDotIndex > 0) {
            return fileName.substring(lastDotIndex);
        }
        return "";
    }
}
