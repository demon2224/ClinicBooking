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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

    private AppointmentDAO appointmentDAO;

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
                    case "checkSlot":
                        handleCheckSlot(request, response);
                        break;
                    case "getDoctorBookedSlots":
                        handleGetDoctorBookedSlots(request, response);
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
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String genderStr = request.getParameter("gender");
        boolean gender = genderStr != null ? Boolean.parseBoolean(genderStr) : true;
        String specialtyIdStr = request.getParameter("specialtyID"); // ★ NEW
        String doctorIdStr = request.getParameter("doctorId");
        String dateBeginStr = request.getParameter("appointmentDateTime");
        String note = request.getParameter("note");

        clearAppointmentErrors(request);
        boolean isValid = true;

        /**
         * VALIDATE PATIENT INFO *
         */
        if (AppointmentValidate.isEmpty(existingPatientId)) {
            if (AppointmentValidate.isEmpty(firstName)) {
                request.getSession().setAttribute("firstNameErrorMsg", "First name cannot be empty.");
                isValid = false;
            } else if (!AppointmentValidate.isValidName(firstName)) {
                request.getSession().setAttribute("firstNameErrorMsg", "First name must contain only letters and spaces.");
                isValid = false;
            }

            if (AppointmentValidate.isEmpty(lastName)) {
                request.getSession().setAttribute("lastNameErrorMsg", "Last name cannot be empty.");
                isValid = false;
            } else if (!AppointmentValidate.isValidName(lastName)) {
                request.getSession().setAttribute("lastNameErrorMsg", "Last name must contain only letters and spaces.");
                isValid = false;
            }

            if (AppointmentValidate.isEmpty(phone)) {
                request.getSession().setAttribute("phoneErrorMsg", "Phone number cannot be empty.");
                isValid = false;
            } else if (!AppointmentValidate.isValidPhone(phone)) {
                request.getSession().setAttribute("phoneErrorMsg", "Phone must start with 0 and contain 10–11 digits.");
                isValid = false;
            }
        } else {
            firstName = null;
            lastName = null;
            phone = null;
        }

        /**
         * VALIDATE SPECIALTY *
         */
        if (AppointmentValidate.isEmpty(specialtyIdStr)) {
            request.getSession().setAttribute("specialtyErrorMsg", "Please select a specialty.");
            isValid = false;
        }

        /**
         * VALIDATE DOCTOR *
         */
        if (AppointmentValidate.isEmpty(doctorIdStr)) {
            request.getSession().setAttribute("doctorErrorMsg", "Please select a doctor.");
            isValid = false;
        }

        /**
         * VALIDATE DATE/TIME *
         */
        if (AppointmentValidate.isEmpty(dateBeginStr)) {
            request.getSession().setAttribute("dateErrorMsg", "Please select a date and time.");
            isValid = false;
        }

        if (!AppointmentValidate.isDateTimeFilled(dateBeginStr)) {
            request.getSession().setAttribute("dateErrorMsg", "Please select date and time.");
            isValid = false;
        }

        /**
         * VALIDATE NOTE *
         */
        if (!AppointmentValidate.isValidNote(note)) {
            request.getSession().setAttribute("noteErrorMsg", "Note cannot exceed 500 characters.");
            isValid = false;
        }

        if (!isValid) {
            response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment?action=add");
            return;
        }

        /**
         * PROCESS INSERT *
         */
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd['T'][ ]H:mm");
            LocalDateTime dateBegin = LocalDateTime.parse(dateBeginStr, formatter);
            LocalDateTime dateEnd = dateBegin.plusMinutes(30);

            int doctorId = Integer.parseInt(doctorIdStr);
            boolean success = appointmentDAO.addAppointment(
                    existingPatientId, firstName, lastName, phone,
                    gender, doctorId, dateBegin, dateEnd, note
            );

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
            "patientNameErrorMsg", "firstNameErrorMsg", "lastNameErrorMsg",
            "phoneErrorMsg", "specialtyErrorMsg", "doctorErrorMsg",
            "dateErrorMsg", "noteErrorMsg", "successMessage", "errorMessage"
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

    private void handleCheckSlot(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String doctorIdStr = request.getParameter("doctorId");
        String dateTimeStr = request.getParameter("dateTime"); // yyyy-MM-ddTHH:mm

        if (doctorIdStr == null || dateTimeStr == null) {
            response.getWriter().write("false");
            return;
        }

        try {
            int doctorId = Integer.parseInt(doctorIdStr);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd['T'][ ]H:mm");
            LocalDateTime dateTime = LocalDateTime.parse(dateTimeStr, formatter);

            boolean available = appointmentDAO.isDoctorAvailableAtExactTime(doctorId, Timestamp.valueOf(dateTime))
                    && appointmentDAO.hasValid30MinuteGap(doctorId, Timestamp.valueOf(dateTime));

            response.getWriter().write(String.valueOf(available));

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("false");
        }
    }

    private void handleGetDoctorBookedSlots(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String doctorIdStr = request.getParameter("doctorId");
        String monthStr = request.getParameter("month");
        String yearStr = request.getParameter("year");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (doctorIdStr == null || monthStr == null || yearStr == null) {
            response.getWriter().write("[]");
            return;
        }

        try {
            int doctorId = Integer.parseInt(doctorIdStr);
            int month = Integer.parseInt(monthStr);
            int year = Integer.parseInt(yearStr);

            List<AppointmentDTO> appointments = appointmentDAO.getAppointmentsByDoctorAndMonth(doctorId, month, year);

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < appointments.size(); i++) {
                AppointmentDTO appt = appointments.get(i);
                if (appt.getDateBegin() == null) {
                    continue;
                }

                Timestamp ts = appt.getDateBegin();
                String date = ts.toLocalDateTime().toLocalDate().toString();
                String time = String.format("%02d:%02d",
                        ts.toLocalDateTime().getHour(),
                        ts.toLocalDateTime().getMinute()
                );

                json.append("{\"date\":\"").append(date).append("\",\"time\":\"").append(time).append("\"}");
                if (i < appointments.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");

            response.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("[]");
        }
    }

    @Override
    public String getServletInfo() {
        return "Receptionist appointment management controller with validation.";
    }
}
