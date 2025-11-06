/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.receptionist;

import dao.AppointmentDAO;
import dao.DoctorDAO;
import dao.PatientDAO;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.List;
import model.AppointmentDTO;
import model.DoctorDTO;
import model.PatientDTO;
import model.SpecialtyDTO;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class ReceptionistManageAppointmentController extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private UserDAO userDAO;
    private DoctorDAO doctorDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        userDAO = new UserDAO();
        doctorDAO = new DoctorDAO();
        patientDAO = new PatientDAO();
    }

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

        String action = request.getParameter("action");
        String searchQuery = request.getParameter("searchQuery");

        try {
            if (null == action) {
                handleViewAppointmentList(request, response, searchQuery);
            } else {
                switch (action) {
                    case "viewDetail":
                        handleViewDetail(request, response);
                        break;
                    case "add":
                        handleAddAppointmentForm(request, response);
                        break;
                    case "getDoctorsBySpecialty":
                        handleGetDoctorsBySpecialty(request, response);
                        break;
                    default:
                        handleViewAppointmentList(request, response, searchQuery);
                        break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
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

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "cancel":
                    handleCancelAppointment(request, response);
                    break;
                case "approve":
                    handleApproveAppointment(request, response);
                    break;
                case "addAppointment":
                    handleAddAppointment(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing POST request");
        }
    }

    private void handleViewAppointmentList(HttpServletRequest request, HttpServletResponse response, String searchQuery)
            throws ServletException, IOException {
        List<AppointmentDTO> appointmentList;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            appointmentList = appointmentDAO.searchAppointments(searchQuery);
        } else {
            appointmentList = appointmentDAO.getAllAppointments();
        }
        request.setAttribute("appointmentList", appointmentList);
        request.getRequestDispatcher("/WEB-INF/receptionist/ReceptionistAppointment.jsp").forward(request, response);
    }

    private void handleViewDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
            return;
        }

        int appointmentId = Integer.parseInt(idParam);
        AppointmentDTO appointment = appointmentDAO.getAppointmentByIdFull(appointmentId);
        if (appointment == null) {
            response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
            return;
        }

        DoctorDTO doctor = doctorDAO.getDoctorById(appointment.getDoctorID().getDoctorID());
        request.setAttribute("appointment", appointment);
        request.setAttribute("doctor", doctor);
        request.getRequestDispatcher("/WEB-INF/receptionist/AppointmentDetail.jsp").forward(request, response);
    }

    private void handleAddAppointmentForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String[]> specialties = doctorDAO.getAllSpecialties();
        List<PatientDTO> patients = patientDAO.getAllPatients();

        request.setAttribute("specialties", specialties);
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/WEB-INF/receptionist/AddAppointment.jsp").forward(request, response);
    }

    private void handleGetDoctorsBySpecialty(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int specialtyID = Integer.parseInt(request.getParameter("specialtyID"));
        List<DoctorDTO> doctors = doctorDAO.getDoctorsBySpecialty(specialtyID);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < doctors.size(); i++) {
            DoctorDTO d = doctors.get(i);
            json.append("{")
                    .append("\"doctorID\":").append(d.getDoctorID()).append(",")
                    .append("\"doctorName\":\"").append(d.getStaffID().getFirstName())
                    .append(" ").append(d.getStaffID().getLastName()).append("\"")
                    .append("}");
            if (i < doctors.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        response.getWriter().write(json.toString());
    }

    private void handleCancelAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        boolean success = appointmentDAO.cancelAppointment(appointmentId);

        if (success) {
            request.getSession().setAttribute("successMessage", "Appointment canceled successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to cancel appointment!");
        }
        response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
    }

    private void handleApproveAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        boolean success = appointmentDAO.updateStatusAppointment(appointmentId);

        if (success) {
            request.getSession().setAttribute("successMessage", "Appointment approved successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to approve appointment!");
        }
        response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
    }

    private void handleAddAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String existingPatientId = request.getParameter("existingPatientId");
        String fullName = request.getParameter("patientName");
        String phone = request.getParameter("phone");
        String genderStr = request.getParameter("gender");
        boolean gender = genderStr != null ? Boolean.parseBoolean(genderStr) : true;
        String doctorIdStr = request.getParameter("doctorId");
        String dateBeginStr = request.getParameter("dateBegin");
        String note = request.getParameter("note");

        // Kiểm tra doctorId
        if (doctorIdStr == null || doctorIdStr.isEmpty()) {
            request.setAttribute("error", "Please select a doctor!");
            request.getRequestDispatcher("/WEB-INF/receptionist/AddAppointment.jsp").forward(request, response);
            return;
        }
        int doctorId = Integer.parseInt(doctorIdStr);

        // Kiểm tra dateBegin
        if (dateBeginStr == null || dateBeginStr.isEmpty()) {
            request.setAttribute("error", "Please select a date and time for the appointment!");
            request.getRequestDispatcher("/WEB-INF/receptionist/AddAppointment.jsp").forward(request, response);
            return;
        }

        LocalDateTime dateBegin;
        try {
            dateBegin = LocalDateTime.parse(dateBeginStr);
        } catch (Exception e) {
            request.setAttribute("error", "Invalid date/time format!");
            request.getRequestDispatcher("/WEB-INF/receptionist/AddAppointment.jsp").forward(request, response);
            return;
        }

        // Kiểm tra patient info
        if ((existingPatientId == null || existingPatientId.isEmpty())
                && (fullName == null || fullName.trim().isEmpty() || phone == null || phone.trim().isEmpty())) {
            request.setAttribute("error", "Please select an existing patient or enter full name and phone for new patient.");
            request.getRequestDispatcher("/WEB-INF/receptionist/AddAppointment.jsp").forward(request, response);
            return;
        }

        try {
            boolean success = appointmentDAO.addAppointment(existingPatientId, fullName, phone, gender, doctorId, dateBegin, note);
            if (success) {
                request.getSession().setAttribute("successMessage", "Appointment added successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to add appointment!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error adding appointment: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
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
