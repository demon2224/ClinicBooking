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
import model.AppointmentDTO;
import model.DoctorDTO;
import model.InvoiceDTO;
import model.MedicalRecordDTO;
import model.PatientDTO;
import model.PrescriptionDTO;
import model.SpecialtyDTO;
import model.StaffDTO;
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
                + " p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, "
                + " p.DOB, p.Gender, p.UserAddress, p.PhoneNumber, p.Email, "
                + " ds.FirstName AS DoctorFirstName, ds.LastName AS DoctorLastName, "
                + " s.SpecialtyID, s.SpecialtyName, ISNULL(s.Price,0) AS ConsultationFee, "
                + " ISNULL(s.Price,0) + ISNULL(( "
                + "     SELECT SUM(pi.Dosage * m.Price) "
                + "     FROM PrescriptionItem pi "
                + "     JOIN Medicine m ON pi.MedicineID = m.MedicineID "
                + "     WHERE pi.PrescriptionID = pre.PrescriptionID "
                + " ),0) AS TotalFee, "
                + " i.PaymentType, i.InvoiceStatus, i.DateCreate, i.DatePay, "
                + " pre.Note AS PrescriptionNote, "
                + " mr.Symptoms, mr.Diagnosis, mr.Note AS MedicalNote "
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
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Patient
                PatientDTO patient = new PatientDTO(
                        rs.getString("PatientFirstName"),
                        rs.getString("PatientLastName"),
                        rs.getTimestamp("DOB"),
                        rs.getBoolean("Gender"),
                        rs.getString("UserAddress"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Email")
                );

                // Staff (Doctor)
                StaffDTO staff = new StaffDTO();
                staff.setFirstName(rs.getString("DoctorFirstName"));
                staff.setLastName(rs.getString("DoctorLastName"));

                // Specialty
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                specialty.setPrice(rs.getDouble("ConsultationFee"));

                // Doctor
                DoctorDTO doctor = new DoctorDTO();
                doctor.setStaffID(staff);
                doctor.setSpecialtyID(specialty);

                // Appointment
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setPatientID(patient);
                appointment.setDoctorID(doctor);

                // MedicalRecord
                MedicalRecordDTO medicalRecord = new MedicalRecordDTO();
                medicalRecord.setAppointmentID(appointment);
                medicalRecord.setSymptoms(rs.getString("Symptoms"));
                medicalRecord.setDiagnosis(rs.getString("Diagnosis"));
                medicalRecord.setNote(rs.getString("MedicalNote"));

                // Prescription
                PrescriptionDTO prescription = new PrescriptionDTO();
                prescription.setNote(rs.getString("PrescriptionNote"));

                // Invoice
                invoice = new InvoiceDTO();
                invoice.setInvoiceID(rs.getInt("InvoiceID"));
                invoice.setMedicalRecordID(medicalRecord);
                invoice.setSpecialtyID(specialty);
                invoice.setPaymentType(rs.getString("PaymentType"));
                invoice.setInvoiceStatus(rs.getString("InvoiceStatus"));
                invoice.setDateCreate(rs.getTimestamp("DateCreate"));
                invoice.setDatePay(rs.getTimestamp("DatePay"));
                invoice.setPrescriptionID(prescription);
                invoice.setTotalFee(rs.getDouble("TotalFee"));
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
                + " p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, "
                + " ds.FirstName AS DoctorFirstName, ds.LastName AS DoctorLastName, "
                + " s.SpecialtyID, s.SpecialtyName, s.Price AS ConsultationFee, "
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
                + " s.SpecialtyID, s.SpecialtyName, s.Price, "
                + " i.PaymentType, "
                + " i.InvoiceStatus, "
                + " i.DateCreate, "
                + " i.DatePay "
                + "ORDER BY i.InvoiceID DESC";

        try ( Connection conn = getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // Patient
                PatientDTO patient = new PatientDTO();
                patient.setFirstName(rs.getString("PatientFirstName"));
                patient.setLastName(rs.getString("PatientLastName"));

                // Staff (for doctor)
                StaffDTO staff = new StaffDTO();
                staff.setFirstName(rs.getString("DoctorFirstName"));
                staff.setLastName(rs.getString("DoctorLastName"));

                // Doctor 
                DoctorDTO doctor = new DoctorDTO();
                doctor.setStaffID(staff);

                // Appointment 
                AppointmentDTO appointment = new model.AppointmentDTO();
                appointment.setPatientID(patient);
                appointment.setDoctorID(doctor);

                // MedicalRecord 
                MedicalRecordDTO medicalRecord = new MedicalRecordDTO();
                medicalRecord.setAppointmentID(appointment);

                // Specialty
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                specialty.setPrice(rs.getDouble("TotalAmount"));

                // Invoice
                InvoiceDTO invoice = new InvoiceDTO();
                invoice.setInvoiceID(rs.getInt("InvoiceID"));
                invoice.setMedicalRecordID(medicalRecord);
                invoice.setSpecialtyID(specialty);
                invoice.setPaymentType(rs.getString("PaymentType"));
                invoice.setInvoiceStatus(rs.getString("InvoiceStatus"));
                invoice.setDateCreate(rs.getTimestamp("DateCreate"));
                invoice.setDatePay(rs.getTimestamp("DatePay"));

                list.add(invoice);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<InvoiceDTO> searchInvoices(String searchQuery) {
        List<InvoiceDTO> invoices = new ArrayList<>();

        String sql = "SELECT "
                + " i.InvoiceID, "
                + " p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, "
                + " ds.FirstName AS DoctorFirstName, ds.LastName AS DoctorLastName, "
                + " s.SpecialtyID, s.SpecialtyName, ISNULL(s.Price, 0) AS ConsultationFee, "
                + " i.PaymentType, i.InvoiceStatus, i.DateCreate, i.DatePay, "
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
                + "WHERE CONCAT(ds.FirstName, ' ', ds.LastName) LIKE ? "
                + "   OR CONCAT(p.FirstName, ' ', p.LastName) LIKE ? "
                + "   OR s.SpecialtyName LIKE ? "
                + "GROUP BY "
                + " i.InvoiceID, "
                + " p.FirstName, p.LastName, "
                + " ds.FirstName, ds.LastName, "
                + " s.SpecialtyID, s.SpecialtyName, s.Price, "
                + " i.PaymentType, i.InvoiceStatus, i.DateCreate, i.DatePay "
                + "ORDER BY i.InvoiceID DESC";

        String pattern = "%" + searchQuery.trim() + "%";

        try ( Connection conn = getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // --- Patient ---
                PatientDTO patient = new PatientDTO();
                patient.setFirstName(rs.getString("PatientFirstName"));
                patient.setLastName(rs.getString("PatientLastName"));

                // --- Staff (Doctor) ---
                StaffDTO staff = new StaffDTO();
                staff.setFirstName(rs.getString("DoctorFirstName"));
                staff.setLastName(rs.getString("DoctorLastName"));

                // --- Doctor ---
                DoctorDTO doctor = new DoctorDTO();
                doctor.setStaffID(staff);

                // --- Appointment ---
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setPatientID(patient);
                appointment.setDoctorID(doctor);

                // --- Medical Record ---
                MedicalRecordDTO medicalRecord = new MedicalRecordDTO();
                medicalRecord.setAppointmentID(appointment);

                // --- Specialty ---
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                specialty.setPrice(rs.getDouble("ConsultationFee"));

                // --- Invoice ---
                InvoiceDTO invoice = new InvoiceDTO();
                invoice.setInvoiceID(rs.getInt("InvoiceID"));
                invoice.setMedicalRecordID(medicalRecord);
                invoice.setSpecialtyID(specialty);
                invoice.setPaymentType(rs.getString("PaymentType"));
                invoice.setInvoiceStatus(rs.getString("InvoiceStatus"));
                invoice.setDateCreate(rs.getTimestamp("DateCreate"));
                invoice.setDatePay(rs.getTimestamp("DatePay"));
                invoice.setTotalFee(rs.getDouble("TotalAmount"));

                invoices.add(invoice);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return invoices;
    }

    // UPDATE 
    public boolean updateInvoice(int invoiceId, String newStatus, String newPaymentType) {
        String sql = "UPDATE Invoice "
                + "SET InvoiceStatus = ?, "
                + "    PaymentType = ?, "
                + "    DatePay = CASE WHEN ? = 'Paid' THEN GETDATE() ELSE DatePay END "
                + "WHERE InvoiceID = ?";

        try ( Connection conn = getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setString(2, newPaymentType);
            ps.setString(3, newStatus);
            ps.setInt(4, invoiceId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // CANCEL
    public boolean cancelInvoice(int invoiceId) {
        String sql = "UPDATE Invoice SET InvoiceStatus = 'Canceled' WHERE InvoiceID = ?";
        Object[] params = {invoiceId};
        int rowsAffected = executeQuery(sql, params);
        return rowsAffected > 0;
    }

}
