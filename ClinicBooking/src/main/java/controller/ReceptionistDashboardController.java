/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DoctorDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Appointment;
import model.Doctor;
import model.Patient;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class ReceptionistDashboardController extends HttpServlet {

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
            out.println("<title>Servlet ReceptionistDashboardController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReceptionistDashboardController at " + request.getContextPath() + "</h1>");
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

        String action = request.getParameter("action");
        String searchQuery = request.getParameter("searchQuery");
        dao.AppointmentDAO dao = new dao.AppointmentDAO();

        try {

            if ("getDoctorsBySpecialty".equals(action)) {
                String specialtyName = request.getParameter("specialtyName");

                DoctorDAO doctorDAO = new DoctorDAO();
                List<Doctor> doctors = doctorDAO.getDoctorsBySpecialty(specialtyName);

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < doctors.size(); i++) {
                    Doctor d = doctors.get(i);
                    json.append("{")
                            .append("\"doctorID\":").append(d.getDoctorID()).append(",")
                            .append("\"doctorName\":\"").append(d.getFirstName()).append(" ").append(d.getLastName()).append("\"")
                            .append("}");
                    if (i < doctors.size() - 1) {
                        json.append(",");
                    }
                }
                json.append("]");
                response.getWriter().write(json.toString());
                return;
            }

            if ("viewDetail".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int appointmentId = Integer.parseInt(idParam);
                    Appointment appointment = dao.getAppointmentByIdFull(appointmentId);

                    if (appointment != null) {
                        // Lấy thêm thông tin bác sĩ từ DoctorDAO
                        Doctor doctor = new DoctorDAO().getDoctorById(appointment.getDoctorID());

                        // Set attribute đúng để JSP dùng
                        request.setAttribute("appointment", appointment);
                        request.setAttribute("doctor", doctor);

                        request.getRequestDispatcher("/WEB-INF/receptionist/AppointmentDetail.jsp")
                                .forward(request, response);
                        return;
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Appointment not found");
                        return;
                    }
                }
            }
            if ("add".equals(action)) {
                DoctorDAO doctorDAO = new DoctorDAO();
                List<String[]> specialties = doctorDAO.getAllSpecialties();
                request.setAttribute("specialties", specialties);

                UserDAO userDAO = new UserDAO();
                List<Patient> patients = userDAO.getAllPatients();
                request.setAttribute("patients", patients);

                request.getRequestDispatcher("/WEB-INF/receptionist/AddAppointment.jsp")
                        .forward(request, response);
                return;
            }

            java.util.List<model.Appointment> appointmentList;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                appointmentList = dao.searchAppointments(searchQuery);
            } else {
                appointmentList = dao.getAllAppointments();
            }

            request.setAttribute("appointmentList", appointmentList);
            request.getRequestDispatcher("/WEB-INF/ReceptionistDashboard.jsp").forward(request, response);

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
        dao.AppointmentDAO dao = new dao.AppointmentDAO();

        try {
            if ("cancel".equals(action)) {
                int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
                boolean success = dao.cancelAppointment(appointmentId);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/receptionist-dashboard");
                } else {
                    request.setAttribute("error", "Failed to cancel appointment.");
                    request.getRequestDispatcher("/WEB-INF/ReceptionistDashboard.jsp").forward(request, response);
                }

            } else if ("approve".equals(action)) {
                int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
                boolean success = dao.approvedStatusAppointment(appointmentId);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/receptionist-dashboard");
                } else {
                    request.setAttribute("error", "Failed to approve appointment. (Maybe not pending?)");
                    request.getRequestDispatcher("/WEB-INF/ReceptionistDashboard.jsp").forward(request, response);
                }

            } else if ("addAppointment".equals(action)) {
                String existingPatientId = request.getParameter("existingPatientId");
                String fullName = request.getParameter("patientName");
                String phone = request.getParameter("phone");
                String genderStr = request.getParameter("gender");
                boolean gender = genderStr != null ? Boolean.parseBoolean(genderStr) : true; // default male
                int doctorId = Integer.parseInt(request.getParameter("doctorId"));
                String note = request.getParameter("note");

                if ((existingPatientId == null || existingPatientId.isEmpty())
                        && (fullName == null || fullName.trim().isEmpty() || phone == null || phone.trim().isEmpty())) {
                    request.setAttribute("error", "Please select existing patient or enter full name and phone for new patient.");
                    doGet(request, response); // gọi lại doGet để hiển thị form
                    return;
                }

                boolean success = dao.addAppointment(existingPatientId, fullName, phone, gender, doctorId, note);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/receptionist-dashboard");
                } else {
                    request.setAttribute("error", "Failed to add appointment.");
                    doGet(request, response);
                }
            } else {
                doGet(request, response); // fallback
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing POST request");
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
