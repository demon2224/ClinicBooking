/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dao.AppointmentDAO;
import dao.MedicalRecordDAO;
import dao.MedicineDAO;
import dao.PrescriptionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DoctorDTO;
import model.MedicineDTO;
import model.PrescriptionDTO;
import model.PrescriptionItemDTO;
import validate.CreatePrescriptionValidate;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class ManageMyPatientPrescriptionController extends HttpServlet {

    private MedicalRecordDAO medicalRecordDAO;
    private PrescriptionDAO prescriptionDAO;
    private AppointmentDAO appointmentDAO;
    private MedicineDAO medicineDAO;

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
        medicineDAO = new MedicineDAO();
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
                case "create":
                    showCreateForm(request, response, doctorID);
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
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {

        int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));

        // kiểm tra record có tồn tại chưa
        boolean hasPrescription = prescriptionDAO.isExistPrescription(medicalRecordID);
        if (hasPrescription) {
            request.setAttribute("error", "Đơn thuốc cho hồ sơ này đã tồn tại!");
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
            return;
        }
        // Lấy danh sách thuốc
        List<MedicineDTO> medicineList = new MedicineDAO().getAllMedicines();
        request.setAttribute("medicineList", medicineList);
        request.setAttribute("medicalRecordID", medicalRecordID);
        request.getRequestDispatcher("/WEB-INF/doctor/CreateMyPatientPrescription.jsp").forward(request, response);
    }

    private void createPrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));
            String note = request.getParameter("note");

            // Lấy appointmentID từ MedicalRecord
            MedicalRecordDAO medicalDAO = new MedicalRecordDAO();
            int appointmentID = medicalDAO.getAppointmentIdByMedicalRecordId(medicalRecordID);

            // Tạo đơn thuốc
            boolean createPrescriptionResult = prescriptionDAO.createPrescription(appointmentID, note);
            if (createPrescriptionResult) {
                Integer prescriptionID = prescriptionDAO.getPrescriptionIDByAppointmentID(appointmentID);

                if (prescriptionID == null) {
                    throw new Exception();
                }

                // Tạo các item
                String[] medicineIDs = request.getParameterValues("medicineID");
                String[] dosages = request.getParameterValues("dosage");
                String[] instructions = request.getParameterValues("instruction");

                boolean currentState = true;

                for (int i = 0; i < medicineIDs.length; i++) {
                    currentState = addPrescriptionInput(request, medicineIDs[i], dosages[i], instructions[i]);
                }

                if (currentState) {
                    for (int i = 0; i < medicineIDs.length; i++) {
                        int medicineID = Integer.parseInt(medicineIDs[i]);
                        int dosage = Integer.parseInt(medicineIDs[i]);
                        prescriptionDAO.addItemToPrescription(prescriptionID, medicineID, dosage, instructions[i]);
                    }
                    // Sau khi tạo xong chuyển đến trang chi tiết
                    response.sendRedirect(request.getContextPath()
                            + "/manage-my-patient-prescription?action=detail&prescriptionID=" + prescriptionID);
                } else {
                    prescriptionDAO.deletePrescription(prescriptionID);
                    response.sendRedirect(request.getContextPath()
                            + "/manage-my-patient-prescription?action=create&medicalRecordID=" + medicalRecordID);
                }
            } else {
                //Set thong6 bao1 loi46
                response.sendRedirect(request.getContextPath()
                        + "/manage-my-patient-prescription?action=create&medicalRecordID=" + medicalRecordID);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tạo đơn thuốc!");
            int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));
            response.sendRedirect(request.getContextPath()
                    + "/manage-my-patient-prescription?action=create&medicalRecordID=" + medicalRecordID);
        }
    }

    private boolean addPrescriptionInput(HttpServletRequest request, String medicineID, String dosage, String instruction) {
        boolean isValidMedicineID = isValidMedicineID(request, medicineID);
        boolean isValidDosage = isValidDosage(request, dosage, medicineID);
        boolean isValidInstruction = isValidInstruction(request, instruction);
        log(isValidMedicineID + " " + isValidInstruction + " " + isValidDosage);
        return isValidMedicineID && isValidDosage && isValidInstruction;
    }

    private boolean isValidInstruction(HttpServletRequest request, String instruction) {
        if (CreatePrescriptionValidate.isEmpty(instruction)) {
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidDosage(HttpServletRequest request, String dosage, String medicineID) {
        if (CreatePrescriptionValidate.isEmpty(dosage)) {
            return false;
        } else if (!CreatePrescriptionValidate.isValidDosage(dosage)) {
            return false;
        } else if (!CreatePrescriptionValidate.isValidDosageNumber(Integer.parseInt(dosage),
                medicineDAO.getQuantityMedicineByMedicineID(Integer.parseInt(medicineID)))) {
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineID(HttpServletRequest request, String medicineID) {
        if (CreatePrescriptionValidate.isEmpty(medicineID)) {
            return false;
        } else if (!CreatePrescriptionValidate.isValidMedicineID(medicineID)) {
            return false;
        } else if (!medicineDAO.isExistMedicineID(Integer.parseInt(medicineID))) {
            return false;
        } else {
            return true;
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
        String action = request.getParameter("action");
        if ("insert".equals(action)) {
            createPrescription(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
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
