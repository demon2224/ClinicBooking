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
import model.MedicalRecord;
import utils.DBContext;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class MedicalRecordDAO extends DBContext {

    public List<MedicalRecord> getPatientMedicalRecordByDoctorId(int doctorId) {
        List<MedicalRecord> list = new ArrayList<>();
        String sql = "SELECT TOP 5\n"
                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
                + "    a.DateBegin AS AppointmentDate,\n"
                + "    mr.Diagnosis,\n"
                + "    ps.PrescriptionStatusName AS PrescriptionStatus,\n"
                + "    mr.DateCreate AS RecordCreatedDate\n"
                + "FROM MedicalRecord mr\n"
                + "INNER JOIN Appointment a ON mr.AppointmentID = a.AppointmentID\n"
                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
                + "LEFT JOIN Prescription pr ON mr.PrescriptionID = pr.PrescriptionID\n"
                + "LEFT JOIN PrescriptionStatus ps ON pr.PrescriptionStatusID = ps.PrescriptionStatusID\n"
                + "WHERE a.DoctorID = ?\n"
                + "ORDER BY mr.DateCreate DESC;";
        try {
            Object[] params = {doctorId};
            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null) {
                while (rs.next()) {
                    MedicalRecord medicalRecord = new MedicalRecord(rs.getString("Diagnosis"), rs.getString("PatientName"), rs.getTimestamp("AppointmentDate"), rs.getString("PrescriptionStatus"), rs.getTimestamp("RecordCreatedDate"));
                    list.add(medicalRecord);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

}
