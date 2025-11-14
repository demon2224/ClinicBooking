/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constants;

/**
 * Constants for ManageMyAppointmentController
 *
 * @author Le Anh Tuan - CE180905
 */
public class ManageMyAppointmentConstants {
    
    // URL Patterns and Paths
    public static final String BASE_URL = "/manage-my-appointments";
    public static final String DETAIL_PAGE_JSP = "/WEB-INF/patient/MyAppointmentDetail.jsp";
    public static final String LIST_PAGE_JSP = "/WEB-INF/patient/ManageMyAppointment.jsp";
    public static final String BOOK_APPOINTMENT_JSP = "/WEB-INF/patient/BookAppointment.jsp";
    
    // Action URLs
    public static final String BOOK_APPOINTMENT_URL = "/book";
    public static final String CANCEL_APPOINTMENT_URL = "/cancel";
    public static final String VIEW_APPOINTMENT_URL = "/view";
    public static final String EDIT_APPOINTMENT_URL = "/edit";
    
    // Request Parameters
    public static final String PARAM_APPOINTMENT_ID = "appointmentId";
    public static final String PARAM_DOCTOR_ID = "doctorId";
    public static final String PARAM_APPOINTMENT_DATE_TIME = "appointmentDateTime";
    public static final String PARAM_NOTE = "note";
    public static final String PARAM_SEARCH = "search";
    public static final String PARAM_STATUS = "status";
    public static final String PARAM_DATE_FROM = "dateFrom";
    public static final String PARAM_DATE_TO = "dateTo";
    
    // Session Attributes
    public static final String SESSION_PATIENT_ID = "patientId";
    public static final String SESSION_SUCCESS_MESSAGE = "successMessage";
    public static final String SESSION_ERROR_MESSAGE = "errorMessage";
    
    // Request Attributes
    public static final String ATTR_APPOINTMENT_LIST = "appointmentList";
    public static final String ATTR_APPOINTMENT = "appointment";
    public static final String ATTR_DOCTOR_LIST = "doctorList";
    public static final String ATTR_SEARCH_QUERY = "searchQuery";
    public static final String ATTR_STATUS_FILTER = "statusFilter";
    
    // Appointment Status
    public static final String STATUS_SCHEDULED = "Scheduled";
    public static final String STATUS_COMPLETED = "Completed";
    public static final String STATUS_CANCELLED = "Cancelled";
    public static final String STATUS_NO_SHOW = "No Show";
    public static final String STATUS_RESCHEDULED = "Rescheduled";
    
    // Success Messages
    public static final String SUCCESS_APPOINTMENT_BOOKED = "Appointment booked successfully!";
    public static final String SUCCESS_APPOINTMENT_CANCELLED = "Appointment cancelled successfully!";
    public static final String SUCCESS_APPOINTMENT_UPDATED = "Appointment updated successfully!";
    public static final String SUCCESS_APPOINTMENT_RESCHEDULED = "Appointment rescheduled successfully!";
    
    // Error Messages
    public static final String ERROR_INVALID_APPOINTMENT_ID = "Invalid appointment ID.";
    public static final String ERROR_APPOINTMENT_NOT_FOUND = "Appointment not found.";
    public static final String ERROR_UNAUTHORIZED_ACCESS = "You are not authorized to access this appointment.";
    public static final String ERROR_INVALID_DOCTOR_ID = "Invalid doctor ID.";
    public static final String ERROR_DOCTOR_NOT_AVAILABLE = "Selected doctor is not available at the chosen time.";
    public static final String ERROR_INVALID_DATE_TIME = "Invalid appointment date and time.";
    public static final String ERROR_PAST_DATE_TIME = "Cannot book appointment for past date and time.";
    public static final String ERROR_OUTSIDE_WORKING_HOURS = "Appointment must be within working hours (7:00 AM - 4:30 PM).";
    public static final String ERROR_INSUFFICIENT_ADVANCE_TIME = "Appointment must be booked at least 24 hours in advance.";
    public static final String ERROR_TOO_FAR_ADVANCE = "Appointment cannot be booked more than 30 days in advance.";
    public static final String ERROR_TIME_SLOT_TAKEN = "Selected time slot is already taken.";
    public static final String ERROR_INSUFFICIENT_GAP = "There must be at least 30 minutes gap between appointments.";
    public static final String ERROR_PATIENT_GAP = "You must have at least 24 hours between your appointments.";
    public static final String ERROR_NOTE_TOO_LONG = "Note cannot exceed 500 characters.";
    public static final String ERROR_BOOKING_FAILED = "Failed to book appointment. Please try again.";
    public static final String ERROR_CANCELLATION_FAILED = "Failed to cancel appointment. Please try again.";
    public static final String ERROR_UPDATE_FAILED = "Failed to update appointment. Please try again.";
    public static final String ERROR_SESSION_EXPIRED = "Your session has expired. Please log in again.";
    public static final String ERROR_GENERAL = "An error occurred while processing your request.";
    public static final String ERROR_CANNOT_CANCEL_PAST = "Cannot cancel past appointments.";
    public static final String ERROR_CANNOT_CANCEL_COMPLETED = "Cannot cancel completed appointments.";
    public static final String ERROR_CANCELLATION_TOO_LATE = "Cannot cancel appointment less than 24 hours before the scheduled time.";
    
    // Validation Error Messages
    public static final String VALIDATION_ERROR_MISSING_DOCTOR_ID = "Doctor selection is required.";
    public static final String VALIDATION_ERROR_MISSING_DATE_TIME = "Appointment date and time is required.";
    public static final String VALIDATION_ERROR_INVALID_DATE_FORMAT = "Invalid date format.";
    public static final String VALIDATION_ERROR_MISSING_PATIENT_ID = "Patient ID is required.";
    
    // Redirect URLs
    public static final String REDIRECT_APPOINTMENT_LIST = "/manage-my-appointments";
    public static final String REDIRECT_BOOK_APPOINTMENT = "/manage-my-appointments/book";
    public static final String REDIRECT_LOGIN = "/authentication/login";
    public static final String REDIRECT_HOME = "/home";
    
    // Content Types
    public static final String CONTENT_TYPE_JSON = "application/json";
    public static final String CONTENT_TYPE_HTML = "text/html;charset=UTF-8";
    
    // Encoding
    public static final String CHARACTER_ENCODING_UTF8 = "UTF-8";
    
    // Business Rules
    public static final int MIN_ADVANCE_HOURS = 24;
    public static final int MAX_ADVANCE_DAYS = 30;
    public static final int MIN_GAP_MINUTES = 30;
    public static final int PATIENT_GAP_HOURS = 24;
    public static final int MAX_NOTE_LENGTH = 500;
    public static final int WORKING_HOUR_START = 7;
    public static final int WORKING_HOUR_END = 16;
    public static final int WORKING_MINUTE_END = 30;
     
}
