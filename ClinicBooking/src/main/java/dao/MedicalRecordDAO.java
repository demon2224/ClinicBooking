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
import model.MedicalRecordDTO;
import model.AppointmentDTO;
import model.DoctorDTO;
import model.MedicineDTO;
import model.PatientDTO;
import model.PrescriptionDTO;
import model.PrescriptionItemDTO;
import model.SpecialtyDTO;
import model.StaffDTO;
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
        MedicalRecordDTO medicalRecordDetail = new MedicalRecordDTO();
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
                + "p.PatientID,\n"
                + "p.FirstName,\n"
                + "p.LastName,\n"
                + "p.DOB,\n"
                + "p.Gender,\n"
                + "p.UserAddress,\n"
                + "p.Email,\n"
                + "p.PhoneNumber\n"
                + "From MedicalRecord m\n"
                + "Join Appointment a on a.AppointmentID = m.AppointmentID\n"
                + "Join Patient p on p.PatientID = a.PatientID\n"
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
                    patient.setPhoneNumber(rs.getString("PhoneNumber"));
                    // Appointment
                    AppointmentDTO appointment = new AppointmentDTO();
                    appointment.setAppointmentID(rs.getInt("AppointmentID"));
                    appointment.setPatientID(patient);
                    appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                    appointment.setDateBegin(rs.getTimestamp("AppointmentDateBegin"));
                    appointment.setDateEnd(rs.getTimestamp("AppointmentDateEnd"));
                    appointment.setNote(rs.getString("AppointmentNote"));
                    // Medical Record
                    medicalRecordDetail.setMedicalRecordID(rs.getInt("MedicalRecordID"));
                    medicalRecordDetail.setAppointmentID(appointment);
                    medicalRecordDetail.setSymptoms(rs.getString("Symptoms"));
                    medicalRecordDetail.setDiagnosis(rs.getString("Diagnosis"));
                    medicalRecordDetail.setNote(rs.getString("MedicalRecordNote"));
                    medicalRecordDetail.setDateCreate(rs.getTimestamp("MedicalRecordDateCreate"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return medicalRecordDetail;
    }

    /**
     * Get medical records by patient ID - following AppointmentDAO pattern
     */
    public List<MedicalRecordDTO> getMedicalRecordsByPatientId(int patientId) {
        List<MedicalRecordDTO> medicalRecords = new ArrayList<>();
        String sql = "SELECT mr.MedicalRecordID, mr.Symptoms, mr.Diagnosis, mr.Note, mr.DateCreate, "
                + "a.AppointmentID, a.DateBegin AS AppointmentDate, "
                + "s.StaffID, s.FirstName, s.LastName, s.PhoneNumber, s.Email, s.Avatar, s.Bio, s.JobStatus, "
                + "sp.SpecialtyID, sp.SpecialtyName, d.YearExperience, d.DoctorID, "
                + "p.PrescriptionID, p.Note AS PrescriptionNote "
                + "FROM MedicalRecord mr "
                + "JOIN Appointment a ON mr.AppointmentID = a.AppointmentID "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "LEFT JOIN Prescription p ON mr.PrescriptionID = p.PrescriptionID "
                + "WHERE a.PatientID = ? "
                + "ORDER BY mr.DateCreate DESC";

        ResultSet rs = null;
        try {
            Object[] params = {patientId};
            rs = executeSelectQuery(sql, params);

            while (rs.next()) {
                MedicalRecordDTO record = new MedicalRecordDTO();
                record.setMedicalRecordID(rs.getInt("MedicalRecordID"));
                record.setSymptoms(rs.getString("Symptoms"));
                record.setDiagnosis(rs.getString("Diagnosis"));
                record.setNote(rs.getString("Note"));
                record.setDateCreate(rs.getTimestamp("DateCreate"));

                // AppointmentDTO
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setDateBegin(rs.getTimestamp("AppointmentDate"));

                // DoctorDTO with StaffDTO and SpecialtyDTO
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setJobStatus(rs.getString("JobStatus"));
                doctor.setStaffID(staff);

                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                appointment.setDoctorID(doctor);
                record.setAppointmentID(appointment);

                // PrescriptionDTO if exists
                if (rs.getInt("PrescriptionID") > 0) {
                    PrescriptionDTO prescription = new PrescriptionDTO();
                    prescription.setPrescriptionID(rs.getInt("PrescriptionID"));
                    prescription.setNote(rs.getString("PrescriptionNote"));
                    record.setPrescriptionDTO(prescription);
                }

                medicalRecords.add(record);
            }
        } catch (SQLException e) {
            Logger.getLogger(MedicalRecordDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(rs);
        }

        return medicalRecords;
    }

    /**
     * Get medical record by ID - following AppointmentDAO pattern
     */
    public MedicalRecordDTO getMedicalRecordById(int medicalRecordId) {
        MedicalRecordDTO record = null;
        String sql = "SELECT mr.MedicalRecordID, mr.Symptoms, mr.Diagnosis, mr.Note, mr.DateCreate, "
                + "a.AppointmentID, a.DateBegin AS AppointmentDate, a.DateEnd AS AppointmentEndDate, a.PatientID, "
                + "s.StaffID, s.FirstName, s.LastName, s.PhoneNumber, s.Email, s.Avatar, s.Bio, s.JobStatus, "
                + "sp.SpecialtyID, sp.SpecialtyName, d.YearExperience, d.DoctorID, "
                + "p.PrescriptionID, p.Note AS PrescriptionNote "
                + "FROM MedicalRecord mr "
                + "JOIN Appointment a ON mr.AppointmentID = a.AppointmentID "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "LEFT JOIN Prescription p ON mr.PrescriptionID = p.PrescriptionID "
                + "WHERE mr.MedicalRecordID = ?";

        ResultSet rs = null;
        try {
            Object[] params = {medicalRecordId};
            rs = executeSelectQuery(sql, params);

            if (rs.next()) {
                record = new MedicalRecordDTO();
                record.setMedicalRecordID(rs.getInt("MedicalRecordID"));
                record.setSymptoms(rs.getString("Symptoms"));
                record.setDiagnosis(rs.getString("Diagnosis"));
                record.setNote(rs.getString("Note"));
                record.setDateCreate(rs.getTimestamp("DateCreate"));

                // AppointmentDTO
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setDateBegin(rs.getTimestamp("AppointmentDate"));
                appointment.setDateEnd(rs.getTimestamp("AppointmentEndDate"));

                // PatientDTO
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                appointment.setPatientID(patient);

                // DoctorDTO with StaffDTO and SpecialtyDTO
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setJobStatus(rs.getString("JobStatus"));
                doctor.setStaffID(staff);

                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                appointment.setDoctorID(doctor);
                record.setAppointmentID(appointment);

                // PrescriptionDTO if exists
                if (rs.getInt("PrescriptionID") > 0) {
                    PrescriptionDTO prescription = new PrescriptionDTO();
                    prescription.setPrescriptionID(rs.getInt("PrescriptionID"));
                    prescription.setNote(rs.getString("PrescriptionNote"));

                    // Load prescription items
                    List<PrescriptionItemDTO> prescriptionItems = getPrescriptionItemsByPrescriptionId(rs.getInt("PrescriptionID"));
                    prescription.setPrescriptionItemList(prescriptionItems);

                    record.setPrescriptionDTO(prescription);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(MedicalRecordDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(rs);
        }

        return record;
    }

    /**
     * Search medical records by patient ID and keyword - following
     * AppointmentDAO pattern
     */
    public List<MedicalRecordDTO> searchMedicalRecordsByPatientId(int patientId, String keyword) {
        List<MedicalRecordDTO> medicalRecords = new ArrayList<>();
        String sql = "SELECT mr.MedicalRecordID, mr.Symptoms, mr.Diagnosis, mr.Note, mr.DateCreate, "
                + "a.AppointmentID, a.DateBegin AS AppointmentDate, "
                + "s.StaffID, s.FirstName, s.LastName, s.PhoneNumber, s.Email, s.Avatar, s.Bio, s.JobStatus, "
                + "sp.SpecialtyID, sp.SpecialtyName, d.YearExperience, d.DoctorID, "
                + "p.PrescriptionID, p.Note AS PrescriptionNote "
                + "FROM MedicalRecord mr "
                + "JOIN Appointment a ON mr.AppointmentID = a.AppointmentID "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "LEFT JOIN Prescription p ON mr.PrescriptionID = p.PrescriptionID "
                + "WHERE a.PatientID = ? ";

        List<Object> paramsList = new ArrayList<>();
        paramsList.add(patientId);

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND (s.FirstName + ' ' + s.LastName LIKE ? OR mr.Symptoms LIKE ? OR mr.Diagnosis LIKE ? OR sp.SpecialtyName LIKE ?) ";
            String searchPattern = "%" + keyword.trim() + "%";
            paramsList.add(searchPattern);
            paramsList.add(searchPattern);
            paramsList.add(searchPattern);
            paramsList.add(searchPattern);
        }

        sql += "ORDER BY mr.DateCreate DESC";

        ResultSet rs = null;
        try {
            Object[] params = paramsList.toArray();
            rs = executeSelectQuery(sql, params);

            while (rs.next()) {
                MedicalRecordDTO record = new MedicalRecordDTO();
                record.setMedicalRecordID(rs.getInt("MedicalRecordID"));
                record.setSymptoms(rs.getString("Symptoms"));
                record.setDiagnosis(rs.getString("Diagnosis"));
                record.setNote(rs.getString("Note"));
                record.setDateCreate(rs.getTimestamp("DateCreate"));

                // AppointmentDTO
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setDateBegin(rs.getTimestamp("AppointmentDate"));

                // DoctorDTO with StaffDTO and SpecialtyDTO
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setJobStatus(rs.getString("JobStatus"));
                doctor.setStaffID(staff);

                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                appointment.setDoctorID(doctor);
                record.setAppointmentID(appointment);

                // PrescriptionDTO if exists
                if (rs.getInt("PrescriptionID") > 0) {
                    PrescriptionDTO prescription = new PrescriptionDTO();
                    prescription.setPrescriptionID(rs.getInt("PrescriptionID"));
                    prescription.setNote(rs.getString("PrescriptionNote"));
                    record.setPrescriptionDTO(prescription);
                }

                medicalRecords.add(record);
            }
        } catch (SQLException e) {
            Logger.getLogger(MedicalRecordDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(rs);
        }

        return medicalRecords;
    }

    /**
     * Get prescription items by prescription ID
     */
    public List<PrescriptionItemDTO> getPrescriptionItemsByPrescriptionId(int prescriptionId) {
        List<PrescriptionItemDTO> items = new ArrayList<>();
        String sql = "SELECT pi.Dosage, pi.Instruction, "
                + "m.MedicineID, m.MedicineName, m.MedicineCode, m.MedicineType, "
                + "m.MedicineStatus, m.Quantity, m.Price, m.DateCreate, m.Hidden "
                + "FROM PrescriptionItem pi "
                + "JOIN Medicine m ON pi.MedicineID = m.MedicineID "
                + "WHERE pi.PrescriptionID = ? AND m.Hidden = 0";

        ResultSet rs = null;
        try {
            Object[] params = {prescriptionId};
            rs = executeSelectQuery(sql, params);

            while (rs.next()) {
                // Create MedicineDTO
                MedicineDTO medicine = new MedicineDTO();
                medicine.setMedicineID(rs.getInt("MedicineID"));
                medicine.setMedicineName(rs.getString("MedicineName"));
                medicine.setMedicineCode(rs.getString("MedicineCode"));
                medicine.setMedicineType(rs.getString("MedicineType"));
                medicine.setMedicineStatus(rs.getBoolean("MedicineStatus"));
                medicine.setQuantity(rs.getInt("Quantity"));
                medicine.setPrice(rs.getDouble("Price"));
                medicine.setDateCreate(rs.getTimestamp("DateCreate"));
                medicine.setIsHidden(rs.getBoolean("Hidden"));

                // Create PrescriptionItemDTO
                PrescriptionItemDTO item = new PrescriptionItemDTO(null, medicine, rs.getInt("Dosage"), rs.getString("Instruction"));
                items.add(item);
            }
        } catch (SQLException e) {
            Logger.getLogger(MedicalRecordDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(rs);
        }

        return items;

    }
}
