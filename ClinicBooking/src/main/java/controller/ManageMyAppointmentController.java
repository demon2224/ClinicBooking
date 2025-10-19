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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import constants.ManageMyAppointmentConstans;

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

        // If no appointment ID, redirect to appointments list
        if (appointmentIdParam == null || appointmentIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
            return;
        }

        try {
            int appointmentId = Integer.parseInt(appointmentIdParam);

            if ("cancel".equals(action)) {
                handleCancelAppointment(request, response, appointmentId);
                return;
            }

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
     * Handle appointment cancellation - Only allow cancelling pending
     * appointments
     */
    private void handleCancelAppointment(HttpServletRequest request, HttpServletResponse response, int appointmentId)
            throws ServletException, IOException {
        try {
            // Check if appointment can be cancelled (only pending status = 1)
            Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);

            if (appointment == null) {
                request.getSession().setAttribute("errorMessage", "Appointment not found!");
            } else if (appointment.getAppointmentStatusID() != 1) {
                request.getSession().setAttribute("errorMessage", "Only pending appointments can be cancelled!");
            } else {
                boolean success = appointmentDAO.cancelMyAppointment(appointmentId);

                if (success) {
                    request.getSession().setAttribute("successMessage", "Appointment cancelled successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to cancel appointment!");
                }
            }
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error cancelling appointment!");
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
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            String doctorIdParam = request.getParameter("doctorId");
            String appointmentDateTimeParam = request.getParameter("appointmentDateTime");
            String note = request.getParameter("note");
            
            if (doctorIdParam == null || appointmentDateTimeParam == null) {
                session.setAttribute("errorMessage", "Missing required information!");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
                return;
            }
            
            int doctorId = Integer.parseInt(doctorIdParam);
            
            // Parse datetime
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date parsedDate = dateFormat.parse(appointmentDateTimeParam);
            Timestamp appointmentDateTime = new Timestamp(parsedDate.getTime());
            
            // Check if appointment time is in the future
            if (appointmentDateTime.before(new Timestamp(System.currentTimeMillis()))) {
                session.setAttribute("errorMessage", "Appointment time must be in the future!");
                response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL + "?action=bookAppointment&doctorId=" + doctorId);
                return;
            }
            
            // Book appointment
            boolean success = appointmentDAO.bookAppointment(user.getUserID(), doctorId, note, appointmentDateTime);
            
            if (success) {
                session.setAttribute("successMessage", "Appointment booked successfully! Your appointment is pending approval.");
            } else {
                session.setAttribute("errorMessage", "Failed to book appointment. Please try again.");
            }
            
            // Redirect back to appointments list
            response.sendRedirect(request.getContextPath() + ManageMyAppointmentConstans.BASE_URL);
            
        } catch (NumberFormatException | ParseException e) {
            session.setAttribute("errorMessage", "Invalid input data!");
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
