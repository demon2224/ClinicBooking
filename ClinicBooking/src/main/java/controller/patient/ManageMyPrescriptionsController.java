package controller.patient;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dao.PrescriptionDAO;
import dao.PatientDAO;
import dao.DoctorDAO;
import model.PrescriptionDTO;
import model.PatientDTO;
import constants.ManageMyPrescriptionsConstants;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for viewing and managing patient's prescriptions (list, detail,
 * search).
 *
 * @author Le Anh Tuan - CE180905
 */
public class ManageMyPrescriptionsController extends HttpServlet {

    private PrescriptionDAO prescriptionDAO;
    private PatientDAO patientDAO;
    private DoctorDAO doctorDAO;

    @Override
    public void init() throws ServletException {
        prescriptionDAO = new PrescriptionDAO();
        patientDAO = new PatientDAO();
        doctorDAO = new DoctorDAO();
    }

    /**
     * Handles GET requests - Display prescriptions list or prescription detail
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String prescriptionIdParam = request.getParameter("id");

        // Check if this is a request for prescription detail
        if (prescriptionIdParam != null && !prescriptionIdParam.trim().isEmpty()) {
            // Handle prescription detail view
            handlePrescriptionDetail(request, response, prescriptionIdParam);
            return;
        }

        // Handle prescriptions list view
        handlePrescriptionsList(request, response);
    }

    /**
     * Handles POST requests - Process actions if needed
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String prescriptionIdParam = request.getParameter("prescriptionId");

        // For any actions, validate prescription ID parameter
        if (prescriptionIdParam == null || prescriptionIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + ManageMyPrescriptionsConstants.BASE_URL);
            return;
        }

        try {
            int prescriptionId = Integer.parseInt(prescriptionIdParam);
            // For other actions or no specific action, redirect back to detail page
            response.sendRedirect(request.getContextPath() + ManageMyPrescriptionsConstants.BASE_URL + "?id=" + prescriptionId);
        } catch (NumberFormatException e) {
            // If invalid ID, redirect to prescriptions list
            response.sendRedirect(request.getContextPath() + ManageMyPrescriptionsConstants.BASE_URL);
        }
    }

    /**
     * Handle prescription detail view
     */
    private void handlePrescriptionDetail(HttpServletRequest request, HttpServletResponse response, String prescriptionIdParam)
            throws ServletException, IOException {

        try {
            // Validate session
            HttpSession session = request.getSession();
            PatientDTO sessionPatient = (PatientDTO) session.getAttribute("patient");

            if (sessionPatient == null) {
                response.sendRedirect(request.getContextPath() + "/patient-login");
                return;
            }

            int prescriptionId = Integer.parseInt(prescriptionIdParam);

            // Get prescription details
            PrescriptionDTO prescription = prescriptionDAO.getPrescriptionById(prescriptionId);

            // Redirect if prescription not found
            if (prescription == null) {
                response.sendRedirect(request.getContextPath() + ManageMyPrescriptionsConstants.BASE_URL);
                return;
            }

            // Verify this prescription belongs to the logged-in patient
            // TEMPORARILY DISABLED FOR TESTING
            /*
            if (prescription.getAppointmentID() != null &&
                prescription.getAppointmentID().getPatientID() != null &&
                prescription.getAppointmentID().getPatientID().getPatientID() != sessionPatient.getPatientID()) {
                response.sendRedirect(request.getContextPath() + ManageMyPrescriptionsConstants.BASE_URL);
                return;
            }
             */
            // Set attributes for JSP (prescription already contains doctor and patient info)
            request.setAttribute("prescription", prescription);

            // Get doctor rating
            int doctorId = prescription.getAppointmentID().getDoctorID().getDoctorID();
            double averageRating = doctorDAO.getAverageRatingByDoctorId(doctorId);
            request.setAttribute("averageRating", averageRating);

            // Forward to detail page
            request.getRequestDispatcher(ManageMyPrescriptionsConstants.DETAIL_PAGE_JSP).forward(request, response);

        } catch (Exception e) {
            // Log the exception for debugging
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + ManageMyPrescriptionsConstants.BASE_URL);
        }
    }

    /**
     * Handle prescriptions list view
     */
    private void handlePrescriptionsList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get patient from session
        HttpSession session = request.getSession();
        PatientDTO patient = (PatientDTO) session.getAttribute("patient");
        int patientId = patient.getPatientID();

        // Get search parameters
        String searchQuery = request.getParameter("search");
        List<PrescriptionDTO> prescriptions;

        // Apply search
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            prescriptions = prescriptionDAO.searchPrescriptionsByPatientId(patientId, searchQuery);
        } else {
            prescriptions = prescriptionDAO.getPrescriptionsByPatientId(patientId);
        }

        // Set attributes for JSP
        request.setAttribute("prescriptions", prescriptions);
        request.setAttribute("searchQuery", searchQuery);

        // Forward to JSP
        request.getRequestDispatcher(ManageMyPrescriptionsConstants.LIST_PAGE_JSP).forward(request, response);
    }
}
