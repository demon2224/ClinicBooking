/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dao.MedicalRecordDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DoctorDTO;
import model.MedicalRecordDTO;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class ManageMyPatientMedicalRecordController extends HttpServlet {

    private MedicalRecordDAO medicalRecordDAO;

    /**
     * Initialize all the necessary DAO using in this controller.
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        medicalRecordDAO = new MedicalRecordDAO();
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

        try {
            int doctorID = ((DoctorDTO) request.getSession().getAttribute("doctor")).getDoctorID();

            String action = request.getParameter("action");
            if ((action == null) || (action.isEmpty())) {
                showMyPatientMedicalRecordList(request, response, doctorID);
            }
            if (action.equals("detail")) {
                showMyPatientMedicalRecordDetail(request, response, doctorID);
            }
        } catch (Exception ex) {

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
            if (medicalRecord.getMedicalRecordID() == medicalRecordID) {
                request.setAttribute("detailMedicalRecord", medicalRecord);
            }
            request.getRequestDispatcher("/WEB-INF/doctor/MyPatientMedicalRecordDetail.jsp").forward(request, response);
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
        processRequest(request, response);
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
