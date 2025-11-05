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

//    public List<Prescription> getPatientPrescriptionByDoctorId(int doctorId) {
//        List<Prescription> list = new ArrayList<>();
//        String sql = "SELECT TOP 5\n"
//                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
//                + "    a.DateBegin AS AppointmentDate,\n"
//                + "    pr.Note AS PrescriptionNote,\n"
//                + "    ps.PrescriptionStatusName AS PrescriptionStatus,\n"
//                + "    pr.DateCreate AS PrescriptionDate\n"
//                + "FROM Prescription pr\n"
//                + "INNER JOIN Appointment a ON pr.AppointmentID = a.AppointmentID\n"
//                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
//                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
//                + "INNER JOIN PrescriptionStatus ps ON pr.PrescriptionStatusID = ps.PrescriptionStatusID\n"
//                + "WHERE a.DoctorID = ?\n"
//                + "ORDER BY pr.DateCreate DESC;";
//        try {
//            Object[] params = {doctorId};
//            ResultSet rs = executeSelectQuery(sql, params);
//            if (rs != null) {
//                while (rs.next()) {
//                    Prescription prescription = new Prescription(rs.getString("PatientName"), rs.getTimestamp("AppointmentDate"), rs.getString("PrescriptionNote"), rs.getString("PrescriptionStatus"), rs.getTimestamp("PrescriptionDate"));
//                    list.add(prescription);
//                }
//                closeResources(rs);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return list;
//    }
//
//    public List<Prescription> getPrescriptionByDoctorIdAndMedicalRecordID(int medicalRecordID, int doctorId) {
//        List<Prescription> list = new ArrayList<>();
//        String sql = "SELECT \n"
//                + "    mr.MedicalRecordID,\n"
//                + "    mi.MedicineName,\n"
//                + "    mt.MedicineTypeName,\n"
//                + "    pi.Dosage,\n"
//                + "    pi.Instruction,\n"
//                + "    mi.Price\n"
//                + "FROM PrescriptionItem pi\n"
//                + "INNER JOIN Medicine mi ON pi.MedicineID = mi.MedicineID\n"
//                + "INNER JOIN MedicineType mt ON mi.MedicineID = mt.MedicineTypeID\n"
//                + "INNER JOIN Prescription p on p.PrescriptionID = pi.PrescriptionID\n"
//                + "INNER JOIN Appointment a on a.AppointmentID = p.AppointmentID\n"
//                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
//                + "INNER JOIN [Profile] pr ON pr.UserProfileID = u.UserID\n"
//                + "INNER JOIN MedicalRecord mr on mr.AppointmentID = p.AppointmentID\n"
//                + "Where MedicalRecordID = ? and DoctorID = ?";
//        try {
//            Object[] params = {medicalRecordID, doctorId};
//            ResultSet rs = executeSelectQuery(sql, params);
//            if (rs != null) {
//                while (rs.next()) {
//                    Prescription prescription = new Prescription(rs.getString("MedicineName"));
//                    list.add(prescription);
//                }
//                closeResources(rs);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return list;
//    }
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
                prescriptionItem.setMedicineIID(medicine);
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

}
