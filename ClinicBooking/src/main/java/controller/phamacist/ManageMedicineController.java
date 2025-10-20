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
import model.Medicine;
import model.MedicineStockTransaction;
import model.MedicineType;
import validate.MedicineInfomationValidate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class ManageMedicineController extends HttpServlet {

    private MedicineDAO medicineDAO;
    private MedicineStockTransactionDAO medicineStockTransactionDAO;
    private MedicineTypeDAO medicineTypeDAO;

    /**
     * Initialize all the necessary DAO using in this controller.
     *
     * @throws ServletException
     */
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

        // Checking if the action is null or not.
        // If it null or empty then show the user the medicine list.
        if (action == null || action.isBlank()) {
            handleInvalidRequest(request, response);
            return;
        }

        // If the action is detail then show the user the detail of specific medicine.
        if (action.equals("detail")) {
            handleViewMedicineDetailRequest(request, response);
            return;
        }

        // If the action is search then show the user the list of.all medicine that match with user input.
        if (action.equals("search")) {
            handleSearchRequest(request, response);
            return;
        }

        // If the action is create then show the user the view when create new medicine.
        if (action.equals("create")) {
            handleCreateRequest(request, response);
            return;
        }

        // If the action is edit then show the user the view when edit a medicine.
        if (action.equals("edit")) {
            handleEditRequest(request, response);
            return;
        }

        // If the action is not all of above then show the user the medicine list.
        handleInvalidRequest(request, response);
    }

    private void handleEditRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String medicineIdParam = request.getParameter("medicineId");

        try {
            int medicineId = Integer.parseInt(medicineIdParam);

            // Get the information of the medicine.
            Medicine medicine = medicineDAO.getMedicineById(medicineId);
            request.setAttribute("medicine", medicine);

            // Get all the medicine type from database.
            List<MedicineType> medicineTypeList = medicineTypeDAO.getAllMedicineType();
            request.setAttribute("medicineTypeList", medicineTypeList);

            // Show user the view when edit a medicine.
            request.getRequestDispatcher("/WEB-INF/pharmacist/EditMedicine.jsp").forward(request, response);

            // If the medicineId is not valid then redirect to the medicineList.
        } catch (Exception e) {
            handleInvalidRequest(request, response);
        }
    }

    /**
     * Handle the request of user when they want to create new medicine.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void handleCreateRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get all the medicine type from database.
        List<MedicineType> medicineTypeList = medicineTypeDAO.getAllMedicineType();
        request.setAttribute("medicineTypeList", medicineTypeList);

        // Show user the view when create new medicine.
        request.getRequestDispatcher("/WEB-INF/pharmacist/CreateMedicine.jsp").forward(request, response);
    }

    /**
     * Handle when user search for a specific medicine.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void handleSearchRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchParam = request.getParameter("search");
        List<Medicine> medicineList = null;

        // Check if the search input is null or not.
        // If it is yes then show user the medicine list.
        if (searchParam == null || searchParam.trim().isEmpty()) {
            medicineList = medicineDAO.getAllMedicines();

            // If it is not then get all the medicine with type, name, code match with user search and show them.
        } else {
            medicineList = medicineDAO.searchMedicineByTypeNameCode(searchParam.trim(), searchParam.trim(), searchParam.trim());
        }
        request.setAttribute("medicineList", medicineList);
        request.getRequestDispatcher("/WEB-INF/pharmacist/MedicineList.jsp").forward(request, response);
    }

    /**
     * Handle when user want to view detail of a specific medicine.
     *
     * @param request servlet request
     * @param response servlet response
     * @param medicineParam medicine id want to view detail information
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void handleViewMedicineDetailRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            // Parse the medicineId from string to integer.
            // If it enable then show the user the detail information of that medicine.
            int medicineParam = Integer.parseInt(request.getParameter("medicineId"));

            Medicine medicine = medicineDAO.getMedicineById(medicineParam);
            List<MedicineStockTransaction> medicineStockTransactionList = medicineStockTransactionDAO.getMedicineStockTransactionByMedicineId(medicineParam);
            request.setAttribute("medicine", medicine);
            request.setAttribute("medicineStockTransactionList", medicineStockTransactionList);
            request.getRequestDispatcher("/WEB-INF/pharmacist/MedicineDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        }
    }

    /**
     * Handle when the user request is invalid or an error occur. Show the user
     * medicine list.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void handleInvalidRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Medicine> medicineList = medicineDAO.getAllMedicines();
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
            return;
        }

        if (action.equals("edit")) {
            handleEditResponse(request, response);
            return;
        }

        if (action.equals("delete")) {
            handleDeleteResponse(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/manage-medicine");
    }

    private void handleDeleteResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String medicineIdParam = request.getParameter("medicineId");

        try {

            int medicineId = Integer.parseInt(medicineIdParam);
            int newMedicineStatus = medicineDAO.getMedicineById(medicineId).getMedicineStatus() ? 0 : 1;
            int resultDelete = medicineDAO.deleteMedicine(newMedicineStatus, medicineId);

            if (resultDelete != 0) {
                request.getSession().setAttribute("medicineDeleteSuccessMsg", "Delete medicine successfully.");
            } else {
                request.getSession().setAttribute("medicineDeleteErrorMsg", "Failed to delete medicine.");
            }

            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        }
    }

    private void handleEditResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {

        removeSessionMsg(request);
        String medicineIdParam = request.getParameter("medicineId");

        try {

            int medicineId = Integer.parseInt(medicineIdParam);

            String medicineNameParam = request.getParameter("medicineName");
            String medicineCodeParam = request.getParameter("medicineCode");
            String medicineTypeParam = request.getParameter("medicineType");
            String medicinePriceParam = request.getParameter("price");

            boolean isValidMedicineName = isValidMedicineName(request, medicineNameParam);
            boolean isValidMedicineCode = isValidMedicineCode(request, medicineCodeParam);
            boolean isValidMedicineType = isValidMedicineType(request, medicineTypeParam);
            boolean isValidMedicinePrice = isValidMedicinePrice(request, medicinePriceParam);

            if (!isValidMedicineName
                    || !isValidMedicineCode
                    || !isValidMedicineType
                    || !isValidMedicinePrice) {
                response.sendRedirect(request.getContextPath() + "/manage-medicine?action=edit&medicineId=" + medicineId);
            } else {

                int resultEdit = medicineDAO.editMedicine(medicineNameParam, medicineCodeParam, medicineTypeParam, Double.parseDouble(medicinePriceParam), medicineId);

                if (resultEdit != 0) {
                    request.getSession().setAttribute("medicineEditSuccessMsg", "Edit medicine successfully.");
                } else {
                    request.getSession().setAttribute("medicineEditErrorMsg", "Failed to edit medicine.");
                }

                response.sendRedirect(request.getContextPath() + "/manage-medicine");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        }
    }

    /**
     * Handle when user want to create new medicine.
     *
     * @param request
     * @param response
     */
    private void handleCreateResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {

        removeSessionMsg(request);

        String medicineNameParam = request.getParameter("medicineName");
        String medicineCodeParam = request.getParameter("medicineCode");
        String medicineTypeParam = request.getParameter("medicineType");
        String medicinePriceParam = request.getParameter("price");
        String medicineStatusParam = request.getParameter("medicineStatus");

        boolean isValidMedicineName = isValidMedicineName(request, medicineNameParam);
        boolean isValidMedicineCode = isValidMedicineCode(request, medicineCodeParam);
        boolean isValidMedicineType = isValidMedicineType(request, medicineTypeParam);
        boolean isValidMedicinePrice = isValidMedicinePrice(request, medicinePriceParam);
        boolean isValidMedicineStatus = isValidMedicineStatus(request, medicineStatusParam);

        if (!isValidMedicineName
                || !isValidMedicineCode
                || !isValidMedicineType
                || !isValidMedicinePrice
                || !isValidMedicineStatus) {
            response.sendRedirect(request.getContextPath() + "/manage-medicine?action=create");
        } else {

            int resultCreate = medicineDAO.createNewMedicine(medicineNameParam, medicineCodeParam, medicineTypeParam, Double.parseDouble(medicinePriceParam), Integer.parseInt(medicineStatusParam));

            if (resultCreate != 0) {
                request.getSession().setAttribute("medicineCreateSuccessMsg", "Create new medicine successfully.");
            } else {
                request.getSession().setAttribute("medicineCreateErrorMsg", "Failed to create new medicine.");
            }

            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        }
    }

    /**
     * Check the medicine name is valid or not. If it is invalid then show the
     * error message of it. If it is valid then show the success message.
     *
     * Medicine name must not be null, empty or contain anything except
     * character.
     *
     * @param request servlet request
     */
    private boolean isValidMedicineName(HttpServletRequest request, String medicineNameParam) {

        if (MedicineInfomationValidate.isEmpty(medicineNameParam)) {
            request.getSession().setAttribute("medicineNameErrorMsg", "The medicine name can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineName(medicineNameParam)) {
            request.getSession().setAttribute("medicineNameErrorMsg", "The medicine name only contains character.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineCode(HttpServletRequest request, String medicineCodeParam) {

        if (MedicineInfomationValidate.isEmpty(medicineCodeParam)) {
            request.getSession().setAttribute("medicineCodeErrorMsg", "The medicine code can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineCodeLength(medicineCodeParam)) {
            request.getSession().setAttribute("medicineCodeErrorMsg", "The medicine code must be 6 letter length.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineCode(medicineCodeParam)) {
            request.getSession().setAttribute("medicineCodeErrorMsg", "Medicine code must be 3 letters followed by 3 numbers (e.g. ABC123).");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineType(HttpServletRequest request, String medicineTypeParam) {

        if (MedicineInfomationValidate.isEmpty(medicineTypeParam)) {
            request.getSession().setAttribute("medicineTypeErrorsMsg", "The medicine type can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineType(medicineTypeParam, medicineTypeDAO.getAllMedicineType())) {
            request.getSession().setAttribute("medicineTypeErrorsMsg", "The medicine type is invalid.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicinePrice(HttpServletRequest request, String medicinePriceParam) {

        if (MedicineInfomationValidate.isEmpty(medicinePriceParam)) {
            request.getSession().setAttribute("medicinePriceErrorsMsg", "The medicine price can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicinePriceNumber(medicinePriceParam)) {
            request.getSession().setAttribute("medicinePriceErrorsMsg", "The medicine price must be a positive number.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineStatus(HttpServletRequest request, String medicineStatusParam) {

        if (MedicineInfomationValidate.isEmpty(medicineStatusParam)) {
            request.getSession().setAttribute("medicineStatusErrorsMsg", "The medicine status can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineStatus(medicineStatusParam)) {
            request.getSession().setAttribute("medicineStatusErrorsMsg", "The medicine status must be a valid value.");
            return false;
        } else {
            return true;
        }
    }

    private void removeSessionMsg(HttpServletRequest request) {

        if (request.getSession().getAttribute("medicineNameErrorMsg") != null) {
            request.getSession().setAttribute("medicineNameErrorMsg", null);
        }

        if (request.getSession().getAttribute("medicineCodeErrorMsg") != null) {
            request.getSession().setAttribute("medicineCodeErrorMsg", null);
        }

        if (request.getSession().getAttribute("medicineTypeErrorsMsg") != null) {
            request.getSession().setAttribute("medicineTypeErrorsMsg", null);
        }

        if (request.getSession().getAttribute("medicinePriceErrorsMsg") != null) {
            request.getSession().setAttribute("medicinePriceErrorsMsg", null);
        }

        if (request.getSession().getAttribute("medicineStatusParam") != null) {
            request.getSession().setAttribute("medicineStatusParam", null);
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
