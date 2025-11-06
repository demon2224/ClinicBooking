/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.AdminDAO;
import dao.DoctorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
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

        // Default: list
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
        AdminDAO dao = new AdminDAO();
        DoctorDAO doctorDAO = new DoctorDAO();

        if ("delete".equalsIgnoreCase(action)) {
            int staffID = Integer.parseInt(request.getParameter("staffID"));
            dao.deleteStaffAccount(staffID);

        } else if ("update".equalsIgnoreCase(action)) {
            // Lấy thông tin từ form Edit
            int staffID = Integer.parseInt(request.getParameter("staffID"));
            String accountName = request.getParameter("accountName");
            String fullName = request.getParameter("fullName");
            String role = request.getParameter("role");
            String phone = request.getParameter("phoneNumber");
            String dob = request.getParameter("dob");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String address = request.getParameter("userAddress");
            boolean hidden = "1".equals(request.getParameter("hidden"));

            dao.updateStaffAccount(staffID, accountName, fullName, role, phone, dob, gender, address, hidden);

            // Nếu là bác sĩ, update thêm doctor info
            if ("Doctor".equalsIgnoreCase(role)) {
                int specialtyID = Integer.parseInt(request.getParameter("specialtyID"));
                int yearExp = Integer.parseInt(request.getParameter("yearExperience"));
                double price = Double.parseDouble(request.getParameter("price"));
                String[] degreeNames = request.getParameterValues("degreeNames");

                //doctorDAO.updateDoctorInfo(staffID, specialtyID, yearExp, price, degreeNames);
            }
        }

        // Reload danh sách sau khi delete/update/add
        List<StaffDTO> staffList = dao.getAllStaffAccounts();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/WEB-INF/admin/AdminManageAccountList.jsp").forward(request, response);
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
