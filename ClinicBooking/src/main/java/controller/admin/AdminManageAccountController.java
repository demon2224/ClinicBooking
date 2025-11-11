/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.AdminDAO;
import dao.DoctorDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DegreeDTO;
import model.DoctorDTO;
import model.StaffDTO;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class AdminManageAccountController extends HttpServlet {

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

        AdminDAO adminDAO = new AdminDAO();
        DoctorDAO doctorDAO = new DoctorDAO();

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if ("add".equalsIgnoreCase(action)) {
            List<String[]> specialties = doctorDAO.getAllSpecialties();

            // 🔹 Thêm map lưu SpecialtyID → Price
            Map<String, Double> specialtyPrices = new HashMap<>();
            String sql = "SELECT SpecialtyID, Price FROM Specialty";
            ResultSet rs = doctorDAO.executeSelectQuery(sql);
            try {
                while (rs != null && rs.next()) {
                    specialtyPrices.put(String.valueOf(rs.getInt("SpecialtyID")), rs.getDouble("Price"));
                }
            } catch (SQLException ex) {
                Logger.getLogger(AdminManageAccountController.class.getName()).log(Level.SEVERE, null, ex);
            }
            doctorDAO.closeResources(rs);

            request.setAttribute("specialties", specialties);
            request.setAttribute("specialtyPrices", specialtyPrices);

            request.getRequestDispatcher("/WEB-INF/admin/AddAccount.jsp").forward(request, response);
            return;
        }

        if ("edit".equalsIgnoreCase(action) && idParam != null) {
            int staffID = Integer.parseInt(idParam);
            StaffDTO staff = adminDAO.getStaffById(staffID);
            request.setAttribute("staff", staff);

            if ("Doctor".equalsIgnoreCase(staff.getRole())) {
                DoctorDTO doctor = doctorDAO.getDoctorById(staffID);
                List<DegreeDTO> degrees = doctorDAO.getDoctorDegrees(doctor.getDoctorID());
                request.setAttribute("doctor", doctor);
                request.setAttribute("degrees", degrees);
                request.setAttribute("specialties", doctorDAO.getAllSpecialties());
            }

            request.getRequestDispatcher("/WEB-INF/admin/EditAccount.jsp").forward(request, response);
            return;
        }

        if (idParam != null) {
            int staffID = Integer.parseInt(idParam);
            StaffDTO staff = adminDAO.getStaffById(staffID);
            request.setAttribute("staff", staff);

            if ("Doctor".equalsIgnoreCase(staff.getRole())) {
                DoctorDTO doctor = doctorDAO.getDoctorById(staffID);
                List<DegreeDTO> degrees = doctorDAO.getDoctorDegrees(doctor.getDoctorID());
                request.setAttribute("doctor", doctor);
                request.setAttribute("degrees", degrees);
            }

            request.getRequestDispatcher("/WEB-INF/admin/AccountDetail.jsp").forward(request, response);
            return;
        }

        String searchQuery = request.getParameter("searchQuery");
        List<StaffDTO> staffList;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            staffList = adminDAO.searchStaffAccounts(searchQuery.trim());
        } else {
            staffList = adminDAO.getAllStaffAccounts();
        }

        request.setAttribute("staffList", staffList);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("/WEB-INF/admin/AdminManageAccountList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AdminDAO dao = new AdminDAO();
        DoctorDAO doctorDAO = new DoctorDAO();

        if ("delete".equalsIgnoreCase(action)) {
            int staffID = Integer.parseInt(request.getParameter("staffID"));
            dao.deleteStaffAccount(staffID);

        } else if ("update".equalsIgnoreCase(action)) {
            int staffID = Integer.parseInt(request.getParameter("staffID"));
            String accountName = request.getParameter("accountName");
            String fullName = request.getParameter("fullName");
            String role = request.getParameter("role");
            String phone = request.getParameter("phoneNumber");
            String dob = request.getParameter("dob");
            String jobStatus = request.getParameter("jobStatus");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String address = request.getParameter("userAddress");
            boolean hidden = "1".equals(request.getParameter("hidden"));

            dao.updateStaffAccount(staffID, accountName, fullName, role, phone, jobStatus, dob, gender, address, hidden);

            if ("Doctor".equalsIgnoreCase(role)) {
                int specialtyID = Integer.parseInt(request.getParameter("specialtyID"));
                int yearExp = Integer.parseInt(request.getParameter("yearExperience"));
                double price = Double.parseDouble(request.getParameter("price"));
                String[] degreeNames = request.getParameterValues("degreeNames");
                doctorDAO.updateDoctorInfo(staffID, specialtyID, yearExp, price, degreeNames);
            }

        } else if ("add".equalsIgnoreCase(action)) {
            String accountName = request.getParameter("accountName");
            String fullName = request.getParameter("fullName");
            String role = request.getParameter("role");
            String phone = request.getParameter("phoneNumber");
            String dob = request.getParameter("dob");
            String jobStatus = request.getParameter("jobStatus");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String address = request.getParameter("userAddress");
            boolean hidden = "1".equals(request.getParameter("hidden"));

            int newStaffID = dao.addStaffAccount(accountName, fullName, role, phone, jobStatus, dob, gender, address, hidden);

            // Thêm thông tin Doctor (nếu vai trò là bác sĩ)
            if ("Doctor".equalsIgnoreCase(role)) {
                int specialtyID = Integer.parseInt(request.getParameter("specialtyID"));
                int yearExp = Integer.parseInt(request.getParameter("yearExperience"));
                String priceStr = request.getParameter("price");
                double price = 0;
                if (priceStr != null && !priceStr.trim().isEmpty()) {
                    price = Double.parseDouble(priceStr);
                }

                String[] degreeNames = request.getParameterValues("degreeNames");

                doctorDAO.addDoctorInfo(newStaffID, specialtyID, yearExp, price, degreeNames);
            }
        }

        List<StaffDTO> staffList = dao.getAllStaffAccounts();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/WEB-INF/admin/AdminManageAccountList.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controller for Admin to manage Staff/Doctor accounts.";
    }

}
