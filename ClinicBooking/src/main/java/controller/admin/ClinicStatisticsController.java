/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import constants.AdminConstants;
import dao.AppointmentDAO;
import dao.DoctorDAO;
import dao.InvoiceDAO;
import dao.MedicineDAO;
import dao.PatientDAO;
import dao.PrescriptionDAO;
import dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.DoctorDTO;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class ClinicStatisticsController extends HttpServlet {

    private StaffDAO staffDAO;
    private DoctorDAO doctorDAO;
    private PatientDAO patientDAO;
    private AppointmentDAO appointmentDAO;
    private InvoiceDAO invoiceDAO;
    private MedicineDAO medicineDAO;
    private PrescriptionDAO prescriptionDAO;

    /**
     * Initialize all the necessary DAO using in this controller.
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAO();
        doctorDAO = new DoctorDAO();
        patientDAO = new PatientDAO();
        appointmentDAO = new AppointmentDAO();
        invoiceDAO = new InvoiceDAO();
        medicineDAO = new MedicineDAO();
        prescriptionDAO = new PrescriptionDAO();
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
            out.println("<title>Servlet ClinicStatisticsController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ClinicStatisticsController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staff") == null) {
            response.sendRedirect(request.getContextPath() + "/staff-login");
            return;
        }
        try {
            int totalDoctors = doctorDAO.getTotalDoctors();
            int totalPatients = patientDAO.getTotalPatients();
            int totalAppointments = appointmentDAO.getTotalAppointments();
            int totalPrescriptions = prescriptionDAO.getTotalPrescriptions();
            int totalInvoices = invoiceDAO.getTotalInvoices();
            int lowStockCount = medicineDAO.getLowStockMedicines();

            int apPending = appointmentDAO.getAppointmentsByStatus("Pending");
            int apApproved = appointmentDAO.getAppointmentsByStatus("Approved");
            int apCompleted = appointmentDAO.getAppointmentsByStatus("Completed");
            int apCanceled = appointmentDAO.getAppointmentsByStatus("Canceled");

            int prPending = prescriptionDAO.getPrescriptionsByStatus("Pending");
            int prDelivered = prescriptionDAO.getPrescriptionsByStatus("Delivered");

            int invPending = invoiceDAO.getInvoicesByStatus("Pending");
            int invPaid = invoiceDAO.getInvoicesByStatus("Paid");

            List<DoctorDTO> topDoctors = doctorDAO.getTopDoctorsByAppointments(5);

            request.setAttribute("totalDoctors", totalDoctors);
            request.setAttribute("totalPatients", totalPatients);
            request.setAttribute("totalAppointments", totalAppointments);
            request.setAttribute("totalPrescriptions", totalPrescriptions);
            request.setAttribute("totalInvoices", totalInvoices);
            request.setAttribute("lowStockCount", lowStockCount);

            request.setAttribute("apPending", apPending);
            request.setAttribute("apApproved", apApproved);
            request.setAttribute("apCompleted", apCompleted);
            request.setAttribute("apCanceled", apCanceled);

            request.setAttribute("prPending", prPending);
            request.setAttribute("prDelivered", prDelivered);

            request.setAttribute("invPending", invPending);
            request.setAttribute("invPaid", invPaid);

            request.setAttribute("topDoctors", topDoctors);

            request.getRequestDispatcher(AdminConstants.CLINIC_STATISTICS_URL).forward(request, response);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin-dashboard");
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
