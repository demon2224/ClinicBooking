/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;

import dao.PatientDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.EmailService;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class ForgotPasswordController extends HttpServlet {

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
            out.println("<title>Servlet ForgotPasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordController at " + request.getContextPath() + "</h1>");
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

        request.getRequestDispatcher("/WEB-INF/authentication/ForgotPassword.jsp").forward(request, response);
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

        String emailParam = request.getParameter("email");

        if (emailParam == null || emailParam.isBlank()) {
            request.setAttribute("errorMsg", "Email can't be empty.");
            request.getRequestDispatcher("/WEB-INF/authentication/ForgotPassword.jsp").forward(request, response);

        } else {

            if (!patientDAO.isExistEmail(emailParam)) {
                request.setAttribute("errorMsg", "Email don't exist.");
                request.getRequestDispatcher("/WEB-INF/authentication/ForgotPassword.jsp").forward(request, response);
            } else {

                EmailService sv = new EmailService();
                try {
                    String otp = sv.generateOtp();
                    sv.sendOtpEmail(emailParam.trim(), otp);
                    request.getSession().setAttribute("email", emailParam);
                    request.getSession().setAttribute("otp", otp);
                    request.getSession().setAttribute("otpExpiredTime", LocalDateTime.now().plusMinutes(5));
                    response.sendRedirect(request.getContextPath() + "/otp-confirm");
                } catch (Exception ex) {
                    request.setAttribute("errorMsg", "An error has occur!");
                    request.getRequestDispatcher("/WEB-INF/authentication/ForgotPassword.jsp").forward(request, response);
                }
            }
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
