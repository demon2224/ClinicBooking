/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Invoice;
import utils.DBContext;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class InvoiceDAO extends DBContext  {
    

    public List<Invoice> getAllInvoices() {
    List<Invoice> list = new ArrayList<>();

    String sql = "SELECT "
            + "    i.InvoiceID, "
            + "    pf.FirstName + ' ' + pf.LastName AS PatientName, "
            + "    df.FirstName + ' ' + df.LastName AS DoctorName, "
            + "    s.SpecialtyName AS Specialty, "
            + "    cf.Fee, "
            + "    pt.PaymentTypeName AS PaymentMethod, "
            + "    CASE "
            + "        WHEN i.InvoiceStatus = 1 THEN 'Paid' "
            + "        ELSE 'Unpaid' "
            + "    END AS Status "
            + "FROM Invoice i "
            + "JOIN MedicalRecord mr ON i.MedicalRecordID = mr.MedicalRecordID "
            + "JOIN Appointment a ON mr.AppointmentID = a.AppointmentID "
            + "JOIN [User] uPatient ON a.UserID = uPatient.UserID "
            + "JOIN [Profile] pf ON pf.UserProfileID = uPatient.UserID "
            + "JOIN Doctor d ON a.DoctorID = d.DoctorID "
            + "JOIN [User] uDoctor ON d.DoctorID = uDoctor.UserID "
            + "JOIN [Profile] df ON df.UserProfileID = uDoctor.UserID "
            + "JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
            + "JOIN ConsultationFee cf ON i.ConsultationFeeID = cf.ConsultationFeeID "
            + "JOIN PaymentType pt ON i.PaymentTypeID = pt.PaymentTypeID "
            + "ORDER BY i.InvoiceID DESC";

    DBContext db = new DBContext();
    ResultSet rs = null;

    try {
        rs = db.executeSelectQuery(sql);
        while (rs != null && rs.next()) {
            Invoice inv = new Invoice(
                    rs.getInt("InvoiceID"),
                    rs.getString("PatientName"),
                    rs.getString("DoctorName"),
                    rs.getString("Specialty"),
                    rs.getDouble("Fee"),
                    rs.getString("PaymentMethod"),
                    rs.getString("Status")
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
}
