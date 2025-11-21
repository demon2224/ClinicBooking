    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
     */
    package controller.receptionist;

    import dao.AppointmentDAO;
    import dao.InvoiceDAO;
    import java.io.IOException;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import java.util.List;
    import model.DoctorDTO;
    import model.SpecialtyDTO;

    /**
     *
     * @author Ngo Quoc Hung - CE191184
     */
    public class ReceptionistDashboardController extends HttpServlet {

        private InvoiceDAO invoiceDAO;
        private AppointmentDAO appointmentDAO;

        @Override
        public void init() throws ServletException {
            invoiceDAO = new InvoiceDAO();
            appointmentDAO = new AppointmentDAO();
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



            // ===== Stats =====
            int todayAppointments = appointmentDAO.countAppointmentsToday();
            int completedAppointments = appointmentDAO.countCompletedAppointmentsToday();
            double todayRevenue = invoiceDAO.sumRevenueToday();

            // ===== Top 5 Doctors by Revenue =====
            List<DoctorDTO> topDoctors = invoiceDAO.getTop5DoctorByRevenue();

            // ===== Top 5 Specialties Booked =====
            List<SpecialtyDTO> topSpecialties = invoiceDAO.getTop5BookedSpecialties();

            // ===== Set Attributes =====
            request.setAttribute("todayAppointments", todayAppointments);
            request.setAttribute("completedAppointments", completedAppointments);
            request.setAttribute("todayRevenue", todayRevenue);

            request.setAttribute("topDoctors", topDoctors);
            request.setAttribute("topSpecialties", topSpecialties);

            // ===== Forward to JSP =====
            request.getRequestDispatcher("/WEB-INF/receptionist/ReceptionistDashboard.jsp")
                    .forward(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
        }

        @Override
        public String getServletInfo() {
            return "Receptionist Dashboard Controller";
        }
    }
