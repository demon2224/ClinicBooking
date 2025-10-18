/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constants.ManageMyFeedbackConstants;
import dao.DoctorReviewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DoctorReview;
import model.User;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class ManageMyFeedbackController extends HttpServlet {

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

        int userID = ((User) request.getSession().getAttribute("user")).getUserID();

        try {
            String action = request.getParameter("action");

            if (action == null || action.equals("view")) {
                viewMyFeedbacks(request, response, userID);
            } else if (action.equals("detail")) {
                handleViewFeedbackDetail(request, response, userID);
            } else if (action.equals("delete")) {
                handleDeleteFeedback(request, response, userID);
            } else if (action.equals("edit")) {
                handleEditFeedback(request, response, userID);
            } else if (action.equals("create")) {
                handleCreateFeedbackForm(request, response, userID);
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
     * View list of user's feedbacks
     */
    private void viewMyFeedbacks(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        DoctorReviewDAO reviewDAO = new DoctorReviewDAO();
        List<DoctorReview> myReviews = reviewDAO.getReviewsByUserId(userID);

        request.setAttribute("myReviews", myReviews);
        request.setAttribute("totalReviews", myReviews.size());
        request.setAttribute("viewMode", ManageMyFeedbackConstants.VIEW_MODE_LIST);
        request.getRequestDispatcher(ManageMyFeedbackConstants.MANAGE_FEEDBACK_JSP)
                .forward(request, response);
    }

    /**
     * Handle delete feedback - Future implementation
     */
    private void handleDeleteFeedback(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        request.setAttribute("message", ManageMyFeedbackConstants.MSG_DELETE_PLACEHOLDER);
        viewMyFeedbacks(request, response, userID);
    }

    /**
     * View detailed information of a specific feedback
     */
    private void handleViewFeedbackDetail(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        String reviewIdParam = request.getParameter("reviewId");

        if (reviewIdParam == null || reviewIdParam.trim().isEmpty()) {
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_REQUIRED_REVIEW_ID);
            viewMyFeedbacks(request, response, userID);
            return;
        }

        try {
            int reviewId = Integer.parseInt(reviewIdParam);

            DoctorReviewDAO reviewDAO = new DoctorReviewDAO();

            List<DoctorReview> myReviews = reviewDAO.getReviewsByUserId(userID);
            DoctorReview selectedReview = null;

            for (DoctorReview review : myReviews) {
                if (review.getDoctorReviewID() == reviewId) {
                    selectedReview = review;
                    break;
                }
            }

            if (selectedReview == null) {
                request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_NOT_FOUND);
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
     * Handle edit feedback - Future implementation
     */
    private void handleEditFeedback(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        request.setAttribute("message", ManageMyFeedbackConstants.MSG_EDIT_PLACEHOLDER);
        viewMyFeedbacks(request, response, userID);
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
        response.setCharacterEncoding(ManageMyFeedbackConstants.URL_ENCODING);

        int userID = ((User) request.getSession().getAttribute("user")).getUserID();

        try {
            String action = request.getParameter("action");

            if (action == null) {
                response.sendRedirect(ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
                return;
            }

            if (action.equals("create")) {
                handleCreateFeedback(request, response, userID);
            } else if (action.equals("update")) {
                handleUpdateFeedback(request, response, userID);
            } else if (action.equals("delete")) {
                handleDeleteFeedbackPost(request, response, userID);
            } else {
                response.sendRedirect(ManageMyFeedbackConstants.MANAGE_FEEDBACK_URL);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_GENERAL);
            viewMyFeedbacks(request, response, userID);
        }
    }

    /**
     * Handle update feedback - Future implementation
     */
    private void handleUpdateFeedback(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        String reviewID = request.getParameter("reviewID");
        String content = request.getParameter("content");
        String rateScore = request.getParameter("rateScore");

        if (content != null && content.length() >= ManageMyFeedbackConstants.MIN_CONTENT_LENGTH
                && content.length() <= ManageMyFeedbackConstants.MAX_CONTENT_LENGTH) {
            request.setAttribute("successMessage", ManageMyFeedbackConstants.MSG_UPDATE_PLACEHOLDER);
        } else {
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_CONTENT_LENGTH);
        }

        viewMyFeedbacks(request, response, userID);
    }

    /**
     * Handle delete feedback POST - Future implementation
     */
    private void handleDeleteFeedbackPost(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        String reviewID = request.getParameter("reviewID");
        request.setAttribute("message", ManageMyFeedbackConstants.MSG_DELETE_POST_PLACEHOLDER + reviewID);
        viewMyFeedbacks(request, response, userID);
    }

    /**
     * Show create feedback form - Future implementation
     */
    private void handleCreateFeedbackForm(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        request.setAttribute("message", ManageMyFeedbackConstants.MSG_CREATE_FORM_PLACEHOLDER);
        request.setAttribute("viewMode", ManageMyFeedbackConstants.VIEW_MODE_CREATE);
        request.getRequestDispatcher(ManageMyFeedbackConstants.MANAGE_FEEDBACK_JSP)
                .forward(request, response);
    }

    /**
     * Handle create feedback - Future implementation
     */
    private void handleCreateFeedback(HttpServletRequest request, HttpServletResponse response, int userID)
            throws ServletException, IOException {

        String doctorID = request.getParameter("doctorID");
        String content = request.getParameter("content");
        String rateScore = request.getParameter("rateScore");

        if (content != null && content.length() >= ManageMyFeedbackConstants.MIN_CONTENT_LENGTH
                && content.length() <= ManageMyFeedbackConstants.MAX_CONTENT_LENGTH
                && rateScore != null) {

            try {
                int rating = Integer.parseInt(rateScore);
                if (rating >= ManageMyFeedbackConstants.MIN_RATE_SCORE
                        && rating <= ManageMyFeedbackConstants.MAX_RATE_SCORE) {
                    request.setAttribute("successMessage",
                            ManageMyFeedbackConstants.MSG_CREATE_PLACEHOLDER + doctorID);
                } else {
                    request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_INVALID_RATING);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_INVALID_RATING);
            }
        } else {
            request.setAttribute("errorMessage", ManageMyFeedbackConstants.ERROR_CONTENT_LENGTH);
        }

        viewMyFeedbacks(request, response, userID);
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
