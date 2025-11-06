/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dao.AppointmentDAO;
import dao.MedicalRecordDAO;
import dao.PrescriptionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.AppointmentDTO;
import model.DoctorDTO;
import model.MedicalRecordDTO;
import model.PrescriptionDTO;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class DoctorDashboardController extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private MedicalRecordDAO medicalRecordDAO;
    private PrescriptionDAO prescriptionDAO;

    /**
     * Initialize all the necessary DAO using in this controller.
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        medicalRecordDAO = new MedicalRecordDAO();
        prescriptionDAO = new PrescriptionDAO();
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
            out.println("<title>Servlet DoctorDashboardController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoctorDashboardController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        DoctorDTO doctor = (DoctorDTO) session.getAttribute("doctor");
        if (doctor == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int doctorID = doctor.getDoctorID();

        // 🔹 Dữ liệu chi tiết
        List<AppointmentDTO> myPatientAppointmentList = appointmentDAO.getPatientAppointmentOfDoctorByID(doctorID);
        List<MedicalRecordDTO> myPatientMedicalRecordList = medicalRecordDAO.getPatientMedicalRecordListByDoctorID(doctorID);
        List<PrescriptionDTO> myPatientPrescriptionList = prescriptionDAO.getPatientPrescriptionListByDoctorID(doctorID);

        // 🔹 Thống kê
        int todayAppointmentCount = appointmentDAO.countTodayAppointmentsByDoctor(doctorID);
        int totalMedicalRecordCount = medicalRecordDAO.countMedicalRecordsByDoctor(doctorID);
        int totalPrescriptionCount = prescriptionDAO.countPrescriptionsByDoctor(doctorID);

        // 🔹 Gửi sang JSP
        request.setAttribute("myPatientAppointmentList", myPatientAppointmentList);
        request.setAttribute("myPatientMedicalRecordList", myPatientMedicalRecordList);
        request.setAttribute("myPatientPrescriptionList", myPatientPrescriptionList);

        request.setAttribute("todayAppointmentCount", todayAppointmentCount);
        request.setAttribute("totalMedicalRecordCount", totalMedicalRecordCount);
        request.setAttribute("totalPrescriptionCount", totalPrescriptionCount);

        request.getRequestDispatcher("/WEB-INF/doctor/DoctorDashboard.jsp").forward(request, response);
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
