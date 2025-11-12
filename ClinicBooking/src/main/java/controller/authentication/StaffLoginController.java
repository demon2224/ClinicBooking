/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;

import dao.DoctorDAO;
import dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DoctorDTO;
import model.StaffDTO;
import validate.LoginValidate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class StaffLoginController extends HttpServlet {

    private StaffDAO staffDAO;

    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAO();
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
            out.println("<title>Servlet StaffLoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffLoginController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
//        processRequest(request, response);

        request.getRequestDispatcher("/WEB-INF/authentication/StaffLogin.jsp").forward(request, response);
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
//        processRequest(request, response);

        String staffUsernameParam = request.getParameter("staff-username");
        String staffPasswordParam = request.getParameter("staff-password");

        boolean isValidPatientUsername = isValidStaffUsername(request, staffUsernameParam);
        boolean isValidPatientPassword = isValidStaffPassword(request, staffPasswordParam);

        if (!isValidPatientUsername
                || !isValidPatientPassword) {
           request.getRequestDispatcher("/WEB-INF/authentication/StaffLogin.jsp").forward(request, response);

        } else {
            StaffDTO staff = staffDAO.getStaffByUsernameAndPassword(staffUsernameParam.trim(), staffPasswordParam.trim());
            boolean isExistAccount = staff != null;

            if (isExistAccount) {
                HttpSession session = request.getSession();
                session.setAttribute("staff", staff);;
                redirectToDashboard(request, response);
            } else {
                request.getSession().setAttribute("loginErrorMsg", "Logic failed");
                request.getRequestDispatcher("/WEB-INF/authentication/StaffLogin.jsp").forward(request, response);
            }
        }
    }

    private void redirectToDashboard(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        StaffDTO staff = (StaffDTO) session.getAttribute("staff");
        String role = staff.getRole();
        switch (role) {
            case "Receptionist":
                response.sendRedirect(request.getContextPath() + "/receptionist-dashboard");
                break;

            case "Pharmacist":
                response.sendRedirect(request.getContextPath() + "/pharmacist-dashboard");
                break;

            case "Doctor":
                DoctorDTO doctor = (new DoctorDAO()).getDoctorByStaffID(staff.getStaffID());
                session.setAttribute("doctor", doctor);
                response.sendRedirect(request.getContextPath() + "/doctor-dashboard");
                break;

            case "Admin":
                response.sendRedirect(request.getContextPath() + "/admin-dashboard");
                break;

            default:
                throw new IOException();
        }
    }

    private boolean isValidStaffPassword(HttpServletRequest request, String staffPasswordParam) {

        if (staffPasswordParam == null || staffPasswordParam.isBlank()) {
            request.setAttribute("staffPasswordErrorMsg", "Password cant't be empty.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidStaffUsername(HttpServletRequest request, String staffUsernameParam) {

        if (staffUsernameParam == null || staffUsernameParam.isBlank()) {
            request.setAttribute("staffUsernameErrorMsg", "Username can't be empty.");
            return false;
        } else {
            return true;
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
