/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import model.Appointment;
import java.util.ArrayList;
import java.util.List;

/**
 * Validation class for Cancel Appointment functionality
 * 
 * @author Le Anh Tuan - CE180905
 */
public class CancelAppointmentValidate {
    
    // Appointment status constants
    private static final int PENDING_STATUS = 1;
    private static final int APPROVED_STATUS = 2;
    private static final int COMPLETED_STATUS = 3;
    private static final int CANCELLED_STATUS = 4;
    
    /**
     * Validate appointment ID parameter
     * 
     * @param appointmentIdParam Appointment ID parameter from request
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateAppointmentIdParameter(String appointmentIdParam) {
        List<String> errors = new ArrayList<>();
        
        if (appointmentIdParam == null || appointmentIdParam.trim().isEmpty()) {
            errors.add("Appointment ID is required.");
        } else {
            try {
                int appointmentId = Integer.parseInt(appointmentIdParam);
                if (appointmentId <= 0) {
                    errors.add("Invalid appointment ID.");
                }
            } catch (NumberFormatException e) {
                errors.add("Invalid appointment ID format.");
            }
        }
        
        return new ValidationResult(errors.isEmpty(), errors);
    }
    
    /**
     * Validate if appointment exists
     * 
     * @param appointment Appointment object from database
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateAppointmentExists(Appointment appointment) {
        List<String> errors = new ArrayList<>();
        
        if (appointment == null) {
            errors.add("Appointment not found!");
        }
        
        return new ValidationResult(errors.isEmpty(), errors);
    }
    
    /**
     * Validate if appointment can be cancelled
     * Only pending appointments can be cancelled
     * 
     * @param appointment Appointment object to validate
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateAppointmentCancellable(Appointment appointment) {
        List<String> errors = new ArrayList<>();
        
        if (appointment == null) {
            errors.add("Appointment not found!");
            return new ValidationResult(false, errors);
        }
        
        int statusId = appointment.getAppointmentStatusID();
        
        if (statusId != PENDING_STATUS) {
            switch (statusId) {
                case APPROVED_STATUS:
                    errors.add("Cannot cancel approved appointments. Please contact the clinic to reschedule.");
                    break;
                case COMPLETED_STATUS:
                    errors.add("Cannot cancel completed appointments.");
                    break;
                case CANCELLED_STATUS:
                    errors.add("This appointment is already cancelled.");
                    break;
                default:
                    errors.add("Only pending appointments can be cancelled!");
                    break;
            }
        }
        
        return new ValidationResult(errors.isEmpty(), errors);
    }
    
    /**
     * Validate user ownership of appointment
     * 
     * @param appointment Appointment object
     * @param userId Current user's ID
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateAppointmentOwnership(Appointment appointment, int userId) {
        List<String> errors = new ArrayList<>();
        
        if (appointment == null) {
            errors.add("Appointment not found!");
            return new ValidationResult(false, errors);
        }
        
        if (appointment.getUserID() != userId) {
            errors.add("You can only cancel your own appointments!");
        }
        
        return new ValidationResult(errors.isEmpty(), errors);
    }
    
    /**
     * Comprehensive validation for cancel appointment
     * 
     * @param appointmentIdParam Appointment ID parameter from request
     * @param appointment Appointment object from database
     * @param userId Current user's ID
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateCancelAppointment(String appointmentIdParam, Appointment appointment, int userId) {
        List<String> allErrors = new ArrayList<>();
        
        // 1. Validate appointment ID parameter
        ValidationResult idValidation = validateAppointmentIdParameter(appointmentIdParam);
        if (!idValidation.isValid()) {
            allErrors.addAll(idValidation.getErrorMessages());
            return new ValidationResult(false, allErrors);
        }
        
        // 2. Validate appointment exists
        ValidationResult existsValidation = validateAppointmentExists(appointment);
        if (!existsValidation.isValid()) {
            allErrors.addAll(existsValidation.getErrorMessages());
            return new ValidationResult(false, allErrors);
        }
        
        // 3. Validate user ownership
        ValidationResult ownershipValidation = validateAppointmentOwnership(appointment, userId);
        if (!ownershipValidation.isValid()) {
            allErrors.addAll(ownershipValidation.getErrorMessages());
        }
        
        // 4. Validate appointment can be cancelled
        ValidationResult cancellableValidation = validateAppointmentCancellable(appointment);
        if (!cancellableValidation.isValid()) {
            allErrors.addAll(cancellableValidation.getErrorMessages());
        }
        
        return new ValidationResult(allErrors.isEmpty(), allErrors);
    }
    
    /**
     * Validate cancel appointment with user session
     * 
     * @param appointmentIdParam Appointment ID parameter from request
     * @param appointment Appointment object from database
     * @param user User object from session
     * @return ValidationResult containing validation status and error messages
     */
    public static ValidationResult validateCancelAppointmentWithUser(String appointmentIdParam, Appointment appointment, Object user) {
        List<String> allErrors = new ArrayList<>();
        
        // 1. Validate user session
        if (user == null) {
            allErrors.add("Please login to cancel appointments.");
            return new ValidationResult(false, allErrors);
        }
        
        // 2. Cast user and get user ID
        model.User validUser = (model.User) user;
        int userId = validUser.getUserID();
        
        // 3. Run comprehensive validation
        ValidationResult validation = validateCancelAppointment(appointmentIdParam, appointment, userId);
        if (!validation.isValid()) {
            allErrors.addAll(validation.getErrorMessages());
        }
        
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
            return String.join("<br>", errorMessages);
        }
    }
}