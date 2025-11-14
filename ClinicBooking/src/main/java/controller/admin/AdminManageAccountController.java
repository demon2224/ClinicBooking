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
// DAO members để dùng chung

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
            if ("add".equalsIgnoreCase(action)) {
                showAddPage(req, res);
                return;
            }

            if ("edit".equalsIgnoreCase(action)) {
                showEditPage(req, res, id);
                return;
            }

            if ("view".equalsIgnoreCase(action)) {
                showDetailPage(req, res, id);
                return;
            }

            // Default: Show all
            String search = req.getParameter("searchQuery");
            List<StaffDTO> list = (search != null && !search.trim().isEmpty())
                    ? staffDAO.searchStaffAccounts(search.trim())
                    : staffDAO.getAllStaffAccounts();
            req.setAttribute("staffList", list);
            req.setAttribute("searchQuery", search);
            req.getRequestDispatcher("/WEB-INF/admin/AdminManageAccountList.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(500, "Unexpected error occurred.");
        }
    }

    private void showAddPage(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("specialties", doctorDAO.getAllSpecialtiesWithPrice());
        req.setAttribute("staff", new StaffDTO());
        req.getRequestDispatcher("/WEB-INF/admin/AddAccount.jsp").forward(req, res);
    }

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

        if ("Doctor".equalsIgnoreCase(staff.getRole())) {
            prepareDoctorData(req, doctorDAO, staffID);
        }

        req.getRequestDispatcher("/WEB-INF/admin/EditAccount.jsp").forward(req, res);
    }

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

    // Gom logic Doctor chung cho Edit & Detail
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
            if ("delete".equalsIgnoreCase(action)) {
                int staffID = parseIntSafe(req.getParameter("staffID"));
                boolean result = staffDAO.deleteStaffAccount(staffID);

                if (result) {
                    req.getSession().setAttribute("successMessage", "Account deleted successfully!");
                } else {
                    req.getSession().setAttribute("successMessage", "Failed to delete account!");
                }

                res.sendRedirect(req.getContextPath() + "/admin-manage-account");
                return;
            }

            if ("add".equalsIgnoreCase(action) || "update".equalsIgnoreCase(action)) {
                handleSave(req, res, action);
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(500, "Error processing account creation/update.");
        }
    }

    private void handleSave(HttpServletRequest req, HttpServletResponse res, String action)
            throws ServletException, IOException {
        boolean hasError = validateForm(req, action);
        if (hasError) {

            req.setAttribute("specialties", doctorDAO.getAllSpecialtiesWithPrice());
            if ("update".equalsIgnoreCase(action)) {

                int staffID = parseIntSafe(req.getParameter("staffID"));
                StaffDTO staff = staffDAO.getStaffById(staffID);
                req.setAttribute("staff", staff);

                if ("Doctor".equalsIgnoreCase(staff.getRole())) {
                    prepareDoctorData(req, doctorDAO, staffID);
                }
            }

            if ("add".equalsIgnoreCase(action)) {
                req.getRequestDispatcher("/WEB-INF/admin/AddAccount.jsp").forward(req, res);
            } else {
                req.getRequestDispatcher("/WEB-INF/admin/EditAccount.jsp").forward(req, res);
            }
            return;
        }

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

        if ("update".equalsIgnoreCase(action)) {
            staffDAO.updateStaffAccount(staffID, account, fullName, role, phone, job, dob, gender, address, hidden);
            req.getSession().setAttribute("successMessage", "Account updated successfully!");
        } else {
            staffID = staffDAO.addStaffAccount(account, password, fullName, role, phone, job, dob, gender, address, hidden);
            req.getSession().setAttribute("successMessage", "Account added successfully!");
        }

        if ("Doctor".equalsIgnoreCase(role)) {
            updateDoctorData(req, doctorDAO, staffID);
        }

        res.sendRedirect(req.getContextPath() + "/admin-manage-account");
    }

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

        // ================= USERNAME =================
        if (!AdminValidate.isValidUsername(username)) {
            request.getSession().setAttribute("usernameErrorMsg",
                    "Username must be 8–200 characters, letters and digits only.");
            hasError = true;
        }

        // ================= PASSWORD (Only for ADD) =================
        if ("add".equalsIgnoreCase(action)) {
            if (!AdminValidate.isValidPassword(password)) {
                request.getSession().setAttribute("passwordErrorMsg",
                        "Password must contain upper, lower, digit, special character, min 8 chars.");
                hasError = true;
            }
        }

        // ================= FULL NAME =================
        if (!AdminValidate.isValidFullName(fullName)) {
            request.getSession().setAttribute("fullNameErrorMsg",
                    "Full name must contain only letters and spaces.");
            hasError = true;
        }

        // ================= PHONE =================
        if (!AdminValidate.isValidPhone(phone)) {
            request.getSession().setAttribute("phoneErrorMsg",
                    "Phone number must start with 0 and contain 10–11 digits.");
            hasError = true;
        }

        // ================= ADDRESS =================
        if (!AdminValidate.isValidAddress(address)) {
            request.getSession().setAttribute("addressErrorMsg",
                    "Address must contain at least 5 characters.");
            hasError = true;
        }

        // ================= ROLE =================
        // ❗ IMPORTANT: Only validate role when ADDING
        if ("add".equalsIgnoreCase(action)) {
            if (!AdminValidate.isValidRole(role)) {
                request.getSession().setAttribute("roleErrorMsg",
                        "Please select a valid role.");
                hasError = true;
            }
        }

        // ================= DOB =================
        LocalDate dob = null;
        try {
            dob = LocalDate.parse(dobString);
            if (!AdminValidate.isValidDOB(dob)) {
                request.getSession().setAttribute("dobErrorMsg",
                        "Age must be between 18 and 120.");
                hasError = true;
            }
        } catch (Exception e) {
            request.getSession().setAttribute("dobErrorMsg",
                    "Invalid date of birth.");
            hasError = true;
        }

        // ================= DUPLICATE CHECK =================
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

                // Username duplicate check
                if (!username.equals(existing.getAccountName())
                        && staffDAO.isUsernameExists(username)) {

                    request.getSession().setAttribute("usernameErrorMsg",
                            "This username already belongs to another account.");
                    hasError = true;
                }

                // Phone duplicate check
                if (!phone.equals(existing.getPhoneNumber())
                        && staffDAO.isPhoneExists(phone)) {

                    request.getSession().setAttribute("phoneErrorMsg",
                            "This phone number is already used by another account.");
                    hasError = true;
                }

            } else {
                request.getSession().setAttribute("usernameErrorMsg", "Invalid staff id.");
                hasError = true;
            }
        }

        // ================= Doctor Section =================
        if ("Doctor".equalsIgnoreCase(role)) {

            String specialtyID = request.getParameter("specialtyID");
            String exp = request.getParameter("yearExperience");
            String price = request.getParameter("price");

            if (AdminValidate.isEmpty(specialtyID)) {
                request.getSession().setAttribute("specialtyErrorMsg",
                        "Please select specialty.");
                hasError = true;
            }

            if (dob != null && !AdminValidate.isValidExperience(exp, dob)) {
                request.getSession().setAttribute("experienceErrorMsg",
                        "Experience must be >=0 and <= (Age - 18).");
                hasError = true;
            }

            if (!AdminValidate.isValidPrice(price)) {
                request.getSession().setAttribute("priceErrorMsg",
                        "Price must be a positive number.");
                hasError = true;
            }
        }

        return hasError;
    }

    // ==================== Utils ====================
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

    private void clearSessionErrors(HttpServletRequest req) {
        String[] keys = {"usernameErrorMsg", "passwordErrorMsg", "fullNameErrorMsg",
            "roleErrorMsg", "phoneErrorMsg", "dobErrorMsg", "addressErrorMsg",
            "specialtyErrorMsg", "experienceErrorMsg", "priceErrorMsg"};
        for (String k : keys) {
            req.getSession().removeAttribute(k);
        }
    }
}
