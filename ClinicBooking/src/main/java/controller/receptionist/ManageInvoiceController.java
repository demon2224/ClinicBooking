/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.receptionist;

import dao.AppointmentDAO;
import dao.DoctorDAO;
import dao.InvoiceDAO;
import dao.PatientDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.InvoiceDTO;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class ManageInvoiceController extends HttpServlet {

    private InvoiceDAO invoiceDAO;

    @Override
    public void init() throws ServletException {
        invoiceDAO = new InvoiceDAO();
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

        String action = request.getParameter("action");

        if ("viewDetail".equals(action)) {
            viewInvoiceDetail(request, response);
        } else if ("update".equals(action)) {
            showUpdateForm(request, response);
        } else {
            showInvoiceList(request, response);
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

        if ("update-confirm".equals(action)) {
            updateInvoice(request, response);
        } else if ("cancel".equals(action)) {
            cancelInvoice(request, response);
        } else {
            showInvoiceList(request, response);
        }
    }

    /**
     *
     */
    private void showInvoiceList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchQuery = request.getParameter("searchQuery");
        List<InvoiceDTO> invoices;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            invoices = invoiceDAO.searchInvoices(searchQuery.trim());
        } else {
            invoices = invoiceDAO.getAllInvoices();
        }

        request.setAttribute("invoices", invoices);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("/WEB-INF/receptionist/ReceptionistInvoice.jsp")
                .forward(request, response);
    }

    /**
     * show invoice detail
     */
    private void viewInvoiceDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int invoiceId = Integer.parseInt(request.getParameter("id"));
        InvoiceDTO invoiceDetail = invoiceDAO.getInvoiceDetail(invoiceId);

        request.setAttribute("invoiceDetail", invoiceDetail);
        request.getRequestDispatcher("/WEB-INF/receptionist/InvoiceDetail.jsp")
                .forward(request, response);
    }

    /**
     * show form update invoice
     */
    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int invoiceId = Integer.parseInt(request.getParameter("id"));
        InvoiceDTO invoiceDetail = invoiceDAO.getInvoiceDetail(invoiceId);

        request.setAttribute("invoiceDetail", invoiceDetail);
        request.getRequestDispatcher("/WEB-INF/receptionist/UpdateInvoice.jsp")
                .forward(request, response);
    }

    /**
     * update invoice
     */
    private void updateInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
        String newStatus = request.getParameter("invoiceStatus");
        String paymentType = request.getParameter("paymentType");

        boolean updated = invoiceDAO.updateInvoice(invoiceId, newStatus, paymentType);

        if (updated) {
            request.setAttribute("message", "Invoice updated successfully!");
        } else {
            request.setAttribute("message", "Failed to update invoice!");
        }

        showInvoiceList(request, response);
    }

    /**
     * change invoice status to cancel
     */
    private void cancelInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
        boolean result = invoiceDAO.cancelInvoice(invoiceId);

        if (result) {
            request.setAttribute("message", "Invoice canceled successfully!");
        } else {
            request.setAttribute("message", "Failed to cancel invoice!");
        }

        showInvoiceList(request, response);
    }



    @Override
    public String getServletInfo() {
        return "ManageInvoiceController - Receptionist Invoice Management";
    }
}
