/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.patient;

import dao.InvoiceDAO;
import dao.PatientDAO;
import dao.DoctorDAO;
import model.InvoiceDTO;
import model.PatientDTO;
import constants.ManageMyInvoiceConstants;
import java.io.IOException;
import java.util.List;
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
    private PatientDAO patientDAO;
    private DoctorDAO doctorDAO;

    @Override
    public void init() throws ServletException {
        invoiceDAO = new InvoiceDAO();
        patientDAO = new PatientDAO();
        doctorDAO = new DoctorDAO();
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
            session.setAttribute("errorMessage", ManageMyInvoiceConstants.ERROR_SESSION_EXPIRED);
            response.sendRedirect(request.getContextPath() + "/authentication");
            return;
        }

        String invoiceIdParam = request.getParameter(ManageMyInvoiceConstants.PARAM_ID);

        // Check if this is a request for invoice detail
        if (invoiceIdParam != null && !invoiceIdParam.trim().isEmpty()) {
            handleInvoiceDetail(request, response, invoiceIdParam, patient.getPatientID());
            return;
        }

        // Handle invoices list view
        handleInvoicesList(request, response, patient.getPatientID());
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
     * Handle invoice detail view
     */
    private void handleInvoiceDetail(HttpServletRequest request, HttpServletResponse response,
            String invoiceIdParam, int patientId)
            throws ServletException, IOException {

        try {
            int invoiceId = Integer.parseInt(invoiceIdParam);

            // Get invoice details
            InvoiceDTO invoice = invoiceDAO.getInvoiceById(invoiceId);

            // Check if invoice exists
            if (invoice == null) {
                request.getSession().setAttribute("errorMessage", ManageMyInvoiceConstants.ERROR_INVOICE_NOT_FOUND);
                response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
                return;
            }

            // Verify patient ownership through medical record -> appointment -> patient
            if (invoice.getMedicalRecordID() == null
                    || invoice.getMedicalRecordID().getAppointmentID() == null
                    || invoice.getMedicalRecordID().getAppointmentID().getPatientID() == null
                    || invoice.getMedicalRecordID().getAppointmentID().getPatientID().getPatientID() != patientId) {

                request.getSession().setAttribute("errorMessage", ManageMyInvoiceConstants.ERROR_UNAUTHORIZED_ACCESS);
                response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
                return;
            }

            // Get doctor's average rating if doctor exists
            if (invoice.getMedicalRecordID().getAppointmentID().getDoctorID() != null) {
                int doctorId = invoice.getMedicalRecordID().getAppointmentID().getDoctorID().getDoctorID();
                double averageRating = doctorDAO.getAverageRatingByDoctorId(doctorId);
                request.setAttribute("averageRating", averageRating);
            }

            // Set attributes for JSP
            request.setAttribute(ManageMyInvoiceConstants.ATTR_INVOICE, invoice);

            // Forward to detail page
            request.getRequestDispatcher(ManageMyInvoiceConstants.DETAIL_PAGE_JSP).forward(request, response);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", ManageMyInvoiceConstants.ERROR_INVALID_INVOICE_ID);
            response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", ManageMyInvoiceConstants.ERROR_GENERAL);
            response.sendRedirect(request.getContextPath() + ManageMyInvoiceConstants.BASE_URL);
        }
    }

    /**
     * Handle invoices list view
     */
    private void handleInvoicesList(HttpServletRequest request, HttpServletResponse response, int patientId)
            throws ServletException, IOException {

        try {
            // Get search parameters
            String searchQuery = request.getParameter(ManageMyInvoiceConstants.PARAM_SEARCH);
            List<InvoiceDTO> invoiceList;

            // Apply search - Use existing DAO methods
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                invoiceList = invoiceDAO.searchInvoicesByPatientId(patientId, searchQuery);
            } else {
                invoiceList = invoiceDAO.getInvoicesByPatientId(patientId);
            }

            // Set attributes for JSP
            request.setAttribute(ManageMyInvoiceConstants.ATTR_INVOICE_LIST, invoiceList);
            request.setAttribute(ManageMyInvoiceConstants.ATTR_SEARCH_QUERY, searchQuery);

            // Forward to JSP
            request.getRequestDispatcher(ManageMyInvoiceConstants.LIST_PAGE_JSP).forward(request, response);

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", ManageMyInvoiceConstants.ERROR_GENERAL);
            request.getRequestDispatcher(ManageMyInvoiceConstants.LIST_PAGE_JSP).forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Manage My Invoice Controller";
    }
}
