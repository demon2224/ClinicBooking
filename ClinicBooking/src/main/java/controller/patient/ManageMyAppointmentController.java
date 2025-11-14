/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.patient;

import dao.AppointmentDAO;
import dao.PatientDAO;
import dao.DoctorDAO;
import model.AppointmentDTO;
import model.DoctorDTO;
import model.PatientDTO;
import validate.BookAppointmentValidate;
import validate.CancelAppointmentValidate;
import constants.ManageMyAppointmentConstans;
import java.io.IOException;
import java.util.List;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for viewing and managing patient's appointments (list, detail,
 * cancel).
 *
 * @author Le Anh Tuan - CE180905
 */
public class ManageMyAppointmentController extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private PatientDAO patientDAO;
    private DoctorDAO doctorDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        patientDAO = new PatientDAO();
        doctorDAO = new DoctorDAO();
    }

    /**
     * Handles GET requests - Display appointments list, appointment detail, or
     * book appointment form
     *
     * @param request
     * @param response
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String appointmentIdParam = request.getParameter("id");
        String doctorIdParam = request.getParameter("doctorId");

        // Check if this is a request for book appointment form
        if ("bookAppointment".equals(action) && doctorIdParam != null && !doctorIdParam.trim().isEmpty()) {
            handleBookAppointmentForm(request, response, doctorIdParam);
            return;
        }

        // Check if this is a request for appointment detail
        if (appointmentIdParam != null && !appointmentIdParam.trim().isEmpty()) {
            // Handle appointment detail view
            handleAppointmentDetail(request, response, appointmentIdParam);
            return;
        }

        // Handle appointments list view
        handleAppointmentsList(request, response);
    }

    /**
     * Handles POST requests - Process actions (cancel, book appointment, etc.)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("bookAppointment".equals(action)) {
            handleBookAppointment(request, response);
            return;
        }

        String appointmentIdParam = request.getParameter("appointmentId");

        if ("cancel".equals(action)) {
            // Parse and validate appointment ID parameter
            try {
                int appointmentId = Integer.parseInt(appointmentIdParam);

                if (!CancelAppointmentValidate.isValidAppointmentId(appointmentId)) {
                    request.getSession().setAttribute("errorMessage", "Invalid appointment ID.");
                    response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                    return;
                }

                handleCancelAppointment(request, response, appointmentId);
                return;
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid appointment ID format.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }
        }

        // For other actions, validate appointment ID parameter
        if (appointmentIdParam == null || appointmentIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
            return;
        }

        try {
            int appointmentId = Integer.parseInt(appointmentIdParam);
            // For other actions or no specific action, redirect back to detail page
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?id=" + appointmentId);
        } catch (NumberFormatException e) {
            // If invalid ID, redirect to appointments list
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
        }
    }

    /**
     * Handle appointment detail view
     */
    private void handleAppointmentDetail(HttpServletRequest request, HttpServletResponse response, String appointmentIdParam)
            throws ServletException, IOException {

        try {
            int appointmentId = Integer.parseInt(appointmentIdParam);

            // Get appointment details
            AppointmentDTO appointment = appointmentDAO.getAppointmentById(appointmentId);

            // Redirect if appointment not found
            if (appointment == null) {
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }

            // Get patient and doctor information
            PatientDTO patient = patientDAO.getPatientById(appointment.getPatientID().getPatientID());
            DoctorDTO doctor = doctorDAO.getDoctorById(appointment.getDoctorID().getDoctorID());

            // Get doctor's average rating
            double averageRating = doctorDAO.getAverageRatingByDoctorId(appointment.getDoctorID().getDoctorID());

            // Set attributes for JSP
            request.setAttribute("appointment", appointment);
            request.setAttribute("patient", patient);
            request.setAttribute("doctor", doctor);
            request.setAttribute("averageRating", averageRating);

            // Forward to detail page
            request.getRequestDispatcher(ManageMyAppointmentConstans.DETAIL_PAGE_JSP).forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
        }
    }

    /**
     * Handle appointments list view
     */
    private void handleAppointmentsList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get patient from session
        HttpSession session = request.getSession();
        PatientDTO patient = (PatientDTO) session.getAttribute("patient");
        int patientId = patient.getPatientID();

        // Get search parameters
        String searchQuery = request.getParameter("search");
        List<AppointmentDTO> appointments;

        // Apply search
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            appointments = appointmentDAO.searchAppointmentsByPatientId(patientId, searchQuery);
        } else {
            appointments = appointmentDAO.getAppointmentsByPatientId(patientId);
        }

        // Set attributes for JSP
        request.setAttribute("appointments", appointments);
        request.setAttribute("searchQuery", searchQuery);

        // Forward to JSP
        request.getRequestDispatcher(ManageMyAppointmentConstans.LIST_PAGE_JSP).forward(request, response);
    }

    /**
     * Handle appointment cancellation - Only allow cancelling pending
     * appointments
     */
    private void handleCancelAppointment(HttpServletRequest request, HttpServletResponse response, int appointmentId)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        PatientDTO patient = (PatientDTO) session.getAttribute("patient");

        try {
            // Validate appointment ID
            if (!CancelAppointmentValidate.isValidAppointmentId(appointmentId)) {
                session.setAttribute("errorMessage", "Invalid appointment ID.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }
            // Get appointment from database
            AppointmentDTO appointment = appointmentDAO.getAppointmentById(appointmentId);

            // Check if appointment exists
            if (!CancelAppointmentValidate.appointmentExists(appointment)) {
                session.setAttribute("errorMessage", "Appointment not found.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }

            // Check if appointment can be cancelled (using string status now)
            if (!CancelAppointmentValidate.canBeCancelledByStatus(appointment.getAppointmentStatus())) {
                session.setAttribute("errorMessage", "This appointment cannot be cancelled.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }

            // Check if patient owns the appointment
            if (!CancelAppointmentValidate.isPatientOwner(appointment.getPatientID().getPatientID(), patient != null ? patient.getPatientID() : 0)) {
                session.setAttribute("errorMessage", "You can only cancel your own appointments.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }

            // Attempt to cancel appointment
            boolean success = appointmentDAO.cancelMyAppointment(appointmentId);

            if (success) {
                session.setAttribute("successMessage", "Appointment cancelled successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to cancel appointment. Please try again.");
            }

        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred while cancelling appointment!");
        }

        // Redirect back to appointments list
        response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
    }

    /**
     * Handle book appointment form display
     */
    private void handleBookAppointmentForm(HttpServletRequest request, HttpServletResponse response, String doctorIdParam)
            throws ServletException, IOException {
        try {
            int doctorId = Integer.parseInt(doctorIdParam);

            // Get doctor information
            DoctorDTO doctor = doctorDAO.getDoctorById(doctorId);

            if (doctor == null) {
                request.getSession().setAttribute("errorMessage", "Doctor not found!");
                response.sendRedirect(request.getContextPath() + "/doctor-list");
                return;
            }

            // Get doctor's average rating
            double averageRating = doctorDAO.getAverageRatingByDoctorId(doctorId);

            // Set attributes for JSP
            request.setAttribute("doctor", doctor);
            request.setAttribute("doctorId", doctorId);
            request.setAttribute("averageRating", averageRating);

            // Forward to book appointment page
            request.getRequestDispatcher(ManageMyAppointmentConstans.BOOK_APPOINTMENT_JSP).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/doctor-list");
        }
    }

    /**
     * Handle book appointment submission
     */
    private void handleBookAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        PatientDTO patient = (PatientDTO) session.getAttribute("patient");

        if (patient == null) {
            response.sendRedirect(request.getContextPath() + "/patient-login");
            return;
        }

        try {
            String doctorIdParam = request.getParameter("doctorId");
            String appointmentDateTimeParam = request.getParameter("appointmentDateTime");
            String note = request.getParameter("note");

            // Basic null/empty validation
            if (appointmentDateTimeParam == null || appointmentDateTimeParam.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Please select appointment date and time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorIdParam);
                return;
            }

            // Validate appointment date time format
            if (!BookAppointmentValidate.isValidDateTimeFormat(appointmentDateTimeParam)) {
                session.setAttribute("errorMessage", "Invalid appointment date and time format. Please use the date picker.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorIdParam);
                return;
            }

            // Validate patient ID
            if (!BookAppointmentValidate.isValidPatientId(patient != null ? patient.getPatientID() : 0)) {
                session.setAttribute("errorMessage", "Invalid patient. Please log in again.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }

            // Validate doctor ID
            int doctorId = 0;
            try {
                doctorId = Integer.parseInt(doctorIdParam);
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "Invalid doctor selection.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }

            if (!BookAppointmentValidate.isValidDoctorId(doctorId)) {
                session.setAttribute("errorMessage", "Invalid doctor selection.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }

            // Parse appointment date time
            Timestamp appointmentDateTime = null;
            try {
                // Convert datetime-local format to Timestamp
                String timestampFormat = appointmentDateTimeParam.replace("T", " ") + ":00";
                appointmentDateTime = Timestamp.valueOf(timestampFormat);
            } catch (Exception e) {
                session.setAttribute("errorMessage", "Invalid appointment date and time format.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Validate appointment is in the future
            if (!BookAppointmentValidate.isFutureDateTime(appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointment must be scheduled for a future date and time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Validate working hours (7AM-4:30PM)
            if (!BookAppointmentValidate.isWithinWorkingHours(appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointments are only available between 7:00 AM and 4:30 PM.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Validate 24-hour advance booking
            if (!BookAppointmentValidate.isAtLeast24HoursInAdvance(appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointments must be booked at least 24 hours in advance.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Validate within 30 days limit
            if (!BookAppointmentValidate.isWithin30Days(appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointments can only be booked up to 30 days in advance.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Validate note length
            if (!BookAppointmentValidate.isValidNoteLength(note)) {
                session.setAttribute("errorMessage", "Note is too long. Maximum 500 characters allowed.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Check 24-hour gap with existing appointments (database-dependent validation)
            if (!appointmentDAO.isValidAppointmentTimeGap(patient.getPatientID(), appointmentDateTime)) {
                session.setAttribute("errorMessage", "You must wait at least 24 hours between appointments. Please choose a different time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Check if doctor is available at the requested time (no conflicting appointments)
            if (!appointmentDAO.isDoctorAvailable(doctorId, appointmentDateTime)) {
                session.setAttribute("errorMessage", "This time slot is already booked by another patient. Please choose a different time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Check 30-minute gap between doctor's appointments on the same day
            if (!appointmentDAO.hasValid30MinuteGap(doctorId, appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointments must be at least 30 minutes apart. Please choose a different time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Book appointment
            boolean success = appointmentDAO.bookAppointment(patient.getPatientID(), doctorId, note, appointmentDateTime);

            if (success) {
                session.setAttribute("successMessage", "Appointment booked successfully! Your appointment is pending approval.");
            } else {
                session.setAttribute("errorMessage", "Failed to book appointment. Please try again.");
            }

            // Redirect back to appointments list
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);

        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred while booking appointment!");
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
        }
    }

    @Override
    public String getServletInfo() {
        return "Manage My Appointment Controller";
    }
}
