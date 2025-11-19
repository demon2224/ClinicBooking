/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.phamacist;

import dao.MedicineDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.MedicineDTO;
import validate.MedicineInfomationValidate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class ManageMedicineController extends HttpServlet {

    private MedicineDAO medicineDAO;

    /**
     * Initialize all the necessary DAO using in this controller.
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        medicineDAO = new MedicineDAO();
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

        try {
            switch (action) {

                // If the action is detail then show the user the detail of specific medicine.
                case "detail":
                    handleViewMedicineDetailRequest(request, response);
                    break;

                // If the action is search then show the user the list of.all medicine that match with user input.
                case "search":
                    handleSearchRequest(request, response);
                    break;

                // If the action is create then show the user the view when create new medicine.
                case "create":
                    handleCreateRequest(request, response);
                    return;

                // If the action is edit then show the user the view when edit a medicine.
                case "edit":
                    handleEditRequest(request, response);
                    break;

                // If the action is import then show the user the view when import a medicine.
                case "import":
                    handleImportRequest(request, response);
                    break;

                // If the action is not all of above then show the user the medicine list.
                default:
                    handleInvalidRequest(request, response);
                    break;
            }
        } catch (ServletException | IOException | NullPointerException e) {
            // If an exception occur then show the user the medicine list.
            handleInvalidRequest(request, response);
        }
    }

    private void handleImportRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String medicineIDParam = request.getParameter("medicineID");

        try {
            int medicineID = Integer.parseInt(medicineIDParam);

            // Get the information of the medicine.
            MedicineDTO medicine = medicineDAO.getMedicineById(medicineID);
            request.setAttribute("medicine", medicine);

            // Show user the view when edit a medicine.
            request.getRequestDispatcher("/WEB-INF/pharmacist/ImportMedicine.jsp").forward(request, response);

            // If the medicineId is not valid then redirect to the medicineList.
        } catch (Exception e) {
            handleInvalidRequest(request, response);
        }
    }

    private void handleEditRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String medicineIDParam = request.getParameter("medicineID");

        try {
            int medicineID = Integer.parseInt(medicineIDParam);

            // Get the information of the medicine.
            MedicineDTO medicine = medicineDAO.getMedicineById(medicineID);
            request.setAttribute("medicine", medicine);

            // Get all the medicine type.
            String[] medicineTypeList = MedicineInfomationValidate.MEDICINE_TYPE_LIST;
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

        // Get all the medicine type.
        String[] medicineTypeList = MedicineInfomationValidate.MEDICINE_TYPE_LIST;
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
        List<MedicineDTO> medicineList = null;

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

        String medicineIDParam = request.getParameter("medicineID");

        try {
            // Parse the medicineId from string to integer.
            // If it enable then show the user the detail information of that medicine.
            int medicineID = Integer.parseInt(medicineIDParam);

            MedicineDTO medicine = medicineDAO.getMedicineById(medicineID);
            request.setAttribute("medicine", medicine);
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
        List<MedicineDTO> medicineList = medicineDAO.getAllMedicines();
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

        try {
            switch (action) {
                case "create":
                    handleCreateResponse(request, response);
                    break;

                case "edit":
                    handleEditResponse(request, response);
                    break;

                case "delete":
                    handleDeleteResponse(request, response);
                    break;

                case "restore":
                    handleRestoreResponse(request, response);
                    break;

                case "import":
                    handleImportResponse(request, response);
                    break;

                default:
                    handleInvalidResponse(request, response);
                    break;
            }
        } catch (IOException | ServletException | NullPointerException e) {
            handleInvalidResponse(request, response);
        }
    }

    private void handleInvalidResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/manage-medicine");
    }

    private void handleImportResponse(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String medicineIDParam = request.getParameter("medicineID");
        String quantityParam = request.getParameter("quantity");

        try {

            int medicineID = Integer.parseInt(medicineIDParam);

            boolean isValidImportQuantity = isValidImportQuantity(request, quantityParam);

            if (!isValidImportQuantity) {
                MedicineDTO medicine = medicineDAO.getMedicineById(medicineID);
                request.setAttribute("medicine", medicine);

                // Show user the view when edit a medicine.
                request.getRequestDispatcher("/WEB-INF/pharmacist/ImportMedicine.jsp").forward(request, response);
            } else {

                boolean importResult = medicineDAO.importMedicine(Integer.parseInt(quantityParam), medicineID);

                if (importResult) {
                    request.getSession().setAttribute("medicineImportSuccessMsg", "Import medicine successfully.");
                } else {
                    request.getSession().setAttribute("medicineImportErrorMsg", "Failed to import medicine.");
                }
                response.sendRedirect(request.getContextPath() + "/manage-medicine");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        }
    }

    private void handleRestoreResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String medicineIDParam = request.getParameter("medicineID");

        try {

            int medicineID = Integer.parseInt(medicineIDParam);
            boolean deleteResult = medicineDAO.restoreMedicine(medicineID);

            if (deleteResult) {
                request.getSession().setAttribute("medicineRestoreSuccessMsg", "Restore medicine successfully.");
            } else {
                request.getSession().setAttribute("medicineRestoreSuccessMsg", "Failed to restore medicine.");
            }

            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        }
    }

    private void handleDeleteResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String medicineIDParam = request.getParameter("medicineID");

        try {

            int medicineID = Integer.parseInt(medicineIDParam);
            boolean deleteResult = medicineDAO.deleteMedicine(medicineID);

            if (deleteResult) {
                request.getSession().setAttribute("medicineDeleteSuccessMsg", "Delete medicine successfully.");
            } else {
                request.getSession().setAttribute("medicineDeleteErrorMsg", "Failed to delete medicine.");
            }

            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        }
    }

    private void handleEditResponse(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String medicineIDParam = request.getParameter("medicineID");

        try {

            int medicineID = Integer.parseInt(medicineIDParam);

            String medicineNameParam = request.getParameter("medicineName");
            String medicineCodeParam = request.getParameter("medicineCode");
            String medicineTypeParam = request.getParameter("medicineType");
            String medicinePriceParam = request.getParameter("price");
            String medicineStatusParam = request.getParameter("medicineStatus");

            boolean isValidMedicineName = isValidMedicineName(request, medicineNameParam);
            boolean isValidMedicineCode = isValidMedicineCode(request, medicineCodeParam, medicineID);
            boolean isValidMedicineType = isValidMedicineType(request, medicineTypeParam);
            boolean isValidMedicinePrice = isValidMedicinePrice(request, medicinePriceParam);
            boolean isValidMedicineStatus = isValidMedicineStatus(request, medicineStatusParam);

            if (!isValidMedicineName
                    || !isValidMedicineCode
                    || !isValidMedicineType
                    || !isValidMedicinePrice
                    || !isValidMedicineStatus) {
                String[] medicineTypeList = MedicineInfomationValidate.MEDICINE_TYPE_LIST;
                request.setAttribute("medicineTypeList", medicineTypeList);
                MedicineDTO medicine = medicineDAO.getMedicineById(medicineID);
                request.setAttribute("medicine", medicine);
                request.getRequestDispatcher("/WEB-INF/pharmacist/EditMedicine.jsp").forward(request, response);
            } else {

                boolean editResult = medicineDAO.editMedicine(medicineTypeParam, Integer.parseInt(medicineStatusParam), medicineNameParam, medicineCodeParam.toUpperCase(), Double.parseDouble(medicinePriceParam), medicineID);

                if (editResult) {
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
    private void handleCreateResponse(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

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
            // Get all the medicine type.
            String[] medicineTypeList = MedicineInfomationValidate.MEDICINE_TYPE_LIST;
            request.setAttribute("medicineTypeList", medicineTypeList);
            request.getRequestDispatcher("/WEB-INF/pharmacist/CreateMedicine.jsp").forward(request, response);
        } else {

            boolean createResult = medicineDAO.createNewMedicine(medicineNameParam, medicineCodeParam, medicineTypeParam, Double.parseDouble(medicinePriceParam), Integer.parseInt(medicineStatusParam));

            if (createResult) {
                request.getSession().setAttribute("medicineCreateSuccessMsg", "Create new medicine successfully.");
            } else {
                request.getSession().setAttribute("medicineCreateErrorMsg", "Failed to create new medicine.");
            }

            response.sendRedirect(request.getContextPath() + "/manage-medicine");
        }
    }

    private boolean isValidImportQuantity(HttpServletRequest request, String quantityImport) {

        if (MedicineInfomationValidate.isEmpty(quantityImport)) {
            request.setAttribute("medicineImportQuantityErrorMsg", "The import quantity can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidImportStockQuantity(quantityImport)) {
            request.setAttribute("medicineImportQuantityErrorMsg", "The import quantity must be integer that greater than 0.");
            return false;
        } else {
            return true;
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
            request.setAttribute("medicineNameErrorMsg", "The medicine name can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineName(medicineNameParam.trim())) {
            request.setAttribute("medicineNameErrorMsg", "The medicine name only contains character, number or white space.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineCode(HttpServletRequest request, String medicineCodeParam, int medicineID) {

        if (MedicineInfomationValidate.isEmpty(medicineCodeParam)) {
            request.setAttribute("medicineCodeErrorMsg", "The medicine code can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineCodeLength(medicineCodeParam.trim())) {
            request.setAttribute("medicineCodeErrorMsg", "The medicine code must be 6 letter length.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineCode(medicineCodeParam.trim())) {
            request.setAttribute("medicineCodeErrorMsg", "Medicine code must be 3 letters followed by 3 numbers (e.g. ABC123).");
            return false;
        } else if (medicineDAO.isAbleToChangeMedicineCode(medicineID, medicineCodeParam.trim())) {
            request.setAttribute("medicineCodeErrorMsg", "Medicine code is exist.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineCode(HttpServletRequest request, String medicineCodeParam) {

        if (MedicineInfomationValidate.isEmpty(medicineCodeParam)) {
            request.setAttribute("medicineCodeErrorMsg", "The medicine code can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineCodeLength(medicineCodeParam.trim())) {
            request.setAttribute("medicineCodeErrorMsg", "The medicine code must be 6 letter length.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineCode(medicineCodeParam.trim())) {
            request.setAttribute("medicineCodeErrorMsg", "Medicine code must be 3 letters followed by 3 numbers (e.g. ABC123).");
            return false;
        } else if (medicineDAO.isExistMedicineCode(medicineCodeParam.trim())) {
            request.setAttribute("medicineCodeErrorMsg", "Medicine code is exist.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineType(HttpServletRequest request, String medicineTypeParam) {

        if (MedicineInfomationValidate.isEmpty(medicineTypeParam)) {
            request.setAttribute("medicineTypeErrorMsg", "The medicine type can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineType(medicineTypeParam.trim())) {
            request.setAttribute("medicineTypeErrorMsg", "The medicine type is invalid.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicinePrice(HttpServletRequest request, String medicinePriceParam) {

        if (MedicineInfomationValidate.isEmpty(medicinePriceParam)) {
            request.setAttribute("medicinePriceErrorMsg", "The medicine price can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicinePriceNumber(medicinePriceParam.trim())) {
            request.setAttribute("medicinePriceErrorMsg", "The medicine price must be a positive number.");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineStatus(HttpServletRequest request, String medicineStatusParam) {

        if (MedicineInfomationValidate.isEmpty(medicineStatusParam)) {
            request.setAttribute("medicineStatusErrorsMsg", "The medicine status can't be empty.");
            return false;
        } else if (!MedicineInfomationValidate.isValidMedicineStatus(medicineStatusParam.trim())) {
            request.setAttribute("medicineStatusErrorsMsg", "The medicine status must be a valid value.");
            return false;
        } else {
            return true;
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
