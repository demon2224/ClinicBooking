/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DoctorDAO;
import dao.PatientDAO;
import dao.AppointmentDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DoctorDTO;
import model.PatientDTO;

/**
 * Home Page Controller - Handles homepage display with doctors list and
 * statistics
 *
 * @author Le Anh Tuan - CE180905
 */
public class HomePageController extends HttpServlet {

    private DoctorDAO doctorDAO;
    private PatientDAO patientDAO;
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        doctorDAO = new DoctorDAO();
        patientDAO = new PatientDAO();
        appointmentDAO = new AppointmentDAO();
    }

    /**
     * Handles GET requests - Display homepage with featured doctors
     *
     * @param request
     * @param response
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Handle homepage display
        handleHomepageDisplay(request, response);
    }

    /**
     * Handles POST requests - Handle homepage actions like search or quick
     * booking
     *
     * @param request
     * @param response
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("clearMessages".equals(action)) {
            // Clear session messages
            HttpSession session = request.getSession();
            session.removeAttribute("successMessage");
            session.removeAttribute("errorMessage");
            response.setStatus(HttpServletResponse.SC_OK);
            return;
        } else if ("search".equals(action)) {
            handleDoctorSearch(request, response);
        } else if ("quickBook".equals(action)) {
            handleQuickBooking(request, response);
        } else {
            // Default to homepage display
            handleHomepageDisplay(request, response);
        }
    }

    /**
     * Handle homepage display with featured doctors and statistics
     */
    private void handleHomepageDisplay(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get top 5 doctors with most appointments for homepage display
            List<DoctorDTO> featuredDoctors = doctorDAO.getTop5DoctorsByAppointmentCount();

            // If less than 5 doctors or none found, fallback to available doctors
            if (featuredDoctors.size() < 5) {
                List<DoctorDTO> availableDoctors = doctorDAO.getAvailableDoctors();

                // Add available doctors to fill up to 6 total
                for (DoctorDTO doctor : availableDoctors) {

                    boolean alreadyExists = false;
                    for (DoctorDTO fd : featuredDoctors) {
                        if (fd.getDoctorID() == doctor.getDoctorID()) {
                            alreadyExists = true;
                            break;
                        }
                    }

                    if (!alreadyExists && featuredDoctors.size() < 5) {
                        featuredDoctors.add(doctor);
                    }

                    if (featuredDoctors.size() >= 5) {
                        break;
                    }
                }

            }

            // Get ratings for each doctor following ManageMyAppointment pattern
            Map<Integer, Double> doctorRatings = new HashMap<>();
            for (DoctorDTO doctor : featuredDoctors) {
                double rating = doctorDAO.getAverageRatingByDoctorId(doctor.getDoctorID());
                doctorRatings.put(doctor.getDoctorID(), rating);
            }

            // Get next available appointment time (for demo purposes)
            String nextAvailableTime = getNextAvailableTime();

            // Set attributes for JSP
            request.setAttribute("featuredDoctors", featuredDoctors);
            request.setAttribute("doctorRatings", doctorRatings);
            request.setAttribute("nextAvailableTime", nextAvailableTime);
            // Forward to homepage
            request.getRequestDispatcher("/WEB-INF/HomePage.jsp").forward(request, response);

        } catch (Exception e) {
            // Log error and show generic homepage
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to load homepage data. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/HomePage.jsp").forward(request, response);
        }
    }

    /**
     * Handle doctor search from homepage
     */
    private void handleDoctorSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String searchQuery = request.getParameter("search");

            List<DoctorDTO> searchResults;

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                // Use searchDoctors method from DoctorDAO
                searchResults = doctorDAO.searchDoctors(searchQuery, null);
            } else {
                // No search criteria, show all available doctors
                searchResults = doctorDAO.getAvailableDoctors();
            }

            // Get ratings for search results following ManageMyAppointment pattern
            Map<Integer, Double> searchRatings = new HashMap<>();
            for (DoctorDTO doctor : searchResults) {
                double rating = doctorDAO.getAverageRatingByDoctorId(doctor.getDoctorID());
                searchRatings.put(doctor.getDoctorID(), rating);
            }

            // Set attributes for search results
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("searchRatings", searchRatings);
            request.setAttribute("searchQuery", searchQuery);

            // Forward to homepage with search results
            request.setAttribute("showSearchResults", true);
            handleHomepageDisplay(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Search failed. Please try again.");
            handleHomepageDisplay(request, response);
        }
    }

    /**
     * Handle quick booking from homepage
     */
    private void handleQuickBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if patient is logged in
        HttpSession session = request.getSession(false);
        PatientDTO patient = null;
        if (session != null) {
            patient = (PatientDTO) session.getAttribute("patient");
        }

        if (patient == null) {
            session.setAttribute("errorMessage", "Please log in to book an appointment.");
            response.sendRedirect(request.getContextPath() + "/patient-login");
            return;
        }

        try {
            String doctorIdParam = request.getParameter("doctorId");

            if (doctorIdParam != null && !doctorIdParam.trim().isEmpty()) {
                int doctorId = Integer.parseInt(doctorIdParam);
                // Redirect to booking page with doctor pre-selected
                response.sendRedirect(request.getContextPath() + "/book-appointment?doctorId=" + doctorId);
            } else {
                // Redirect to general booking page
                response.sendRedirect(request.getContextPath() + "/book-appointment");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid doctor selection.");
            handleHomepageDisplay(request, response);
        }
    }

    /**
     * Get next available appointment time (demo implementation) In real
     * application, this would check actual doctor availability
     */
    private String getNextAvailableTime() {
        // Simple demo logic - could be enhanced to check real availability
        java.time.LocalTime now = java.time.LocalTime.now();
        java.time.LocalTime nextSlot;

        if (now.isBefore(java.time.LocalTime.of(9, 0))) {
            nextSlot = java.time.LocalTime.of(9, 0);
        } else if (now.isBefore(java.time.LocalTime.of(14, 30))) {
            nextSlot = java.time.LocalTime.of(14, 30);
        } else {
            // Next day morning
            return "Tomorrow 9:00 AM";
        }

        return "Today " + nextSlot.toString();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Home Page Controller";
    }
}
