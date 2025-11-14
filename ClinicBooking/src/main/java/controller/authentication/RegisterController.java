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
import validate.RegisterValidate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class RegisterController extends HttpServlet {

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
            out.println("<title>Servlet RegisterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath() + "</h1>");
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

        request.getRequestDispatcher("/WEB-INF/authentication/Register.jsp").forward(request, response);
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

        String firstNameParam = request.getParameter("firstName");
        String lastNameParam = request.getParameter("lastName");
        String sexParam = request.getParameter("sex");
        String dobParam = request.getParameter("dob");
        String phoneNumberParam = request.getParameter("phoneNumber");
        String emailParam = request.getParameter("email");
        String usernameParam = request.getParameter("username");
        String passwordParam = request.getParameter("password");

        boolean isValidFirstName = isValidFirstName(request, firstNameParam);
        boolean isValidLastName = isValidLastName(request, lastNameParam);
        boolean isValidSex = isValidSex(request, sexParam);
        boolean isValidDob = isValidDob(request, dobParam);
        boolean isValidPhoneNumber = isValidPhoneNumber(request, phoneNumberParam);
        boolean isValidEmail = isValidEmail(request, emailParam);
        boolean isValidUsername = isValidUsername(request, usernameParam);
        boolean isValidPassword = isValidPassword(request, passwordParam);

        if (!isValidFirstName
                || !isValidLastName
                || !isValidSex
                || !isValidDob
                || !isValidPhoneNumber
                || !isValidEmail
                || !isValidUsername
                || !isValidPassword) {
            request.getRequestDispatcher("/WEB-INF/authentication/Register.jsp").forward(request, response);
        } else {
            boolean registerResult = patientDAO.register(usernameParam.trim(), passwordParam.trim(), firstNameParam.trim(), lastNameParam.trim(), dobParam.trim(), sexParam.trim(), phoneNumberParam.trim(), emailParam.trim());

            if (registerResult) {
                request.getSession().setAttribute("registerSuccessMsg", "Register account successfully!");
                response.sendRedirect(request.getContextPath() + "/patient-login");
            } else {
                request.setAttribute("registerFailMsg", "Fail to register account!");
                request.getRequestDispatcher("/WEB-INF/authentication/Register.jsp").forward(request, response);
            }
        }

    }

    private boolean isValidPassword(HttpServletRequest request, String passwordParam) {

        if (RegisterValidate.isEmpty(passwordParam)) {
            request.setAttribute("passwordErrorMsg", "Password can't be empty.");
            return false;
        } else if (!RegisterValidate.isValidPassword(passwordParam.trim())) {
            request.setAttribute("passwordErrorMsg", "Password must be 8 to 200 letter and must contain uppercase, lowercase, a number, a special character.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidUsername(HttpServletRequest request, String isValidUsernameParam) {

        if (RegisterValidate.isEmpty(isValidUsernameParam)) {
            request.setAttribute("usernameErrorMsg", "Username can't be empty.");
            return false;
        } else if (!RegisterValidate.isValidUsername(isValidUsernameParam.trim())) {
            request.setAttribute("usernameErrorMsg", "Username must be 8 to 200 and contains only letter, number and white space.");
            return false;
        } else if (patientDAO.isExistUsername(isValidUsernameParam.trim())) {
            request.setAttribute("usernameErrorMsg", "Username already exists.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidEmail(HttpServletRequest request, String emailParam) {

        if (RegisterValidate.isEmpty(emailParam)) {
            request.setAttribute("emailErrorMsg", "Email can't be empty.");
            return false;
        } else if (!RegisterValidate.isValidEmail(emailParam.trim())) {
            request.setAttribute("emailErrorMsg", "Invalid email format.");
            return false;
        } else if (patientDAO.isExistEmail(emailParam.trim())) {
            request.setAttribute("emailErrorMsg", "Email already used.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidPhoneNumber(HttpServletRequest request, String phoneNumberParam) {

        if (RegisterValidate.isEmpty(phoneNumberParam)) {
            request.setAttribute("phoneNumberErrorMsg", "Phone can't be empty.");
            return false;
        } else if (!RegisterValidate.isValidPhoneNumber(phoneNumberParam.trim())) {
            request.setAttribute("phoneNumberErrorMsg", "Invalid phone number format.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidDob(HttpServletRequest request, String dobParam) {
        if (RegisterValidate.isEmpty(dobParam)) {
            request.setAttribute("dobErrorMsg", "Date of birth can't be empty.");
            return false;
        } else if (!RegisterValidate.isValidDateFormat(dobParam.trim())) {
            request.setAttribute("dobErrorMsg", "Invalid date format.");
            return false;
        } else if (!RegisterValidate.isValidDob(dobParam.trim())) {
            request.setAttribute("dobErrorMsg", "Your age must between 18 and 120.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidSex(HttpServletRequest request, String sexParam) {

        if (RegisterValidate.isEmpty(sexParam)) {
            request.setAttribute("sexErrorMsg", "Sex can't be empty.");
            return false;
        } else if (!RegisterValidate.isValidSex(sexParam.trim())) {
            request.setAttribute("sexErrorMsg", "Invalid sex.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidLastName(HttpServletRequest request, String lastNameParam) {

        if (RegisterValidate.isEmpty(lastNameParam)) {
            request.setAttribute("lastNameErrorMsg", "Last name can't be empty.");
            return false;
        } else if (!RegisterValidate.isValidLastNameLength(lastNameParam.trim())) {
            request.setAttribute("lastNameErrorMsg", "Last name length only from 1 to 200 character.");
            return false;
        } else if (!RegisterValidate.isValidLastName(lastNameParam.trim())) {
            request.setAttribute("lastNameErrorMsg", "Last name only contain letter and white space.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidFirstName(HttpServletRequest request, String firstNameParam) {

        if (RegisterValidate.isEmpty(firstNameParam)) {
            request.setAttribute("firstNameErrorMsg", "First name can't be empty.");
            return false;
        } else if (!RegisterValidate.isValidFirstNameLength(firstNameParam.trim())) {
            request.setAttribute("firstNameErrorMsg", "Last name length only from 1 to 200 character.");
            return false;
        } else if (!RegisterValidate.isValidFirstName(firstNameParam.trim())) {
            request.setAttribute("firstNameErrorMsg", "Last name only contain letter and white space.");
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
