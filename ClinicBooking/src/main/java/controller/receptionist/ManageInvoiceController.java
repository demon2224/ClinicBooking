/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.receptionist;

import dao.InvoiceDAO;
import java.io.IOException;
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


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "viewDetail":
                viewInvoiceDetail(request, response);
                break;
            case "update":
                showUpdateForm(request, response);
                break;
            default:
                showInvoiceList(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "update-confirm":
                updateInvoice(request, response);
                break;
            case "cancel":
                cancelInvoice(request, response);
                break;
            default:
                showInvoiceList(request, response);
                break;
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
            request.getSession().setAttribute("successMessage", "Invoice updated successfully!");
        } else {
            request.getSession().setAttribute("successMessage", "Failed to update invoice!");
        }

        response.sendRedirect("manage-invoice");
    }

    /**
     * change invoice status to cancel
     */
    private void cancelInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
        boolean result = invoiceDAO.cancelInvoice(invoiceId);

        if (result) {
            request.getSession().setAttribute("successMessage", "Invoice canceled successfully!");
        } else {
            request.getSession().setAttribute("successMessage", "Failed to cancel invoice!");
        }

        response.sendRedirect("manage-invoice");
    }

    @Override
    public String getServletInfo() {
        return "ManageInvoiceController - Receptionist Invoice Management";
    }
}
