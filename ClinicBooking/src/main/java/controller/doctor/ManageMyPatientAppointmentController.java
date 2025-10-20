/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dao.AppointmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import model.Appointment;
import model.User;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class ManageMyPatientAppointmentController extends HttpServlet {

    private AppointmentDAO appointmentDAO;

    /**
     * Initialize all the necessary DAO using in this controller.
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
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
            out.println("<title>Servlet ManageMyPatientAppointment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageMyPatientAppointment at " + request.getContextPath() + "</h1>");
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
        int doctorID = ((User) request.getSession().getAttribute("user")).getUserID();

        String action = request.getParameter("action");
        if ((action == null) || (action.isEmpty())) {
            showMyPatientAppointmentList(request, response, doctorID);
        }
        if (action.equals("detail")) {
            showMyPatientAppointmentDetail(request, response, doctorID);
        }

    }

    /**
     * Show thông tin danh sách lịch hẹn
     *
     * @param request
     * @param response
     * @param doctorID
     * @throws ServletException
     * @throws IOException
     */
    private void showMyPatientAppointmentList(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Appointment> list;
        if ((keyword != null) && (!keyword.trim().isEmpty())) {
            list = appointmentDAO.searchAppointmentsByDoctor(doctorID, keyword);
        } else {
            list = appointmentDAO.getAllAppointmentsByDoctorId(doctorID);
        }
        request.setAttribute("myPatientAppointmentList", list);
        request.getRequestDispatcher("/WEB-INF/doctor/ManageMyPatientAppointment.jsp").forward(request, response);
    }

    /**
     * Show chi tiết 1 lịch hẹn
     *
     * @param request
     * @param response
     * @param doctorID
     * @throws ServletException
     * @throws IOException
     */
    private void showMyPatientAppointmentDetail(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {
        try {
            int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
            Appointment appointment = appointmentDAO.getDetailAppointmentById(appointmentID, doctorID);
            if (appointment.getAppointmentID() == appointmentID) {
                request.setAttribute("detailAppointment", appointment);
                request.getRequestDispatcher("/WEB-INF/doctor/MyPatientAppointmentDetail.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-appointment");
        }
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
