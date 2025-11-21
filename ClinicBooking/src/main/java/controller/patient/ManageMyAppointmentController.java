/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.patient;

import dao.AppointmentDAO;
import dao.DoctorDAO;
import validate.BookAppointmentValidate;
import model.AppointmentDTO;
import model.DoctorDTO;
import model.PatientDTO;
import constants.ManageMyAppointmentConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.sql.Timestamp;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for viewing and managing patient's appointments (list, detail, book).
 *
 * @author Le Anh Tuan - CE180905
 */
public class ManageMyAppointmentController extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private DoctorDAO doctorDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
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
        //Check session login
        HttpSession session = request.getSession();
        PatientDTO sessionPatient = (PatientDTO) session.getAttribute("patient");

        if (sessionPatient == null) {
            session.setAttribute("errorMessage", "Your session has expired. Please log in again.");
            response.sendRedirect(request.getContextPath() + "/patient-login");
            return;
        }

        String action = request.getParameter("action");
        String appointmentIdParam = request.getParameter("id");
        String doctorIdParam = request.getParameter("doctorId");

        // API endpoint: Get time slots status (booked + validation) - Single optimized request
        if ("getTimeSlotsStatus".equals(action)) {
            handleGetTimeSlotsStatus(request, response);
            return;
        }

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
     * Handles POST requests - Process book appointment action
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("bookAppointment".equals(action)) {
            handleBookAppointment(request, response);
            return;
        }

        // If action is not recognized, redirect to appointments list
        response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL);
    }

    /**
     * Handle appointment detail view
     */
    private void handleAppointmentDetail(HttpServletRequest request, HttpServletResponse response, String appointmentIdParam)
            throws ServletException, IOException {

        try {
            // Get patient from session (already validated in doGet)
            HttpSession session = request.getSession();
            PatientDTO sessionPatient = (PatientDTO) session.getAttribute("patient");

            int appointmentId = Integer.parseInt(appointmentIdParam);

            // Get appointment details
            AppointmentDTO appointment = appointmentDAO.getAppointmentById(appointmentId);

            // Redirect if appointment not found
            if (appointment == null) {
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL);
                return;
            }

            // Verify this appointment belongs to the logged-in patient
            if (appointment.getPatientID() == null
                    || appointment.getPatientID().getPatientID() != sessionPatient.getPatientID()
                    || appointment.getDoctorID() == null) {
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL);
                return;
            }

            // Doctor information
            DoctorDTO doctor = doctorDAO.getDoctorById(appointment.getDoctorID().getDoctorID());

            // Get doctor's average rating
            double averageRating = doctorDAO.getAverageRatingByDoctorId(appointment.getDoctorID().getDoctorID());

            // Set attributes for JSP
            request.setAttribute("appointment", appointment);
            request.setAttribute("doctor", doctor);
            request.setAttribute("averageRating", averageRating);

            // Forward to detail page
            request.getRequestDispatcher(ManageMyAppointmentConstants.DETAIL_PAGE_JSP).forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL);
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
        request.getRequestDispatcher(ManageMyAppointmentConstants.LIST_PAGE_JSP).forward(request, response);
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
                response.sendRedirect(request.getContextPath() + "/doctor");
                return;
            }

            // Get doctor's average rating
            double averageRating = doctorDAO.getAverageRatingByDoctorId(doctorId);

            // Set attributes for JSP
            request.setAttribute("doctor", doctor);
            request.setAttribute("doctorId", doctorId);
            request.setAttribute("averageRating", averageRating);

            // Forward to book appointment page
            request.getRequestDispatcher(ManageMyAppointmentConstants.BOOK_APPOINTMENT_JSP).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/doctor");
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
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorIdParam);
                return;
            }

            // Validate appointment date time format
            if (!BookAppointmentValidate.isValidDateTimeFormat(appointmentDateTimeParam)) {
                session.setAttribute("errorMessage", "Invalid appointment date and time format. Please use the date picker.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorIdParam);
                return;
            }

            // Parse doctor ID
            int doctorId = 0;
            try {
                doctorId = Integer.parseInt(doctorIdParam);
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "Invalid doctor selection.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL);
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
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // VALIDATE BUSINESS LOGIC (same as handleValidateTimeSlot, but adds note validation)
            // Note: These validations are duplicated but necessary for security (server-side validation)
            // 1. Past time
            if (!BookAppointmentValidate.isFutureDateTime(appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointment must be scheduled for a future date and time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // 2. Outside working hours (7:00-16:30)
            if (!BookAppointmentValidate.isWithinWorkingHours(appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointments are only available between 7:00 AM and 4:30 PM.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // 3. More than 30 days in advance
            if (!BookAppointmentValidate.isWithin30Days(appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointments can only be booked up to 30 days in advance.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // 4. Check exact time match: A doctor cannot have 2 appointments at the same time
            if (!appointmentDAO.isDoctorAvailableAtExactTime(doctorId, appointmentDateTime)) {
                session.setAttribute("errorMessage", "This time slot is already booked by another patient. Please choose a different time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // 5. 30-minute gap with doctor's other appointments
            if (!appointmentDAO.hasValid30MinuteGap(doctorId, appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointments must be at least 30 minutes apart. Please choose a different time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // 6. 24-hour gap with patient's other appointments
            if (!appointmentDAO.isValidAppointmentTimeGap(patient.getPatientID(), appointmentDateTime)) {
                session.setAttribute("errorMessage", "You must wait at least 24 hours between appointments. Please choose a different time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // 7. Must book at least 24 hours in advance
            if (!BookAppointmentValidate.isAtLeast24HoursInAdvance(appointmentDateTime)) {
                session.setAttribute("errorMessage", "Appointments must be booked at least 24 hours in advance.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // 8. Validate note length (only when submitting form)
            if (!BookAppointmentValidate.isValidNoteLength(note)) {
                session.setAttribute("errorMessage", "Note is too long. Maximum 500 characters allowed.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }

            // Redirect to consultation payment page (instead of creating appointment directly)
            String paymentUrl = request.getContextPath() + "/payment"
                    + "?type=consultation"
                    + "&doctorId=" + doctorId
                    + "&appointmentDateTime=" + appointmentDateTimeParam
                    + "&note=" + (note != null ? java.net.URLEncoder.encode(note, "UTF-8") : "");

            response.sendRedirect(paymentUrl);

        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred while booking appointment!");
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstants.BASE_URL);
        }
    }

    /**
     * ⭐ Optimized API endpoint: Get all time slots status in one request
     * Returns both booked slots and validation results for all slots
     * This replaces the need for multiple requests (getBookedTimeSlots + multiple validateTimeSlot)
     */
    private void handleGetTimeSlotsStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            HttpSession session = request.getSession();
            PatientDTO patient = (PatientDTO) session.getAttribute("patient");

            if (patient == null) {
                JsonObject error = new JsonObject();
                error.addProperty("error", "Not logged in");
                writeJsonResponse(response, error);
                return;
            }

            String doctorIdStr = request.getParameter("doctorId");
            String date = request.getParameter("date"); // Format: yyyy-MM-dd

            if (doctorIdStr == null || date == null) {
                JsonObject error = new JsonObject();
                error.addProperty("error", "Missing doctorId or date parameter");
                writeJsonResponse(response, error);
                return;
            }

            int doctorId = Integer.parseInt(doctorIdStr);

            // 1. Get booked slots
            List<String> bookedSlots = appointmentDAO.getBookedTimeSlots(doctorId, date);

            // 2. Get all time slots to validate (all slots in working hours)
            // Standard time slots: 07:00, 07:30, ..., 16:30
            String[] allTimeSlots = {
                "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
                "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30"
            };

            // 3. Validate all slots that are not already booked
            JsonObject result = new JsonObject();
            
            // Add booked slots array (normalize format to ensure consistency)
            JsonArray bookedSlotsArray = new JsonArray();
            for (String slot : bookedSlots) {
                // Normalize time format: ensure "HH:mm" format (e.g., "7:00" -> "07:00")
                String normalizedSlot = normalizeTimeFormat(slot);
                bookedSlotsArray.add(normalizedSlot);
            }
            result.add("bookedSlots", bookedSlotsArray);

            // Add validation results for all slots
            JsonObject validationResults = new JsonObject();
            for (String time : allTimeSlots) {
                String dateTimeStr = date + " " + time + ":00";
                Timestamp appointmentDateTime;
                
                try {
                    appointmentDateTime = Timestamp.valueOf(dateTimeStr);
                } catch (IllegalArgumentException e) {
                    continue; // Skip invalid time
                }

                // Skip if already booked (normalize both for comparison)
                String normalizedTime = normalizeTimeFormat(time);
                boolean isBooked = false;
                for (String bookedSlot : bookedSlots) {
                    if (normalizeTimeFormat(bookedSlot).equals(normalizedTime)) {
                        isBooked = true;
                        break;
                    }
                }
                if (isBooked) {
                    continue;
                }

                // Validate this slot
                JsonObject slotResult = new JsonObject();
                slotResult.addProperty("disabled", false);
                slotResult.addProperty("reason", "");

                // Apply all validations
                if (!BookAppointmentValidate.isFutureDateTime(appointmentDateTime)) {
                    slotResult.addProperty("disabled", true);
                    slotResult.addProperty("reason", "past");
                } else if (!BookAppointmentValidate.isWithinWorkingHours(appointmentDateTime)) {
                    slotResult.addProperty("disabled", true);
                    slotResult.addProperty("reason", "outside_working_hours");
                } else if (!BookAppointmentValidate.isWithin30Days(appointmentDateTime)) {
                    slotResult.addProperty("disabled", true);
                    slotResult.addProperty("reason", "too_far_future");
                } else if (!appointmentDAO.isDoctorAvailableAtExactTime(doctorId, appointmentDateTime)) {
                    slotResult.addProperty("disabled", true);
                    slotResult.addProperty("reason", "already_booked");
                } else if (!appointmentDAO.isValidAppointmentTimeGap(patient.getPatientID(), appointmentDateTime)) {
                    slotResult.addProperty("disabled", true);
                    slotResult.addProperty("reason", "patient_24h_gap");
                } else if (!BookAppointmentValidate.isAtLeast24HoursInAdvance(appointmentDateTime)) {
                    slotResult.addProperty("disabled", true);
                    slotResult.addProperty("reason", "less_than_24h");
                }

                // Only add if disabled (to reduce response size)
                // Use normalized time as key for consistency
                if (slotResult.get("disabled").getAsBoolean()) {
                    validationResults.add(normalizeTimeFormat(time), slotResult);
                }
            }

            result.add("validationResults", validationResults);
            writeJsonResponse(response, result);

        } catch (NumberFormatException e) {
            JsonObject error = new JsonObject();
            error.addProperty("error", "Invalid doctorId format");
            writeJsonResponse(response, error);
        } catch (Exception e) {
            System.err.println("Error in handleGetTimeSlotsStatus: " + e.getMessage());
            e.printStackTrace();
            JsonObject error = new JsonObject();
            error.addProperty("error", "Error: " + e.getMessage());
            writeJsonResponse(response, error);
        }
    }

    /**
     * Normalize time format to "HH:mm" (e.g., "7:00" -> "07:00", "14:30" -> "14:30")
     * 
     * @param time Time string in various formats
     * @return Normalized time string in "HH:mm" format
     */
    private String normalizeTimeFormat(String time) {
        if (time == null || time.trim().isEmpty()) {
            return time;
        }
        time = time.trim();
        String[] parts = time.split(":");
        if (parts.length == 2) {
            try {
                int hour = Integer.parseInt(parts[0]);
                int minute = Integer.parseInt(parts[1]);
                return String.format("%02d:%02d", hour, minute);
            } catch (NumberFormatException e) {
                return time; // Return original if parsing fails
            }
        }
        return time;
    }

    private void writeJsonResponse(HttpServletResponse response, JsonObject json) throws IOException {
        try ( PrintWriter out = response.getWriter()) {
            out.print(json.toString());
            out.flush();
        }
    }

    @Override
    public String getServletInfo() {
        return "Manage My Appointment Controller";
    }
}
