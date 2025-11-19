/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.text.SimpleDateFormat;

/**
 * Validation utility class for Book Appointment functionality
 * 
 * @author Le Anh Tuan - CE180905
 */
public class BookAppointmentValidate {
    
    // Business rules constants
    private static final int MIN_HOUR = 7;  // 7:00 AM
    private static final int MAX_HOUR = 17; // 5:00 PM (but validate up to 16:30)
    private static final int MIN_ADVANCE_HOURS = 24; // Must book at least 24 hours in advance
    private static final int MAX_ADVANCE_DAYS = 30; // Can only book up to 30 days in advance
    
    /**
     * Validates appointment date time string parameter
     *
     * @param appointmentDateTimeStr Date time string to validate
     * @return true if valid format, false otherwise
     */
    public static boolean isValidDateTimeFormat(String appointmentDateTimeStr) {
        if (appointmentDateTimeStr == null || appointmentDateTimeStr.trim().isEmpty()) {
            return false;
        }
        try {
            // Format for datetime-local input: "2025-10-21T14:30"
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            dateFormat.setLenient(false); // Strict parsing
            dateFormat.parse(appointmentDateTimeStr);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Validates appointment time is within working hours (7:00 AM - 4:30 PM)
     *
     * @param appointmentDateTime Appointment date time
     * @return true if within working hours, false otherwise
     */
    public static boolean isWithinWorkingHours(Timestamp appointmentDateTime) {
        if (appointmentDateTime == null) {
            return false;
        }
        LocalDateTime localDateTime = appointmentDateTime.toLocalDateTime();
        int hour = localDateTime.getHour();
        int minute = localDateTime.getMinute();
        
        // Check if time is between 7:00 AM and 4:30 PM
        if (hour < MIN_HOUR) {
            return false; // Before 7:00 AM
        }
        if (hour > 16) {
            return false; // After 4:00 PM
        }
        if (hour == 16 && minute > 30) {
            return false; // After 4:30 PM
        }
        
        return true;
    }

    /**
     * Validates appointment is not in the past
     *
     * @param appointmentDateTime Appointment date time
     * @return true if future appointment, false otherwise
     */
    public static boolean isFutureDateTime(Timestamp appointmentDateTime) {
        if (appointmentDateTime == null) {
            return false;
        }
        LocalDateTime appointmentTime = appointmentDateTime.toLocalDateTime();
        LocalDateTime now = LocalDateTime.now();
        return appointmentTime.isAfter(now);
    }

    /**
     * Validates appointment is booked at least 24 hours in advance
     *
     * @param appointmentDateTime Appointment date time
     * @return true if meets advance booking requirement, false otherwise
     */
    public static boolean isAtLeast24HoursInAdvance(Timestamp appointmentDateTime) {
        if (appointmentDateTime == null) {
            return false;
        }
        LocalDateTime appointmentTime = appointmentDateTime.toLocalDateTime();
        LocalDateTime minAllowedTime = LocalDateTime.now().plusHours(MIN_ADVANCE_HOURS);
        return appointmentTime.isAfter(minAllowedTime);
    }

    /**
     * Validates appointment is not too far in the future (max 30 days)
     *
     * @param appointmentDateTime Appointment date time
     * @return true if within max advance booking, false otherwise
     */
    public static boolean isWithin30Days(Timestamp appointmentDateTime) {
        if (appointmentDateTime == null) {
            return false;
        }
        LocalDateTime appointmentTime = appointmentDateTime.toLocalDateTime();
        LocalDateTime maxAllowedTime = LocalDateTime.now().plusDays(MAX_ADVANCE_DAYS);
        return appointmentTime.isBefore(maxAllowedTime);
    }

    /**
     * Validates appointment note length
     *
     * @param note Appointment note
     * @return true if valid length, false otherwise
     */
    public static boolean isValidNoteLength(String note) {
        if (note == null) {
            return true; // Note is optional
        }
        return note.length() <= 500;
    }

}
