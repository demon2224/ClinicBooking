/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;

import dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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

        removeSessionMsg(request);
        String action = request.getParameter("action");

        try {
            switch (action) {

                // If the user is patient.
                case "login":
                    staffLogin(request, response);
                    break;

                // If the user is not above then send redirect them to login view.
                default:
                    handleInvalidRequest(request, response);
                    break;
            }
        } catch (IOException | NullPointerException e) {
            // If an exception occur then show the user the medicine list.
            handleInvalidRequest(request, response);
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
                response.sendRedirect(request.getContextPath() + "/doctor-dashboard");
                break;

            case "Admin":
                response.sendRedirect(request.getContextPath() + "/admin-dashboard");
                break;

            default:
                throw new IOException();
        }
    }

    private void staffLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String staffUsernameParam = request.getParameter("staff-username");
        String staffPasswordParam = request.getParameter("staff-password");

        boolean isValidPatientUsername = isValidStaffUsername(request, staffUsernameParam);
        boolean isValidPatientPassword = isValidStaffPassword(request, staffPasswordParam);

        if (!isValidPatientUsername
                || !isValidPatientPassword) {
            response.sendRedirect(request.getContextPath() + "/staff-login");

        } else {
            StaffDTO staff = staffDAO.getStaffByUsernameAndPassword(staffUsernameParam.trim(), staffPasswordParam.trim());
            boolean isExistAccount = staff != null;

            if (isExistAccount) {
                HttpSession session = request.getSession();
                session.setAttribute("staff", staff);
                request.getSession().setAttribute("loginSuccessMsg", "Login successfully!");
                redirectToDashboard(request, response);
            } else {
                request.getSession().setAttribute("loginErrorMsg", "Logic failed");
                response.sendRedirect(request.getContextPath() + "/staff-login");
            }
        }
    }

    private boolean isValidStaffPassword(HttpServletRequest request, String staffPasswordParam) {
        if (LoginValidate.isEmpty(staffPasswordParam)) {
            request.getSession().setAttribute("staffPasswordErrorMsg", "Password can't be empty.");
            return false;
        } else if (!LoginValidate.isValidPasswordLength(staffPasswordParam.trim())) {
            request.getSession().setAttribute("staffPasswordErrorMsg", "Password length must be range in 8 to 200.");
            return false;
        } else if (!LoginValidate.isValidPassword(staffPasswordParam.trim())) {
            request.getSession().setAttribute("patientPasswordErrorMsg", "Password must be contain 1 special character and 1 uppercase character.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidStaffUsername(HttpServletRequest request, String patientUsernameParam) {
        if (LoginValidate.isEmpty(patientUsernameParam)) {
            request.getSession().setAttribute("staffUsernameErrorMsg", "Username can't be empty.");
            return false;
        } else if (!LoginValidate.isValidUsernameLength(patientUsernameParam.trim())) {
            request.getSession().setAttribute("staffUsernameErrorMsg", "Username length must be range in 8 to 200.");
            return false;
        } else if (!LoginValidate.isValidUsername(patientUsernameParam.trim())) {
            request.getSession().setAttribute("staffUsernameErrorMsg", "Username only can contain letter and number.");
            return false;
        } else {
            return true;
        }
    }

    private void handleInvalidRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/staff-login");
    }

    private void removeSessionMsg(HttpServletRequest request) {

        String[] keys = {
            "staffUsernameErrorMsg", "staffPasswordErrorMsg", "loginSuccessMsg", "loginErrorMsg"
        };

        for (String key : keys) {
            request.getSession().removeAttribute(key);
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
