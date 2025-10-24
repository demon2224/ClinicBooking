/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constants.DoctorConstants;
import dao.DoctorDAO;
import dao.DoctorReviewDAO;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import model.Doctor;
import model.DoctorDegree;
import model.DoctorReview;
import utils.AvatarHandler;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorController extends HttpServlet {

    private DoctorDAO doctorDAO;
    private DoctorReviewDAO doctorReviewDAO;

    /**
     * Initialize all necessary DAOs
     *
     * @throws jakarta.servlet.ServletException
     */
    @Override
    public void init() throws ServletException {
        doctorDAO = new DoctorDAO();
        doctorReviewDAO = new DoctorReviewDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DoctorController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoctorController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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

        String action = request.getParameter("action");

        try {
            if (action != null && action.equals("detail")) {
                handleDoctorDetail(request, response);
            } else {
                handleDoctorList(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", DoctorConstants.ERROR_MSG + e.getMessage());
            handleDoctorList(request, response);
        }
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

        String action = request.getParameter("action");

        try {
            if (action.equals("detail")) {
                handleDoctorDetailPost(request, response);
            } else {
                handleDoctorListPost(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + DoctorConstants.DOCTOR_URL);
        }
    }

    /**
     * Handle Doctor List display (from DoctorListController logic)
     */
    private void handleDoctorList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        List<Doctor> doctors;

        // Determine search strategy based on criteria
        if (search != null && !search.trim().isEmpty()) {
            doctors = doctorDAO.searchDoctors(search, null, DoctorConstants.AVAILABLE_ID, null);
        } else {
            doctors = doctorDAO.getAvailableDoctors();
        }
        AvatarHandler.processDoctorAvatars(doctors);
        request.setAttribute("doctors", doctors);
        request.setAttribute("totalDoctors", doctors.size());
        request.setAttribute("search", search);
        request.getRequestDispatcher(DoctorConstants.DOCTOR_LIST_JSP).forward(request, response);
    }

    /**
     * Handle Doctor List POST (search form submission)
     */
    private void handleDoctorListPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String search = request.getParameter("search");
        String redirectUrl = buildRedirectUrl(request.getContextPath(), search, null, null);
        response.sendRedirect(redirectUrl);
    }

    /**
     * Handle Doctor Detail display (from DoctorDetailController logic)
     */
    private void handleDoctorDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String doctorIdParam = request.getParameter("id");
        // If doctorId parameter is missing or empty, redirect to doctor list
        if (doctorIdParam == null || doctorIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + DoctorConstants.DOCTOR_URL);
            return;
        }
        try {
            int doctorId = Integer.parseInt(doctorIdParam);
            Doctor doctor = doctorDAO.getDoctorById(doctorId);

            if (doctor == null) {
                response.sendRedirect(request.getContextPath() + DoctorConstants.DOCTOR_URL);
                return;
            }

            AvatarHandler.processSingleDoctorAvatar(doctor);

            List<DoctorDegree> degrees = doctorDAO.getDoctorDegrees(doctorId);
            List<DoctorReview> doctorReviews = doctorReviewDAO.getReviewsByDoctorId(doctorId);

            // Calculate the average rating and review count
            //double averageRating = doctorReviewDAO.getAverageRatingByDoctorId(doctorId);
            int reviewCount = doctorReviewDAO.getReviewCountByDoctorId(doctorId);

            request.setAttribute("doctor", doctor);
            request.setAttribute("degrees", degrees);
            request.setAttribute("doctorReviews", doctorReviews);
            //request.setAttribute("averageRating", averageRating);
            request.setAttribute("reviewCount", reviewCount);
            request.getRequestDispatcher(DoctorConstants.DOCTOR_DETAIL_JSP).forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + DoctorConstants.DOCTOR_URL);
        }
    }

    /**
     * Handle Doctor Detail POST requests
     */
    private void handleDoctorDetailPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String doctorId = request.getParameter("id");
        String redirectUrl = buildRedirectUrl(request.getContextPath(), null, "detail", doctorId);
        response.sendRedirect(redirectUrl);
    }

    /**
     * Build redirect URL with parameters for POST-Redirect-GET pattern
     *
     * @param contextPath Application context path
     * @param search Doctor name search term (for list view)
     * @param action Action parameter (for detail view)
     * @param doctorId Doctor ID (for detail view)
     * @return Complete redirect URL with parameters
     */
    private String buildRedirectUrl(String contextPath, String search, String action, String doctorId)
            throws IOException {

        StringBuilder url = new StringBuilder(contextPath + DoctorConstants.DOCTOR_URL);
        boolean hasParams = false;

        // Add action parameter for detail view
        if (action != null && !action.trim().isEmpty()) {
            url.append("?action=").append(URLEncoder.encode(action.trim(), DoctorConstants.URL_ENCODING));
            hasParams = true;
        }
        // Add doctor ID for detail view
        if (doctorId != null && !doctorId.trim().isEmpty()) {
            url.append(hasParams ? "&" : "?");
            url.append("id=").append(URLEncoder.encode(doctorId.trim(), DoctorConstants.URL_ENCODING));
            hasParams = true;
        }
        // Add search parameter for list view
        if (search != null && !search.trim().isEmpty()) {
            url.append(hasParams ? "&" : "?");
            url.append("search=").append(URLEncoder.encode(search.trim(), DoctorConstants.URL_ENCODING));
        }
        return url.toString();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Doctor Controller - Handles doctor list, search doctors and detail views";
    }// </editor-fold>
}
