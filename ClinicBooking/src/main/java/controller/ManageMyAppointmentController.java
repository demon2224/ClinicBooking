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
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        int userId = ((User) request.getSession().getAttribute("user")).getUserID();
        if ("cancel".equals(action)) {
            handleCancelAppointment(request, response);
            return;
        }

        // Get appointments for specific user (Long Pham)
        List<Appointment> appointments = appointmentDAO.getAppointmentsByUserId(userId);

        User user = ((User) request.getSession().getAttribute("user"));
        // Set attributes for JSP
        request.setAttribute("appointments", appointments);
        request.setAttribute("userId", userId);
        request.setAttribute("userName", user.getAccountName());

        // Forward to ManageMyAppointment.jsp
        request.getRequestDispatcher("/WEB-INF/ManageMyAppointment.jsp").forward(request, response);
    }

    private void handleCancelAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            boolean success = appointmentDAO.cancelAppointment(appointmentId);

            if (success) {
                request.setAttribute("message", "Appointment cancelled successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to cancel appointment!");
                request.setAttribute("messageType", "error");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid appointment ID!");
            request.setAttribute("messageType", "error");
        }

        // Redirect back to appointments list
        response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Manage My Appointment Controller";
    }// </editor-fold>

}
