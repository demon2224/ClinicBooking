/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.patient;

import dao.MedicalRecordDAO;
import dao.PatientDAO;
import dao.DoctorDAO;
import model.MedicalRecordDTO;
import model.DoctorDTO;
import model.PatientDTO;
import constants.ManageMyMedicalRecordConstants;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for viewing and managing patient's medical records (list, detail,
 * search).
 *
 * @author Le Anh Tuan - CE180905
 */
public class ManageMyMedicalRecordController extends HttpServlet {

    private MedicalRecordDAO medicalRecordDAO;
    private PatientDAO patientDAO;
    private DoctorDAO doctorDAO;

    @Override
    public void init() throws ServletException {
        medicalRecordDAO = new MedicalRecordDAO();
        patientDAO = new PatientDAO();
        doctorDAO = new DoctorDAO();
    }

    /**
     * Handles GET requests - Display medical records list or medical record
     * detail
     *
     * @param request
     * @param response
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String medicalRecordIdParam = request.getParameter("id");

        // Check if this is a request for medical record detail
        if (medicalRecordIdParam != null && !medicalRecordIdParam.trim().isEmpty()) {
            // Handle medical record detail view
            handleMedicalRecordDetail(request, response, medicalRecordIdParam);
            return;
        }

        // Handle medical records list view
        handleMedicalRecordsList(request, response);
    }

    /**
     * Handles POST requests - Process actions if needed
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String medicalRecordIdParam = request.getParameter("medicalRecordId");

        // For any actions, validate medical record ID parameter
        if (medicalRecordIdParam == null || medicalRecordIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + ManageMyMedicalRecordConstants.BASE_URL);
            return;
        }

        try {
            int medicalRecordId = Integer.parseInt(medicalRecordIdParam);
            // For other actions or no specific action, redirect back to detail page
            response.sendRedirect(request.getContextPath() + ManageMyMedicalRecordConstants.BASE_URL + "?id=" + medicalRecordId);
        } catch (NumberFormatException e) {
            // If invalid ID, redirect to medical records list
            response.sendRedirect(request.getContextPath() + ManageMyMedicalRecordConstants.BASE_URL);
        }
    }

    /**
     * Handle medical record detail view
     */
    private void handleMedicalRecordDetail(HttpServletRequest request, HttpServletResponse response, String medicalRecordIdParam)
            throws ServletException, IOException {

        try {

            //Check session login
            HttpSession session = request.getSession();
            PatientDTO sessionPatient = (PatientDTO) session.getAttribute("patient");

            if (sessionPatient == null) {
                session.setAttribute("errorMessage", "Your session has expired. Please log in again.");
                response.sendRedirect(request.getContextPath() + "/patient-login");
                return;
            }

            //Validate param
            if (medicalRecordIdParam == null || !medicalRecordIdParam.matches("\\d+")) {
                response.sendRedirect(request.getContextPath() + ManageMyMedicalRecordConstants.BASE_URL);
                return;
            }

            int medicalRecordId = Integer.parseInt(medicalRecordIdParam);

            //Get medical record
            MedicalRecordDTO medicalRecord = medicalRecordDAO.getMedicalRecordById(medicalRecordId);
            if (medicalRecord == null) {
                response.sendRedirect(request.getContextPath() + ManageMyMedicalRecordConstants.BASE_URL);
                return;
            }

            //Validate record belongs to logged-in patient
            int recordPatientId = medicalRecord.getAppointmentID().getPatientID().getPatientID();
            if (recordPatientId != sessionPatient.getPatientID()) {
                response.sendRedirect(request.getContextPath() + "/403");
                return;
            }

            //Load patient + doctor data
            PatientDTO patientInfo = patientDAO.getPatientById(recordPatientId);
            int doctorId = medicalRecord.getAppointmentID().getDoctorID().getDoctorID();
            DoctorDTO doctor = doctorDAO.getDoctorById(doctorId);

            double averageRating = doctorDAO.getAverageRatingByDoctorId(doctorId);

            //Set attributes
            request.setAttribute("medicalRecord", medicalRecord);
            request.setAttribute("patient", patientInfo);
            request.setAttribute("doctor", doctor);
            request.setAttribute("averageRating", averageRating);

            //Forward
            request.getRequestDispatcher(ManageMyMedicalRecordConstants.DETAIL_PAGE_JSP).forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + ManageMyMedicalRecordConstants.BASE_URL);
        }
    }

    /**
     * Handle medical records list view
     */
    private void handleMedicalRecordsList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get patient from session
        HttpSession session = request.getSession();
        PatientDTO patient = (PatientDTO) session.getAttribute("patient");
        int patientId = patient.getPatientID();

        // Get search parameters
        String searchQuery = request.getParameter("search");
        List<MedicalRecordDTO> medicalRecords;

        // Apply search
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            medicalRecords = medicalRecordDAO.searchMedicalRecordsByPatientId(patientId, searchQuery);
        } else {
            medicalRecords = medicalRecordDAO.getMedicalRecordsByPatientId(patientId);
        }

        // Set attributes for JSP
        request.setAttribute("medicalRecords", medicalRecords);
        request.setAttribute("searchQuery", searchQuery);

        // Forward to JSP
        request.getRequestDispatcher(ManageMyMedicalRecordConstants.LIST_PAGE_JSP).forward(request, response);
    }
}
