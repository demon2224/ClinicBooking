/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import dao.PatientDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import validate.ResetPasswordValidate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class ResetPasswordController extends HttpServlet {
    
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
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
            out.println("<title>Servlet ResetPasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPasswordController at " + request.getContextPath() + "</h1>");
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

        request.getRequestDispatcher("/WEB-INF/authentication/ResetPassword.jsp").forward(request, response);
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
        String passwordParam = request.getParameter("newPassword");
        String confirmPasswordParam = request.getParameter("confirmPassword");

        boolean isValidPassword = isValidPassword(request, passwordParam, confirmPasswordParam);

        if (isValidPassword) {
            patientDAO.updatePassword(passwordParam, (String) request.getSession().getAttribute("email"));
            response.sendRedirect(request.getContextPath() + "/patient-login");
        } else {
            request.getRequestDispatcher("/WEB-INF/authentication/ResetPassword.jsp").forward(request, response);
        }

    }

    private boolean isValidPassword(HttpServletRequest request, String passwordParam, String confirmPasswordParam) {
        if (ResetPasswordValidate.isEmpty(passwordParam) || ResetPasswordValidate.isEmpty(confirmPasswordParam)) {
            request.setAttribute("errorMsg", "Password can't be empty.");
            return false;
        } else if (!ResetPasswordValidate.isValidPassword(passwordParam)) {
            request.setAttribute("errorMsg", "Invalid password.");
            return false;
        } else if (!ResetPasswordValidate.isValidConfirmPassword(passwordParam, confirmPasswordParam)) {
            request.setAttribute("errorMsg", "Confirm password is not match with password.");
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
