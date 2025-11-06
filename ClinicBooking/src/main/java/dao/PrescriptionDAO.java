/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AppointmentDTO;
import model.DoctorDTO;
import model.MedicineDTO;
import model.PatientDTO;
import model.PrescriptionDTO;
import model.PrescriptionItemDTO;
import model.StaffDTO;
import utils.DBContext;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class PrescriptionDAO extends DBContext {

    /**
     * Check Prescription of one medical record exist or not
     *
     * @param medicalRecordID
     * @return
     */
    public boolean isExistPrescription(int medicalRecordID) {
        String sql = "Select p.PrescriptionID\n"
                + "                from MedicalRecord m\n"
                + "                Join Prescription p on p.AppointmentID = m.AppointmentID\n"
                + "                Where m.MedicalRecordID = ?";
        Object[] params = {medicalRecordID};
        ResultSet rs = executeSelectQuery(sql, params);
        boolean isExistPrescription = false;
        try {
            isExistPrescription = rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(MedicalRecordDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return isExistPrescription;
    }

    /**
     * Get prescription for medical record.
     *
     * @param doctorID
     * @param medicalRecordID
     * @return
     */
    public List<PrescriptionItemDTO> getPrescriptionByDoctorIDAndMedicalRecordID(int doctorID, int medicalRecordID) {
        List<PrescriptionItemDTO> prescriptionItemList = new ArrayList<>();
        String sql = "select m.MedicalRecordID,\n"
                + "p.PrescriptionID,\n"
                + "p.DateCreate as PrescriptionDateCreate,\n"
                + "p.Note as PrescriptionNote,\n"
                + "p.PrescriptionStatus,\n"
                + "pi.Instruction,\n"
                + "pi.Dosage,\n"
                + "me.MedicineName\n"
                + "from Prescription p\n"
                + "join MedicalRecord m on m.AppointmentID = p.AppointmentID\n"
                + "join PrescriptionItem pi on pi.PrescriptionID = p.PrescriptionID\n"
                + "join Medicine me on me.MedicineID = pi.MedicineID\n"
                + "join Appointment a on a.AppointmentID = p.AppointmentID\n"
                + "Where a.DoctorID = ? and m.MedicalRecordID = ?";
        Object[] params = {doctorID, medicalRecordID};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    // Prescription
                    PrescriptionDTO prescription = new PrescriptionDTO();
                    prescription.setDateCreate(rs.getTimestamp("PrescriptionDateCreate"));
                    prescription.setPrescriptionStatus(rs.getString("PrescriptionStatus"));
                    prescription.setNote(rs.getString("PrescriptionNote"));
                    prescription.setPrescriptionID(rs.getInt("PrescriptionID"));
                    // Medicine
                    MedicineDTO medicine = new MedicineDTO();
                    medicine.setMedicineName(rs.getString("MedicineName"));
                    // Prescription Item
                    PrescriptionItemDTO prescriptionItem = new PrescriptionItemDTO();
                    prescriptionItem.setMedicineID(medicine);
                    prescriptionItem.setPrescriptionID(prescription);
                    prescriptionItem.setDosage(rs.getInt("Dosage"));
                    prescriptionItem.setInstruction(rs.getString("Instruction"));
                    // Add to list
                    prescriptionItemList.add(prescriptionItem);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return prescriptionItemList;
    }

    /**
     * Lấy danh sách đơn thuốc của bác sĩ
     */
    public List<PrescriptionDTO> getPatientPrescriptionListByDoctorID(int doctorID) {
        List<PrescriptionDTO> prescriptions = new ArrayList<>();
        String sql = "SELECT p.PrescriptionID, p.Note, p.DateCreate, p.PrescriptionStatus, "
                + "pa.FirstName, pa.LastName, a.DateBegin "
                + "FROM Prescription p "
                + "JOIN MedicalRecord m ON m.PrescriptionID = p.PrescriptionID "
                + "JOIN Appointment a ON a.AppointmentID = m.AppointmentID "
                + "JOIN Patient pa ON pa.PatientID = a.PatientID "
                + "WHERE a.DoctorID = ? "
                + "ORDER BY p.DateCreate DESC";
        Object[] params = {doctorID};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            while (rs.next()) {
                PrescriptionDTO pres = new PrescriptionDTO();
                pres.setPrescriptionID(rs.getInt("PrescriptionID"));
                pres.setNote(rs.getString("Note"));
                pres.setDateCreate(rs.getTimestamp("DateCreate"));
                pres.setPrescriptionStatus(rs.getString("PrescriptionStatus"));

                PatientDTO patient = new PatientDTO();
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));

                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setPatientID(patient);

                pres.setAppointmentID(appointment);
                prescriptions.add(pres);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PrescriptionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return prescriptions;
    }

    public List<PrescriptionDTO> getAllActivePrescriptions() {

        String query = "SELECT p.PrescriptionID, p.PrescriptionStatus, p.DateCreate, st.FirstName as DoctorFirstName, st.LastName as DoctorLastName, pt.FirstName as PatientFirstName, pt.LastName as PatientLastName\n"
                + "FROM [dbo].[Prescription] p\n"
                + "JOIN [dbo].[Appointment] a\n"
                + "ON a.AppointmentID = p.AppointmentID\n"
                + "JOIN [dbo].[Doctor] dt\n"
                + "ON dt.DoctorID = a.DoctorID\n"
                + "JOIN [dbo].[Staff] st\n"
                + "ON st.StaffID = dt.StaffID\n"
                + "JOIN [dbo].[Patient] pt\n"
                + "ON pt.PatientID = a.PatientID\n"
                + "WHERE p.Hidden = 0\n"
                + "ORDER BY DateCreate DESC;";
        List<PrescriptionDTO> prescriptionList = new ArrayList<>();
        ResultSet rs = null;

        try {

            rs = executeSelectQuery(query);
            while (rs.next()) {

                StaffDTO staff = new StaffDTO();
                staff.setFirstName(rs.getString("DoctorFirstName"));
                staff.setLastName(rs.getString("DoctorFirstName"));

                PatientDTO patient = new PatientDTO();
                patient.setFirstName(rs.getString("PatientFirstName"));
                patient.setLastName(rs.getString("PatientLastName"));

                DoctorDTO doctor = new DoctorDTO();
                doctor.setStaffID(staff);

                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setDoctorID(doctor);
                appointment.setPatientID(patient);

                PrescriptionDTO prescription = new PrescriptionDTO();
                prescription.setPrescriptionID(rs.getInt("PrescriptionID"));
                prescription.setPrescriptionStatus(rs.getString("PrescriptionStatus"));
                prescription.setDateCreate(rs.getObject("DateCreate", Timestamp.class));
                prescription.setAppointmentID(appointment);

                prescriptionList.add(prescription);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PrescriptionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return prescriptionList;
    }

    public List<PrescriptionDTO> searchPrescriptionsByDoctorNameOrPatientName(String searchQuery) {

        String query = "SELECT p.PrescriptionID, p.PrescriptionStatus, p.DateCreate, st.FirstName as DoctorFirstName, st.LastName as DoctorLastName, pt.FirstName as PatientFirstName, pt.LastName as PatientLastName\n"
                + "FROM [dbo].[Prescription] p\n"
                + "JOIN [dbo].[Appointment] a\n"
                + "ON a.AppointmentID = p.AppointmentID\n"
                + "JOIN [dbo].[Doctor] dt\n"
                + "ON dt.DoctorID = a.DoctorID\n"
                + "JOIN [dbo].[Staff] st\n"
                + "ON st.StaffID = dt.StaffID\n"
                + "JOIN [dbo].[Patient] pt\n"
                + "ON pt.PatientID = a.PatientID\n"
                + "WHERE p.Hidden = 0\n"
                + "AND (st.FirstName LIKE ? OR st.LastName LIKE ?\n"
                + "	OR pt.FirstName LIKE ? OR pt.LastName LIKE ?)\n"
                + "ORDER BY DateCreate DESC;";
        Object[] params = {'%' + searchQuery + '%', '%' + searchQuery + '%', '%' + searchQuery + '%', '%' + searchQuery + '%'};
        List<PrescriptionDTO> prescriptionList = new ArrayList<>();
        ResultSet rs = null;

        try {

            rs = executeSelectQuery(query, params);
            while (rs.next()) {

                StaffDTO staff = new StaffDTO();
                staff.setFirstName(rs.getString("DoctorFirstName"));
                staff.setLastName(rs.getString("DoctorFirstName"));

                PatientDTO patient = new PatientDTO();
                patient.setFirstName(rs.getString("PatientFirstName"));
                patient.setLastName(rs.getString("PatientLastName"));

                DoctorDTO doctor = new DoctorDTO();
                doctor.setStaffID(staff);

                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setDoctorID(doctor);
                appointment.setPatientID(patient);

                PrescriptionDTO prescription = new PrescriptionDTO();
                prescription.setPrescriptionID(rs.getInt("PrescriptionID"));
                prescription.setPrescriptionStatus(rs.getString("PrescriptionStatus"));
                prescription.setDateCreate(rs.getObject("DateCreate", Timestamp.class));
                prescription.setAppointmentID(appointment);

                prescriptionList.add(prescription);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PrescriptionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return prescriptionList;
    }

    public PrescriptionDTO getPrescriptionById(int prescriptionID) {

        String query = "SELECT p.PrescriptionID, p.PrescriptionStatus, p.DateCreate, st.FirstName as DoctorFirstName, st.LastName as DoctorLastName, pt.FirstName as PatientFirstName, pt.LastName as PatientLastName, p.Note AS PrescriptionNote\n"
                + "FROM [dbo].[Prescription] p\n"
                + "JOIN [dbo].[Appointment] a\n"
                + "ON a.AppointmentID = p.AppointmentID\n"
                + "JOIN [dbo].[Doctor] dt\n"
                + "ON dt.DoctorID = a.DoctorID\n"
                + "JOIN [dbo].[Staff] st\n"
                + "ON st.StaffID = dt.StaffID\n"
                + "JOIN [dbo].[Patient] pt\n"
                + "ON pt.PatientID = a.PatientID\n"
                + "WHERE p.Hidden = 0\n"
                + "AND p.PrescriptionID = ?\n"
                + "ORDER BY DateCreate DESC;";
        Object[] params = {prescriptionID};
        PrescriptionDTO prescription = null;
        ResultSet rs = null;

        try {

            rs = executeSelectQuery(query, params);
            if (rs.next()) {

                StaffDTO staff = new StaffDTO();
                staff.setFirstName(rs.getString("DoctorFirstName"));
                staff.setLastName(rs.getString("DoctorFirstName"));

                PatientDTO patient = new PatientDTO();
                patient.setFirstName(rs.getString("PatientFirstName"));
                patient.setLastName(rs.getString("PatientLastName"));

                DoctorDTO doctor = new DoctorDTO();
                doctor.setStaffID(staff);

                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setDoctorID(doctor);
                appointment.setPatientID(patient);

                prescription = new PrescriptionDTO();
                prescription.setPrescriptionID(rs.getInt("PrescriptionID"));
                prescription.setPrescriptionStatus(rs.getString("PrescriptionStatus"));
                prescription.setDateCreate(rs.getObject("DateCreate", Timestamp.class));
                prescription.setAppointmentID(appointment);
                prescription.setNote(rs.getString("PrescriptionNote"));
                prescription.setPrescriptionItemList(getAllPrescriptionItemByPrescriptionID(prescriptionID));
            }

        } catch (SQLException ex) {
            Logger.getLogger(PrescriptionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return prescription;
    }

    public List<PrescriptionItemDTO> getAllPrescriptionItemByPrescriptionID(int prescriptionID) {

        String query = "SELECT m.MedicineName, m.MedicineCode, m.MedicineType, m.Price, pti.Dosage, pti.Instruction\n"
                + "FROM [dbo].[Prescription] p\n"
                + "JOIN [dbo].[PrescriptionItem] pti\n"
                + "ON pti.PrescriptionID = p.PrescriptionID\n"
                + "JOIN [dbo].[Medicine] m\n"
                + "ON m.MedicineID = pti.MedicineID\n"
                + "WHERE p.Hidden = 0\n"
                + "AND p.PrescriptionID = ?;";
        Object[] params = {prescriptionID};
        List<PrescriptionItemDTO> prescriptionItemList = new ArrayList<>();
        ResultSet rs = null;

        try {

            rs = executeSelectQuery(query, params);
            while (rs.next()) {
                MedicineDTO medicine = new MedicineDTO();
                medicine.setMedicineName(rs.getString("MedicineName"));
                medicine.setMedicineCode(rs.getString("MedicineCode"));
                medicine.setMedicineType(rs.getString("MedicineType"));
                medicine.setPrice(rs.getDouble("Price"));

                PrescriptionItemDTO prescriptionItem = new PrescriptionItemDTO();
                prescriptionItem.setMedicineID(medicine);
                prescriptionItem.setDosage(rs.getInt("Dosage"));
                prescriptionItem.setInstruction(rs.getString("Instruction"));

                prescriptionItemList.add(prescriptionItem);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PrescriptionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return prescriptionItemList;
    }

    public boolean cancelPrescription(int prescriptionID) {

        String query = "UPDATE [dbo].[Prescription]\n"
                + "SET PrescriptionStatus = 'Canceled'\n"
                + "WHERE PrescriptionID = ?;";
        Object[] params = {prescriptionID};

        int rs = executeQuery(query, params);
        closeResources(null);

        return rs != 0;
    }

    public boolean deliverPrescription(int prescriptionID) {

        String query = "UPDATE [dbo].[Prescription]\n"
                + "SET PrescriptionStatus = 'Delivered'\n"
                + "WHERE PrescriptionID = ?;";
        Object[] params = {prescriptionID};

        int rs = executeQuery(query, params);
        closeResources(null);

        return rs != 0;
    }

    /**
     * Count total prescriptions by doctor
     */
    public int countPrescriptionsByDoctor(int doctorId) {
        String sql = "SELECT COUNT(*) AS Total FROM Prescription p "
                + "JOIN MedicalRecord m ON p.PrescriptionID = m.PrescriptionID "
                + "JOIN Appointment a ON a.AppointmentID = m.AppointmentID "
                + "WHERE a.DoctorID = ?";
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }
        return 0;
    }

}
