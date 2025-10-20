/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Validation class for Book Appointment functionality
 * 
 * @author Le Anh Tuan - CE180905
 */
public class BookAppointmentValidate {
    
    // Business rules constants
    private static final int MIN_HOUR = 7;  // 7:00 AM
    private static final int MAX_HOUR = 17; // 5:00 PM
    private static final int MIN_ADVANCE_HOURS = 24; // Must book at least 24 hours in advance
    private static final int MAX_ADVANCE_DAYS = 30; // Can only book up to 30 days in advance
    
    /**
     * Validate appointment booking data
     * 
     * @param userId Patient's user ID
     * @param doctorId Doctor's ID
     * @param appointmentDateTime Appointment date and time
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateBookingData(int userId, int doctorId, Timestamp appointmentDateTime) {
        List<String> errors = new ArrayList<>();
        
        // Validate user ID
        if (userId <= 0) {
            errors.add("Invalid user ID");
        }
        
        // Validate doctor ID
        if (doctorId <= 0) {
            errors.add("Invalid doctor ID");
        }
        
        // Validate appointment date time
        if (appointmentDateTime == null) {
            errors.add("Appointment date and time is required");
        } else {
            // Convert to LocalDateTime for easier validation
            LocalDateTime appointmentTime = appointmentDateTime.toLocalDateTime();
            LocalDateTime now = LocalDateTime.now();
            
            // Check if appointment is in the past
            if (appointmentTime.isBefore(now)) {
                errors.add("Appointment time cannot be in the past");
            }
            
            // Check minimum advance booking (24 hours)
            if (appointmentTime.isBefore(now.plusHours(MIN_ADVANCE_HOURS))) {
                errors.add("Appointments must be booked at least 24 hours in advance");
            }
            
            // Check maximum advance booking (30 days)
            if (appointmentTime.isAfter(now.plusDays(MAX_ADVANCE_DAYS))) {
                errors.add("Appointments can only be booked up to 30 days in advance");
            }
            
            // Check working hours (7 AM to 5 PM)
            int hour = appointmentTime.getHour();
            if (hour < MIN_HOUR || hour >= MAX_HOUR) {
                errors.add("Appointments can only be scheduled between 7:00 AM and 5:00 PM");
            }
            
            // Check if appointment is on weekend (optional - uncomment if needed)
            // int dayOfWeek = appointmentTime.getDayOfWeek().getValue();
            // if (dayOfWeek == 6 || dayOfWeek == 7) { // Saturday or Sunday
            //     errors.add("Appointments cannot be scheduled on weekends");
            // }
        }
        
        return new ValidationResult(errors.isEmpty(), errors);
    }
    
    /**
     * Validate appointment note
     * 
     * @param note Appointment note
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateNote(String note) {
        List<String> errors = new ArrayList<>();
        
        if (note != null && note.length() > 500) {
            errors.add("Note cannot exceed 500 characters");
        }
        
        return new ValidationResult(errors.isEmpty(), errors);
    }
    
    /**
     * Get next available appointment time
     * 
     * @return Next available appointment slot (next day at 7 AM)
     */
    public static Timestamp getNextAvailableTime() {
        LocalDateTime tomorrow7AM = LocalDateTime.now()
                .plusDays(1)
                .with(LocalTime.of(MIN_HOUR, 0, 0, 0));
        
        return Timestamp.valueOf(tomorrow7AM);
    }
    
    /**
     * Comprehensive validation for complete booking process
     * This method combines all validation rules in one call (without gap validation)
     * 
     * @param userId Patient's user ID
     * @param doctorId Doctor's ID
     * @param appointmentDateTime Appointment date and time
     * @param note Appointment note
     * @param lastAppointmentTime User's last appointment time (ignored - no gap validation)
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateCompleteBooking(int userId, int doctorId, 
            Timestamp appointmentDateTime, String note, Timestamp lastAppointmentTime) {
        List<String> allErrors = new ArrayList<>();
        
        // Validate basic booking data
        ValidationResult basicValidation = validateBookingData(userId, doctorId, appointmentDateTime);
        if (!basicValidation.isValid()) {
            allErrors.addAll(basicValidation.getErrorMessages());
        }
        
        // Validate note
        ValidationResult noteValidation = validateNote(note);
        if (!noteValidation.isValid()) {
            allErrors.addAll(noteValidation.getErrorMessages());
        }
        
        // Note: Gap validation removed - users can book multiple appointments without time restrictions
        
        return new ValidationResult(allErrors.isEmpty(), allErrors);
    }
    
    /**
     * Inner class to hold validation results
     */
    public static class ValidationResult {
        private final boolean valid;
        private final List<String> errorMessages;
        
        public ValidationResult(boolean valid, List<String> errorMessages) {
            this.valid = valid;
            this.errorMessages = errorMessages;
        }
        
        public boolean isValid() {
            return valid;
        }
        
        public List<String> getErrorMessages() {
            return errorMessages;
        }
        
        public String getFirstErrorMessage() {
            return errorMessages.isEmpty() ? "" : errorMessages.get(0);
        }
        
        public String getAllErrorMessages() {
            return String.join("; ", errorMessages);
        }
    }
    
    /**
     * Validate user session and authentication
     * 
     * @param user User object from session
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateUserSession(Object user) {
        List<String> errors = new ArrayList<>();
        
        if (user == null) {
            errors.add("Please login to book an appointment.");
        }
        
        return new ValidationResult(errors.isEmpty(), errors);
    }
    
    /**
     * Validate request parameters for book appointment
     * 
     * @param doctorIdParam Doctor ID parameter from request
     * @param appointmentDateTimeParam DateTime parameter from request
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateRequestParameters(String doctorIdParam, String appointmentDateTimeParam) {
        List<String> errors = new ArrayList<>();
        
        // Validate doctor ID parameter
        if (doctorIdParam == null || doctorIdParam.trim().isEmpty()) {
            errors.add("Doctor ID is required.");
        } else {
            try {
                int doctorId = Integer.parseInt(doctorIdParam);
                if (doctorId <= 0) {
                    errors.add("Invalid doctor ID.");
                }
            } catch (NumberFormatException e) {
                errors.add("Invalid doctor ID format.");
            }
        }
        
        // Validate appointment date time parameter
        if (appointmentDateTimeParam == null || appointmentDateTimeParam.trim().isEmpty()) {
            errors.add("Appointment date and time is required.");
        }
        
        return new ValidationResult(errors.isEmpty(), errors);
    }
    
    /**
     * Parse and validate appointment date time from string
     * 
     * @param appointmentDateTimeStr Date time string from request
     * @return ValidationResult with parsed Timestamp if successful
     */
    public static ValidationResultWithData<Timestamp> parseAndValidateDateTime(String appointmentDateTimeStr) {
        List<String> errors = new ArrayList<>();
        Timestamp appointmentDateTime = null;
        
        if (appointmentDateTimeStr == null || appointmentDateTimeStr.trim().isEmpty()) {
            errors.add("Appointment date and time is required.");
        } else {
            try {
                java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                java.util.Date parsedDate = dateFormat.parse(appointmentDateTimeStr);
                appointmentDateTime = new Timestamp(parsedDate.getTime());
            } catch (Exception e) {
                errors.add("Invalid date and time format. Please use correct format.");
            }
        }
        
        return new ValidationResultWithData<>(errors.isEmpty(), errors, appointmentDateTime);
    }
    
    /**
     * Enhanced comprehensive validation that includes all controller validations
     * 
     * @param user User object from session
     * @param doctorIdParam Doctor ID parameter from request
     * @param appointmentDateTimeParam DateTime parameter from request
     * @param note Note parameter from request
     * @param lastAppointmentTime User's last appointment time
     * @return ValidationResultWithData containing parsed booking data
     */
    public static ValidationResultWithData<BookingData> validateCompleteBookingWithRequest(
            Object user, 
            String doctorIdParam,
            String appointmentDateTimeParam,
            String note,
            Timestamp lastAppointmentTime) {
        
        List<String> allErrors = new ArrayList<>();
        BookingData bookingData = new BookingData();
        
        // 1. Validate session
        ValidationResult sessionValidation = validateUserSession(user);
        if (!sessionValidation.isValid()) {
            allErrors.addAll(sessionValidation.getErrorMessages());
            return new ValidationResultWithData<>(false, allErrors, null);
        }
        
        // Cast user to get userID
        model.User validUser = (model.User) user;
        bookingData.userId = validUser.getUserID();
        
        // 2. Validate request parameters
        ValidationResult paramValidation = validateRequestParameters(doctorIdParam, appointmentDateTimeParam);
        if (!paramValidation.isValid()) {
            allErrors.addAll(paramValidation.getErrorMessages());
        }
        
        // 3. Parse and validate datetime
        ValidationResultWithData<Timestamp> dateTimeValidation = parseAndValidateDateTime(appointmentDateTimeParam);
        if (!dateTimeValidation.isValid()) {
            allErrors.addAll(dateTimeValidation.getErrorMessages());
        } else {
            bookingData.appointmentDateTime = dateTimeValidation.getData();
        }
        
        // 4. Parse doctor ID
        try {
            if (doctorIdParam != null && !doctorIdParam.trim().isEmpty()) {
                bookingData.doctorId = Integer.parseInt(doctorIdParam);
            }
        } catch (NumberFormatException e) {
            allErrors.add("Invalid doctor ID format.");
        }
        
        // 5. Set note
        bookingData.note = (note == null) ? "" : note;
        
        // 6. Run comprehensive booking validation if basic data is valid
        if (allErrors.isEmpty()) {
            ValidationResult bookingValidation = validateCompleteBooking(
                bookingData.userId, bookingData.doctorId, 
                bookingData.appointmentDateTime, bookingData.note, 
                lastAppointmentTime
            );
            if (!bookingValidation.isValid()) {
                allErrors.addAll(bookingValidation.getErrorMessages());
            }
        }
        
        return new ValidationResultWithData<>(allErrors.isEmpty(), allErrors, bookingData);
    }
    
    /**
     * Inner class to hold booking data
     */
    public static class BookingData {
        public int userId;
        public int doctorId;
        public Timestamp appointmentDateTime;
        public String note;
    }
    
    /**
     * Generic validation result with data
     */
    public static class ValidationResultWithData<T> {
        private final boolean valid;
        private final List<String> errorMessages;
        private final T data;
        
        public ValidationResultWithData(boolean valid, List<String> errorMessages, T data) {
            this.valid = valid;
            this.errorMessages = errorMessages;
            this.data = data;
        }
        
        public boolean isValid() {
            return valid;
        }
        
        public List<String> getErrorMessages() {
            return errorMessages;
        }
        
        public T getData() {
            return data;
        }
        
        public String getFirstErrorMessage() {
            return errorMessages.isEmpty() ? "" : errorMessages.get(0);
        }
        
        public String getAllErrorMessages() {
            return String.join("<br>", errorMessages);
        }
    }
}