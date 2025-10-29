///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package dao;
//
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//import model.MedicalRecord;
//import utils.DBContext;
//
///**
// *
// * @author Le Thien Tri - CE191249
// */
//public class MedicalRecordDAO extends DBContext {
//
//    public List<MedicalRecord> getPatientMedicalRecordByDoctorId(int doctorId) {
//        List<MedicalRecord> list = new ArrayList<>();
//        String sql = "				SELECT   mr.MedicalRecordID,\n"
//                + "                p.FirstName + ' ' + p.LastName AS PatientName,\n"
//                + "                    a.DateBegin AS AppointmentDate,\n"
//                + "                    mr.Diagnosis,\n"
//                + "                    ast.AppointmentStatusName,\n"
//                + "                    ps.PrescriptionStatusName AS PrescriptionStatus,\n"
//                + "                    mr.DateCreate AS RecordCreatedDate\n"
//                + "                FROM MedicalRecord mr\n"
//                + "                INNER JOIN Appointment a ON mr.AppointmentID = a.AppointmentID\n"
//                + "                INNER JOIN AppointmentStatus ast on a.AppointmentStatusID = ast.AppointmentStatusID\n"
//                + "                INNER JOIN [User] u ON a.UserID = u.UserID\n"
//                + "                INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
//                + "                LEFT JOIN Prescription pr ON mr.PrescriptionID = pr.PrescriptionID\n"
//                + "                LEFT JOIN PrescriptionStatus ps ON pr.PrescriptionStatusID = ps.PrescriptionStatusID\n"
//                + "                WHERE a.DoctorID = ? and ast.AppointmentStatusName = 'completed'\n"
//                + "                ORDER BY mr.DateCreate DESC";
//        try {
//            Object[] params = {doctorId};
//            ResultSet rs = executeSelectQuery(sql, params);
//            if (rs != null) {
//                while (rs.next()) {
//                    MedicalRecord medicalRecord = new MedicalRecord(rs.getString("Diagnosis"),
//                            rs.getString("PatientName"),
//                            rs.getTimestamp("AppointmentDate"),
//                            rs.getString("AppointmentStatusName"),
//                            rs.getTimestamp("RecordCreatedDate"),
//                            rs.getInt("MedicalRecordID"));
//                    list.add(medicalRecord);
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
//    public List<MedicalRecord> searchMedicalRecordByPatientName(int doctorId, String keyword) {
//        List<MedicalRecord> list = new ArrayList<>();
//
//        String sql = "SELECT MedicalRecordID, \n"
//                + "  p.FirstName + ' ' + p.LastName AS PatientName,\n"
//                + "    a.DateBegin AS AppointmentDate,\n"
//                + "    mr.Diagnosis,\n"
//                + "    ast.AppointmentStatusName,\n"
//                + "    ps.PrescriptionStatusName AS PrescriptionStatus,\n"
//                + "    mr.DateCreate AS RecordCreatedDate\n"
//                + "FROM MedicalRecord mr\n"
//                + "INNER JOIN Appointment a ON mr.AppointmentID = a.AppointmentID\n"
//                + "INNER JOIN AppointmentStatus ast on a.AppointmentStatusID = ast.AppointmentStatusID\n"
//                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
//                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
//                + "LEFT JOIN Prescription pr ON mr.PrescriptionID = pr.PrescriptionID\n"
//                + "LEFT JOIN PrescriptionStatus ps ON pr.PrescriptionStatusID = ps.PrescriptionStatusID\n"
//                + "WHERE a.DoctorID = ? AND ast.AppointmentStatusName = 'completed'\n";
//
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            sql += "AND (p.FirstName + ' ' + p.LastName LIKE ?) ";
//        }
//
//        sql += "ORDER BY mr.DateCreate DESC;";
//
//        try {
//            List<Object> paramsList = new ArrayList<>();
//            paramsList.add(doctorId);
//
//            if (keyword != null && !keyword.trim().isEmpty()) {
//                paramsList.add("%" + keyword.trim() + "%");
//            }
//            Object[] params = paramsList.toArray();
//
//            ResultSet rs = executeSelectQuery(sql, params);
//            if (rs != null) {
//                while (rs.next()) {
//                    MedicalRecord medicalRecord = new MedicalRecord(rs.getString("Diagnosis"),
//                            rs.getString("PatientName"),
//                            rs.getTimestamp("AppointmentDate"),
//                            rs.getString("AppointmentStatusName"),
//                            rs.getTimestamp("RecordCreatedDate"),
//                            rs.getInt("MedicalRecordID"));
//                    list.add(medicalRecord);
//                }
//                closeResources(rs);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return list;
//    }
//
//    public MedicalRecord getDetailMedicalRecordById(int medicalRecordID, int doctorId) {
//        MedicalRecord medicalRecord = null;
//
//        String sql = "SELECT \n"
//                + "    a.AppointmentID,\n"
//                + "    a.DateBegin,\n"
//                + "    a.DateEnd,\n"
//                + "    ast.AppointmentStatusName AS AppointmentStatus,\n"
//                + "    a.Note AS AppointmentNote,\n"
//                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
//                + "    p.Email AS PatientEmail,\n"
//                + "    p.PhoneNumber AS PatientPhone,\n"
//                + "    CASE WHEN p.Gender = 1 THEN 'Male' ELSE 'Female' END AS PatientGender,\n"
//                + "    p.DOB AS PatientDOB,\n"
//                + "    p.UserAddress AS PatientAddress,\n"
//                + "    mr.MedicalRecordID,\n"
//                + "    mr.Symptoms,\n"
//                + "    mr.Diagnosis,\n"
//                + "    mr.Note AS MedicalRecordNote,\n"
//                + "    mr.DateCreate AS RecordCreatedDate,\n"
//                + "    pr.PrescriptionID,\n"
//                + "    pr.Note AS PrescriptionNote,\n"
//                + "    ps.PrescriptionStatusName AS PrescriptionStatus,\n"
//                + "    inv.InvoiceID,\n"
//                + "	CASE WHEN inv.InvoiceStatus = 1 THEN 'Paid' ELSE 'Unpaid' END AS InvoiceStatus,\n"
//                + "    inv.DateCreate AS InvoiceCreatedDate,\n"
//                + "    inv.DatePay,\n"
//                + "    pt.PaymentTypeName,\n"
//                + "      cf.Fee + ISNULL(\n"
//                + "        (SELECT SUM(mi.Price)\n"
//                + "         FROM PrescriptionItem pi\n"
//                + "         INNER JOIN Medicine mi ON pi.MedicineID = mi.MedicineID\n"
//                + "         WHERE pi.PrescriptionID = pr.PrescriptionID), 0\n"
//                + "    ) AS TotalFee\n"
//                + "FROM MedicalRecord mr\n"
//                + "INNER JOIN Appointment a ON mr.AppointmentID = a.AppointmentID\n"
//                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
//                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
//                + "INNER JOIN AppointmentStatus ast ON ast.AppointmentStatusID = a.AppointmentStatusID\n"
//                + "LEFT JOIN Prescription pr ON mr.PrescriptionID = pr.PrescriptionID\n"
//                + "LEFT JOIN PrescriptionItem pi on pi.PrescriptionID = pr.PrescriptionID\n"
//                + "LEFT JOIN Medicine mi on mi.MedicineID = pi.MedicineID\n"
//                + "LEFT JOIN PrescriptionStatus ps ON pr.PrescriptionStatusID = ps.PrescriptionStatusID\n"
//                + "LEFT JOIN Invoice inv ON inv.MedicalRecordID = mr.MedicalRecordID\n"
//                + "LEFT JOIN ConsultationFee cf ON inv.ConsultationFeeID = cf.ConsultationFeeID\n"
//                + "LEFT JOIN PaymentType pt ON inv.PaymentTypeID = pt.PaymentTypeID\n"
//                + "WHERE mr.MedicalRecordID = ? AND a.DoctorID = ? AND ast.AppointmentStatusName = 'Completed';";
//
//        try {
//            Object[] params = {medicalRecordID, doctorId};
//            ResultSet rs = executeSelectQuery(sql, params);
//            if (rs != null && rs.next()) {
//                medicalRecord = new MedicalRecord(rs.getInt("MedicalRecordID"),
//                        rs.getInt("AppointmentID"),
//                        rs.getInt("PrescriptionID"),
//                        rs.getString("Symptoms"),
//                        rs.getString("Diagnosis"),
//                        rs.getString("MedicalRecordNote"),
//                        rs.getTimestamp("RecordCreatedDate"),
//                        rs.getString("PatientName"),
//                        rs.getString("PatientEmail"),
//                        rs.getString("PatientPhone"),
//                        rs.getString("PatientGender"),
//                        rs.getString("PatientAddress"),
//                        rs.getTimestamp("PatientDOB"),
//                        rs.getString("AppointmentStatus"),
//                        rs.getTimestamp("DateBegin"),
//                        rs.getTimestamp("DateEnd"),
//                        rs.getString("AppointmentNote"),
//                        rs.getString("PrescriptionStatus"),
//                        rs.getString("PrescriptionNote"),
//                        rs.getInt("InvoiceID"),
//                        rs.getTimestamp("DatePay"),
//                        rs.getString("InvoiceStatus"),
//                        rs.getString("PaymentTypeName"),
//                        rs.getTimestamp("InvoiceCreatedDate"),
//                        rs.getInt("TotalFee"));
//            }
//            closeResources(rs);
//        } catch (SQLException ex) {
//            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return medicalRecord;
//    }
//}
