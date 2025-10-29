///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package validate;
//
//import java.sql.Timestamp;
//import java.time.LocalDateTime;
//import java.text.SimpleDateFormat;
//
///**
// * Validation utility class for Book Appointment functionality
// *
// * @author Le Anh Tuan - CE180905
// */
//public class BookAppointmentValidate {
//
//    // Business rules constants
//    private static final int MIN_HOUR = 7;  // 7:00 AM
//    private static final int MAX_HOUR = 17; // 5:00 PM
//    private static final int MIN_ADVANCE_HOURS = 24; // Must book at least 24 hours in advance
//    private static final int MAX_ADVANCE_DAYS = 30; // Can only book up to 30 days in advance
//    private static final int MIN_GAP_HOURS = 24; // Must have 24 hours gap between appointments
//
//    /**
//     * Validates user ID parameter
//     *
//     * @param userId User ID to validate
//     * @return true if valid, false otherwise
//     */
//    public static boolean isValidUserId(int userId) {
//        return userId > 0;
//    }
//
//    /**
//     * Validates doctor ID parameter
//     *
//     * @param doctorId Doctor ID to validate
//     * @return true if valid, false otherwise
//     */
//    public static boolean isValidDoctorId(int doctorId) {
//        return doctorId > 0;
//    }
//
//    /**
//     * Validates appointment date time string parameter
//     *
//     * @param appointmentDateTimeStr Date time string to validate
//     * @return true if valid format, false otherwise
//     */
//    public static boolean isValidDateTimeFormat(String appointmentDateTimeStr) {
//        if (appointmentDateTimeStr == null || appointmentDateTimeStr.trim().isEmpty()) {
//            return false;
//        }
//        try {
//            // Format for datetime-local input: "2025-10-21T14:30"
//            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
//            dateFormat.setLenient(false); // Strict parsing
//            dateFormat.parse(appointmentDateTimeStr);
//            return true;
//        } catch (Exception e) {
//            return false;
//        }
//    }
//
//    /**
//     * Validates appointment time is within working hours (7 AM - 5 PM)
//     *
//     * @param appointmentDateTime Appointment date time
//     * @return true if within working hours, false otherwise
//     */
//    public static boolean isWithinWorkingHours(Timestamp appointmentDateTime) {
//        if (appointmentDateTime == null) {
//            return false;
//        }
//        LocalDateTime localDateTime = appointmentDateTime.toLocalDateTime();
//        int hour = localDateTime.getHour();
//        return hour >= MIN_HOUR && hour < MAX_HOUR;
//    }
//
//    /**
//     * Validates appointment is not in the past
//     *
//     * @param appointmentDateTime Appointment date time
//     * @return true if future appointment, false otherwise
//     */
//    public static boolean isFutureDateTime(Timestamp appointmentDateTime) {
//        if (appointmentDateTime == null) {
//            return false;
//        }
//        LocalDateTime appointmentTime = appointmentDateTime.toLocalDateTime();
//        LocalDateTime now = LocalDateTime.now();
//        return appointmentTime.isAfter(now);
//    }
//
//    /**
//     * Validates appointment is booked at least 24 hours in advance
//     *
//     * @param appointmentDateTime Appointment date time
//     * @return true if meets advance booking requirement, false otherwise
//     */
//    public static boolean isAtLeast24HoursInAdvance(Timestamp appointmentDateTime) {
//        if (appointmentDateTime == null) {
//            return false;
//        }
//        LocalDateTime appointmentTime = appointmentDateTime.toLocalDateTime();
//        LocalDateTime minAllowedTime = LocalDateTime.now().plusHours(MIN_ADVANCE_HOURS);
//        return appointmentTime.isAfter(minAllowedTime);
//    }
//
//    /**
//     * Validates appointment is not too far in the future (max 30 days)
//     *
//     * @param appointmentDateTime Appointment date time
//     * @return true if within max advance booking, false otherwise
//     */
//    public static boolean isWithin30Days(Timestamp appointmentDateTime) {
//        if (appointmentDateTime == null) {
//            return false;
//        }
//        LocalDateTime appointmentTime = appointmentDateTime.toLocalDateTime();
//        LocalDateTime maxAllowedTime = LocalDateTime.now().plusDays(MAX_ADVANCE_DAYS);
//        return appointmentTime.isBefore(maxAllowedTime);
//    }
//
//    /**
//     * Validates appointment note length
//     *
//     * @param note Appointment note
//     * @return true if valid length, false otherwise
//     */
//    public static boolean isValidNoteLength(String note) {
//        if (note == null) {
//            return true; // Note is optional
//        }
//        return note.length() <= 500;
//    }
//
//    /**
//     * Validates 24-hour gap between appointments
//     *
//     * @param lastAppointmentTime Previous appointment time (from database)
//     * @param newAppointmentTime New appointment time
//     * @return true if gap is sufficient, false otherwise
//     */
//    public static boolean hasValidTimeGap(Timestamp lastAppointmentTime, Timestamp newAppointmentTime) {
//        if (lastAppointmentTime == null || newAppointmentTime == null) {
//            return true; // No previous appointment or invalid data
//        }
//
//        LocalDateTime lastTime = lastAppointmentTime.toLocalDateTime();
//        LocalDateTime newTime = newAppointmentTime.toLocalDateTime();
//
//        // Check if the new appointment is at least 24 hours after the last one
//        long hoursDifference = Math.abs(java.time.Duration.between(lastTime, newTime).toHours());
//        return hoursDifference >= MIN_GAP_HOURS;
//    }
//
//    /**
//     * Validates complete appointment booking data
//     *
//     * @param userId Patient's user ID
//     * @param doctorId Doctor's ID
//     * @param appointmentDateTime Appointment date and time
//     * @param note Appointment note
//     * @return true if all data is valid, false otherwise
//     */
//    public static boolean isValidBookingData(int userId, int doctorId, Timestamp appointmentDateTime, String note) {
//        return isValidUserId(userId)
//                && isValidDoctorId(doctorId)
//                && isFutureDateTime(appointmentDateTime)
//                && isWithinWorkingHours(appointmentDateTime)
//                && isAtLeast24HoursInAdvance(appointmentDateTime)
//                && isWithin30Days(appointmentDateTime)
//                && isValidNoteLength(note);
//    }
//}
