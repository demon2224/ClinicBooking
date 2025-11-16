/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import constants.ManageMyPatientPrescriptionConstants;
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
import java.util.Arrays;
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
                    showCreateForm(request, response);
                    break;
                case "edit":
                    int prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));
                    showEditPrescription(request, response, doctorID, prescriptionID);
                    break;
                case "delete":
                    deletePrescription(request, response, doctorID);
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
            request.setAttribute("prescription", prescription);
            request.getRequestDispatcher("/WEB-INF/doctor/MyPatientPrescriptionDetail.jsp").forward(request, response);
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

    private boolean addPrescriptionInputEditVer(HttpServletRequest request, String medicineID, String dosage, String instruction, int prescriptionID) {
        boolean isValidDosage = isValidDosageEditVer(request, dosage, medicineID, prescriptionID);
        boolean isValidInstruction = isValidInstruction(request, instruction);
        boolean isValidMedicineID = isValidMedicineID(request, medicineID);
        log(isValidMedicineID + " " + isValidInstruction + " " + isValidDosage);
        return isValidMedicineID && isValidDosage && isValidInstruction;
    }

    private boolean isValidInstruction(HttpServletRequest request, String instruction) {
        if (CreatePrescriptionValidate.isEmpty(instruction)) {
            // Hướng dẫn trống.
            log("intruction");
            request.getSession().setAttribute("intructionError", "Instruction cannot be empty!");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidDosage(HttpServletRequest request, String dosage, String medicineID) {
        if (CreatePrescriptionValidate.isEmpty(dosage)) {
            // Liều lượng trống.
            log("dosage1");
            request.getSession().setAttribute("dosageError", "Dosage cannot be empty!");
            return false;
        } else if (!CreatePrescriptionValidate.isValidDosage(dosage)) {
            // Check có phải là số không.
            log("dosage2");
            request.getSession().setAttribute("dosageError", "Dosage must be a numeric value!");
            return false;
        } else if (!CreatePrescriptionValidate.isValidDosageNumber(Integer.parseInt(dosage), medicineDAO.getQuantityMedicineByMedicineID(Integer.parseInt(medicineID)))) {
            // Check liều lượng có quá số lượng trong kho còn không.
            log("dosage3");
            request.getSession().setAttribute("dosageError", "Invalid dosage: exceeds available stock!");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidDosageEditVer(HttpServletRequest request, String dosage, String medicineID, int prescriptionID) {
        if (CreatePrescriptionValidate.isEmpty(dosage)) {
            // Liều lượng trống.
            log("dosage1");
            request.getSession().setAttribute("dosageError", "Dosage cannot be empty!");
            return false;
        } else if (!CreatePrescriptionValidate.isValidDosage(dosage)) {
            // Check có phải là số không.
            log("dosage2");
            request.getSession().setAttribute("dosageError", "Dosage must be a numeric value!");
            return false;
        } else if (!CreatePrescriptionValidate.isValidDosageForEdit(Integer.parseInt(dosage),
                medicineDAO.getQuantityMedicineByMedicineID(Integer.parseInt(medicineID)),
                prescriptionDAO.getDosageMedicineByPrescriptionID(Integer.parseInt(medicineID), prescriptionID))) {
            // Check số lương hiện tại trong đơn thuốc + số lượng trong kho có quá tổng số lượng cả 2 không để tránh đặt quá số lượng thuốc trong kho.
            log("dosage3");
            request.getSession().setAttribute("dosageError", "Invalid dosage: exceeds available stock!");
            return false;
        } else {
            return true;
        }
    }

    private boolean isValidMedicineID(HttpServletRequest request, String medicineID) {
        if (CreatePrescriptionValidate.isEmpty(medicineID)) {
            // Thuốc trống.
            request.getSession().setAttribute("medicineError", "Medicine cannot be empty!");
            return false;
        } else if (!CreatePrescriptionValidate.isValidMedicineID(medicineID)) {
            // Thuốc không tồn tại
            request.getSession().setAttribute("medicineError", "Invalid medicine ID format!");
            return false;
        } else if (!medicineDAO.isExistMedicineID(Integer.parseInt(medicineID))) {
            request.getSession().setAttribute("medicineError", "Medicine does not exist!");
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
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));
        log(medicalRecordID + "-> MedicalRecordID");
        // kiểm tra record có tồn tại chưa
        boolean hasPrescription = prescriptionDAO.isExistPrescription(medicalRecordID);
        if (hasPrescription) {
            log(hasPrescription + "-> has Prescription");
            request.getSession().setAttribute("error", "Prescription for this profile already exists!");
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
            return;
        }
        boolean isExist = medicalRecordDAO.isExistMedicalRecord(medicalRecordID);
        if (!isExist) {
            request.getSession().setAttribute("error", "Medical record not found!");
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
            return;
        }
        // Lấy danh sách thuốc
        List<MedicineDTO> medicineList = new MedicineDAO().getAllMedicines();
        List<String> instructionList = new ManageMyPatientPrescriptionConstants().INSTRUCTION_LIST;
        request.setAttribute("instructionList", instructionList);
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
            log(hasMedicine + "1. Co thuoc trong don roi");
            // Tạo đơn thuốc mà không có thuốc thì báo lỗi quay lại trang tạo đơn thuốc.
            if (!validMedicineInput) {
                request.getSession().setAttribute("errorNull", "Please add at least one medicine before saving the prescription!");
                response.sendRedirect(request.getContextPath()
                        + "/manage-my-patient-prescription?action=create&medicalRecordID=" + medicalRecordID);
                return;
            }

            // Nếu có thuốc thì bắt đầu tạo đơn thuốc để chứa thuốc.
            boolean createPrescriptionResult = prescriptionDAO.createPrescription(appointmentID, note);
            log(createPrescriptionResult + "2. Co thuoc trong don roi");
            // sau khi tạo thì add thuốc vào đơn.
            if (createPrescriptionResult) {
                int prescriptionID = prescriptionDAO.getPrescriptionIDByAppointmentID(appointmentID);
                // kiểm tra valid cho từng thuốc.
                boolean currentState = true;
                log(prescriptionID + "3. ID don thuoc");
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
                    // Update PrescriptionID moi nhat cho MedicalRecordID de lay invoice
                    medicalRecordDAO.updatePrescriptionIDForMedicalRecordID(prescriptionID, appointmentID);
                    request.setAttribute("message", "Prescription created successfully.");
                    //Sau khi tạo xong thì chuyển đến trang chi tiết đơn
                    response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
                } else {
                    // lỗi khi không chọn thuốc
                    prescriptionDAO.deletePrescription(prescriptionID);
                    request.getSession().setAttribute("error", true);
//                    request.setAttribute("medicalRecordID", medicalRecordID);
//                    List<MedicineDTO> medicineList = new MedicineDAO().getAllMedicines();
//                    request.setAttribute("medicineList", medicineList);
                    response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription?action=create&medicalRecordID=" + medicalRecordID);
//                    request.getRequestDispatcher("/WEB-INF/doctor/CreateMyPatientPrescription.jsp").forward(request, response);
                }
            } else {

                // Nếu không thể tạo đơn thuốc
                request.getSession().setAttribute("error", "Unable to create prescription. Please try again!");
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("error", "An error occurred while creating the prescription!");
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-medical-record");
        }
    }

    private void deletePrescription(HttpServletRequest request, HttpServletResponse response, int doctorID)
            throws ServletException, IOException {
        try {
            // Lấy prescriptionID từ request
            int prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));

            // Xác nhận rằng đơn thuốc thuộc về bác sĩ hiện tại
            PrescriptionDTO prescription = prescriptionDAO.getPrescriptionDetailByDoctorIDAndPrescriptionID(doctorID, prescriptionID);

            if (prescription == null) {
                // Không tìm thấy đơn thuốc hoặc không thuộc quyền bác sĩ này
                request.getSession().setAttribute("error", "The prescription does not exist.");
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
                return;
            }
            boolean isHidden = prescriptionDAO.isHiddenPrescription(prescriptionID);
            log(isHidden + "    Hidden");
            // Xóa đơn thuốc (DAO sẽ đảm bảo xóa cả prescription item trước)
            if (!isHidden) {
                boolean isDeleted = prescriptionDAO.doctorDeletePrescription(prescriptionID);

                if (isDeleted) {
                    // Thông báo thành công
                    log("That Bai");
                    request.getSession().setAttribute("message", "Prescription deleted successfully.");
                } else {
                    // Thông báo thất bại
                    request.getSession().setAttribute("error", "Failed to delete prescription. Please try again later.");
                }

                // Quay lại danh sách đơn thuốc
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
            } else {
                boolean isRestore = prescriptionDAO.doctorUnDeletePrescription(prescriptionID);

                if (isRestore) {
                    // Thông báo thành công
                    log("Thanh Cong");
                    request.getSession().setAttribute("message", "Prescription has been restored successfully.");
                } else {
                    // Thông báo thất bại
                    request.getSession().setAttribute("error", "Failed to delete prescription. Please try again later.");
                }

                // Quay lại danh sách đơn thuốc
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
            }
        } catch (NumberFormatException e) {
            // Lỗi khi ID không hợp lệ
            request.getSession().setAttribute("error", "Invalid prescription ID.");
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
        } catch (Exception e) {
            // Lỗi tổng quát
            request.getSession().setAttribute("error", "An unexpected error occurred while deleting the prescription.");
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
        }
    }

    public void showEditPrescription(HttpServletRequest request, HttpServletResponse response, int doctorID, int prescriptionID)
            throws ServletException, IOException {
        try {
            // Lấy thông tin chi tiết để edit
            PrescriptionDTO prescription = prescriptionDAO.getPrescriptionDetailByDoctorIDAndPrescriptionIDToEdit(doctorID, prescriptionID);
            if (prescription != null) {
                // Lấy thuốc để edit
                List<MedicineDTO> medicineList = new MedicineDAO().getAllMedicines();
                // Hiển thị danh sách thuố cũ
                List<PrescriptionItemDTO> itemList = prescriptionDAO.getPrescriptionItemListByPrescriptionID(prescriptionID);
                List<String> instructionList = new ManageMyPatientPrescriptionConstants().INSTRUCTION_LIST;
                request.setAttribute("instructionList", instructionList);
                request.setAttribute("itemList", itemList);
                request.setAttribute("medicineList", medicineList);
                request.setAttribute("prescription", prescription);
                request.getRequestDispatcher("/WEB-INF/doctor/EditMyPatientPrescription.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
        }
    }

    /**
     *
     *
     * edit prescription
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void editPrescriptionInPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));
            String note = request.getParameter("note");
            String[] medicineIDs = request.getParameterValues("medicineID");
            String[] dosages = request.getParameterValues("dosage");
            String[] instructions = request.getParameterValues("instruction");

            boolean currentState = true;

            // Kiểm tra dữ liệu từng thuốc hợp lệ (dosage, instruction)
            for (int i = 0; i < medicineIDs.length; i++) {
                currentState = addPrescriptionInputEditVer(request, medicineIDs[i], dosages[i], instructions[i], prescriptionID);
                if (!currentState) {
                    break;
                }
            }
            if (currentState) {
                //  Xóa các item cũ & phục hồi số lượng thuốc
                prescriptionDAO.deleteAllItemsByPrescriptionID(prescriptionID);

                //  Thêm lại các thuốc mới (đảm bảo không trùng)
                for (int i = 0; i < medicineIDs.length; i++) {
                    String medicineIDStr = medicineIDs[i];
                    if (medicineIDStr == null || medicineIDStr.trim().isEmpty()) {
                        continue;
                    }

                    int medicineID = Integer.parseInt(medicineIDStr);
                    int dosage = Integer.parseInt(dosages[i]);
                    String instruction = instructions[i];

                    // Kiểm tra trùng trong đơn
                    if (prescriptionDAO.isMedicineAlreadyInPrescription(prescriptionID, medicineID)) {
                        String medicineName = medicineDAO.getMedicineNameByID(medicineID);
                        request.getSession().setAttribute("error",
                                "Medicine '" + medicineName + "' already exists in this prescription!");
                        response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription?action=edit&prescriptionID=" + prescriptionID);
                        return;
                    }

                    // Thêm thuốc vào đơn
                    prescriptionDAO.addItemToPrescription(prescriptionID, medicineID, dosage, instruction);
                }

                // Cập nhật ghi chú đơn thuốc
                prescriptionDAO.updatePrescriptionNote(prescriptionID, note);

                //  Thông báo thành công
                request.getSession().setAttribute("message", "Prescription updated successfully.");
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription");
            } else {
                // lỗi khi không chọn thuốc
                request.getSession().setAttribute("error", true);
                response.sendRedirect(request.getContextPath() + "/manage-my-patient-prescription?action=edit&prescriptionID=" + prescriptionID);
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Failed to update prescription.");
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

        String action = request.getParameter("action");
        try {
            switch (action) {
                case "create":
                    createPrescriptionInPost(request, response);
                    break;
                case "edit":
                    editPrescriptionInPost(request, response);
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
