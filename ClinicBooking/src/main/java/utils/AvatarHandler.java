/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import constants.AvatarConstants;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import model.DoctorDTO;
import model.PatientDTO;
import model.StaffDTO;
import validate.AvatarValidate;

/**
 * Utility class for handling avatar processing and upload
 * Profile upload feature is for Patient only
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class AvatarHandler {

    /**
     * Process multiple doctors avatars (for display only)
     *
     * @param doctors List of doctors to process
     */
    public static void processDoctorAvatars(List<DoctorDTO> doctors) {
        if (doctors == null || doctors.isEmpty()) {
            return;
        }

        for (DoctorDTO doctor : doctors) {
            processSingleDoctorAvatar(doctor);
        }
    }

    /**
     * Process single doctor's avatar (for display only)
     * Sets default avatar if doctor has no avatar
     *
     * @param doctor Doctor to process
     */
    public static void processSingleDoctorAvatar(DoctorDTO doctor) {
        if (doctor == null) {
            return;
        }

        StaffDTO staff = doctor.getStaffID();
        if (staff == null) {
            return;
        }

        String avatar = staff.getAvatar();
        // If avatar is null or empty, set default
        if (avatar == null || avatar.trim().isEmpty()) {
            staff.setAvatar(AvatarConstants.DEFAULT_AVATAR);
        }
        // Otherwise keep the avatar path from database as-is
    }

    /**
     * Process single patient's avatar Sets default avatar if patient has no avatar
     *
     * @param patient Patient to process
     */
    public static void processPatientAvatar(PatientDTO patient) {
        if (patient == null) {
            return;
        }

        String avatar = patient.getAvatar();
        // If avatar is null or empty, set default
        if (avatar == null || avatar.trim().isEmpty()) {
            patient.setAvatar(AvatarConstants.DEFAULT_AVATAR);
        }
        // Otherwise keep the avatar path from database as-is
    }

    /**
     * Handle avatar file upload for patient
     *
     * @param avatarPart     Uploaded file part
     * @param userId         User ID (for filename)
     * @param userType       User type ("patient")
     * @param servletContext Servlet context to get real path
     * @return Relative path to saved avatar, or null if failed
     */
    public static String handleAvatarUpload(Part avatarPart, int userId, String userType,
            ServletContext servletContext) {
        try {
            // Validate file
            if (!AvatarValidate.isValidAvatarFile(avatarPart)) {
                return null;
            }

            // Get filename and extension
            String fileName = extractFileName(avatarPart);
            String extension = AvatarValidate.getFileExtension(fileName);

            // Use patient avatar directory
            String uploadDir = AvatarConstants.PATIENT_AVATAR_DIR;

            // Get real path (target folder)
            String targetPath = servletContext.getRealPath("") + File.separator
                    + uploadDir.replace("/", File.separator);

            // Get source path (src/main/webapp folder)
            String sourcePath = servletContext.getRealPath("").replace(
                    "target" + File.separator + "ClinicBooking-1.0-SNAPSHOT",
                    "src" + File.separator + "main" + File.separator + "webapp") + File.separator
                    + uploadDir.replace("/", File.separator);

            // Create directories if not exist
            File targetDir = new File(targetPath);
            if (!targetDir.exists()) {
                targetDir.mkdirs();
            }

            File sourceDir = new File(sourcePath);
            if (!sourceDir.exists()) {
                sourceDir.mkdirs();
            }

            // Generate unique filename
            String newFileName = "avatar_" + userType + "_" + userId + "_" + System.currentTimeMillis() + extension;

            // Save file to source folder (persistent)
            Path sourceFilePath = Paths.get(sourcePath, newFileName);
            Files.copy(avatarPart.getInputStream(), sourceFilePath, StandardCopyOption.REPLACE_EXISTING);

            // Also save to target folder for immediate display
            avatarPart.getInputStream().reset();
            Path targetFilePath = Paths.get(targetPath, newFileName);
            Files.copy(avatarPart.getInputStream(), targetFilePath, StandardCopyOption.REPLACE_EXISTING);

            // Return relative path for database (use forward slashes)
            return uploadDir + "/" + newFileName;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
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
}
