/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AppointmentDAO;
import dao.UserDAO;
import model.Appointment;
import java.io.IOException;
import java.util.List;
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

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        userDAO = new UserDAO();
    }

    /**
     * Handles GET requests - Display appointments list or appointment detail
     *
     * @param request
     * @param response
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if this is a request for appointment detail
        String appointmentIdParam = request.getParameter("id");

        if (appointmentIdParam != null && !appointmentIdParam.trim().isEmpty()) {
            // Handle appointment detail view
            handleAppointmentDetail(request, response, appointmentIdParam);
            return;
        }

        // Handle appointments list view
        handleAppointmentsList(request, response);
    }

    /**
     * Handles POST requests - Process actions (cancel, etc.)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
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

    @Override
    public String getServletInfo() {
        return "Manage My Appointment Controller";
    }
}
