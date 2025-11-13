/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.phamacist;

import constants.PharmacistDashboardConstants;
import dao.MedicineDAO;
import dao.PrescriptionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.MedicineDTO;
import model.PrescriptionDTO;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class PharmacistDashboardController extends HttpServlet {
    
    private MedicineDAO medicineDAO;
    private PrescriptionDAO prescriptionDAO;

    @Override
    public void init() throws ServletException {
        medicineDAO = new MedicineDAO();
        prescriptionDAO = new PrescriptionDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PharmacistDashboardController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PharmacistDashboardController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);

        int totalMedicine = medicineDAO.getTotalMedicines();
        int lowStock = medicineDAO.getLowStockMedicines();
        int numberPendingPrecription = prescriptionDAO.getPendingPrecription();
        int numberDeliverPrecriptionToday = prescriptionDAO.getDeliverPrecriptionToday();
        List<MedicineDTO> lowStockMedicneList = medicineDAO.getLowStockMedicinesList();
        List<PrescriptionDTO> pendingPrecriptionList = prescriptionDAO.getPendingPrecriptionList();
        
        request.setAttribute("totalMedicine", totalMedicine);
        request.setAttribute("lowStock", lowStock);
        request.setAttribute("numberPendingPrecription", numberPendingPrecription);
        request.setAttribute("numberDeliverPrecriptionToday", numberDeliverPrecriptionToday);
        request.setAttribute("lowStockMedicneList", lowStockMedicneList);
        request.setAttribute("pendingPrecriptionList", pendingPrecriptionList);

        // Show the user the pharmacist dashboard.
        request.getRequestDispatcher(PharmacistDashboardConstants.PHARMACIST_DASHBOARD_URL).forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);

        // Redirect to this controller.
        response.sendRedirect(request.getContextPath() + "/pharmacist-dashboard");
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
