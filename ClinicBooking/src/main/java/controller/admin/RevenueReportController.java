/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import constants.AdminConstants;
import dao.InvoiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.DoctorDTO;
import model.InvoiceDTO;
import model.MedicineDTO;
import model.SpecialtyDTO;
import model.StaffDTO;

/**
 * Controller for Revenue Report
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class RevenueReportController extends HttpServlet {

    private InvoiceDAO invoiceDAO;

    @Override
    public void init() throws ServletException {
        invoiceDAO = new InvoiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get revenue data
            double paidRevenue = invoiceDAO.getPaidRevenue();
            double pendingRevenue = invoiceDAO.getPendingRevenue();
            Map<String, Integer> paymentMethods = invoiceDAO.getPaymentMethodDistribution();
            List<InvoiceDTO> monthlyRevenue = invoiceDAO.getMonthlyRevenue(12);
            List<SpecialtyDTO> specialtyRevenue = invoiceDAO.getRevenueBySpecialty();
            List<DoctorDTO> doctorRevenue = invoiceDAO.getRevenueByDoctor(10);
            List<MedicineDTO> topMedicines = invoiceDAO.getTopMedicinesByRevenue(5);

            // Set attributes
            request.setAttribute("paidRevenue", paidRevenue);
            request.setAttribute("pendingRevenue", pendingRevenue);
            request.setAttribute("paymentMethods", paymentMethods);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("specialtyRevenue", specialtyRevenue);
            request.setAttribute("doctorRevenue", doctorRevenue);
            request.setAttribute("topMedicines", topMedicines);

            // Forward to JSP
            request.getRequestDispatcher(AdminConstants.REVENUE_REPORT_JSP).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + AdminConstants.ADMIN_DASHBOARD_URL);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + AdminConstants.REVENUE_REPORT_URL);
    }

    @Override
    public String getServletInfo() {
        return "Revenue Report Controller";
    }
}
