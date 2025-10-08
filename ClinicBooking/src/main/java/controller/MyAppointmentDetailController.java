/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AppointmentDAO;
import dao.UserDAO;
import model.Appointment;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * My Appointment Detail Controller
 *
 * @author Le Anh Tuan - CE180905
 */
public class MyAppointmentDetailController extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        userDAO = new UserDAO();
    }

    /**
     * Handles the HTTP GET method to display appointment details
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appointmentIdParam = request.getParameter("id");

        if (appointmentIdParam == null || appointmentIdParam.trim().isEmpty()) {
            // No appointment ID provided, redirect to manage appointments
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(appointmentIdParam);

            // Get appointment details
            Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);

            if (appointment == null) {
                request.setAttribute("errorMessage", "Appointment not found!");
                request.getRequestDispatcher("/WEB-INF/error/404.jsp").forward(request, response);
                return;
            }

            // Get patient information
            User patient = userDAO.getUserById(appointment.getUserID());

            // Get doctor information
            User doctor = userDAO.getUserById(appointment.getDoctorID());

            // Set attributes for JSP
            request.setAttribute("appointment", appointment);
            request.setAttribute("patient", patient);
            request.setAttribute("doctor", doctor);

            // Forward to detail page
            request.getRequestDispatcher("/WEB-INF/MyAppointmentDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid appointment ID!");
            request.getRequestDispatcher("/WEB-INF/error/404.jsp").forward(request, response);
        }
    }

    /**
     * Handles POST requests for appointment actions (cancel, reschedule, etc.)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String appointmentIdParam = request.getParameter("appointmentId");

        if (appointmentIdParam == null || action == null) {
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(appointmentIdParam);

            switch (action) {
                case "cancel":
                    handleCancelAppointment(appointmentId, request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/my-appointment-detail?id=" + appointmentId);
                    break;
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid appointment ID!");
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
        }
    }

    /**
     * Handle appointment cancellation
     */
    private void handleCancelAppointment(int appointmentId, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean success = appointmentDAO.cancelAppointment(appointmentId);

        if (success) {
            request.getSession().setAttribute("successMessage", "Appointment cancelled successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to cancel appointment!");
        }

        response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
    }

    @Override
    public String getServletInfo() {
        return "My Appointment Detail Controller";
    }
}
