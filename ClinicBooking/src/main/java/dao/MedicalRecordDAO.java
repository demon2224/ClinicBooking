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
import model.AppointmentDTO;
import model.MedicalRecordDTO;
import model.PatientDTO;
import model.PrescriptionDTO;
import utils.DBContext;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class MedicalRecordDAO extends DBContext {

    /**
     * Check Medical record of one appointment exist or not
     *
     * @param appointmentID
     * @return
     */
    public boolean isExistMedicalRecord(int appointmentID) {
        String sql = "Select m.MedicalRecordID\n"
                + "from MedicalRecord m\n"
                + "JOIN Appointment a on a.AppointmentID = m.AppointmentID\n"
                + "Where a.AppointmentID = ?";
        Object[] params = {appointmentID};
        ResultSet rs = executeSelectQuery(sql, params);
        boolean isExistMedicalRecord = false;
        try {
            isExistMedicalRecord = rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(MedicalRecordDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return isExistMedicalRecord;
    }

    /**
     * Get patient medical record list by doctorID
     *
     * @param doctorID
     * @return
     */
    public List<MedicalRecordDTO> getPatientMedicalRecordListByDoctorID(int doctorID) {
        List<MedicalRecordDTO> medicalRecords = new ArrayList<>();
        String sql = "Select p.FirstName,\n"
                + "p.LastName,\n"
                + "m.MedicalRecordID,\n"
                + "m.Symptoms,\n"
                + "m.Diagnosis,\n"
                + "m.Note,\n"
                + "m.DateCreate\n"
                + "From MedicalRecord m\n"
                + "Join Appointment a on a.AppointmentID = m.AppointmentID\n"
                + "Join Patient p on p.PatientID = a.PatientID\n"
                + "Where a.DoctorID = ?\n"
                + "order by DateCreate desc";
        Object[] params = {doctorID};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    // Patient
                    PatientDTO patient = new PatientDTO();
                    patient.setFirstName(rs.getString("FirstName"));
                    patient.setLastName(rs.getString("LastName"));
                    AppointmentDTO appointment = new AppointmentDTO();
                    appointment.setPatientID(patient);
                    // Medical Record
                    MedicalRecordDTO medicalRecord = new MedicalRecordDTO();
                    medicalRecord.setMedicalRecordID(rs.getInt("MedicalRecordID"));
                    medicalRecord.setAppointmentID(appointment);
                    medicalRecord.setSymptoms(rs.getString("Symptoms"));
                    medicalRecord.setDiagnosis(rs.getString("Diagnosis"));
                    medicalRecord.setNote(rs.getString("Note"));
                    medicalRecord.setDateCreate(rs.getTimestamp("DateCreate"));
                    // Add medical record into list.
                    medicalRecords.add(medicalRecord);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return medicalRecords;
    }

    /**
     * Get patient medical record list by doctorID
     *
     * @param doctorID
     * @return
     */
    public List<MedicalRecordDTO> searchPatientMedicalRecordListByPatientName(int doctorID, String keyword) {
        List<MedicalRecordDTO> medicalRecords = new ArrayList<>();
        String sql = "Select p.FirstName,\n"
                + "p.LastName,\n"
                + "m.MedicalRecordID,\n"
                + "m.Symptoms,\n"
                + "m.Diagnosis,\n"
                + "m.Note,\n"
                + "m.DateCreate\n"
                + "From MedicalRecord m\n"
                + "Join Appointment a on a.AppointmentID = m.AppointmentID\n"
                + "Join Patient p on p.PatientID = a.PatientID\n"
                + "Where a.DoctorID = ?\n"
                + "And (p.FirstName LIKE ? OR p.LastName LIKE ?)"
                + "order by DateCreate desc";
        Object[] params = {doctorID,
            "%" + keyword + "%",
            "%" + keyword + "%"};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    // Patient
                    PatientDTO patient = new PatientDTO();
                    patient.setFirstName(rs.getString("FirstName"));
                    patient.setLastName(rs.getString("LastName"));
                    AppointmentDTO appointment = new AppointmentDTO();
                    appointment.setPatientID(patient);
                    // Medical Record
                    MedicalRecordDTO medicalRecord = new MedicalRecordDTO();
                    medicalRecord.setMedicalRecordID(rs.getInt("MedicalRecordID"));
                    medicalRecord.setAppointmentID(appointment);
                    medicalRecord.setSymptoms(rs.getString("Symptoms"));
                    medicalRecord.setDiagnosis(rs.getString("Diagnosis"));
                    medicalRecord.setNote(rs.getString("Note"));
                    medicalRecord.setDateCreate(rs.getTimestamp("DateCreate"));
                    // Add medical record into list.
                    medicalRecords.add(medicalRecord);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return medicalRecords;
    }

    /**
     * Retrieves detailed information of a patient's medical record for a
     * specific doctor and medical record.
     *
     * @param doctorID
     * @param medicalRecordID
     * @return
     */
    public MedicalRecordDTO getPatientMedicalRecordDetailByDoctorIDAndMedicalRecordID(int doctorID, int medicalRecordID) {
        MedicalRecordDTO medicalRecordDetail = null;
        String sql = "Select m.MedicalRecordID,\n"
                + "m.Symptoms,\n"
                + "m.Diagnosis,\n"
                + "m.Note as MedicalRecordNote,\n"
                + "m.DateCreate as MedicalRecordDateCreate,\n"
                + "a.AppointmentID,\n"
                + "a.AppointmentStatus,\n"
                + "a.DateBegin as AppointmentDateBegin,\n"
                + "a.DateEnd as AppointmentDateEnd,\n"
                + "a.Note as AppointmentNote,\n"
                + "pa.FirstName,\n"
                + "pa.LastName,\n"
                + "pa.DOB,\n"
                + "pa.Gender,\n"
                + "pa.UserAddress,\n"
                + "pa.Email,\n"
                + "p.PrescriptionID,\n"
                + "p.PrescriptionStatus,\n"
                + "p.DateCreate as PrescriptionDateCreate,\n"
                + "p.Note as PrescriptionNote,\n"
                + "p.Hidden as PrescriptionHidden\n"
                + "From MedicalRecord m\n"
                + "Join Appointment a on a.AppointmentID = m.AppointmentID\n"
                + "Join Prescription p on p.AppointmentID = a.AppointmentID\n"
                + "Join Patient pa on pa.PatientID = a.PatientID\n"
                + "Where a.DoctorID = ? and m.MedicalRecordID = ?";
        Object[] params = {doctorID, medicalRecordID};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    // Patient
                    PatientDTO patient = new PatientDTO();
                    patient.setFirstName(rs.getString("FirstName"));
                    patient.setLastName(rs.getString("LastName"));
                    patient.setDob(rs.getTimestamp("DOB"));
                    patient.setGender(rs.getBoolean("Gender"));
                    patient.setUserAddress(rs.getString("UserAddress"));
                    patient.setEmail(rs.getString("Email"));
                    // Appointment
                    AppointmentDTO appointment = new AppointmentDTO();
                    appointment.setAppointmentID(rs.getInt("AppointmentID"));
                    appointment.setPatientID(patient);
                    appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                    appointment.setDateBegin(rs.getTimestamp("AppointmentDateBegin"));
                    appointment.setDateEnd(rs.getTimestamp("AppointmentDateEnd"));
                    appointment.setNote(rs.getString("AppointmentNote"));
                    // Prescription
                    PrescriptionDTO prescription = new PrescriptionDTO();
                    prescription.setPrescriptionID(rs.getInt("PrescriptionID"));
                    prescription.setAppointmentID(appointment);
                    prescription.setPrescriptionStatus(rs.getString("PrescriptionStatus"));
                    prescription.setDateCreate(rs.getTimestamp("PrescriptionDateCreate"));
                    prescription.setNote(rs.getString("PrescriptionNote"));
                    prescription.setHidden(rs.getBoolean("PrescriptionHidden"));
                    // Medical Record
                    MedicalRecordDTO medicalRecord = new MedicalRecordDTO();
                    medicalRecord.setMedicalRecordID(rs.getInt("MedicalRecordID"));
                    medicalRecord.setAppointmentID(appointment);
                    medicalRecord.setPrescriptionDTO(prescription);
                    medicalRecord.setSymptoms(rs.getString("Symptoms"));
                    medicalRecord.setDiagnosis(rs.getString("Diagnosis"));
                    medicalRecord.setNote(rs.getString("MedicalRecordNote"));
                    medicalRecord.setDateCreate(rs.getTimestamp("MedicalRecordDateCreate"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return medicalRecordDetail;
    }

}
