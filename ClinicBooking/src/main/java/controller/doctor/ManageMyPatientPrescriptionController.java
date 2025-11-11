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

    private boolean addPrescriptionInput(HttpServletRequest request, String medicineID, String dosage, String instruction) {
        boolean isValidDosage = isValidDosage(request, dosage, medicineID);
        boolean isValidInstruction = isValidInstruction(request, instruction);
        boolean isValidMedicineID = isValidMedicineID(request, medicineID);
        log(isValidMedicineID + " " + isValidInstruction + " " + isValidDosage);
        return isValidMedicineID && isValidDosage && isValidInstruction;
    }

    private boolean isValidInstruction(HttpServletRequest request, String instruction) {
        if (CreatePrescriptionValidate.isEmpty(instruction)) {
            // Hướng dẫn trống.
            request.getSession().setAttribute("intructionError", "Chỉ dẫn không thể để trống!");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidDosage(HttpServletRequest request, String dosage, String medicineID) {
        if (CreatePrescriptionValidate.isEmpty(dosage)) {
            // Liều lượng trống.
            request.getSession().setAttribute("dosageError", "Liều lượng không thể để trống!");
            return false;
        } else if (!CreatePrescriptionValidate.isValidDosage(dosage)) {
            // Check có phải là số không.
            request.getSession().setAttribute("dosageError", "Liều lượng phải là số!");
            return false;
        } else if (!CreatePrescriptionValidate.isValidDosageNumber(Integer.parseInt(dosage), medicineDAO.getQuantityMedicineByMedicineID(Integer.parseInt(medicineID)))) {
            // Check liều lượng có quá số lượng trong kho còn không.
            request.getSession().setAttribute("dosageError", "Liều lượng không hợp lệ!");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineID(HttpServletRequest request, String medicineID) {
        if (CreatePrescriptionValidate.isEmpty(medicineID)) {
            // Thuốc trống.
            request.getSession().setAttribute("medicineError", "Thuốc không thể để trống!");
            return false;
        } else if (!CreatePrescriptionValidate.isValidMedicineID(medicineID)) {
            // Thuốc không tồn tại
            request.getSession().setAttribute("medicineError", "Thuốc hợp lệ!");
            return false;
        } else if (!medicineDAO.isExistMedicineID(Integer.parseInt(medicineID))) {
            request.getSession().setAttribute("medicineError", "Thuốc không tồn tại!");
            return false;
        } else {
            return true;
        }
    }

    /**
     * Show form tạo thuốc.
     *
     * @param request
     * @param response
     * @param doctorID
     * @throws ServletException
     * @throws IOException
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {

        int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));

        // kiểm tra record có tồn tại chưa
        boolean hasPrescription = prescriptionDAO.isExistPrescription(medicalRecordID);
        if (hasPrescription) {
            request.getSession().setAttribute("error", "Prescription for this profile already exists!");
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
            return;
        }
        // Lấy danh sách thuốc
        List<MedicineDTO> medicineList = new MedicineDAO().getAllMedicines();
        request.setAttribute("medicineList", medicineList);
        request.setAttribute("medicalRecordID", medicalRecordID);
        request.getRequestDispatcher("/WEB-INF/doctor/CreateMyPatientPrescription.jsp").forward(request, response);
    }

    public void createPrescriptionInPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));
            String note = request.getParameter("note");

            // Lấy appointmentID từ MedicalRecord để tạo đơn thuốc cho appointmentID này.
            int appointmentID = medicalRecordDAO.getAppointmentIdByMedicalRecordId(medicalRecordID);

            // Lấy dữ liệu thuốc từ form
            String[] medicineIDs = request.getParameterValues("medicineID");
            String[] dosages = request.getParameterValues("dosage");
            String[] instructions = request.getParameterValues("instruction");

            // Kiểm tra xem có chọn thuốc hay chưa
            boolean hasMedicine = medicineIDs != null && medicineIDs.length > 0;
            boolean validMedicineInput = false;

            if (hasMedicine) {
                for (String med : medicineIDs) {
                    if (med != null && !med.trim().isEmpty()) {
                        validMedicineInput = true;
                        break;
                    }

                }
            }

            // Tạo đơn thuốc mà không có thuốc thì báo lỗi quay lại trang tạo đơn thuốc.
            if (!validMedicineInput) {
                request.getSession().setAttribute("errorNull", "Vui lòng thêm ít nhất một loại thuốc trước khi lưu đơn!");
                response.sendRedirect(request.getContextPath()
                        + "/manage-my-patient-prescription?action=create&medicalRecordID=" + medicalRecordID);
                return;
            }

            // Nếu có thuốc thì bắt đầu tạo đơn thuốc để chứa thuốc.
            boolean createPrescriptionResult = prescriptionDAO.createPrescription(appointmentID, note);

            // sau khi tạo thì add thuốc vào đơn.
            if (createPrescriptionResult) {
                int prescriptionID = prescriptionDAO.getPrescriptionIDByAppointmentID(appointmentID);
                // kiểm tra valid cho từng thuốc.
                boolean currentState = true;

                // Kiểm tra dữ liệu từng thuốc hợp lệ (dosage, instruction)
                for (int i = 0; i < medicineIDs.length; i++) {
                    currentState = addPrescriptionInput(request, medicineIDs[i], dosages[i], instructions[i]);
                    if (!currentState) {
                        break;
                    }
                }

                if (currentState) {
                    //Thêm từng thuốc vào đơn
                    for (int i = 0; i < medicineIDs.length; i++) {
                        if (medicineIDs[i] == null || medicineIDs[i].trim().isEmpty()) {
                            continue;
                        }

                        int medicineID = Integer.parseInt(medicineIDs[i]);
                        int dosage = Integer.parseInt(dosages[i]);
                        String instruction = instructions[i];

                        prescriptionDAO.addItemToPrescription(prescriptionID, medicineID, dosage, instruction);
                    }

                    request.setAttribute("message", "Đơn thuốc đã tạo thành công.");
                    //Sau khi tạo xong thì chuyển đến trang chi tiết đơn
                    response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
                } else {
                    // lỗi khi không chọn thuốc
                    prescriptionDAO.deletePrescription(prescriptionID);
                    request.getSession().setAttribute("error", true);
                    response.sendRedirect(request.getContextPath()
                            + "/manage-my-patient-prescription?action=create&medicalRecordID=" + medicalRecordID);
                }
            } else {
                // Nếu không thể tạo đơn thuốc
                request.getSession().setAttribute("error", "Không thể tạo đơn thuốc, vui lòng thử lại!");
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("error", "Đã xảy ra lỗi trong quá trình tạo đơn thuốc!");
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

        String action = request.getParameter("action");
        try {
            switch (action) {
                case "create":
                    createPrescriptionInPost(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
                    break;
            }
        } catch (Exception e) {
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
