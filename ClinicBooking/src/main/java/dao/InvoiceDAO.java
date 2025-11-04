/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.InvoiceDTO;
import utils.DBContext;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class InvoiceDAO extends DBContext {

    public InvoiceDTO getInvoiceDetail(int invoiceId) {
        InvoiceDTO invoice = null;

        String sql = "SELECT "
                + " i.InvoiceID, "
                + " CONCAT(p.FirstName, ' ', p.LastName) AS PatientName, "
                + " CONCAT(ds.FirstName, ' ', ds.LastName) AS DoctorName, "
                + " s.SpecialtyName AS Specialty, "
                + " ISNULL(s.Price,0) AS ConsultationFee, "
                + " i.PaymentType AS PaymentType, "
                + " i.InvoiceStatus AS InvoiceStatus, "
                + " i.DateCreate, "
                + " i.DatePay, "
                + " pre.Note AS PrescriptionNote, "
                + " mr.Symptoms, "
                + " mr.Diagnosis, "
                + " mr.Note AS MedicalNote "
                + "FROM Invoice i "
                + "JOIN MedicalRecord mr ON i.MedicalRecordID = mr.MedicalRecordID "
                + "JOIN Appointment a ON mr.AppointmentID = a.AppointmentID "
                + "JOIN Patient p ON a.PatientID = p.PatientID "
                + "JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "JOIN Staff ds ON d.StaffID = ds.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "LEFT JOIN Prescription pre ON i.PrescriptionID = pre.PrescriptionID "
                + "WHERE i.InvoiceID = ?";

        try ( Connection conn = getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, invoiceId);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    invoice = new InvoiceDTO();
                    invoice.setInvoiceID(rs.getInt("InvoiceID"));
                    invoice.setPatientName(rs.getString("PatientName"));
                    invoice.setDoctorName(rs.getString("DoctorName"));
                    invoice.setSpecialty(rs.getString("Specialty"));
                    invoice.setFee(rs.getDouble("ConsultationFee"));
                    invoice.setPaymentType(rs.getString("PaymentType"));
                    invoice.setInvoiceStatus(rs.getString("InvoiceStatus"));
                    invoice.setDateCreate(rs.getTimestamp("DateCreate"));
                    invoice.setDatePay(rs.getTimestamp("DatePay"));
                    invoice.setPrescriptionNote(rs.getString("PrescriptionNote"));
                    invoice.setSymptoms(rs.getString("Symptoms"));
                    invoice.setDiagnosis(rs.getString("Diagnosis"));
                    invoice.setMedicalNote(rs.getString("MedicalNote"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return invoice;
    }

    public List<InvoiceDTO> getAllInvoices() {
        List<InvoiceDTO> list = new ArrayList<>();
        String sql = "SELECT "
                + " i.InvoiceID, "
                + " p.FirstName + ' ' + p.LastName AS PatientName, "
                + " ds.FirstName + ' ' + ds.LastName AS DoctorName, "
                + " s.SpecialtyName AS Specialty, "
                + " i.PaymentType, "
                + " i.InvoiceStatus, "
                + " i.DateCreate, "
                + " i.DatePay, "
                + " ISNULL(s.Price, 0) + ISNULL(SUM(pi.Dosage * m.Price), 0) AS TotalAmount "
                + "FROM Invoice i "
                + "JOIN MedicalRecord mr ON i.MedicalRecordID = mr.MedicalRecordID "
                + "JOIN Appointment a ON mr.AppointmentID = a.AppointmentID "
                + "JOIN Patient p ON a.PatientID = p.PatientID "
                + "JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "JOIN Staff ds ON d.StaffID = ds.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "LEFT JOIN Prescription pre ON i.PrescriptionID = pre.PrescriptionID "
                + "LEFT JOIN PrescriptionItem pi ON pre.PrescriptionID = pi.PrescriptionID "
                + "LEFT JOIN Medicine m ON pi.MedicineID = m.MedicineID "
                + "GROUP BY "
                + " i.InvoiceID, "
                + " p.FirstName, p.LastName, "
                + " ds.FirstName, ds.LastName, "
                + " s.SpecialtyName, "
                + " i.PaymentType, "
                + " i.InvoiceStatus, "
                + " i.DateCreate, "
                + " i.DatePay, "
                + " s.Price "
                + "ORDER BY i.InvoiceID DESC";

        DBContext db = new DBContext();
        ResultSet rs = null;
        try {
            rs = db.executeSelectQuery(sql);
            while (rs != null && rs.next()) {
                InvoiceDTO inv = new InvoiceDTO(
                        rs.getInt("InvoiceID"),
                        rs.getString("PatientName"),
                        rs.getString("DoctorName"),
                        rs.getString("Specialty"),
                        rs.getString("PaymentType"),
                        rs.getString("InvoiceStatus"),
                        rs.getTimestamp("DateCreate"),
                        rs.getTimestamp("DatePay"),
                        rs.getDouble("TotalAmount")
                );
                list.add(inv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeResources(rs);
        }

        return list;
    }

    // UPDATE
    public boolean updateInvoice(int invoiceId) {
        String sql = "UPDATE Invoice SET InvoiceStatus = 'Paid', DatePay = GETDATE() WHERE InvoiceID = ?";
        Object[] params = {invoiceId};
        int rowsAffected = executeQuery(sql, params);
        return rowsAffected > 0;
    }

    // CANCEL
    public boolean cancelInvoice(int invoiceId) {
        String sql = "UPDATE Invoice SET InvoiceStatus = 'Canceled' WHERE InvoiceID = ?";
        Object[] params = {invoiceId};
        int rowsAffected = executeQuery(sql, params);
        return rowsAffected > 0;
    }

}
