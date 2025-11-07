/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DoctorDAO;
import dao.PatientDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DoctorDTO;
import model.PatientDTO;

/**
 *
 * @author Le Anh Tuan - CE180905
 */
public class HomePageController extends HttpServlet {

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
//        PatientDTO patient = ((new PatientDAO()).getPatientById(1)); // Get first patient for demo
        DoctorDTO doctor = ((new DoctorDAO()).getDoctorById(1));
        if ((session != null) && (doctor != null)) {
//        if ((session != null) && (patient != null)) {
//            session.setAttribute("patient", patient); // Changed from "user" to "patient"
            session.setAttribute("doctor", doctor);
        }

        // Since Patient table doesn't have RoleID, redirect to patient homepage
        // Remove role-based redirects as patients don't have roles
        // Forward to Homepage.jsp
        request.getRequestDispatcher("/WEB-INF/doctor/DoctorDashboard.jsp").forward(request, response);
//        request.getRequestDispatcher("/WEB-INF/HomePage.jsp").forward(request, response);

//        // Using for test patient login.
//        HttpSession session = request.getSession();
//        PatientDTO patient = (PatientDTO) session.getAttribute("patient");
//
//        if (patient != null) {
//            request.getRequestDispatcher("/WEB-INF/HomePage.jsp").forward(request, response);
//        } else {
//            response.sendRedirect(request.getContextPath() + "/patient-login");
//        }
//
//        // Using for test staff login.
//        response.sendRedirect(request.getContextPath() + "/staff-login");
    }

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
        return "Home Page Controller";
    }// </editor-fold>

}
