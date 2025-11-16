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
import jakarta.servlet.http.HttpSession;
import model.PatientDTO;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class PatientLoginController extends HttpServlet {

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
            out.println("<title>Servlet LoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginController at " + request.getContextPath() + "</h1>");
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

        request.getRequestDispatcher("/WEB-INF/authentication/PatientLogin.jsp").forward(request, response);
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

        String patientUsernameParam = request.getParameter("patient-username");
        String patientPasswordParam = request.getParameter("patient-password");

        boolean isValidPatientUsername = isValidPatientUsername(request, patientUsernameParam);
        boolean isValidPatientPassword = isValidPatientPassword(request, patientPasswordParam);

        if (!isValidPatientUsername
                || !isValidPatientPassword) {
            request.getRequestDispatcher("/WEB-INF/authentication/PatientLogin.jsp").forward(request, response);

        } else {
            PatientDTO patient = patientDAO.getPatientByUsernameAndPassword(patientUsernameParam, patientPasswordParam);
            boolean isExistAccount = patient != null;

            if (isExistAccount) {
                HttpSession session = request.getSession();
                session.setAttribute("patient", patient);
                session.setAttribute("successMessage", "Welcome back, " + patient.getFullName() + "! You have successfully logged in.");
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("loginErrorMsg", "Wrong password or username!");
                request.getRequestDispatcher("/WEB-INF/authentication/PatientLogin.jsp").forward(request, response);
            }
        }
    }

    private boolean isValidPatientPassword(HttpServletRequest request, String patientPasswordParam) {

        if (patientPasswordParam == null || patientPasswordParam.isBlank()) {
            request.setAttribute("patientPasswordErrorMsg", "Password cant't be empty.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidPatientUsername(HttpServletRequest request, String patientUsernameParam) {

        if (patientUsernameParam == null || patientUsernameParam.isBlank()) {
            request.setAttribute("patientUsernameErrorMsg", "Username can't be empty.");
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
