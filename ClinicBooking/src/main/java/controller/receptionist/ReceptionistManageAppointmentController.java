/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.receptionist;

import dao.AppointmentDAO;
import dao.DoctorDAO;
import dao.PatientDAO;
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
import validate.AppointmentValidate;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class ReceptionistManageAppointmentController extends HttpServlet {

    private AppointmentDAO appointmentDAO;;
    private DoctorDAO doctorDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        doctorDAO = new DoctorDAO();
        patientDAO = new PatientDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String searchQuery = request.getParameter("searchQuery");

        try {
            if (action == null) {
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
                    case "searchPatients":
                        handleSearchPatients(request, response);
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

        clearAppointmentErrors(request);
        boolean isValid = true;

        if (AppointmentValidate.isEmpty(existingPatientId)) {

            // Validate Full Name
            if (AppointmentValidate.isEmpty(fullName)) {
                request.getSession().setAttribute("patientNameErrorMsg", "Full name cannot be empty.");
                isValid = false;
            } else if (!AppointmentValidate.isValidName(fullName)) {
                request.getSession().setAttribute("patientNameErrorMsg", "Full name must contain only English letters and spaces.");
                isValid = false;
            }

            // Validate Phone
            if (AppointmentValidate.isEmpty(phone)) {
                request.getSession().setAttribute("phoneErrorMsg", "Phone number cannot be empty.");
                isValid = false;
            } else if (!AppointmentValidate.isValidPhone(phone)) {
                request.getSession().setAttribute("phoneErrorMsg", "Phone must start with 0 and contain 10–11 digits.");
                isValid = false;
            }

        } else {
            fullName = null;
            phone = null;
        }

        // Validate Doctor
        if (AppointmentValidate.isEmpty(doctorIdStr)) {
            request.getSession().setAttribute("doctorErrorMsg", "Please select a doctor.");
            isValid = false;
        }

        // Validate Date
        if (AppointmentValidate.isEmpty(dateBeginStr)) {
            request.getSession().setAttribute("dateErrorMsg", "Please select a date and time.");
            isValid = false;
        }

        // Validate Note
        if (!AppointmentValidate.isValidNote(note)) {
            request.getSession().setAttribute("noteErrorMsg", "Note cannot exceed 500 characters.");
            isValid = false;
        }

        if (!isValid) {
            response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment?action=add");
            return;
        }

        try {
            LocalDateTime dateBegin = LocalDateTime.parse(dateBeginStr);
            int doctorId = Integer.parseInt(doctorIdStr);

            boolean success = appointmentDAO.addAppointment(existingPatientId, fullName, phone, gender, doctorId, dateBegin, note);

            if (success) {
                request.getSession().setAttribute("successMessage", "Appointment created successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to create appointment.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("appointmentCreateErrorMsg", "Error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
    }

    private void clearAppointmentErrors(HttpServletRequest request) {
        String[] keys = {
            "patientNameErrorMsg", "phoneErrorMsg", "doctorErrorMsg", "dateErrorMsg",
            "noteErrorMsg", "successMessage", "errorMessage"
        };
        for (String key : keys) {
            request.getSession().removeAttribute(key);
        }
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

    private void handleSearchPatients(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String query = request.getParameter("query");
        if (query == null || query.trim().isEmpty()) {
            response.getWriter().write("[]");
            return;
        }

        List<PatientDTO> patients = patientDAO.searchPatientsByName(query);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < patients.size(); i++) {
            PatientDTO p = patients.get(i);
            json.append("{")
                    .append("\"id\":").append(p.getPatientID()).append(",")
                    .append("\"name\":\"").append(p.getFirstName()).append(" ").append(p.getLastName()).append("\"")
                    .append("}");
            if (i < patients.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        response.getWriter().write(json.toString());
    }

    private void handleCancelAppointment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
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
            throws IOException {
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        boolean success = appointmentDAO.updateStatusAppointment(appointmentId);

        if (success) {
            request.getSession().setAttribute("successMessage", "Appointment approved successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to approve appointment!");
        }
        response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
    }

    @Override
    public String getServletInfo() {
        return "Receptionist appointment management controller with validation.";
    }
}
