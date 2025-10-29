///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controller.receptionist;
//
//import dao.AppointmentDAO;
//import dao.DoctorDAO;
//import dao.UserDAO;
//import java.io.IOException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.util.List;
//import model.Appointment;
//import model.Doctor;
//import model.Patient;
//
///**
// *
// * @author Ngo Quoc Hung - CE191184
// */
//public class ReceptionistManageAppointmentController extends HttpServlet {
//
//    private AppointmentDAO appointmentDAO;
//    private UserDAO userDAO;
//    private DoctorDAO doctorDAO;
//
//    @Override
//    public void init() throws ServletException {
//        appointmentDAO = new AppointmentDAO();
//        userDAO = new UserDAO();
//        doctorDAO = new DoctorDAO();
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//        String searchQuery = request.getParameter("searchQuery");
//
//        try {
//            if ("viewDetail".equals(action)) {
//                handleViewDetail(request, response);
//            } else if ("add".equals(action)) {
//                handleAddAppointmentForm(request, response);
//            } else if ("getDoctorsBySpecialty".equals(action)) {
//                handleGetDoctorsBySpecialty(request, response);
//            } else {
//                handleViewAppointmentList(request, response, searchQuery);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
//        }
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//
//        try {
//            switch (action) {
//                case "cancel":
//                    handleCancelAppointment(request, response);
//                    break;
//                case "approve":
//                    handleApproveAppointment(request, response);
//                    break;
//                case "addAppointment":
//                    handleAddAppointment(request, response);
//                    break;
//                default:
//                    response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing POST request");
//        }
//    }
//
//    private void handleViewAppointmentList(HttpServletRequest request, HttpServletResponse response, String searchQuery)
//            throws ServletException, IOException {
//        List<Appointment> appointmentList;
//        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
//            appointmentList = appointmentDAO.searchAppointments(searchQuery);
//        } else {
//            appointmentList = appointmentDAO.getAllAppointments();
//        }
//        request.setAttribute("appointmentList", appointmentList);
//        request.getRequestDispatcher("/WEB-INF/receptionist/ReceptionistAppointment.jsp").forward(request, response);
//    }
//
//    private void handleViewDetail(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String idParam = request.getParameter("id");
//        if (idParam == null || idParam.trim().isEmpty()) {
//            response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
//            return;
//        }
//
//        int appointmentId = Integer.parseInt(idParam);
//        Appointment appointment = appointmentDAO.getAppointmentByIdFull(appointmentId);
//        if (appointment == null) {
//            response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
//            return;
//        }
//
//        Doctor doctor = doctorDAO.getDoctorById(appointment.getDoctorID());
//        request.setAttribute("appointment", appointment);
//        request.setAttribute("doctor", doctor);
//        request.getRequestDispatcher("/WEB-INF/receptionist/AppointmentDetail.jsp").forward(request, response);
//    }
//
//    private void handleAddAppointmentForm(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        List<String[]> specialties = doctorDAO.getAllSpecialties();
//        List<Patient> patients = userDAO.getAllPatients();
//
//        request.setAttribute("specialties", specialties);
//        request.setAttribute("patients", patients);
//        request.getRequestDispatcher("/WEB-INF/receptionist/AddAppointment.jsp").forward(request, response);
//    }
//
//    private void handleGetDoctorsBySpecialty(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        String specialtyName = request.getParameter("specialtyName");
//        List<Doctor> doctors = doctorDAO.getDoctorsBySpecialty(specialtyName);
//
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//
//        StringBuilder json = new StringBuilder("[");
//        for (int i = 0; i < doctors.size(); i++) {
//            Doctor d = doctors.get(i);
//            json.append("{")
//                    .append("\"doctorID\":").append(d.getDoctorID()).append(",")
//                    .append("\"doctorName\":\"").append(d.getFirstName()).append(" ").append(d.getLastName()).append("\"")
//                    .append("}");
//            if (i < doctors.size() - 1) {
//                json.append(",");
//            }
//        }
//        json.append("]");
//        response.getWriter().write(json.toString());
//    }
//
//    private void handleCancelAppointment(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
//        boolean success = appointmentDAO.cancelAppointment(appointmentId);
//
//        if (success) {
//            request.getSession().setAttribute("successMessage", "Appointment canceled successfully!");
//        } else {
//            request.getSession().setAttribute("errorMessage", "Failed to cancel appointment!");
//        }
//        response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
//    }
//
//    private void handleApproveAppointment(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
//        boolean success = appointmentDAO.approvedStatusAppointment(appointmentId);
//
//        if (success) {
//            request.getSession().setAttribute("successMessage", "Appointment approved successfully!");
//        } else {
//            request.getSession().setAttribute("errorMessage", "Failed to approve appointment!");
//        }
//        response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
//    }
//
//    private void handleAddAppointment(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String existingPatientId = request.getParameter("existingPatientId");
//        String fullName = request.getParameter("patientName");
//        String phone = request.getParameter("phone");
//        String genderStr = request.getParameter("gender");
//        boolean gender = genderStr != null ? Boolean.parseBoolean(genderStr) : true;
//        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
//        String note = request.getParameter("note");
//
//        if ((existingPatientId == null || existingPatientId.isEmpty())
//                && (fullName == null || fullName.trim().isEmpty() || phone == null || phone.trim().isEmpty())) {
//            request.setAttribute("error", "Please select existing patient or enter full name and phone for new patient.");
//            request.getRequestDispatcher("/WEB-INF/receptionist/AddAppointment.jsp").forward(request, response);
//            return;
//        }
//
//        boolean success = appointmentDAO.addAppointment(existingPatientId, fullName, phone, gender, doctorId, note);
//        if (success) {
//            request.getSession().setAttribute("successMessage", "Appointment added successfully!");
//        } else {
//            request.getSession().setAttribute("errorMessage", "Failed to add appointment!");
//        }
//        response.sendRedirect(request.getContextPath() + "/receptionist-manage-appointment");
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
