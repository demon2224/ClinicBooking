///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package utils;
//
//import constants.AvatarConstants;
//import java.util.List;
//import model.DoctorDTO;
//import model.StaffDTO;
//import validate.AvatarValidate;
//
///**
// * Utility class for handling doctor avatar processing
// *
// * @author Nguyen Minh Khang - CE190728
// */
//public class AvatarHandler {
//
//    /**
//     * Process multiple doctors avatars
//     *
//     * @param doctors List of doctors to process
//     */
//    public static void processDoctorAvatars(List<DoctorDTO> doctors) {
//        if (doctors == null || doctors.isEmpty()) {
//            return;
//        }
//
//        for (DoctorDTO doctor : doctors) {
//            processSingleDoctorAvatar(doctor);
//        }
//    }
//
//    /**
//     * Process single doctor's avatar Sets default avatar if doctor has no profile image
//     *
//     * @param doctor Doctor to process
//     */
//    public static void processSingleDoctorAvatar(DoctorDTO doctor) {
//        if (doctor == null) {
//            return;
//        }
//
//        StaffDTO staff = doctor.getStaffID();
//        if (staff == null) {
//            return;
//        }
//        String processedAvatar = getProcessedAvatarPath(staff.getAvatar());
//        staff.setAvatar(processedAvatar);
//    }
//
//    /**
//     * Get processed avatar path with proper validation
//     *
//     * @param originalPath Original avatar path from database
//     * @return Processed avatar path ready for display
//     */
//    private static String getProcessedAvatarPath(String originalPath) {
//        if (AvatarValidate.isValidAvatarPath(originalPath)) {
//            return buildFullAvatarPath(originalPath);
//        }
//        return AvatarConstants.DEFAULT_AVATAR;
//    }
//
//    /**
//     * Build full avatar path if needed
//     *
//     * @param avatarPath Original avatar path
//     * @return Full avatar path
//     */
//    private static String buildFullAvatarPath(String avatarPath) {
//        if (avatarPath.startsWith(AvatarConstants.AVATAR_PATH_PREFIX)) {
//            return avatarPath;
//        }
//        return AvatarConstants.AVATAR_BASE_PATH + avatarPath;
//    }
//}
