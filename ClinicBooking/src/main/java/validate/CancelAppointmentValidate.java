/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

/**
 * Validation utility class for Cancel Appointment functionality
 * 
 * @author Le Anh Tuan - CE180905
 */
public class CancelAppointmentValidate {
    
    /**
     * Validates appointment ID parameter
     * 
     * @param appointmentId Appointment ID to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidAppointmentId(int appointmentId) {
        return appointmentId > 0;
    }
    
    /**
     * Validates if appointment exists
     * 
     * @param appointment Appointment object from database
     * @return true if exists, false otherwise
     */
    public static boolean appointmentExists(Object appointment) {
        return appointment != null;
    }
    
    /**
     * Validates if appointment can be cancelled (only pending status)
     * 
     * @param appointmentStatusId Status ID from database
     * @return true if can be cancelled, false otherwise
     */
    public static boolean canBeCancelled(int appointmentStatusId) {
        return appointmentStatusId == 1; // Only pending appointments can be cancelled
    }
    
    /**
     * Validates user ownership of appointment
     * 
     * @param appointmentUserId User ID from appointment (from database)
     * @param currentUserId Current user's ID
     * @return true if user owns appointment, false otherwise
     */
    public static boolean isOwner(int appointmentUserId, int currentUserId) {
        return appointmentUserId == currentUserId;
    }
    
    /**
     * Validates complete cancel appointment data
     * 
     * @param appointmentUserId User ID from appointment (from database)
     * @param appointmentStatusId Status ID from appointment (from database) 
     * @param currentUserId Current user's ID
     * @param appointmentExists Whether appointment exists (from database check)
     * @return true if all validations pass, false otherwise
     */
    public static boolean isValidCancelData(int appointmentUserId, int appointmentStatusId, int currentUserId, boolean appointmentExists) {
        return appointmentExists
                && isOwner(appointmentUserId, currentUserId)
                && canBeCancelled(appointmentStatusId);
    }
}