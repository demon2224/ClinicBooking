/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.phamacist;

import dao.MedicineDAO;
import dao.MedicineStockTransactionDAO;
import dao.MedicineTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.MedicineStockTransaction;
import model.MedicineType;
import model.MedicineViewModel;
import validate.CreateNewMedicineValidate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class ManageMedicineController extends HttpServlet {

    private MedicineDAO medicineDAO;
    private MedicineStockTransactionDAO medicineStockTransactionDAO;
    private MedicineTypeDAO medicineTypeDAO;

    @Override
    public void init() throws ServletException {
        medicineDAO = new MedicineDAO();
        medicineStockTransactionDAO = new MedicineStockTransactionDAO();
        medicineTypeDAO = new MedicineTypeDAO();
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
            out.println("<title>Servlet ManageMedicineController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageMedicineController at " + request.getContextPath() + "</h1>");
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

        String action = request.getParameter("action");

        if (action == null || action.isBlank()) {
            handleInvalidRequest(request, response);
            return;
        }

        try {
            if (action.equals("detail")) {
                int medicineParam = Integer.parseInt(request.getParameter("medicineId"));
                handleViewMedicineDetailRequest(request, response, medicineParam);
                return;
            }

            if (action.equals("search")) {
                handleSearchRequest(request, response);
                return;
            }

            if (action.equals("create")) {
                handleCreateRequest(request, response);
                return;
            }
        } catch (NumberFormatException ex) {
            handleInvalidRequest(request, response);
            return;
        }

        handleInvalidRequest(request, response);
    }

    private void handleCreateRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String typeParam = request.getParameter("type");
        if (typeParam.equals("medicine")) {
            List<MedicineType> medicineTypeList = medicineTypeDAO.getAllMedicineType();
            request.setAttribute("medicineTypeList", medicineTypeList);
            request.getRequestDispatcher("/WEB-INF/pharmacist/CreateMedicine.jsp").forward(request, response);
        } else {
            handleInvalidRequest(request, response);
        }
    }

    private void handleSearchRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchParam = request.getParameter("search");
        List<MedicineViewModel> medicineList = null;
        if (searchParam == null || searchParam.trim().isEmpty()) {
            medicineList = medicineDAO.getAllMedicines();
        } else {
            medicineList = medicineDAO.searchMedicineByTypeNameCode(searchParam.trim(), searchParam.trim(), searchParam.trim());
        }
        request.setAttribute("medicineList", medicineList);
        request.getRequestDispatcher("/WEB-INF/pharmacist/MedicineList.jsp").forward(request, response);
    }

    private void handleViewMedicineDetailRequest(HttpServletRequest request, HttpServletResponse response, int medicineParam) throws ServletException, IOException {
        MedicineViewModel medicine = medicineDAO.getMedicineById(medicineParam);
        List<MedicineStockTransaction> medicineStockTransactionList = medicineStockTransactionDAO.getMedicineStockTransactionByMedicineId(medicineParam);
        request.setAttribute("medicine", medicine);
        request.setAttribute("medicineStockTransactionList", medicineStockTransactionList);
        request.getRequestDispatcher("/WEB-INF/pharmacist/MedicineDetail.jsp").forward(request, response);
    }

    private void handleInvalidRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<MedicineViewModel> medicineList = medicineDAO.getAllMedicines();
        request.setAttribute("medicineList", medicineList);
        request.getRequestDispatcher("/WEB-INF/pharmacist/MedicineList.jsp").forward(request, response);
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
//        processRequest(request, response);

        String action = request.getParameter("action");

        if (action.equals("create")) {
            handleCreateResponse(request, response);
        }

        response.sendRedirect("/manage-medicine");
    }

    private void handleCreateResponse(HttpServletRequest request, HttpServletResponse response) {
        String medicineNameParam = request.getParameter("medicineName");
        String medicineCodeParam = request.getParameter("medicineCode");
        String medicineTypeIdParam = request.getParameter("medicineTypeId");
        String quantityParam = request.getParameter("quantity");
        String priceParam = request.getParameter("price");
        String dateExpireParam = request.getParameter("dateExpire");
        String medicineStatusParam = request.getParameter("medicineStatus");

    }

    private void handleCheckMedicineName(HttpServletRequest request) {
        String medicineNameParam = request.getParameter("medicineName");

        if (CreateNewMedicineValidate.isValidMedicineName(medicineNameParam)) {

        }
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
