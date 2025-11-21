/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.patient;

import dao.InvoiceDAO;
import dao.AppointmentDAO;
import dao.PrescriptionDAO;
import model.InvoiceDTO;
import utils.VietQRService;
import constants.PaymentConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import model.PatientDTO;

/**
 * PaymentController - Handles 2 TYPES OF PAYMENTS:
 * 1. "consultation" - Consultation fee payment BEFORE creating appointment (Vietnamese business practice)
 * 2. "medicine" - Medicine payment AFTER prescription is created (optional)
 *
 * @author Le Anh Tuan - CE180905
 */
public class PaymentController extends HttpServlet {

    private final InvoiceDAO invoiceDAO = new InvoiceDAO();
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final PrescriptionDAO prescriptionDAO = new PrescriptionDAO();

    /**
     * Handles the HTTP <code>GET</code> method.
     * Handles 2 types of payments:
     * - type=consultation: Consultation fee payment
     * - type=medicine: Medicine payment (invoice)
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check session login
        HttpSession session = request.getSession();
        PatientDTO sessionPatient = (PatientDTO) session.getAttribute("patient");

        if (sessionPatient == null) {
            session.setAttribute("errorMessage", "Your session has expired. Please log in again.");
            response.sendRedirect(request.getContextPath() + "/patient-login");
            return;
        }

        // Classify payment type
        String paymentType = request.getParameter("type"); // "consultation" or "medicine"
        
        if ("consultation".equals(paymentType)) {
            // Consultation fee payment
            handleConsultationPayment(request, response, sessionPatient);
        } else {
            // Medicine payment (Default - legacy support)
            handleMedicinePayment(request, response, sessionPatient);
        }
    }
    
    /**
     * Handle consultation fee payment BEFORE creating appointment
     */
    private void handleConsultationPayment(HttpServletRequest request, HttpServletResponse response, PatientDTO patient)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Get information from request parameters (set from BookAppointment form)
        String doctorIdStr = request.getParameter("doctorId");
        String appointmentDateTimeStr = request.getParameter("appointmentDateTime");
        String note = request.getParameter("note");
        
        if (doctorIdStr == null || appointmentDateTimeStr == null) {
            session.setAttribute("errorMessage", "Missing appointment information");
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
            return;
        }
        
        try {
            int doctorId = Integer.parseInt(doctorIdStr);
            Timestamp appointmentDateTime = Timestamp.valueOf(appointmentDateTimeStr.replace("T", " ") + ":00");
            
            // Get consultation fee from doctor's specialty
            double consultationFee = appointmentDAO.getConsultationFee(doctorId);
            
            if (consultationFee <= 0) {
                session.setAttribute("errorMessage", "Cannot determine consultation fee");
                response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
                return;
            }
            
            // Generate payment reference
            SimpleDateFormat timeFormat = new SimpleDateFormat("HHmm");
            String currentTime = timeFormat.format(new Date());
            String paymentReference = "KHAM" + currentTime;  // Consultation payment reference
            
            // Generate QR code URL (VND)
            String qrUrl = VietQRService.createVietQRImageUrl(consultationFee, paymentReference);
            
            // Set attributes for JSP
            request.setAttribute("paymentType", "consultation");
            request.setAttribute("consultationFee", consultationFee);
            request.setAttribute("doctorId", doctorId);
            request.setAttribute("appointmentDateTime", appointmentDateTimeStr);
            request.setAttribute("note", note);
            request.setAttribute("qrUrl", qrUrl);
            request.setAttribute("paymentReference", paymentReference);
            
            // Bank info
            request.setAttribute("bankName", utils.VietQRConfig.get("vietqr.bank.name"));
            request.setAttribute("accountNumber", utils.VietQRConfig.getAccountNumber());
            request.setAttribute("accountName", utils.VietQRConfig.getAccountName());
            
            // Forward to consultation payment JSP
            request.getRequestDispatcher("/WEB-INF/patient/ConsultationPayment.jsp").forward(request, response);
            
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error processing payment: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manage-my-appointments");
        }
    }
    
    /**
     * Handle medicine payment (Invoice) - Legacy logic
     */
    private void handleMedicinePayment(HttpServletRequest request, HttpServletResponse response, PatientDTO sessionPatient)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        String invoiceIdStr = request.getParameter("id");
        if (invoiceIdStr == null) {
            response.sendRedirect(request.getContextPath() + PaymentConstants.MANAGE_INVOICES_REDIRECT);
            return;
        }

        try {
            int invoiceId = Integer.parseInt(invoiceIdStr);
            InvoiceDTO invoice = invoiceDAO.getInvoiceById(invoiceId);

            if (invoice == null) {
                session.setAttribute("errorMessage", "Invoice not found");
                response.sendRedirect(request.getContextPath() + PaymentConstants.MANAGE_INVOICES_REDIRECT);
                return;
            }

            // Verify invoice ownership - Security check
            if (invoice.getMedicalRecordID() == null
                    || invoice.getMedicalRecordID().getAppointmentID() == null
                    || invoice.getMedicalRecordID().getAppointmentID().getPatientID() == null
                    || invoice.getMedicalRecordID().getAppointmentID().getPatientID().getPatientID() != sessionPatient.getPatientID()
                    || invoice.getMedicalRecordID().getAppointmentID().getDoctorID() == null) {
                response.sendRedirect(request.getContextPath() + PaymentConstants.MANAGE_INVOICES_REDIRECT);
                return;
            }

            // Generate time format for payment reference
            SimpleDateFormat timeFormat = new SimpleDateFormat("HHmm");
            String currentTime = timeFormat.format(new Date());

            // Generate QR code URL with new reference format
            String qrDescription = "THUOC" + currentTime;  // Medicine payment reference
            String qrUrl = VietQRService.createVietQRImageUrl(invoice.getTotalFee(), qrDescription);

            // Set attributes for JSP
            request.setAttribute("paymentType", "medicine");
            request.setAttribute("invoice", invoice);
            request.setAttribute("invoiceId", invoiceId);
            request.setAttribute("qrUrl", qrUrl);
            request.setAttribute("contextPath", request.getContextPath());

            // Add bank information for QR section
            request.setAttribute("bankName", utils.VietQRConfig.get("vietqr.bank.name"));
            request.setAttribute("accountNumber", utils.VietQRConfig.getAccountNumber());
            request.setAttribute("accountName", utils.VietQRConfig.getAccountName());

            // Payment reference - Medicine + current time
            String paymentReference = "THUOC" + currentTime;
            request.setAttribute("paymentReference", paymentReference);

            // Format currency display (already in VND, no conversion needed)
            String currencyDisplay = String.format("%.0f VND", invoice.getTotalFee());
            request.setAttribute("currencyDisplay", currencyDisplay);

            request.getRequestDispatcher(PaymentConstants.PAYMENT_JSP).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + PaymentConstants.MANAGE_INVOICES_REDIRECT);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Handles 2 types of payments
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String paymentType = request.getParameter("paymentType"); // "consultation" or "medicine"
        response.setContentType("application/json");

        JsonObject jsonResponse = new JsonObject();

        try {
            // Validate session
            HttpSession session = request.getSession();
            PatientDTO patient = (PatientDTO) session.getAttribute("patient");

            if (patient == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Session expired. Please log in again.");
                try ( PrintWriter out = response.getWriter()) {
                    out.print(jsonResponse.toString());
                    out.flush();
                }
                return;
            }

            // Classify payment processing
            // Logic: doctorId = CONSULTATION payment, invoiceId = MEDICINE payment
            String doctorIdStr = request.getParameter("doctorId");
            String invoiceIdStr = request.getParameter("invoiceId");
            
            if (doctorIdStr != null && !doctorIdStr.trim().isEmpty()) {
                // Consultation fee payment + Create appointment
                processConsultationPayment(request, response, patient, action, jsonResponse);
            } else if (invoiceIdStr != null && !invoiceIdStr.trim().isEmpty()) {
                // Medicine payment (Invoice) - Independent of appointment payment status
                processMedicinePayment(request, response, patient, action, jsonResponse);
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Missing doctorId (for consultation) or invoiceId (for medicine payment).");
            }

        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error: " + e.getMessage());
        }

        try ( PrintWriter out = response.getWriter()) {
            out.print(jsonResponse.toString());
            out.flush();
        }
    }
    
    /**
     * Process consultation fee payment + create appointment
     * NOT related to invoice, prescription, medical record
     * Only create appointment with status "Pending" and save payment info in Note
     */
    private void processConsultationPayment(HttpServletRequest request, HttpServletResponse response, 
                                           PatientDTO patient, String action, JsonObject jsonResponse) {
        try {
            String doctorIdStr = request.getParameter("doctorId");
            String appointmentDateTimeStr = request.getParameter("appointmentDateTime");
            String note = request.getParameter("note");
            
            // Validate required parameters
            if (doctorIdStr == null || doctorIdStr.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Doctor ID is required.");
                return;
            }
            
            if (appointmentDateTimeStr == null || appointmentDateTimeStr.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Appointment date time is required.");
                return;
            }
            
            int doctorId = Integer.parseInt(doctorIdStr);
            Timestamp appointmentDateTime = Timestamp.valueOf(appointmentDateTimeStr.replace("T", " ") + ":00");
            double consultationFee = appointmentDAO.getConsultationFee(doctorId);
            
            if (consultationFee <= 0) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Cannot determine consultation fee for this doctor.");
                return;
            }
            
            if ("markPaymentSuccess".equals(action)) {
                // Create appointment after payment
                // DO NOT create invoice, prescription, medical record
                // Only create appointment with status "Pending" and payment info in Note
                int appointmentId = appointmentDAO.bookAppointmentWithPayment(
                    patient.getPatientID(),
                    doctorId,
                    note,
                    appointmentDateTime,
                    consultationFee,
                    "Credit Card" // Payment type for consultation
                );
                
                if (appointmentId > 0) {
                    // ⭐ Invoice is automatically created by database trigger when appointment is inserted
                    // Get the newly created invoice and update status to "Paid" and payment type to "Credit Card"
                    Integer invoiceId = invoiceDAO.getInvoiceIdByAppointmentId(appointmentId);
                    if (invoiceId != null && invoiceId > 0) {
                        invoiceDAO.updateInvoicePaymentAndStatus(
                            invoiceId, "Credit Card", "Paid", LocalDateTime.now()
                        );
                    } else {
                        // Log warning if invoice not found (should not happen if trigger works correctly)
                        System.err.println("Warning: Invoice not found for appointment ID: " + appointmentId);
                    }
                    
                    jsonResponse.addProperty("success", true);
                    jsonResponse.addProperty("message", "Payment successful! Appointment created. Waiting for receptionist confirmation.");
                    jsonResponse.addProperty("appointmentId", appointmentId);
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Payment successful but failed to create appointment. Please contact support.");
                }
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid action for consultation payment.");
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Invalid doctor ID or appointment date format.");
        } catch (IllegalArgumentException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Invalid appointment date time format: " + e.getMessage());
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error processing consultation payment: " + (e.getMessage() != null ? e.getMessage() : e.getClass().getSimpleName()));
            e.printStackTrace(); // Log for debugging
        }
    }
    
    /**
     * Process medicine payment (Invoice)
     * ONLY used when invoice exists (related to prescription after consultation)
     */
    private void processMedicinePayment(HttpServletRequest request, HttpServletResponse response, 
                                       PatientDTO patient, String action, JsonObject jsonResponse) {
        try {
            String invoiceIdStr = request.getParameter("invoiceId");
            
            // Validate invoiceId before parsing
            if (invoiceIdStr == null || invoiceIdStr.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invoice ID is required for medicine payment.");
                return;
            }
            
            int invoiceId = Integer.parseInt(invoiceIdStr);

            // Verify invoice ownership before processing payment
            InvoiceDTO invoice = invoiceDAO.getInvoiceById(invoiceId);
            if (invoice == null
                    || invoice.getMedicalRecordID() == null
                    || invoice.getMedicalRecordID().getAppointmentID() == null
                    || invoice.getMedicalRecordID().getAppointmentID().getPatientID() == null
                    || invoice.getMedicalRecordID().getAppointmentID().getPatientID().getPatientID() != patient.getPatientID()
                    || invoice.getMedicalRecordID().getAppointmentID().getDoctorID() == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Unauthorized access to invoice.");
                return;
            }

            // Get PrescriptionID from Appointment to update status
            // Try to get from invoice first, if not available, get from appointment
            Integer prescriptionId = null;
            if (invoice.getPrescriptionID() != null) {
                prescriptionId = invoice.getPrescriptionID().getPrescriptionID();
            } else if (invoice.getMedicalRecordID() != null 
                    && invoice.getMedicalRecordID().getAppointmentID() != null) {
                int appointmentId = invoice.getMedicalRecordID().getAppointmentID().getAppointmentID();
                prescriptionId = prescriptionDAO.getPrescriptionIDByAppointmentID(appointmentId);
            }
            
            // ⭐ Medicine payment: ONLY update prescription status, DO NOT update invoice
            if ("markPaymentSuccess".equals(action)) {
                // ⭐ Medicine payment is independent of invoice status
                // Only check and update prescription status (from 'Pending' to 'Paid')
                if (prescriptionId == null) {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Prescription ID not found for this invoice.");
                    return;
                }
                
                // Update PrescriptionStatus to 'Paid' only if current status is 'Pending'
                // Method already has built-in check: WHERE PrescriptionID = ? AND PrescriptionStatus = 'Pending'
                boolean success = prescriptionDAO.updatePrescriptionStatusToPaid(prescriptionId);

                if (success) {
                    jsonResponse.addProperty("success", true);
                    jsonResponse.addProperty("message", "Payment confirmed successfully!");
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Failed to update prescription status. Prescription may already be paid or not found.");
                }
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid action");
            }
            
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error processing medicine payment: " + e.getMessage());
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Payment Controller - Handles cash and credit card payments";
    }
}
