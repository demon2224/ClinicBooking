/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constants.DoctorListConstants;
import dao.DoctorDAO;
import dao.DoctorReviewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Doctor;
import model.DoctorDegree;
import model.DoctorReview;
import utils.AvatarHandler;

/**
 * Controller for Doctor Detail page
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorDetailController extends HttpServlet {

    private DoctorDAO doctorDAO;
    private DoctorReviewDAO doctorReviewDAO;

    /**
     * Initialize all the necessary DAO using in this controller.
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        doctorDAO = new DoctorDAO();
        doctorReviewDAO = new DoctorReviewDAO();
    }

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
            out.println("<title>Servlet DoctorDetailController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoctorDetailController at " + request.getContextPath() + "</h1>");
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
            String doctorIdParam = request.getParameter("id");
            // If doctorId parameter is missing or empty, redirect to doctor list page
            if (doctorIdParam == null || doctorIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + DoctorListConstants.DOCTOR_LIST_URL);
                return;
            }
            int doctorId = Integer.parseInt(doctorIdParam);
            Doctor doctor = doctorDAO.getDoctorById(doctorId);
            // If doctor is not found, redirect to doctor list page
            if (doctor == null) {
                response.sendRedirect(request.getContextPath() + DoctorListConstants.DOCTOR_LIST_URL);
                return;
            }
            // Process the doctor's avatar
            AvatarHandler.processSingleDoctorAvatar(doctor);
            // Retrieve all academic degrees of the doctor
            List<DoctorDegree> degrees = doctorDAO.getDoctorDegrees(doctorId);
            // Get doctor reviews data
            List<DoctorReview> doctorReviews = doctorReviewDAO.getReviewsByDoctorId(doctorId);
            // Calculate the average rating for the doctor based on the reviews
            double averageRating = doctorReviewDAO.getAverageRatingByDoctorId(doctorId);
            // Count the total number of reviews for the doctor
            int reviewCount = doctorReviewDAO.getReviewCountByDoctorId(doctorId);
            // Set doctor reviews, average rating, review count, degrees, and doctor details
            // in request attributes
            request.setAttribute("doctorReviews", doctorReviews);
            request.setAttribute("averageRating", averageRating);
            request.setAttribute("reviewCount", reviewCount);
            request.setAttribute("degrees", degrees);
            request.setAttribute("doctor", doctor);

            request.getRequestDispatcher(DoctorListConstants.DOCTOR_DETAIL_JSP).forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + DoctorListConstants.DOCTOR_LIST_URL);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + DoctorListConstants.DOCTOR_LIST_URL);
        }
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

        String doctorId = request.getParameter("id");
        // Initialize the redirect URL to the doctor detail page
        String redirectUrl = request.getContextPath() + DoctorListConstants.DOCTOR_DETAIL_URL;
        // If doctorId is provided and not empty, append it as a query parameter to the
        // URL
        if (doctorId != null && !doctorId.trim().isEmpty()) {
            redirectUrl += "?id=" + doctorId;
        }
        // Redirect the response to the constructed URL
        response.sendRedirect(redirectUrl);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Doctor Detail Controller";
    }// </editor-fold>
}
