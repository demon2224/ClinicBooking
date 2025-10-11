/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constants.DoctorListConstants;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.DoctorDAO;
import model.Doctor;
import java.net.URLEncoder;
import java.util.List;

/**
 * Controller for Doctor List page Handles search and filter functionality for doctors
 * Implements PRG (Post-Redirect-Get) pattern for form submissions
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorListController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
        try {
            DoctorDAO doctorDAO = new DoctorDAO();

            // Get search and filter parameters from request
            String searchName = request.getParameter("searchName");
            String specialtyNameParam = request.getParameter("specialty");
            String experienceParam = request.getParameter("minExperience");

            // Parse and validate parameters
            String selectedSpecialtyName = null;
            Integer minExperience = null;

            // Process specialty name
            if (specialtyNameParam != null && !specialtyNameParam.trim().isEmpty()) {
                selectedSpecialtyName = specialtyNameParam.trim();
            }

            // Process minimum experience
            if (experienceParam != null && !experienceParam.trim().isEmpty()) {
                try {
                    minExperience = Integer.parseInt(experienceParam.trim());
                    // Validate experience range using constants
                    if (minExperience < DoctorListConstants.MIN_EXPERIENCE_YEARS
                            || minExperience > DoctorListConstants.MAX_EXPERIENCE_YEARS) {
                        minExperience = null; // Invalid range, ignore
                    }
                } catch (NumberFormatException e) {
                    // Ignore invalid numeric input
                }
            }

            List<Doctor> doctors;

            // Determine search strategy based on criteria
            boolean hasSearchCriteria = (searchName != null && !searchName.trim().isEmpty())
                    || selectedSpecialtyName != null || minExperience != null;

            if (hasSearchCriteria) {
                // Execute search with criteria - filter only Available doctors
                // Now using specialty name directly instead of converting to ID
                doctors = doctorDAO.searchDoctors(searchName, selectedSpecialtyName, 1, minExperience);
            } else {
                // No criteria provided - get all available doctors
                doctors = doctorDAO.getAvailableDoctors();
            }

            // Process doctor avatars - ensure proper image paths
            processDoctorAvatars(doctors);

            // Get all specialties for dropdown filter
            List<String[]> specialties = doctorDAO.getAllSpecialties();

            // Set attributes for JSP
            request.setAttribute("doctors", doctors);
            request.setAttribute("totalDoctors", doctors.size());
            request.setAttribute("specialties", specialties);

            // Maintain search state for form persistence
            request.setAttribute("searchName", searchName);
            request.setAttribute("selectedSpecialty", selectedSpecialtyName);
            request.setAttribute("minExperience", experienceParam);

        } catch (Exception e) {
            request.setAttribute("errorMessage", DoctorListConstants.ERROR_LOADING_DOCTORS_MSG + e.getMessage());
            e.printStackTrace();
        }

        request.getRequestDispatcher(DoctorListConstants.DOCTOR_LIST_JSP).forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method. Process search form and redirect to
     * prevent form resubmission.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Extract form parameters from POST request
            String searchName = request.getParameter("searchName");
            String specialtyName = request.getParameter("specialty");
            String experienceParam = request.getParameter("minExperience");

            // Build redirect URL for PRG pattern
            String redirectUrl = buildRedirectUrl(request.getContextPath(), searchName, specialtyName, experienceParam);

            // Execute redirect to GET request (Post-Redirect-Get pattern)
            response.sendRedirect(redirectUrl);

        } catch (Exception e) {
            // Fallback: redirect to clean doctor list page on any error
            response.sendRedirect(request.getContextPath() + DoctorListConstants.DOCTOR_LIST_URL);
        }
    }

    /**
     * Process doctor avatar paths to ensure proper image display
     *
     * @param doctors List of doctors to process
     */
    private void processDoctorAvatars(List<Doctor> doctors) {
        for (Doctor doctor : doctors) {
            String avatar = doctor.getAvatar();

            if (avatar != null && !avatar.trim().isEmpty()) {
                // Ensure avatar has full path if it doesn't already
                if (!avatar.startsWith(DoctorListConstants.AVATAR_PATH_PREFIX)) {
                    doctor.setAvatar(DoctorListConstants.AVATAR_BASE_PATH + avatar);
                }
            } else {
                // Set default avatar for doctors without image
                doctor.setAvatar(DoctorListConstants.DEFAULT_AVATAR);
            }
        }
    }

    /**
     * Build redirect URL with search parameters for POST-Redirect-GET pattern
     *
     * @param contextPath Application context path
     * @param searchName Doctor name search term
     * @param specialtyName Specialty name filter
     * @param experienceParam Experience requirement
     * @return Complete redirect URL with parameters
     * @throws IOException if URL encoding fails
     */
    private String buildRedirectUrl(String contextPath, String searchName, String specialtyName, String experienceParam)
            throws IOException {
        StringBuilder url = new StringBuilder(contextPath + DoctorListConstants.DOCTOR_LIST_URL);
        boolean hasParams = false;

        // Add search name parameter
        if (searchName != null && !searchName.trim().isEmpty()) {
            url.append("?searchName=").append(URLEncoder.encode(searchName.trim(), DoctorListConstants.URL_ENCODING));
            hasParams = true;
        }

        // Add specialty name parameter
        if (specialtyName != null && !specialtyName.trim().isEmpty()) {
            url.append(hasParams ? "&" : "?").append("specialty=")
                    .append(URLEncoder.encode(specialtyName.trim(), DoctorListConstants.URL_ENCODING));
            hasParams = true;
        }

        // Add experience parameter (validate first)
        if (experienceParam != null && !experienceParam.trim().isEmpty()) {
            try {
                int experience = Integer.parseInt(experienceParam.trim());
                if (experience >= DoctorListConstants.MIN_EXPERIENCE_YEARS
                        && experience <= DoctorListConstants.MAX_EXPERIENCE_YEARS) {
                    url.append(hasParams ? "&" : "?").append("minExperience=").append(experience);
                }
            } catch (NumberFormatException e) {
                // Skip invalid experience parameter
            }
        }

        return url.toString();
    }

    @Override
    public String getServletInfo() {
        return "Doctor List Controller";
    }

}
