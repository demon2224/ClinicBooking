/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import model.AppointmentDTO;

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
    public static boolean appointmentExists(AppointmentDTO appointment) {
        return appointment != null;
    }

    /**
     * Validates if appointment can be cancelled based on string status
     *
     * @param appointmentStatus Current appointment status
     * @return true if can be cancelled, false otherwise
     */
    public static boolean canBeCancelledByStatus(String appointmentStatus) {
        return "Pending".equals(appointmentStatus);
    }

    /**
     * Validates if patient owns the appointment
     *
     * @param appointmentPatientId Patient ID from appointment
     * @param currentPatientId Patient ID from session
     * @return true if patient owns the appointment, false otherwise
     */
    public static boolean isPatientOwner(int appointmentPatientId, int currentPatientId) {
        return appointmentPatientId == currentPatientId && currentPatientId > 0;
    }
}