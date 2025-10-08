/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.DoctorDAO;
import model.Doctor;
import java.util.List;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorListController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DoctorListController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoctorListController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DoctorDAO doctorDAO = new DoctorDAO();

            // Get search and filter parameters
            String searchName = request.getParameter("searchName");
            String specialtyParam = request.getParameter("specialty");
            String experienceParam = request.getParameter("minExperience");

            // Parse parameters
            Integer specialtyId = null;
            Integer minExperience = null;

            if (specialtyParam != null && !specialtyParam.isEmpty()) {
                try {
                    specialtyId = Integer.parseInt(specialtyParam);
                } catch (NumberFormatException e) {
                    // Ignore invalid input
                }
            }

            if (experienceParam != null && !experienceParam.isEmpty()) {
                try {
                    minExperience = Integer.parseInt(experienceParam);
                } catch (NumberFormatException e) {
                    // Ignore invalid input
                }
            }

            List<Doctor> doctors;

            // Check if any search/filter criteria is provided
            boolean hasSearchCriteria = (searchName != null && !searchName.trim().isEmpty())
                    || specialtyId != null || minExperience != null;

            if (hasSearchCriteria) {
                // Use search method - always filter to only Available doctors (JobStatusID = 1)
                doctors = doctorDAO.searchDoctors(searchName, specialtyId, 1, minExperience);
            } else {
                // Get only available doctors
                doctors = doctorDAO.getAvailableDoctors();
            }

            // Set avatar path for each doctor
            for (Doctor doctor : doctors) {
                if (doctor.getAvatar() != null && !doctor.getAvatar().isEmpty()) {
                    // If avatar path exists in DB, use it
                    if (!doctor.getAvatar().startsWith("assests/")) {
                        doctor.setAvatar("assests/img/" + doctor.getAvatar());
                    }
                } else {
                    // If no avatar, use default image 0.png
                    doctor.setAvatar("assests/img/0.png");
                }
            }

            // Get all specialties for dropdown filter
            List<String[]> specialties = doctorDAO.getAllSpecialties();

            // Set attributes for JSP
            request.setAttribute("doctors", doctors);
            request.setAttribute("totalDoctors", doctors.size());
            request.setAttribute("specialties", specialties);

            // Keep search parameters to maintain state
            request.setAttribute("searchName", searchName);
            request.setAttribute("selectedSpecialty", specialtyParam);
            request.setAttribute("minExperience", experienceParam);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading doctor list: " + e.getMessage());
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/DoctorList.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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
        return "Short description";
    }// </editor-fold>

}
