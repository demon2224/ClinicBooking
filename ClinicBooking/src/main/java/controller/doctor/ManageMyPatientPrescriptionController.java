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
import model.DoctorDTO;
import model.PrescriptionDTO;
import model.PrescriptionItemDTO;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class ManageMyPatientPrescriptionController extends HttpServlet {

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
            out.println("<title>Servlet ManageMyPatientPrescriptionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageMyPatientPrescriptionController at " + request.getContextPath() + "</h1>");
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
                    showPrescriptionDetail(request, response, doctorID);
                    break;
                default:
                    showPrescriptionList(request, response, doctorID);
                    break;
            }
        } catch (Exception e) {
            showPrescriptionList(request, response, doctorID);
        }

    }

    private void showPrescriptionList(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        List<PrescriptionDTO> list;

        if (keyword != null && !keyword.trim().isEmpty()) {
            list = prescriptionDAO.searchPrescriptionListByPatientName(doctorID, keyword);
        } else {
            list = prescriptionDAO.getPrescriptionListByDoctorID(doctorID);
        }

        request.setAttribute("myPatientPrescriptionList", list);
        request.getRequestDispatcher("/WEB-INF/doctor/MyPatientPrescriptionList.jsp").forward(request, response);
    }

    private void showPrescriptionDetail(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {
        try {
            int prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));
            PrescriptionDTO prescription = prescriptionDAO.getPrescriptionDetailByDoctorIDAndPrescriptionID(doctorID, prescriptionID);

            if (prescription != null) {
                request.setAttribute("prescription", prescription);
                request.getRequestDispatcher("/WEB-INF/doctor/MyPatientPrescriptionDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
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
