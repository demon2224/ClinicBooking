/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
        String searchQuery = request.getParameter("searchQuery"); // Lấy giá trị search
        dao.AppointmentDAO dao = new dao.AppointmentDAO();

        try {
            if ("viewDetail".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int appointmentId = Integer.parseInt(idParam);
                    model.Appointment appointment = dao.getAppointmentByIdFull(appointmentId);
                    if (appointment != null) {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        String json = "{"
                                + "\"doctorName\":\"" + appointment.getDoctorName() + "\","
                                + "\"specialtyName\":\"" + appointment.getSpecialtyName() + "\","
                                + "\"patientName\":\"" + appointment.getPatientName() + "\","
                                + "\"statusName\":\"" + appointment.getStatusName() + "\","
                                + "\"dateBegin\":\"" + appointment.getDateBegin() + "\","
                                + "\"dateEnd\":\"" + appointment.getDateEnd() + "\","
                                + "\"note\":\"" + (appointment.getNote() != null ? appointment.getNote() : "") + "\""
                                + "}";
                        response.getWriter().write(json);
                        return;
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Appointment not found");
                        return;
                    }
                }
            }

            // Load danh sách appointment (search hoặc toàn bộ)
            java.util.List<model.Appointment> appointmentList;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                appointmentList = dao.searchAppointments(searchQuery); // dùng hàm search mới
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

        if ("cancel".equals(action)) {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            boolean success = dao.cancelAppointment(appointmentId);

            if (success) {
                // load lại danh sách
                response.sendRedirect(request.getContextPath() + "/receptionist-dashboard");
            } else {
                request.setAttribute("error", "Failed to cancel appointment.");
                request.getRequestDispatcher("/WEB-INF/ReceptionistDashboard.jsp").forward(request, response);
            }
        } else if ("approve".equals(action)) {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            System.out.println("Attempting to approve appointmentId=" + appointmentId);

            boolean success = dao.approvedStatusAppointment(appointmentId);
            System.out.println("Approve success=" + success);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/receptionist-dashboard");
            } else {
                request.setAttribute("error", "Failed to approve appointment. (Maybe not pending?)");
                request.getRequestDispatcher("/WEB-INF/ReceptionistDashboard.jsp").forward(request, response);
            }

        } else {
            doGet(request, response); // fallback
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
