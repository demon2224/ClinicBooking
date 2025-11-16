/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.DoctorDAO;
import dao.StaffDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import model.*;
import validate.AdminValidate;

public class AdminManageAccountController extends HttpServlet {

    private StaffDAO staffDAO;
    private DoctorDAO doctorDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        staffDAO = new StaffDAO();
        doctorDAO = new DoctorDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String id = req.getParameter("id");

        try {
            switch (action != null ? action.toLowerCase() : "") {
                case "add":
                    showAddPage(req, res); // Show add account form
                    break;
                case "edit":
                    showEditPage(req, res, id); // Show edit account form
                    break;
                case "view":
                    showDetailPage(req, res, id); // Show account details
                    break;
                default:
                    showStaffList(req, res); // Show list of all staff accounts
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(500, "Unexpected error occurred."); // Internal server error
        }
    }

    // Display the list of staff accounts
    private void showStaffList(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String search = req.getParameter("searchQuery");
        List<StaffDTO> list = (search != null && !search.trim().isEmpty())
                ? staffDAO.searchStaffAccounts(search.trim())
                : staffDAO.getAllStaffAccounts();
        req.setAttribute("staffList", list);
        req.setAttribute("searchQuery", search);
        req.getRequestDispatcher("/WEB-INF/admin/AdminManageAccountList.jsp").forward(req, res);
    }

    // Display add account form
    private void showAddPage(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("specialties", doctorDAO.getAllSpecialtiesWithPrice());
        req.setAttribute("staff", new StaffDTO());
        req.getRequestDispatcher("/WEB-INF/admin/AddAccount.jsp").forward(req, res);
    }

    // Display edit account form
    private void showEditPage(HttpServletRequest req, HttpServletResponse res, String id)
            throws ServletException, IOException {
        int staffID = parseIntSafe(id);
        StaffDTO staff = staffDAO.getStaffById(staffID);
        if (staff == null) {
            res.sendRedirect(req.getContextPath() + "/admin-manage-account");
            return;
        }

        req.setAttribute("staff", staff);
        req.setAttribute("specialties", doctorDAO.getAllSpecialtiesWithPrice());

        // If the account is a Doctor, prepare additional doctor info
        if ("Doctor".equalsIgnoreCase(staff.getRole())) {
            prepareDoctorData(req, doctorDAO, staffID);
        }

        req.getRequestDispatcher("/WEB-INF/admin/EditAccount.jsp").forward(req, res);
    }

    // Display account detail page
    private void showDetailPage(HttpServletRequest req, HttpServletResponse res, String id)
            throws ServletException, IOException {
        int staffID = parseIntSafe(id);
        StaffDTO staff = staffDAO.getStaffById(staffID);
        if (staff == null) {
            res.sendRedirect(req.getContextPath() + "/admin-manage-account");
            return;
        }

        req.setAttribute("staff", staff);

        if ("Doctor".equalsIgnoreCase(staff.getRole())) {
            prepareDoctorData(req, doctorDAO, staffID);
        }

        req.getRequestDispatcher("/WEB-INF/admin/AccountDetail.jsp").forward(req, res);
    }

    // Prepare Doctor-specific data for edit/detail views
    private void prepareDoctorData(HttpServletRequest req, DoctorDAO doctorDAO, int staffID) {
        DoctorDTO doctor = doctorDAO.getDoctorByStaffID(staffID);
        List<DegreeDTO> degrees = doctorDAO.getDoctorDegrees(doctor != null ? doctor.getDoctorID() : 0);
        List<SpecialtyDTO> specialties = doctorDAO.getAllSpecialtiesWithPrice();

        if (doctor != null) {
            SpecialtyDTO doctorSpec = doctor.getSpecialtyID();
            if (doctorSpec != null) {
                for (SpecialtyDTO sp : specialties) {
                    if (sp.getSpecialtyID() == doctorSpec.getSpecialtyID()) {
                        doctor.setSpecialtyID(sp); 
                        break;
                    }
                }
            } else {
                doctor.setSpecialtyID(new SpecialtyDTO());
            }
        }

        req.setAttribute("doctor", doctor);
        req.setAttribute("degrees", degrees);
    }

    // ==================== POST ====================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            switch (action != null ? action.toLowerCase() : "") {
                case "delete":
                    handleDelete(req, res); // Delete account
                    break;
                case "add":
                case "update":
                    handleSave(req, res, action); // Add or update account
                    break;
                default:
                    res.sendError(400, "Invalid action.");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(500, "Error processing account request.");
        }
    }

    // Handle account deletion
    private void handleDelete(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        int staffID = parseIntSafe(req.getParameter("staffID"));
        boolean result = staffDAO.deleteStaffAccount(staffID);

        req.getSession().setAttribute("successMessage",
                result ? "Account deleted successfully!" : "Failed to delete account!");
        res.sendRedirect(req.getContextPath() + "/admin-manage-account");
    }

    // ==================== SAVE (ADD/UPDATE) ====================
    private void handleSave(HttpServletRequest req, HttpServletResponse res, String action)
            throws ServletException, IOException {

        boolean hasError = validateForm(req, action);
        if (hasError) {
            // If validation fails, reload the form with error messages
            req.setAttribute("specialties", doctorDAO.getAllSpecialtiesWithPrice());

            if ("update".equalsIgnoreCase(action)) {
                int staffID = parseIntSafe(req.getParameter("staffID"));
                StaffDTO staff = staffDAO.getStaffById(staffID);
                req.setAttribute("staff", staff);

                if ("Doctor".equalsIgnoreCase(staff.getRole())) {
                    prepareDoctorData(req, doctorDAO, staffID);
                }
            }

            String page = "add".equalsIgnoreCase(action) ? "/WEB-INF/admin/AddAccount.jsp"
                    : "/WEB-INF/admin/EditAccount.jsp";
            req.getRequestDispatcher(page).forward(req, res);
            return;
        }

        // Collect form parameters
        int staffID = parseIntSafe(req.getParameter("staffID"));
        String account = req.getParameter("accountName");
        String password = req.getParameter("accountPassword");
        String fullName = req.getParameter("fullName");
        String role = req.getParameter("role");
        String phone = req.getParameter("phoneNumber");
        String job = req.getParameter("jobStatus");
        String dob = req.getParameter("dob");
        boolean gender = Boolean.parseBoolean(req.getParameter("gender") == null ? "false" : req.getParameter("gender"));
        String address = req.getParameter("userAddress");
        boolean hidden = "1".equals(req.getParameter("hidden"));

        // Add or update staff account
        if ("update".equalsIgnoreCase(action)) {
            staffDAO.updateStaffAccount(staffID, account, fullName, role, phone, job, dob, gender, address, hidden);
            req.getSession().setAttribute("successMessage", "Account updated successfully!");
            
        } else {
            staffID = staffDAO.addStaffAccount  (account, password, fullName, role, phone, job, dob, gender, address, hidden);
            req.getSession().setAttribute("successMessage", "Account added successfully!");
        }

        // If the account is a Doctor, update doctor-specific info
        if ("Doctor".equalsIgnoreCase(role)) {
            updateDoctorData(req, doctorDAO, staffID);
        }

        res.sendRedirect(req.getContextPath() + "/admin-manage-account");
    }

    // Add or update Doctor-specific info
    private void updateDoctorData(HttpServletRequest req, DoctorDAO dao, int staffID) {
        int specialtyID = parseIntSafe(req.getParameter("specialtyID"));
        int exp = parseIntSafe(req.getParameter("yearExperience"));
        double price = parseDoubleSafe(req.getParameter("price"));
        String[] degrees = req.getParameterValues("degreeNames");

        if (staffID > 0) {
            if (dao.getDoctorByStaffID(staffID) != null) {
                dao.updateDoctorInfo(staffID, specialtyID, exp, price, degrees);
            } else {
                dao.addDoctorInfo(staffID, specialtyID, exp, price, degrees);
            }
        }
    }

    // ==================== VALIDATION ====================
    private boolean validateForm(HttpServletRequest request, String action) {

        clearSessionErrors(request);
        boolean hasError = false;

        String username = request.getParameter("accountName");
        String password = request.getParameter("accountPassword");
        String fullName = request.getParameter("fullName");
        String role = request.getParameter("role");
        String phone = request.getParameter("phoneNumber");
        String address = request.getParameter("userAddress");
        String dobString = request.getParameter("dob");

        // Validate username
        if (!AdminValidate.isValidUsername(username)) {
            request.getSession().setAttribute("usernameErrorMsg",
                    "Username must be 8–200 characters, letters and digits only.");
            hasError = true;
        }

        // Validate password only for ADD
        if ("add".equalsIgnoreCase(action)) {
            if (!AdminValidate.isValidPassword(password)) {
                request.getSession().setAttribute("passwordErrorMsg",
                        "Password must contain upper, lower, digit, special character, min 8 chars.");
                hasError = true;
            }
        }

        // Validate full name
        if (!AdminValidate.isValidFullName(fullName)) {
            request.getSession().setAttribute("fullNameErrorMsg",
                    "Full name must contain only letters and spaces.");
            hasError = true;
        }

        // Validate phone number
        if (!AdminValidate.isValidPhone(phone)) {
            request.getSession().setAttribute("phoneErrorMsg",
                    "Phone number must start with 0 and contain 10–11 digits.");
            hasError = true;
        }

        // Validate address
        if (!AdminValidate.isValidAddress(address)) {
            request.getSession().setAttribute("addressErrorMsg",
                    "Address must contain at least 5 characters.");
            hasError = true;
        }

        // Validate role only for ADD
        if ("add".equalsIgnoreCase(action)) {
            if (!AdminValidate.isValidRole(role)) {
                request.getSession().setAttribute("roleErrorMsg", "Please select a valid role.");
                hasError = true;
            }
        }

        // Validate date of birth
        LocalDate dob = null;
        try {
            dob = LocalDate.parse(dobString);
            if (!AdminValidate.isValidDOB(dob)) {
                request.getSession().setAttribute("dobErrorMsg", "Age must be between 18 and 120.");
                hasError = true;
            }
        } catch (Exception e) {
            request.getSession().setAttribute("dobErrorMsg", "Invalid date of birth.");
            hasError = true;
        }

        // Duplicate checks for username and phone
        if ("add".equalsIgnoreCase(action)) {
            if (username != null && staffDAO.isUsernameExists(username)) {
                request.getSession().setAttribute("usernameErrorMsg", "This username already exists.");
                hasError = true;
            }
            if (phone != null && staffDAO.isPhoneExists(phone)) {
                request.getSession().setAttribute("phoneErrorMsg", "This phone number already exists.");
                hasError = true;
            }
        } else if ("update".equalsIgnoreCase(action)) {
            int staffID = parseIntSafe(request.getParameter("staffID"));
            StaffDTO existing = staffDAO.getStaffById(staffID);
            if (existing != null) {
                if (!username.equals(existing.getAccountName()) && staffDAO.isUsernameExists(username)) {
                    request.getSession().setAttribute("usernameErrorMsg",
                            "This username already belongs to another account.");
                    hasError = true;
                }
                if (!phone.equals(existing.getPhoneNumber()) && staffDAO.isPhoneExists(phone)) {
                    request.getSession().setAttribute("phoneErrorMsg",
                            "This phone number is already used by another account.");
                    hasError = true;
                }
            } else {
                request.getSession().setAttribute("usernameErrorMsg", "Invalid staff id.");
                hasError = true;
            }
        }

        // Doctor-specific validation
        if ("Doctor".equalsIgnoreCase(role)) {
            String specialtyID = request.getParameter("specialtyID");
            String exp = request.getParameter("yearExperience");
//            String price = request.getParameter("price");

            if (AdminValidate.isEmpty(specialtyID)) {
                request.getSession().setAttribute("specialtyErrorMsg", "Please select specialty.");
                hasError = true;
            }

            if (dob != null && !AdminValidate.isValidExperience(exp, dob)) {
                request.getSession().setAttribute("experienceErrorMsg",
                        "Experience cannot exceed the number of years since you turned 18.");
                hasError = true;
            }

//            if (!AdminValidate.isValidPrice(price)) {
//                request.getSession().setAttribute("priceErrorMsg", "Price must be a positive number.");
//                hasError = true;
//            }
        }

        return hasError;
    }

    // ==================== UTILITY METHODS ====================
    private int parseIntSafe(String v) {
        try {
            return (v != null && !v.isBlank()) ? Integer.parseInt(v) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private double parseDoubleSafe(String v) {
        try {
            return (v != null && !v.isBlank()) ? Double.parseDouble(v) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    // Clear session error messages before validation
    private void clearSessionErrors(HttpServletRequest req) {
        String[] keys = {"usernameErrorMsg", "passwordErrorMsg", "fullNameErrorMsg",
            "roleErrorMsg", "phoneErrorMsg", "dobErrorMsg", "addressErrorMsg",
            "specialtyErrorMsg", "experienceErrorMsg"};
        for (String k : keys) {
            req.getSession().removeAttribute(k);
        }
    }
}
