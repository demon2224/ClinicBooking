/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.MedicineDTO;
import model.PrescriptionDTO;
import model.PrescriptionItemDTO;

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

}
