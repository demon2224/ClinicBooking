/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constants.ManageMyFeedbackConstants;
import dao.DoctorDAO;
import validate.FeedbackValidate;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DoctorReviewDTO;
import model.DoctorDTO;
import model.PatientDTO;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class ManageMyFeedbackController extends HttpServlet {

    private DoctorDAO doctorReviewDAO;

    /**
     * Initialize all the necessary DAO using in this controller.
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        doctorReviewDAO = new DoctorDAO();
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
            out.println("<title>Servlet ManageMyFeedbackController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageMyFeedbackController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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

        int userID = ((PatientDTO) request.getSession().getAttribute("patient")).getPatientID();

        try {
            String action = request.getParameter("action");

            if (action == null || action.equals("view")) {
                viewMyFeedbacks(request, response, userID);
            } else if (action.equals("detail")) {
                handleViewFeedbackDetail(request, response, userID);
            } else if (action.equals("delete")) {
                handleDeleteFeedbackPost(request, response, userID);
            } else {
                viewMyFeedbacks(request, response, userID);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_GENERAL);
            request.getRequestDispatcher(ManageMyFeedbackConstants.MANAGE_FEEDBACK_JSP)
                    .forward(request, response);
        }
    }

    /**
     * View list of user's feedback
     */
    private void viewMyFeedbacks(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        List<DoctorReviewDTO> myReviews = doctorReviewDAO.getReviewsByUserId(userID);
        List<DoctorDTO> availableDoctors = doctorReviewDAO.getAvailableDoctors();

        // Check for session messages and move to request attributes
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        String errorMessage = (String) request.getSession().getAttribute("errorMessage");

        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            request.getSession().removeAttribute("successMessage");
        }

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getSession().removeAttribute("errorMessage");
        }

        request.setAttribute("myReviews", myReviews);
        request.setAttribute("totalReviews", myReviews.size());
        request.setAttribute("availableDoctors", availableDoctors);
        request.setAttribute("viewMode", ManageMyFeedbackConstants.VIEW_MODE_LIST);
        request.getRequestDispatcher(ManageMyFeedbackConstants.MANAGE_FEEDBACK_JSP)
                .forward(request, response);
    }

    /**
     * View detailed information of a specific feedback
     */
    private void handleViewFeedbackDetail(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        String reviewIdParam = request.getParameter("reviewId");

        if (!FeedbackValidate.isValidReviewId(reviewIdParam)) {
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_REQUIRED_REVIEW_ID);
            viewMyFeedbacks(request, response, userID);
            return;
        }

        try {
            int reviewId = Integer.parseInt(reviewIdParam.trim());

            List<DoctorReviewDTO> myReviews = doctorReviewDAO.getReviewsByUserId(userID);
            DoctorReviewDTO selectedReview = null;

            for (DoctorReviewDTO review : myReviews) {
                if (review.getDoctorReviewID() == reviewId) {
                    selectedReview = review;
                    break;
                }
            }

            if (selectedReview == null) {
                request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_REVIEW_NOT_FOUND);
                viewMyFeedbacks(request, response, userID);
                return;
            }

            request.setAttribute("reviewDetail", selectedReview);
            request.getRequestDispatcher(ManageMyFeedbackConstants.MY_FEEDBACK_DETAIL_JSP)
                    .forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_INVALID_REVIEW_ID);
            viewMyFeedbacks(request, response, userID);
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

        request.setCharacterEncoding(ManageMyFeedbackConstants.URL_ENCODING);

        int userID = ((PatientDTO) request.getSession().getAttribute("patient")).getPatientID();

        try {
            String action = request.getParameter("action");

            if (action == null) {
                response.sendRedirect(ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
                return;
            }

            switch (action) {
                case "create":
                    handleCreateFeedback(request, response, userID);
                    break;
                case "update":
                    handleUpdateFeedback(request, response, userID);
                    break;
                case "delete":
                    handleDeleteFeedbackPost(request, response, userID);
                    break;
                default:
                    response.sendRedirect(ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_GENERAL);
            viewMyFeedbacks(request, response, userID);
        }
    }

    /**
     * Handle update feedback
     */
    private void handleUpdateFeedback(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        String reviewIdParam = request.getParameter("reviewId");
        String content = request.getParameter("content");
        String ratingParam = request.getParameter("rating");

        // Use centralized validation
        FeedbackValidate.ValidationResult validation = FeedbackValidate.validateUpdateFeedback(reviewIdParam, content,
                ratingParam);
        if (!validation.isValid()) {
            request.getSession().setAttribute("errorMessage", validation.getErrorMessage());
            response.sendRedirect(request.getContextPath() + ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
            return;
        }

        try {
            int reviewId = Integer.parseInt(reviewIdParam.trim());
            int rating = Integer.parseInt(ratingParam.trim());

            // Update the review
            boolean success = doctorReviewDAO.updateDoctorReview(reviewId, userID, content.trim(), rating);

            if (success) {
                request.getSession().setAttribute("successMessage", ManageMyFeedbackConstants.SUCCESS_FEEDBACK_UPDATE);
                response.sendRedirect(request.getContextPath() + ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
            } else {
                request.getSession().setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_FAILED_UPDATE_REVIEW);
                response.sendRedirect(request.getContextPath() + ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_INVALID_REVIEW_ID);
            viewMyFeedbacks(request, response, userID);
        }
    }

    /**
     * Handle delete feedback POST
     */
    private void handleDeleteFeedbackPost(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        String reviewIdParam = request.getParameter("reviewId");

        // Use centralized validation
        FeedbackValidate.ValidationResult validation = FeedbackValidate.validateReviewId(reviewIdParam);
        if (!validation.isValid()) {
            request.setAttribute("errorMessage", validation.getErrorMessage());
            viewMyFeedbacks(request, response, userID);
            return;
        }

        try {
            int reviewId = Integer.parseInt(reviewIdParam.trim());

            // Delete the review
            boolean success = doctorReviewDAO.deleteDoctorReview(reviewId, userID);

            if (success) {
                request.getSession().setAttribute("successMessage", ManageMyFeedbackConstants.SUCCESS_FEEDBACK_DELETE);
            } else {
                request.getSession().setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_FAILED_DELETE_REVIEW);
            }

            response.sendRedirect(request.getContextPath() + ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_INVALID_REVIEW_ID);
            viewMyFeedbacks(request, response, userID);
        }
    }

    /**
     * Handle create feedback
     */
    private void handleCreateFeedback(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        String doctorIdParam = request.getParameter("doctorId");
        String content = request.getParameter("content");
        String ratingParam = request.getParameter("rating");

        // Use centralized validation
        FeedbackValidate.ValidationResult validation = FeedbackValidate.validateCreateFeedback(doctorIdParam, content,
                ratingParam);
        if (!validation.isValid()) {
            request.getSession().setAttribute("errorMessage", validation.getErrorMessage());
            response.sendRedirect(request.getContextPath() + ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
            return;
        }

        try {
            int doctorId = Integer.parseInt(doctorIdParam.trim());
            int rating = Integer.parseInt(ratingParam.trim());

            // Check if patient has already reviewed this doctor
            if (doctorReviewDAO.hasPatientReviewedDoctor(userID, doctorId)) {
                request.getSession().setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_EXISTS_DOCTOR_REVIEW);
                response.sendRedirect(request.getContextPath() + ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
                return;
            }

            // Create the review
            boolean success = doctorReviewDAO.createDoctorReview(userID, doctorId, content.trim(), rating);

            if (success) {
                // Set success message in session to survive redirect
                request.getSession().setAttribute("successMessage", ManageMyFeedbackConstants.SUCCESS_FEEDBACK_SUBMIT);
                response.sendRedirect(request.getContextPath() + ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
            } else {
                request.getSession().setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_FAILED_SUBMIT_REVIEW);
                response.sendRedirect(request.getContextPath() + ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_INVALID_DOCTOR_ID);
            response.sendRedirect(request.getContextPath() + ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
        }
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
