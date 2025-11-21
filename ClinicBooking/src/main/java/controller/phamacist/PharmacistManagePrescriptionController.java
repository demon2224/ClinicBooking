/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.phamacist;

import dao.PrescriptionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.List;
import model.PrescriptionDTO;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class PharmacistManagePrescriptionController extends HttpServlet {

    private PrescriptionDAO prescriptionDAO;

    @Override
    public void init() throws ServletException {
        prescriptionDAO = new PrescriptionDAO();
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
            out.println("<title>Servlet ManagePrescriptionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagePrescriptionController at " + request.getContextPath() + "</h1>");
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

                // If the action is detail then show the user the detail of specific prescription.
                case "detail":
                    handleViewPrescriptionDetailRequest(request, response);
                    break;

                // If the action is search then show the user the list of.all prescription that match with user input.
                case "search":
                    handleSearchRequest(request, response);
                    break;

                // If the action is not all of above then show the user the medicine list.
                default:
                    handleInvalidRequest(request, response);
                    break;
            }
        } catch (ServletException | IOException | NullPointerException e) {
            // If an exception occur then show the user the prescription list.
            handleInvalidRequest(request, response);
        }
    }

    private void handleViewPrescriptionDetailRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String prescriptionIDParam = request.getParameter("prescriptionID");

        try {
            // Parse the prescriptionID from string to integer.
            // If it enable then show the user the detail information of that prescription.
            int prescriptionID = Integer.parseInt(prescriptionIDParam);

            PrescriptionDTO prescription = prescriptionDAO.getPrescriptionById(prescriptionID);
            request.setAttribute("prescription", prescription);
            request.getRequestDispatcher("/WEB-INF/pharmacist/PrescriptionDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pharmacist-manage-prescription");
        }
    }

    private void handleSearchRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchParam = request.getParameter("search");
        List<PrescriptionDTO> prescriptionList = null;

        // Check if the search input is null or not.
        // If it is yes then show user the prescription list.
        if (searchParam == null || searchParam.trim().isEmpty()) {
            prescriptionList = prescriptionDAO.getAllActivePrescriptions();

            // If it is not then get all the prescription that are match with user input.
            // Search the doctor name or patient name.
        } else {
            prescriptionList = prescriptionDAO.searchPrescriptionsByDoctorNameOrPatientName(searchParam);
        }
        request.setAttribute("prescriptionList", prescriptionList);
        request.getRequestDispatcher("/WEB-INF/pharmacist/PrescriptionList.jsp").forward(request, response);
    }

    private void handleInvalidRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<PrescriptionDTO> prescriptionList = prescriptionDAO.getAllActivePrescriptions();
        request.setAttribute("prescriptionList", prescriptionList);
        request.getRequestDispatcher("/WEB-INF/pharmacist/PrescriptionList.jsp").forward(request, response);
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
                case "deliver":
                    handleDeliverResponse(request, response);
                    break;

                case "cancel":
                    handleCancelResponse(request, response);
                    break;

                default:
                    handleInvalidResponse(request, response);
                    break;
            }
        } catch (IOException | ServletException | NullPointerException e) {
            handleInvalidResponse(request, response);
        }
    }

    private void handleDeliverResponse(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String prescriptionIDParam = request.getParameter("prescriptionID");

        try {

            int prescriptionID = Integer.parseInt(prescriptionIDParam);

            if (!isValidUpdateDate(prescriptionID)) {
                request.setAttribute("errorMsg", "Can't update prescription status after 24h.");
                List<PrescriptionDTO> prescriptionList = prescriptionDAO.getAllActivePrescriptions();
                request.setAttribute("prescriptionList", prescriptionList);
                request.getRequestDispatcher("/WEB-INF/pharmacist/PrescriptionList.jsp").forward(request, response);
            } else {

                boolean deliverResult = prescriptionDAO.deliverPrescription(prescriptionID);

                if (deliverResult) {
                    request.getSession().setAttribute("successMsg", "Deliver medicine successfully.");
                } else {
                    request.getSession().setAttribute("errorMsg", "Failed to deliver prescription.");
                }

                response.sendRedirect(request.getContextPath() + "/pharmacist-manage-prescription");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pharmacist-manage-prescription");
        }
    }

    private void handleCancelResponse(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String prescriptionIDParam = request.getParameter("prescriptionID");

        try {

            int prescriptionID = Integer.parseInt(prescriptionIDParam);

            if (!isValidUpdateDate(prescriptionID)) {
                request.setAttribute("errorMsg", "Can't update prescription status after 24h.");
                List<PrescriptionDTO> prescriptionList = prescriptionDAO.getAllActivePrescriptions();
                request.setAttribute("prescriptionList", prescriptionList);
                request.getRequestDispatcher("/WEB-INF/pharmacist/PrescriptionList.jsp").forward(request, response);
            } else {

                boolean cancelResult = prescriptionDAO.cancelPrescription(prescriptionID);

                if (cancelResult) {
                    request.getSession().setAttribute("successMsg", "Cancel medicine successfully.");
                } else {
                    request.getSession().setAttribute("errorMsg", "Failed to cancel prescription.");
                }

                response.sendRedirect(request.getContextPath() + "/pharmacist-manage-prescription");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pharmacist-manage-prescription");
        }
    }

    private void handleInvalidResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/pharmacist-manage-prescription");
    }

    private boolean isValidUpdateDate(int prescriptionID) {

        PrescriptionDTO prescription = prescriptionDAO.getPrescriptionById(prescriptionID);
        LocalDateTime dateCreate = prescription.getDateCreate().toLocalDateTime();
        LocalDateTime now = LocalDateTime.now();

        return true;
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
