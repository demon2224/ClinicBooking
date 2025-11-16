/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.patient;

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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
            // Get patient ID from session
            int patientId = ((PatientDTO) session.getAttribute("patient")).getPatientID();

            // Reload patient from database to get latest data
            PatientDTO patient = patientDAO.getPatientById(patientId);

            if (patient == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            // Update session with fresh data from database
            session.setAttribute("patient", patient);

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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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

        String firstName = null;
        String lastName = null;
        String phoneNumber = null;
        String email = null;
        String address = null;
        String dobStr = null;
        String genderStr = null;
        PatientDTO currentPatient = null;

        try {
            int patientId = ((PatientDTO) session.getAttribute("patient")).getPatientID();
            currentPatient = patientDAO.getPatientById(patientId);

            // Get form data
            firstName = request.getParameter("firstName");
            lastName = request.getParameter("lastName");
            phoneNumber = request.getParameter("phoneNumber");
            email = request.getParameter("email");
            address = request.getParameter("address");
            dobStr = request.getParameter("dob");
            genderStr = request.getParameter("gender");

            // Validate each field and set error message directly (like RegisterController)
            boolean isValidFirstName = validateFirstName(request, firstName);
            boolean isValidLastName = validateLastName(request, lastName);
            boolean isValidPhoneNumber = validatePhoneNumber(request, phoneNumber, currentPatient, patientId);
            boolean isValidEmail = validateEmail(request, email, currentPatient, patientId);
            boolean isValidAddress = validateAddress(request, address);
            boolean isValidDob = validateDob(request, dobStr);
            boolean isValidGender = validateGender(request, genderStr);

            // If any validation fails, return to form with user input preserved
            if (!isValidFirstName || !isValidLastName || !isValidPhoneNumber 
                    || !isValidEmail || !isValidAddress || !isValidDob || !isValidGender) {
                PatientDTO formData = createFormDataDTO(currentPatient, firstName, lastName, phoneNumber, email, address, dobStr, genderStr);
                request.setAttribute("patient", formData);
                request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
                return;
            }

            // Handle avatar upload if present
            Part avatarPart = request.getPart("avatar");
            String newAvatarPath = null;

            if (avatarPart != null && avatarPart.getSize() > 0) {
                // Validate avatar file
                if (!AvatarValidate.isValidAvatarFile(avatarPart)) {
                    request.setAttribute("avatarErrorMsg", "Avatar file must be JPG, PNG, or GIF format and less than 10MB");
                    
                    // Preserve form data
                    PatientDTO formData = createFormDataDTO(currentPatient, firstName, lastName, phoneNumber, email, address, dobStr, genderStr);
                    request.setAttribute("patient", formData);
                    request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
                    return;
                }

                // Upload avatar
                newAvatarPath = AvatarHandler.handleAvatarUpload(
                        avatarPart, currentPatient.getAccountName(), "patient", getServletContext());

                if (newAvatarPath == null) {
                    request.setAttribute("avatarErrorMsg", "Failed to upload avatar. Please try again");
                    
                    // Preserve form data
                    PatientDTO formData = createFormDataDTO(currentPatient, firstName, lastName, phoneNumber, email, address, dobStr, genderStr);
                    request.setAttribute("patient", formData);
                    request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
                    return;
                }
            }

            // Update patient data
            currentPatient.setFirstName(firstName);
            currentPatient.setLastName(lastName);
            currentPatient.setPhoneNumber(phoneNumber);
            currentPatient.setEmail(email);
            // Normalize address: if empty or null, set to null
            String normalizedAddress = (address != null && !address.trim().isEmpty()) ? address.trim() : null;
            currentPatient.setUserAddress(normalizedAddress);
            currentPatient.setDob(parseDate(dobStr));
            currentPatient.setGender("Male".equalsIgnoreCase(genderStr));

            if (newAvatarPath != null) {
                currentPatient.setAvatar(newAvatarPath);
            }

            // Save to database
            boolean success = patientDAO.updatePatientProfile(currentPatient);

            if (success) {
                // Update session with new data
                session.setAttribute("patient", currentPatient);
                session.setAttribute("successMessage", "Profile updated successfully!");
                response.sendRedirect(request.getContextPath() + "/profile");
            } else {
                request.setAttribute("generalErrorMsg", "Failed to update profile. Please try again");
                PatientDTO formData = createFormDataDTO(currentPatient, firstName, lastName, phoneNumber, email, address, dobStr, genderStr);
                request.setAttribute("patient", formData);
                request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            
            // Try to preserve form data if possible
            if (currentPatient != null) {
                request.setAttribute("generalErrorMsg", "An unexpected error occurred. Please try again");
                PatientDTO formData = createFormDataDTO(currentPatient, firstName, lastName, phoneNumber, email, address, dobStr, genderStr);
                request.setAttribute("patient", formData);
                request.getRequestDispatcher(ProfileConstants.URL_EDIT_PROFILE_JSP).forward(request, response);
            } else {
                // If currentPatient is null, redirect to view profile
                session.setAttribute("errorMessage", "An unexpected error occurred. Please try again");
                response.sendRedirect(request.getContextPath() + "/profile");
            }
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

        // Validate each field and set error message directly (like other validations)
        boolean isValidCurrentPassword = true;
        boolean isValidNewPassword = true;
        boolean isValidConfirmPassword = true;
        boolean isValidPasswordDifferent = true;

        // Validate current password
        String currentPasswordError = ProfileValidate.validateCurrentPassword(currentPassword);
        if (currentPasswordError != null) {
            request.setAttribute("currentPasswordErrorMsg", currentPasswordError);
            isValidCurrentPassword = false;
        }

        // Validate new password strength (get all detailed errors)
        List<String> passwordStrengthErrors = ProfileValidate.validatePasswordStrength(newPassword);
        if (!passwordStrengthErrors.isEmpty()) {
            request.setAttribute("newPasswordErrorList", passwordStrengthErrors);
            isValidNewPassword = false;
        }

        // Validate password match
        String passwordMatchError = ProfileValidate.validatePasswordMatch(newPassword, confirmPassword);
        if (passwordMatchError != null) {
            request.setAttribute("confirmPasswordErrorMsg", passwordMatchError);
            isValidConfirmPassword = false;
        }

        // Validate password different
        String passwordDifferentError = ProfileValidate.validatePasswordDifferent(currentPassword, newPassword);
        if (passwordDifferentError != null) {
            request.setAttribute("passwordDifferentErrorMsg", passwordDifferentError);
            isValidPasswordDifferent = false;
        }

        // If any validation errors, show them
        if (!isValidCurrentPassword || !isValidNewPassword || !isValidConfirmPassword || !isValidPasswordDifferent) {
            viewProfile(request, response);
            return;
        }

        // Update password in database
        boolean success = patientDAO.updatePatientPassword(patientId, currentPassword, newPassword);

        if (success) {
            session.setAttribute("successMessage", "Password changed successfully!");
            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            request.setAttribute("currentPasswordErrorMsg", "Current password is incorrect");
            viewProfile(request, response);
        }
    }

    /**
     * Validate first name and set error message if invalid
     */
    private boolean validateFirstName(HttpServletRequest request, String firstName) {
        String errorMsg = ProfileValidate.validateFirstName(firstName);
        if (errorMsg != null) {
            request.setAttribute("firstNameErrorMsg", errorMsg);
            return false;
        }
        return true;
    }

    /**
     * Validate last name and set error message if invalid
     */
    private boolean validateLastName(HttpServletRequest request, String lastName) {
        String errorMsg = ProfileValidate.validateLastName(lastName);
        if (errorMsg != null) {
            request.setAttribute("lastNameErrorMsg", errorMsg);
            return false;
        }
        return true;
    }

    /**
     * Validate phone number and set error message if invalid
     * Checks format first, then uniqueness if phone number changed
     */
    private boolean validatePhoneNumber(HttpServletRequest request, String phoneNumber, PatientDTO currentPatient, int patientId) {
        // Validate format using ProfileValidate
        String errorMsg = ProfileValidate.validatePhoneNumberFormat(phoneNumber);
        if (errorMsg != null) {
            request.setAttribute("phoneNumberErrorMsg", errorMsg);
            return false;
        }
        
        // Check uniqueness if phone number changed
        if (!phoneNumber.equalsIgnoreCase(currentPatient.getPhoneNumber())) {
            if (patientDAO.isPhoneExistForOtherPatient(phoneNumber, patientId)) {
                request.setAttribute("phoneNumberErrorMsg", "Phone number is already registered to another account");
                return false;
            }
        }
        return true;
    }

    /**
     * Validate email and set error message if invalid
     * Checks format first, then uniqueness if email changed
     */
    private boolean validateEmail(HttpServletRequest request, String email, PatientDTO currentPatient, int patientId) {
        // Validate format using ProfileValidate
        String errorMsg = ProfileValidate.validateEmailFormat(email);
        if (errorMsg != null) {
            request.setAttribute("emailErrorMsg", errorMsg);
            return false;
        }
        
        // Check uniqueness if email changed
        if (!email.equalsIgnoreCase(currentPatient.getEmail())) {
            if (patientDAO.isEmailExistForOtherPatient(email, patientId)) {
                request.setAttribute("emailErrorMsg", "Email is already registered to another account");
                return false;
            }
        }
        return true;
    }

    /**
     * Validate address and set error message if invalid
     */
    private boolean validateAddress(HttpServletRequest request, String address) {
        String errorMsg = ProfileValidate.validateAddress(address);
        if (errorMsg != null) {
            request.setAttribute("addressErrorMsg", errorMsg);
            return false;
        }
        return true;
    }

    /**
     * Validate date of birth and set error message if invalid
     */
    private boolean validateDob(HttpServletRequest request, String dobStr) {
        String errorMsg = ProfileValidate.validateDob(dobStr);
        if (errorMsg != null) {
            request.setAttribute("dobErrorMsg", errorMsg);
            return false;
        }
        return true;
    }

    /**
     * Validate gender and set error message if invalid
     */
    private boolean validateGender(HttpServletRequest request, String genderStr) {
        String errorMsg = ProfileValidate.validateGender(genderStr);
        if (errorMsg != null) {
            request.setAttribute("genderErrorMsg", errorMsg);
            return false;
        }
        return true;
    }

    /**
     * Create PatientDTO with form data to preserve user input when validation fails
     */
    private PatientDTO createFormDataDTO(PatientDTO currentPatient, String firstName, String lastName, 
            String phoneNumber, String email, String address, String dobStr, String genderStr) {
        PatientDTO formData = new PatientDTO();
        
        // Copy unchanged data from current patient
        formData.setPatientID(currentPatient.getPatientID());
        formData.setAccountName(currentPatient.getAccountName());
        formData.setAvatar(currentPatient.getAvatar());
        
        // Use new form data if provided, otherwise keep current data
        formData.setFirstName(getValueOrDefault(firstName, currentPatient.getFirstName()));
        formData.setLastName(getValueOrDefault(lastName, currentPatient.getLastName()));
        formData.setPhoneNumber(getValueOrDefault(phoneNumber, currentPatient.getPhoneNumber()));
        formData.setEmail(getValueOrDefault(email, currentPatient.getEmail()));
        // Normalize address: if empty or null, use current address or null
        String normalizedAddress = (address != null && !address.trim().isEmpty()) ? address.trim() : currentPatient.getUserAddress();
        formData.setUserAddress(normalizedAddress);
        
        // Handle date of birth
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                formData.setDob(parseDate(dobStr));
            } catch (Exception e) {
                formData.setDob(currentPatient.getDob());
            }
        } else {
            formData.setDob(currentPatient.getDob());
        }
        
        // Handle gender
        if (genderStr != null) {
            formData.setGender("Male".equalsIgnoreCase(genderStr));
        } else {
            formData.setGender(currentPatient.isGender());
        }
        
        return formData;
    }
    
    /**
     * Helper method to get value or default
     */
    private String getValueOrDefault(String value, String defaultValue) {
        return (value != null && !value.trim().isEmpty()) ? value : defaultValue;
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
