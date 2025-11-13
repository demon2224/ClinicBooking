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
import model.*;

public class AdminManageAccountController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        StaffDAO staffDAO = new StaffDAO();
        DoctorDAO doctorDAO = new DoctorDAO();
        String action = req.getParameter("action");
        String id = req.getParameter("id");

        clearSessionErrors(req);

        try {
            if ("add".equalsIgnoreCase(action)) {
                showAddPage(req, res, doctorDAO);
                return;
            }

            if ("edit".equalsIgnoreCase(action)) {
                showEditPage(req, res, staffDAO, doctorDAO, id);
                return;
            }

            if ("view".equalsIgnoreCase(action)) {
                showDetailPage(req, res, staffDAO, doctorDAO, id);
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

    private void showAddPage(HttpServletRequest req, HttpServletResponse res, DoctorDAO dao)
            throws ServletException, IOException {
        req.setAttribute("specialties", dao.getAllSpecialtiesWithPrice());
        req.setAttribute("staff", new StaffDTO());
        req.getRequestDispatcher("/WEB-INF/admin/AddAccount.jsp").forward(req, res);
    }

    private void showEditPage(HttpServletRequest req, HttpServletResponse res,
            StaffDAO staffDAO, DoctorDAO doctorDAO, String id)
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

    private void showDetailPage(HttpServletRequest req, HttpServletResponse res,
            StaffDAO staffDAO, DoctorDAO doctorDAO, String id)
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

    // 🔹 Gom logic Doctor chung cho Edit & Detail
    private void prepareDoctorData(HttpServletRequest req, DoctorDAO doctorDAO, int staffID) {
        DoctorDTO doctor = doctorDAO.getDoctorByStaffID(staffID);
        List<DegreeDTO> degrees = doctorDAO.getDoctorDegrees(
                doctor != null ? doctor.getDoctorID() : 0);
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
        StaffDAO staffDAO = new StaffDAO();
        DoctorDAO doctorDAO = new DoctorDAO();
        String action = req.getParameter("action");

        try {
            if ("delete".equalsIgnoreCase(action)) {
                int staffID = parseIntSafe(req.getParameter("staffID"));
                staffDAO.deleteStaffAccount(staffID);
                res.sendRedirect(req.getContextPath() + "/admin-manage-account");
                return;
            }

            if ("add".equalsIgnoreCase(action) || "update".equalsIgnoreCase(action)) {
                handleSave(req, res, staffDAO, doctorDAO, action);
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(500, "Error processing account creation/update.");
        }
    }

    private void handleSave(HttpServletRequest req, HttpServletResponse res,
            StaffDAO staffDAO, DoctorDAO doctorDAO, String action)
            throws ServletException, IOException {
        boolean hasError = validateForm(req, action);
        if (hasError) {
            if ("add".equalsIgnoreCase(action)) {
                res.sendRedirect(req.getContextPath() + "/admin-manage-account?action=add");
            } else {
                res.sendRedirect(req.getContextPath() + "/admin-manage-account?action=edit&id=" + req.getParameter("staffID"));
            }
            return;
        }

        // Lấy data
        int staffID = parseIntSafe(req.getParameter("staffID"));
        String account = req.getParameter("accountName");
        String password = req.getParameter("accountPassword");
        String fullName = req.getParameter("fullName");
        String role = req.getParameter("role");
        String phone = req.getParameter("phoneNumber");
        String job = req.getParameter("jobStatus");
        String dob = req.getParameter("dob");
        boolean gender = Boolean.parseBoolean(req.getParameter("gender"));
        String address = req.getParameter("userAddress");
        boolean hidden = "1".equals(req.getParameter("hidden"));

        if ("update".equalsIgnoreCase(action)) {
            staffDAO.updateStaffAccount(staffID, account, fullName, role, phone, job, dob, gender, address, hidden);
        } else {
            staffID = staffDAO.addStaffAccount(account, password, fullName, role, phone, job, dob, gender, address, hidden);
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
    // ==================== Validation ====================

    private boolean validateForm(HttpServletRequest request, String action) {
        clearSessionErrors(request);
        boolean hasError = false;

        if (validate.AdminValidate.isEmpty(request.getParameter("accountName"))) {
            request.getSession().setAttribute("usernameErrorMsg", "Username cannot be empty.");
            hasError = true;
        }

        if ("add".equalsIgnoreCase(action)) {
            String password = request.getParameter("accountPassword");
            if (validate.AdminValidate.isEmpty(password)) {
                request.getSession().setAttribute("passwordErrorMsg", "Password cannot be empty.");
                hasError = true;
            }
        }

        if (validate.AdminValidate.isEmpty(request.getParameter("fullName"))) {
            request.getSession().setAttribute("fullNameErrorMsg", "Full name cannot be empty.");
            hasError = true;
        }

        if (validate.AdminValidate.isEmpty(request.getParameter("phoneNumber"))) {
            request.getSession().setAttribute("phoneErrorMsg", "Phone number cannot be empty.");
            hasError = true;
        }

        if (validate.AdminValidate.isEmpty(request.getParameter("userAddress"))) {
            request.getSession().setAttribute("addressErrorMsg", "Address cannot be empty.");
            hasError = true;
        }

        if (validate.AdminValidate.isEmpty(request.getParameter("dob"))) {
            request.getSession().setAttribute("dobErrorMsg", "Date of birth cannot be empty.");
            hasError = true;
        }

        String role = request.getParameter("role");
        if (validate.AdminValidate.isEmpty(role)) {
            request.getSession().setAttribute("roleErrorMsg", "Please select role.");
            hasError = true;
        }

        if ("Doctor".equalsIgnoreCase(role)) {
            String specialtyID = request.getParameter("specialtyID");
            String yearExp = request.getParameter("yearExperience");
            String price = request.getParameter("price");

            if (validate.AdminValidate.isEmpty(specialtyID)) {
                request.getSession().setAttribute("specialtyErrorMsg", "Please select a specialty.");
                hasError = true;
            }
            if (validate.AdminValidate.isEmpty(yearExp)) {
                request.getSession().setAttribute("experienceErrorMsg", "Experience cannot be empty.");
                hasError = true;
            }
            if (validate.AdminValidate.isEmpty(price)) {
                request.getSession().setAttribute("priceErrorMsg", "Price cannot be empty.");
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
