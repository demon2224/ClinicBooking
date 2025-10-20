/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AppointmentDAO;
import dao.UserDAO;
import dao.DoctorDAO;
import model.Appointment;
import model.Doctor;
import java.io.IOException;
import java.util.List;
import java.sql.Timestamp;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import constants.ManageMyAppointmentConstans;
import validate.BookAppointmentValidate;
import validate.CancelAppointmentValidate;

/**
 * Controller for viewing and managing user's appointments (list, detail,
 * cancel).
 *
 * @author Le Anh Tuan - CE180905
 */
public class ManageMyAppointmentController extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private UserDAO userDAO;
    private DoctorDAO doctorDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        userDAO = new UserDAO();
        doctorDAO = new DoctorDAO();
    }

    /**
     * Handles GET requests - Display appointments list, appointment detail, or book appointment form
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
            // Validate appointment ID parameter using CancelAppointmentValidate
            CancelAppointmentValidate.ValidationResult paramValidation = 
                CancelAppointmentValidate.validateAppointmentIdParameter(appointmentIdParam);
            
            if (!paramValidation.isValid()) {
                request.getSession().setAttribute("errorMessage", paramValidation.getAllErrorMessages());
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }
            
            try {
                int appointmentId = Integer.parseInt(appointmentIdParam);
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
            Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);

            // Redirect if appointment not found
            if (appointment == null) {
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }

            // Get patient and doctor information
            User patient = userDAO.getUserById(appointment.getUserID());
            User doctor = userDAO.getUserById(appointment.getDoctorID());

            // Set attributes for JSP
            request.setAttribute("appointment", appointment);
            request.setAttribute("patient", patient);
            request.setAttribute("doctor", doctor);

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

        // Hardcoded UserID for Long Pham (UserID = 14)
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user.getUserID();

        // Get search parameters
        String searchQuery = request.getParameter("search");
        List<Appointment> appointments;

        // Apply search
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            appointments = appointmentDAO.searchAppointmentsByUserId(userId, searchQuery);
        } else {
            appointments = appointmentDAO.getAppointmentsByUserId(userId);
        }

        // Set attributes for JSP
        request.setAttribute("appointments", appointments);
        request.setAttribute("searchQuery", searchQuery);

        // Forward to JSP
        request.getRequestDispatcher(ManageMyAppointmentConstans.LIST_PAGE_JSP).forward(request, response);
    }

    /**
     * Handle appointment cancellation - Only allow cancelling pending appointments
     */
    private void handleCancelAppointment(HttpServletRequest request, HttpServletResponse response, int appointmentId)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            // Get appointment from database
            Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);
            
            // Validate using CancelAppointmentValidate class
            CancelAppointmentValidate.ValidationResult validationResult = 
                CancelAppointmentValidate.validateCancelAppointmentWithUser(
                    String.valueOf(appointmentId), appointment, user);
            
            if (!validationResult.isValid()) {
                session.setAttribute("errorMessage", validationResult.getAllErrorMessages());
            } else {
                // Attempt to cancel appointment
                boolean success = appointmentDAO.cancelMyAppointment(appointmentId);
                
                if (success) {
                    session.setAttribute("successMessage", "Appointment cancelled successfully!");
                } else {
                    session.setAttribute("errorMessage", "Failed to cancel appointment. Please try again.");
                }
            }
            
        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred while cancelling appointment!");
        }

        // Redirect back to appointments list
        response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
    }
    
    /**
     * Check if user has any appointments within 24 hours of the requested time
     * This method handles gap validation directly in controller
     * 
     * @param userId User's ID
     * @param requestedDateTime Requested appointment date time
     * @return true if 24-hour gap is maintained, false otherwise
     */
    private boolean isValidAppointmentGap(int userId, Timestamp requestedDateTime) {
        try {
            // Query to check for appointments within 24 hours before or after requested time
            String sql = "SELECT COUNT(*) as count FROM Appointment " +
                        "WHERE UserID = ? AND AppointmentStatusID IN (1, 2) " +
                        "AND ABS(DATEDIFF(HOUR, DateBegin, ?)) < 24";
            
            java.sql.ResultSet rs = null;
            try {
                Object[] params = {userId, requestedDateTime};
                rs = appointmentDAO.executeSelectQuery(sql, params);
                
                if (rs.next()) {
                    int count = rs.getInt("count");
                    return count == 0; // Return true if no conflicts found
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                appointmentDAO.closeResources(rs);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Default to false (not valid) if any error occurs
        return false;
    }
    
    /**
     * Enhanced book appointment with gap validation handled in controller
     */
    private void handleBookAppointmentWithGapValidation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            String doctorIdParam = request.getParameter("doctorId");
            String appointmentDateTimeParam = request.getParameter("appointmentDateTime");
            String note = request.getParameter("note");
            
            // Basic validation using BookAppointmentValidate class (without gap validation)
            BookAppointmentValidate.ValidationResultWithData<BookAppointmentValidate.BookingData> validationResult = 
                BookAppointmentValidate.validateCompleteBookingWithRequest(user, doctorIdParam, 
                    appointmentDateTimeParam, note, null);
            
            if (!validationResult.isValid()) {
                session.setAttribute("errorMessage", validationResult.getAllErrorMessages());
                if (doctorIdParam != null && !doctorIdParam.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorIdParam);
                } else {
                    response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                }
                return;
            }
            
            // Get validated booking data
            BookAppointmentValidate.BookingData bookingData = validationResult.getData();
            
            // Controller-level gap validation
            if (!isValidAppointmentGap(bookingData.userId, bookingData.appointmentDateTime)) {
                session.setAttribute("errorMessage", "You must wait at least 24 hours between appointments. Please choose a different time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + bookingData.doctorId);
                return;
            }
            
            // Book appointment
            boolean success = appointmentDAO.bookAppointment(bookingData.userId, bookingData.doctorId, 
                bookingData.note, bookingData.appointmentDateTime);
            
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

    /**
     * Handle book appointment form display
     */
    private void handleBookAppointmentForm(HttpServletRequest request, HttpServletResponse response, String doctorIdParam)
            throws ServletException, IOException {
        try {
            int doctorId = Integer.parseInt(doctorIdParam);
            
            // Get doctor information
            Doctor doctor = doctorDAO.getDoctorById(doctorId);
            
            if (doctor == null) {
                request.getSession().setAttribute("errorMessage", "Doctor not found!");
                response.sendRedirect(request.getContextPath() + "/doctor-list");
                return;
            }
            
            // Set attributes for JSP
            request.setAttribute("doctor", doctor);
            request.setAttribute("doctorId", doctorId);
            
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
        User user = (User) session.getAttribute("user");
        
        try {
            String doctorIdParam = request.getParameter("doctorId");
            String appointmentDateTimeParam = request.getParameter("appointmentDateTime");
            String note = request.getParameter("note");
            
            // Basic validation using BookAppointmentValidate class (without gap validation)
            BookAppointmentValidate.ValidationResultWithData<BookAppointmentValidate.BookingData> validationResult = 
                BookAppointmentValidate.validateCompleteBookingWithRequest(user, doctorIdParam, 
                    appointmentDateTimeParam, note, null);
            
            if (!validationResult.isValid()) {
                session.setAttribute("errorMessage", validationResult.getAllErrorMessages());
                if (doctorIdParam != null && !doctorIdParam.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorIdParam);
                } else {
                    response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                }
                return;
            }
            
            // Get validated booking data
            BookAppointmentValidate.BookingData bookingData = validationResult.getData();
            
            // Controller-level gap validation (24-hour rule)
            if (!isValidAppointmentGap(bookingData.userId, bookingData.appointmentDateTime)) {
                session.setAttribute("errorMessage", "You must wait at least 24 hours between appointments. Please choose a different time.");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + bookingData.doctorId);
                return;
            }
            
            // Book appointment
            boolean success = appointmentDAO.bookAppointment(bookingData.userId, bookingData.doctorId, 
                bookingData.note, bookingData.appointmentDateTime);
            
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
