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
 * My Appointment Detail Controller - Display appointment details only
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

        // Redirect to appointments list if no ID provided
        if (appointmentIdParam == null || appointmentIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(appointmentIdParam);

            // Get appointment details
            Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);

            // Redirect if appointment not found
            if (appointment == null) {
                response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
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
            request.getRequestDispatcher("/WEB-INF/MyAppointmentDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Redirect if ID is not a valid number
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
        } catch (Exception e) {
            // Redirect on any other error
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
        }
    }

    /**
     * Handles POST requests - processes form actions and redirects back to current page
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appointmentIdParam = request.getParameter("appointmentId");
        String action = request.getParameter("action");

        // If no appointment ID, redirect to appointments list
        if (appointmentIdParam == null || appointmentIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(appointmentIdParam);

            // Process actions here if needed (currently no actions implemented)
            // Example: case "someAction": processAction(); break;

            // Always redirect back to current appointment detail page
            response.sendRedirect(request.getContextPath() + "/my-appointment-detail?id=" + appointmentId);

        } catch (NumberFormatException e) {
            // If invalid ID, redirect to appointments list
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
        }
    }

    @Override
    public String getServletInfo() {
        return "My Appointment Detail Controller";
    }
}
