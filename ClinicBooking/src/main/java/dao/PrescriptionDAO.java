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
import model.Prescription;
import utils.DBContext;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class PrescriptionDAO extends DBContext {

    public List<Prescription> getPatientPrescriptionByDoctorId(int doctorId) {
        List<Prescription> list = new ArrayList<>();
        String sql = "SELECT TOP 5\n"
                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
                + "    a.DateBegin AS AppointmentDate,\n"
                + "    pr.Note AS PrescriptionNote,\n"
                + "    ps.PrescriptionStatusName AS PrescriptionStatus,\n"
                + "    pr.DateCreate AS PrescriptionDate\n"
                + "FROM Prescription pr\n"
                + "INNER JOIN Appointment a ON pr.AppointmentID = a.AppointmentID\n"
                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
                + "INNER JOIN PrescriptionStatus ps ON pr.PrescriptionStatusID = ps.PrescriptionStatusID\n"
                + "WHERE a.DoctorID = ?\n"
                + "ORDER BY pr.DateCreate DESC;";
        try {
            Object[] params = {doctorId};
            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null) {
                while (rs.next()) {
                    Prescription prescription = new Prescription(rs.getString("PatientName"), rs.getTimestamp("AppointmentDate"), rs.getString("PrescriptionNote"), rs.getString("PrescriptionStatus"), rs.getTimestamp("PrescriptionDate"));
                    list.add(prescription);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

}
