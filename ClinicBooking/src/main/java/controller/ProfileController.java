/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constants.ProfileConstants;
import dao.PatientDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import model.PatientDTO;
import utils.AvatarHandler;
import validate.AvatarValidate;
import validate.ProfileValidate;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class ProfileController extends HttpServlet {

    private PatientDAO patientDAO;

    @Override
    public void init() {
        patientDAO = new PatientDAO();
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
            out.println("<title>Servlet ProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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

        String action = request.getParameter("action");

        if (action != null && action.equals("edit")) {
            showEditProfileForm(request, response);
        } else {
            viewProfile(request, response);
        }
    }

    /**
     * Display profile view page
     */
    private void viewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("patient") == null) {
            response.sendRedirect(request.getContextPath() + "/patient-login");
            return;
        }
        try {
            int patientId = ((PatientDTO) session.getAttribute("patient")).getPatientID();

            // Get patient from database
            PatientDTO patient = patientDAO.getPatientById(patientId);

            if (patient == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            // Process avatar - set default if not exists
            AvatarHandler.processPatientAvatar(patient);

            request.setAttribute("patient", patient);
            request.getRequestDispatcher(ProfileConstants.URL_PROFILE_JSP).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    /**
     * Show edit profile form
     */
    private void showEditProfileForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if (session == null || session.getAttribute("patient") == null) {
            response.sendRedirect(request.getContextPath() + "/patient-login");
            return;
        }

        try {

            int patientId = ((PatientDTO) session.getAttribute("patient")).getPatientID();

            PatientDTO patient = patientDAO.getPatientById(patientId);

            if (patient == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            // Process avatar
            AvatarHandler.processPatientAvatar(patient);

            request.setAttribute("patient", patient);
            request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("patient") == null) {
            response.sendRedirect(request.getContextPath() + "/patient-login");
            return;
        }

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            updateProfile(request, response, session);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, session);
        } else {
            updateProfile(request, response, session);
        }
    }

    /**
     * Update profile information
     */
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {

        try {
            PatientDTO patient = (PatientDTO) session.getAttribute("patient");
            int patientId = patient.getPatientID();

            // Get form data from request parameters
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String dobStr = request.getParameter("dob");
            String genderStr = request.getParameter("gender");

            // Validate input
            List<String> errors = ProfileValidate.validateProfileInput(
                    firstName, lastName, phoneNumber, email, dobStr, genderStr, address);

            // Check if email is unique (if changed)
            PatientDTO currentPatient = patientDAO.getPatientById(patientId);
            if (!email.equalsIgnoreCase(currentPatient.getEmail())) {
                if (patientDAO.isEmailExistForOtherPatient(email, patientId)) {
                    errors.add("This email is already in use by another patient");
                }
            }

            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("patient", currentPatient);
                request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
                return;
            }

            // Handle avatar upload
            Part avatarPart = request.getPart("avatar");
            String newAvatarPath = null;

            if (avatarPart != null && avatarPart.getSize() > 0) {
                if (!AvatarValidate.isValidAvatarFile(avatarPart)) {
                    errors.add("Invalid avatar file (only .jpg, .png, .gif, max 10MB accepted)");
                    request.setAttribute("errors", errors);
                    request.setAttribute("patient", currentPatient);
                    request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
                    return;
                }

                newAvatarPath = AvatarHandler.handleAvatarUpload(
                        avatarPart, patientId, "patient", getServletContext());

                if (newAvatarPath == null) {
                    errors.add("Upload avatar failed");
                    request.setAttribute("errors", errors);
                    request.setAttribute("patient", currentPatient);
                    request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
                    return;
                }
            }

            // Update patient data
            patient = patientDAO.getPatientById(patientId);
            patient.setFirstName(firstName);
            patient.setLastName(lastName);
            patient.setPhoneNumber(phoneNumber);
            patient.setEmail(email);
            patient.setUserAddress(address);
            patient.setDob(parseDate(dobStr));
            patient.setGender("Male".equalsIgnoreCase(genderStr));

            if (newAvatarPath != null) {
                patient.setAvatar(newAvatarPath);
            }

            boolean success = patientDAO.updatePatientProfile(patient);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/profile?success=true");
            } else {
                errors.add("Update information failed");
                request.setAttribute("errors", errors);
                request.setAttribute("patient", patient);
                request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred!");
            response.sendRedirect(request.getContextPath() + "/profile?action=edit");
        }
    }

    /**
     * Change password
     */
    private void changePassword(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {

        int patientId = ((PatientDTO) session.getAttribute("patient")).getPatientID();
        // Get form data
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate passwords
        List<String> errors = ProfileValidate.validatePasswordStrength(newPassword);

        // Check if passwords match
        if (!ProfileValidate.isPasswordMatch(newPassword, confirmPassword)) {
            errors.add("New password and confirmation do not match");
        }

        // Check if new password is different from current
        if (currentPassword.equals(newPassword)) {
            errors.add("The new password must be different from the current password.");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("passwordError", String.join(", ", errors));
            viewProfile(request, response);
            return;
        }

        // Update password in database
        boolean success = patientDAO.updatePatientPassword(patientId, currentPassword, newPassword);

        if (success) {
            request.setAttribute("successMessage", "Password changed successfully!");
            viewProfile(request, response);
        } else {
            request.setAttribute("passwordError", "Current password is incorrect");
            viewProfile(request, response);
        }
    }

    /**
     * Parse date string to Timestamp
     */
    private Timestamp parseDate(String dateStr) throws ParseException {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date = sdf.parse(dateStr);
        return new Timestamp(date.getTime());
    }
}
