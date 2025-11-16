/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.patient;

import dao.InvoiceDAO;
import model.InvoiceDTO;
import utils.VietQRService;
import constants.PaymentConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import model.PatientDTO;

/**
 *
 * @author Le Anh Tuan - CE180905
 */
public class PaymentController extends HttpServlet {

    private final InvoiceDAO invoiceDAO = new InvoiceDAO();

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

        // Check session login
        HttpSession session = request.getSession();
        PatientDTO sessionPatient = (PatientDTO) session.getAttribute("patient");

        if (sessionPatient == null) {
            session.setAttribute("errorMessage", "Your session has expired. Please log in again.");
            response.sendRedirect(request.getContextPath() + "/patient-login");
            return;
        }

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
            String qrDescription = "CLINIC" + currentTime;
            String qrUrl = VietQRService.createVietQRImageUrl(invoice.getTotalFee(), qrDescription);

            // Set attributes for JSP
            request.setAttribute("invoice", invoice);
            request.setAttribute("invoiceId", invoiceId);
            request.setAttribute("qrUrl", qrUrl);
            request.setAttribute("contextPath", request.getContextPath());

            // Add bank information for QR section
            request.setAttribute("bankName", utils.VietQRConfig.get("vietqr.bank.name"));
            request.setAttribute("accountNumber", utils.VietQRConfig.getAccountNumber());
            request.setAttribute("accountName", utils.VietQRConfig.getAccountName());

            // Calculate VND amount
            double vndAmount = VietQRService.convertUsdToVnd(invoice.getTotalFee());
            request.setAttribute("vndAmount", vndAmount);

            // Payment reference - CLINIC + current time
            String paymentReference = "CLINIC" + currentTime;
            request.setAttribute("paymentReference", paymentReference);

            // Format currency display
            String currencyDisplay = String.format("$%.2f", invoice.getTotalFee());
            request.setAttribute("currencyDisplay", currencyDisplay);

            request.getRequestDispatcher(PaymentConstants.PAYMENT_JSP).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + PaymentConstants.MANAGE_INVOICES_REDIRECT);
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

        String action = request.getParameter("action");
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

            String invoiceIdStr = request.getParameter("invoiceId");
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
                try ( PrintWriter out = response.getWriter()) {
                    out.print(jsonResponse.toString());
                    out.flush();
                }
                return;
            }

            if ("processCashPayment".equals(action)) {
                // Process cash payment
                boolean success = invoiceDAO.updateInvoicePaymentAndStatus(
                        invoiceId, "Cash", "Paid", LocalDateTime.now()
                );

                if (success) {
                    jsonResponse.addProperty("success", true);
                    jsonResponse.addProperty("message", "Cash payment processed successfully!");
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Failed to process cash payment");
                }

            } else if ("markPaymentSuccess".equals(action)) {
                // Mark Credit Card payment as successful
                boolean success = invoiceDAO.updateInvoicePaymentAndStatus(
                        invoiceId, "Credit Card", "Paid", LocalDateTime.now()
                );

                if (success) {
                    jsonResponse.addProperty("success", true);
                    jsonResponse.addProperty("message", "Credit Card payment confirmed successfully!");
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Failed to process Credit Card payment");
                }
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid action");
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
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Payment Controller - Handles cash and credit card payments";
    }
}
