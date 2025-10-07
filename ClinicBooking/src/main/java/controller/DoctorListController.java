/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.DoctorDAO;
import model.Doctor;
import java.util.List;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
@WebServlet(name = "DoctorListController", urlPatterns = {"/doctor-list"})
public class DoctorListController extends HttpServlet {

    private DoctorDAO doctorDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        doctorDAO = new DoctorDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet DoctorListController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoctorListController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
        try {
            String specialtyParam = request.getParameter("specialty");
            String statusParam = request.getParameter("status");

            List<Doctor> doctors;

            if (specialtyParam != null && !specialtyParam.isEmpty()) {
                int specialtyId = Integer.parseInt(specialtyParam);
                doctors = doctorDAO.getDoctorsBySpecialty(specialtyId);
            } else if ("available".equalsIgnoreCase(statusParam)) {
                doctors = doctorDAO.getAvailableDoctors();
            } else {
                doctors = doctorDAO.getAllDoctors();
            }

            request.setAttribute("doctors", doctors);
            request.setAttribute("totalDoctors", doctors.size());

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading doctor list: " + e.getMessage());
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/DoctorList.jsp").forward(request, response);
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
        processRequest(request, response);
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
