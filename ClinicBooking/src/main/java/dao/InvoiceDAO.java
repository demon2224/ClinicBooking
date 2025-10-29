///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package dao;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//import model.Invoice;
//import utils.DBContext;
//
///**
// *
// * @author Ngo Quoc Hung - CE191184
// */
//public class InvoiceDAO extends DBContext {
//
//    public Invoice getInvoiceDetail(int invoiceId) {
//        Invoice invoice = null;
//
//        String sql = "SELECT "
//                + " i.InvoiceID, "
//                + " pf.FirstName + ' ' + pf.LastName AS PatientName, "
//                + " df.FirstName + ' ' + df.LastName AS DoctorName, "
//                + " s.SpecialtyName AS Specialty, "
//                + " cf.Fee AS ConsultationFee, "
//                + " pt.PaymentTypeName AS PaymentMethod, "
//                + " ist.InvoiceStatusName AS InvoiceStatus, "
//                + " i.DateCreate, "
//                + " i.DatePay, "
//                + " pre.PrescriptionID, "
//                + " pre.Note AS PrescriptionNote, "
//                + " mr.Symptoms, "
//                + " mr.Diagnosis, "
//                + " mr.Note AS MedicalNote "
//                + "FROM Invoice i "
//                + " JOIN InvoiceStatus ist ON i.InvoiceStatusID = ist.InvoiceStatusID "
//                + " JOIN MedicalRecord mr ON i.MedicalRecordID = mr.MedicalRecordID "
//                + " JOIN Appointment a ON mr.AppointmentID = a.AppointmentID "
//                + " JOIN [User] uPatient ON a.UserID = uPatient.UserID "
//                + " JOIN [Profile] pf ON pf.UserProfileID = uPatient.UserID "
//                + " JOIN Doctor d ON a.DoctorID = d.DoctorID "
//                + " JOIN [User] uDoctor ON d.DoctorID = uDoctor.UserID "
//                + " JOIN [Profile] df ON df.UserProfileID = uDoctor.UserID "
//                + " JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
//                + " JOIN ConsultationFee cf ON i.ConsultationFeeID = cf.ConsultationFeeID "
//                + " JOIN PaymentType pt ON i.PaymentTypeID = pt.PaymentTypeID "
//                + " LEFT JOIN Prescription pre ON i.PrescriptionID = pre.PrescriptionID "
//                + "WHERE i.InvoiceID = ?";
//        try ( Connection conn = getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
//
//            ps.setInt(1, invoiceId);
//
//            try ( ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    invoice = new Invoice();
//
//                    // Gán dữ liệu từ ResultSet vào đối tượng Invoice
//                    invoice.setInvoiceId(rs.getInt("InvoiceID"));
//                    invoice.setPatientName(rs.getString("PatientName"));
//                    invoice.setDoctorName(rs.getString("DoctorName"));
//                    invoice.setSpecialty(rs.getString("Specialty"));
//                    invoice.setFee(rs.getDouble("ConsultationFee"));
//                    invoice.setPaymentMethod(rs.getString("PaymentMethod"));
//                    invoice.setStatus(rs.getString("InvoiceStatus"));
//                    invoice.setDateCreate(rs.getTimestamp("DateCreate"));
//                    invoice.setDatePay(rs.getTimestamp("DatePay"));
//                    invoice.setPrescriptionID(rs.getInt("PrescriptionID"));
//                    invoice.setPrescriptionNote(rs.getString("PrescriptionNote"));
//                    invoice.setSymptoms(rs.getString("Symptoms"));
//                    invoice.setDiagnosis(rs.getString("Diagnosis"));
//                    invoice.setMedicalNote(rs.getString("MedicalNote"));
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return invoice;
//    }
//
//    public List<Invoice> getAllInvoices() {
//        List<Invoice> list = new ArrayList<>();
//
//        String sql = "SELECT "
//                + "    i.InvoiceID, "
//                + "    pf.FirstName + ' ' + pf.LastName AS PatientName, "
//                + "    df.FirstName + ' ' + df.LastName AS DoctorName, "
//                + "    s.SpecialtyName AS Specialty, "
//                + "    cf.Fee, "
//                + "    pt.PaymentTypeName AS PaymentMethod, "
//                + "    ist.InvoiceStatusName AS Status "
//                + "FROM Invoice i "
//                + "JOIN InvoiceStatus ist ON i.InvoiceStatusID = ist.InvoiceStatusID "
//                + "JOIN MedicalRecord mr ON i.MedicalRecordID = mr.MedicalRecordID "
//                + "JOIN Appointment a ON mr.AppointmentID = a.AppointmentID "
//                + "JOIN [User] uPatient ON a.UserID = uPatient.UserID "
//                + "JOIN [Profile] pf ON pf.UserProfileID = uPatient.UserID "
//                + "JOIN Doctor d ON a.DoctorID = d.DoctorID "
//                + "JOIN [User] uDoctor ON d.DoctorID = uDoctor.UserID "
//                + "JOIN [Profile] df ON df.UserProfileID = uDoctor.UserID "
//                + "JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
//                + "JOIN ConsultationFee cf ON i.ConsultationFeeID = cf.ConsultationFeeID "
//                + "JOIN PaymentType pt ON i.PaymentTypeID = pt.PaymentTypeID "
//                + "ORDER BY i.InvoiceID DESC";
//
//        DBContext db = new DBContext();
//        ResultSet rs = null;
//
//        try {
//            rs = db.executeSelectQuery(sql);
//            while (rs != null && rs.next()) {
//                Invoice inv = new Invoice(
//                        rs.getInt("InvoiceID"),
//                        rs.getString("PatientName"),
//                        rs.getString("DoctorName"),
//                        rs.getString("Specialty"),
//                        rs.getDouble("Fee"),
//                        rs.getString("PaymentMethod"),
//                        rs.getString("Status")
//                );
//                list.add(inv);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            db.closeResources(rs);
//        }
//
//        return list;
//    }
//
//    public boolean updateInvoice(int invoiceId) {
//        String sql = "UPDATE Invoice SET InvoiceStatusID = 2 WHERE InvoiceID = ?";
//        Object[] params = {invoiceId};
//
//        int rowsAffected = executeQuery(sql, params);
//
//        return rowsAffected > 0;
//    }
//
//        public boolean cancelInvoice(int invoiceId) {
//        String sql = "UPDATE Invoice SET InvoiceStatusID = 3 WHERE InvoiceID = ?";
//        Object[] params = {invoiceId};
//
//        int rowsAffected = executeQuery(sql, params);
//
//        return rowsAffected > 0;
//    }
//
//}
