/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.patient;

import dao.InvoiceDAO;
import dao.AppointmentDAO;
import dao.PatientDAO;
import dao.DoctorDAO;
import dao.PrescriptionDAO;
import model.InvoiceDTO;
import model.AppointmentDTO;
import model.PatientDTO;
import model.PrescriptionItemDTO;
import constants.ManageMyInvoiceConstants;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for viewing and managing patient's invoices (list and detail).
 *
 * @author Le Anh Tuan - CE180905
 */
public class ManageMyInvoiceController extends HttpServlet {

    private InvoiceDAO invoiceDAO;
    private AppointmentDAO appointmentDAO;
    private PatientDAO patientDAO;
    private DoctorDAO doctorDAO;
    private PrescriptionDAO prescriptionDAO;

    @Override
    public void init() throws ServletException {
        invoiceDAO = new InvoiceDAO();
        appointmentDAO = new AppointmentDAO();
        patientDAO = new PatientDAO();
        doctorDAO = new DoctorDAO();
        prescriptionDAO = new PrescriptionDAO();
    }

    /**
     * Handles GET requests - Display invoices list or invoice detail
     *
     * @param request
     * @param response
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in as patient
        HttpSession session = request.getSession();
        PatientDTO patient = (PatientDTO) session.getAttribute("patient");

        if (patient == null) {
            session.setAttribute("errorMessage", "Your session has expired. Please log in again.");
            response.sendRedirect(request.getContextPath() + "/patient-login");
            return;
        }

        String invoiceIdParam = request.getParameter("id");
        String appointmentIdParam = request.getParameter("appointmentId");

        // Check if this is a request for consultation payment detail (appointmentId)
        if (appointmentIdParam != null && !appointmentIdParam.trim().isEmpty()) {
            handleConsultationPaymentDetail(request, response, appointmentIdParam, patient.getPatientID());
            return;
        }

        // Check if this is a request for medicine invoice detail (invoiceId)
        if (invoiceIdParam != null && !invoiceIdParam.trim().isEmpty()) {
            handleInvoiceDetail(request, response, invoiceIdParam, patient.getPatientID());
            return;
        }

        // Handle invoices list view
        handleInvoicesList(request, response);
    }

    /**
     * Handles POST requests - Currently not used for invoice management
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // For future enhancements like invoice payment processing
        response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
    }

    /**
     * Handle consultation payment detail view (consultation fee)
     * Consultation payment does not have separate invoice, only appointment that has been paid
     */
    private void handleConsultationPaymentDetail(HttpServletRequest request, HttpServletResponse response,
            String appointmentIdParam, int patientId)
            throws ServletException, IOException {

        try {
            // Get patient from session
            HttpSession session = request.getSession();
            PatientDTO sessionPatient = (PatientDTO) session.getAttribute("patient");
            int appointmentId = Integer.parseInt(appointmentIdParam);

            // Get appointment details
            AppointmentDTO appointment = appointmentDAO.getAppointmentById(appointmentId);

            // Check if appointment exists
            if (appointment == null) {
                request.getSession().setAttribute("errorMessage", "Appointment not found.");
                response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
                return;
            }

            // Verify patient ownership
            if (appointment.getPatientID() == null
                    || appointment.getPatientID().getPatientID() != sessionPatient.getPatientID()
                    || appointment.getDoctorID() == null
                    || !"Completed".equals(appointment.getAppointmentStatus())) {
                request.getSession().setAttribute("errorMessage", "You are not authorized to view this consultation payment.");
                response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
                return;
            }

            // Get consultation fee from specialty
            double consultationFee = appointmentDAO.getConsultationFee(appointment.getDoctorID().getDoctorID());
            
            // Get medicine invoice info if exists (fee + status)
            Object[] medicineInvoiceInfo = invoiceDAO.getMedicineInvoiceInfoByAppointmentId(appointmentId);
            double medicineFee = 0;
            String medicineFeeStatus = null;
            if (medicineInvoiceInfo != null) {
                medicineFee = (Double) medicineInvoiceInfo[0];
                medicineFeeStatus = (String) medicineInvoiceInfo[1];
            }
            
            // Get prescription items if exists
            Integer prescriptionId = prescriptionDAO.getPrescriptionIDByAppointmentID(appointmentId);
            List<PrescriptionItemDTO> prescriptionItems = null;
            if (prescriptionId != null) {
                prescriptionItems = prescriptionDAO.getPrescriptionItemListByPrescriptionID(prescriptionId);
            }

            // Set attributes - reuse MyInvoiceDetail.jsp
            request.setAttribute("appointment", appointment);
            request.setAttribute("consultationFee", consultationFee);
            request.setAttribute("consultationFeeStatus", "PAID"); // Consultation fee is always paid for completed appointments
            request.setAttribute("medicineFee", medicineFee);
            request.setAttribute("medicineFeeStatus", medicineFeeStatus);
            request.setAttribute("prescriptionItems", prescriptionItems);

            // Forward to existing invoice detail JSP (will handle both appointment and invoice)
            request.getRequestDispatcher(ManageMyInvoiceConstants.DETAIL_PAGE_JSP).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
        }
    }

    /**
     * Handle invoice detail view (medicine invoice)
     */
    private void handleInvoiceDetail(HttpServletRequest request, HttpServletResponse response,
            String invoiceIdParam, int patientId)
            throws ServletException, IOException {

        try {
            // Get patient from session
            HttpSession session = request.getSession();
            PatientDTO sessionPatient = (PatientDTO) session.getAttribute("patient");
            int invoiceId = Integer.parseInt(invoiceIdParam);

            // Get invoice details
            InvoiceDTO invoice = invoiceDAO.getInvoiceById(invoiceId);

            // Check if invoice exists
            if (invoice == null) {
                request.getSession().setAttribute("errorMessage", "Invoice not found.");
                response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
                return;
            }

            // Verify patient ownership through medical record -> appointment -> patient
            // Verify ownership and data completeness
            if (invoice.getMedicalRecordID() == null
                    || invoice.getMedicalRecordID().getAppointmentID() == null
                    || invoice.getMedicalRecordID().getAppointmentID().getPatientID() == null
                    || invoice.getMedicalRecordID().getAppointmentID().getPatientID().getPatientID() != sessionPatient.getPatientID()
                    || invoice.getMedicalRecordID().getAppointmentID().getDoctorID() == null) {
                request.getSession().setAttribute("errorMessage", "You are not authorized to view this invoice.");
                response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
                return;
            }

            // data
            int doctorId = invoice.getMedicalRecordID().getAppointmentID().getDoctorID().getDoctorID();
            double averageRating = doctorDAO.getAverageRatingByDoctorId(doctorId);
            
            // Get consultation fee
            int appointmentId = invoice.getMedicalRecordID().getAppointmentID().getAppointmentID();
            double consultationFee = appointmentDAO.getConsultationFee(doctorId);
            
            // Get prescription items if exists
            // InvoiceDTO already has prescription with items loaded, but we'll get it from appointment to be safe
            Integer prescriptionId = prescriptionDAO.getPrescriptionIDByAppointmentID(appointmentId);
            List<PrescriptionItemDTO> prescriptionItems = null;
            if (prescriptionId != null) {
                prescriptionItems = prescriptionDAO.getPrescriptionItemListByPrescriptionID(prescriptionId);
            }

            // Set attributes
            request.setAttribute("invoice", invoice);
            request.setAttribute("averageRating", averageRating);
            request.setAttribute("consultationFee", consultationFee);
            request.setAttribute("consultationFeeStatus", "PAID"); // Consultation fee is always paid for completed appointments
            request.setAttribute("medicineFee", invoice.getTotalFee());
            request.setAttribute("medicineFeeStatus", invoice.getInvoiceStatus());
            request.setAttribute("prescriptionItems", prescriptionItems);

            // Forward
            request.getRequestDispatcher(ManageMyInvoiceConstants.DETAIL_PAGE_JSP).forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
        }
    }

    /**
     * Handle invoices list view
     * Only shows consultation payments (completed appointments)
     */
    private void handleInvoicesList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get patient from session
        HttpSession session = request.getSession();
        PatientDTO patient = (PatientDTO) session.getAttribute("patient");
        int patientId = patient.getPatientID();

        // Get search parameters
        String searchQuery = request.getParameter("search");
        
        // Only show consultation payments (Completed appointments)
        List<AppointmentDTO> completedAppointments = appointmentDAO.getCompletedAppointmentsByPatientId(patientId);

        // Get medicine fee for each appointment
        Map<Integer, Double> appointmentMedicineFeeMap = new HashMap<>();
        for (AppointmentDTO appointment : completedAppointments) {
            double medicineFee = invoiceDAO.getMedicineFeeByAppointmentId(appointment.getAppointmentID());
            if (medicineFee > 0) {
                appointmentMedicineFeeMap.put(appointment.getAppointmentID(), medicineFee);
            }
        }

        // Set attributes for JSP
        request.setAttribute("completedAppointments", completedAppointments);  // Only completed consultation payments
        request.setAttribute("appointmentMedicineFeeMap", appointmentMedicineFeeMap);  // Map of appointmentId -> medicine fee
        request.setAttribute("searchQuery", searchQuery);

        // Forward to JSP
        request.getRequestDispatcher(ManageMyInvoiceConstants.LIST_PAGE_JSP).forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Manage My Invoice Controller";
    }
}
