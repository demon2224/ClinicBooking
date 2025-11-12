/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dao.AppointmentDAO;
import dao.MedicalRecordDAO;
import dao.PrescriptionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.AppointmentDTO;
import model.DoctorDTO;
import model.MedicalRecordDTO;
import model.PrescriptionItemDTO;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class ManageMyPatientMedicalRecordController extends HttpServlet {

    private MedicalRecordDAO medicalRecordDAO;
    private PrescriptionDAO prescriptionDAO;
    private AppointmentDAO appointmentDAO;

    /**
     * Initialize all the necessary DAO using in this controller.
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        medicalRecordDAO = new MedicalRecordDAO();
        prescriptionDAO = new PrescriptionDAO();
        appointmentDAO = new AppointmentDAO();
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
            out.println("<title>Servlet ManageMyPatientMedicalRecordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageMyPatientMedicalRecordController at " + request.getContextPath() + "</h1>");
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
        int doctorID = ((DoctorDTO) request.getSession().getAttribute("doctor")).getDoctorID();

        String action = request.getParameter("action");
        try {
            switch (action) {

                case "detail":
                    showMyPatientMedicalRecordDetail(request, response, doctorID);
                    break;

                case "create":
                    createNewMedicalRecord(request, response, doctorID);
                    break;
                case "edit":
                    int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));
                    editMedicalRecord(request, response, doctorID, medicalRecordID);
                    break;
                default:
                    showMyPatientMedicalRecordList(request, response, doctorID);
                    break;
            }
        } catch (ServletException | IOException | NullPointerException e) {
            showMyPatientMedicalRecordList(request, response, doctorID);
        }
    }

    /**
     * Show medical record list
     *
     * @param request
     * @param response
     * @param doctorID
     * @throws ServletException
     * @throws IOException
     */
    private void showMyPatientMedicalRecordList(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<MedicalRecordDTO> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = medicalRecordDAO.searchPatientMedicalRecordListByPatientName(doctorID, keyword);
        } else {
            list = medicalRecordDAO.getPatientMedicalRecordListByDoctorID(doctorID);
        }
        request.setAttribute("myPatientMedicalRecordList", list);
        request.getRequestDispatcher("/WEB-INF/doctor/MyPatientMedicalRecord.jsp").forward(request, response);
    }

    /**
     * Show medical record detail
     *
     * @param request
     * @param response
     * @param doctorID
     * @throws ServletException
     * @throws IOException
     */
    private void showMyPatientMedicalRecordDetail(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {
        try {
            int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));
            MedicalRecordDTO medicalRecord = medicalRecordDAO.getPatientMedicalRecordDetailByDoctorIDAndMedicalRecordID(doctorID, medicalRecordID);
            boolean isExist = prescriptionDAO.isExistPrescription(medicalRecordID);
            List<PrescriptionItemDTO> list;
            list = prescriptionDAO.getPrescriptionByDoctorIDAndMedicalRecordID(doctorID, medicalRecordID);
            if (medicalRecord.getMedicalRecordID() == medicalRecordID) {
                request.setAttribute("detail", medicalRecord);
                request.setAttribute("isExist", isExist);
                request.setAttribute("list", list);
            }
            request.getRequestDispatcher("/WEB-INF/doctor/MyPatientMedicalRecordDetail.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
        }
    }

    /**
     * doctor create new medical record
     *
     * @param request
     * @param response
     * @param doctorID
     * @throws ServletException
     * @throws IOException
     */
    private void createNewMedicalRecord(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {
        try {
            int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
            AppointmentDTO appointment = appointmentDAO.getPatientAppointmentDetailOfDoctorByID(appointmentID, doctorID);

            if ((appointment == null) || (appointment.getAppointmentID() != appointmentID)) {
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-appointment");
                return;
            }

            boolean isExist = medicalRecordDAO.isExistMedicalRecord(appointmentID);

            if (isExist) {
                // Nếu đã tồn tại medical record, quay lại trang danh sách appointment
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-appointment");
                return;
            }

            request.setAttribute("appointment", appointment);
            request.getRequestDispatcher("/WEB-INF/doctor/CreateMyPatientMedicalRecord.jsp").forward(request, response);

        } catch (NumberFormatException ex) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-appointment");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
        }
    }

    public void editMedicalRecord(HttpServletRequest request, HttpServletResponse response, int doctorID, int medicalRecordID)
            throws ServletException, IOException {
        try {
            MedicalRecordDTO medicalRecord = medicalRecordDAO.getPatientMedicalRecordDetailByDoctorIDAndMedicalRecordID(doctorID, medicalRecordID);
            if (medicalRecord.getMedicalRecordID() == medicalRecordID) {
                request.setAttribute("detail", medicalRecord);
            }
            request.getRequestDispatcher("/WEB-INF/doctor/EditMyPatientMedicalRecord.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
        }
    }

    public void createMedicalRecordInPost(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {
        try {
            int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
            String symptoms = request.getParameter("symptoms");
            String diagnosis = request.getParameter("diagnosis");
            String note = request.getParameter("note");

            if (symptoms == null || symptoms.trim().isEmpty()
                    || diagnosis == null || diagnosis.trim().isEmpty()
                    || note == null || note.trim().isEmpty()) {

                AppointmentDTO appointment = appointmentDAO.getPatientAppointmentDetailOfDoctorByID(appointmentID, doctorID);
                request.setAttribute("appointment", appointment);
                request.setAttribute("error", " All fields (Symptoms, Diagnosis, and Note) are required.");
                request.getRequestDispatcher("/WEB-INF/doctor/CreateMyPatientMedicalRecord.jsp").forward(request, response);
                return;
            }

            boolean success = medicalRecordDAO.createMedicalRecord(appointmentID, symptoms.trim(), diagnosis.trim(), note.trim());

            if (success) {
                request.getSession().setAttribute("message", "Create new medical record successfully.");
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
            } else {
                AppointmentDTO appointment = appointmentDAO.getPatientAppointmentDetailOfDoctorByID(appointmentID, doctorID);
                request.setAttribute("appointment", appointment);
                request.setAttribute("error", " Failed to create medical record. Please try again.");
                request.getRequestDispatcher("/WEB-INF/doctor/CreateMyPatientMedicalRecord.jsp").forward(request, response);
            }

        } catch (NumberFormatException ex) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-appointment");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
        }

    }

    public void editMedicalRecordInPost(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {
        try {
            int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));
            String symptoms = request.getParameter("symptoms");
            String diagnosis = request.getParameter("diagnosis");
            String note = request.getParameter("note");
            if (symptoms == null || symptoms.trim().isEmpty()
                    || diagnosis == null || diagnosis.trim().isEmpty()
                    || note == null || note.trim().isEmpty()) {
                MedicalRecordDTO medicalRecord = medicalRecordDAO.getPatientMedicalRecordDetailByDoctorIDAndMedicalRecordID(doctorID, medicalRecordID);
                request.setAttribute("detail", medicalRecord);
                request.setAttribute("error", " All fields (Symptoms, Diagnosis, and Note) are required.");
                request.getRequestDispatcher("/WEB-INF/doctor/EditMyPatientMedicalRecord.jsp").forward(request, response);
                return;
            }
            boolean success = medicalRecordDAO.updateMedicalRecord(medicalRecordID, symptoms, diagnosis, note);

            if (success) {
                request.getSession().setAttribute("message", "Medical record updated successfully.");
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
            } else {
                MedicalRecordDTO medicalRecord = medicalRecordDAO.getPatientMedicalRecordDetailByDoctorIDAndMedicalRecordID(doctorID, medicalRecordID);
                request.setAttribute("detail", medicalRecord);
                request.setAttribute("error", " Failed to edit medical record. Please try again.");
                request.getRequestDispatcher("/WEB-INF/doctor/EditMyPatientMedicalRecord.jsp").forward(request, response);
            }
        } catch (NumberFormatException ex) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-appointment");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
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
//        processRequest(request, response);

        int doctorID = ((DoctorDTO) request.getSession().getAttribute("doctor")).getDoctorID();
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "create":
                    createMedicalRecordInPost(request, response, doctorID);
                    break;
                case "edit":
                    editMedicalRecordInPost(request, response, doctorID);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
                    break;
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
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
