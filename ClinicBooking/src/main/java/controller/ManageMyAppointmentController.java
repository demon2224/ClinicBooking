/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AppointmentDAO;
import model.Appointment;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 * Manage My Appointment Controller
 *
 * @author Le Anh Tuan - CE180905
 */
public class ManageMyAppointmentController extends HttpServlet {

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
    }

    /**
     * Handles GET requests - Display appointments with search functionality
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Hardcoded UserID for Long Pham (UserID = 14)
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user.getUserID();

        // Get search parameters
        String searchQuery = request.getParameter("search");
        String statusFilter = request.getParameter("status");

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
        request.getRequestDispatcher("/WEB-INF/ManageMyAppointment.jsp").forward(request, response);
    }

    /**
     * Handles POST requests - Process cancel appointment
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("cancel".equals(action)) {
            handleCancelAppointment(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
    }

    /**
     * Handle appointment cancellation - Only allow cancelling pending
     * appointments
     */
    private void handleCancelAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

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
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid appointment ID!");
        }

        // Redirect back to appointments list
        response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
    }

    @Override
    public String getServletInfo() {
        return "Manage My Appointment Controller";
    }
}
