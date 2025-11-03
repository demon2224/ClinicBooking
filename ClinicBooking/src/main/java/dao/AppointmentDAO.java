///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
package dao;

import model.AppointmentDTO;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.PatientDTO;

/**
 * Appointment Data Access Object
 *
 * @author Le Anh Tuan - CE180905
 */
public class AppointmentDAO extends DBContext {

    /**
     * Get list patient appointments of doctor by doctor id
     *
     * @param doctorID
     * @return
     */
    public List<AppointmentDTO> getPatientAppointmentOfDoctorByID(int doctorID) {
        List<AppointmentDTO> appointments = new ArrayList<>();
        String sql = "SELECT a.AppointmentID,\n"
                + "	p.FirstName,\n"
                + "	p.LastName,\n"
                + "	p.Email,\n"
                + "	p.DOB,\n"
                + "	CASE WHEN p.Gender = 1 THEN 'Male' ELSE 'Female' END as Gender,\n"
                + "	p.UserAddress,\n"
                + "	p.PhoneNumber,\n"
                + "	a.DateBegin,\n"
                + "	a.Note,\n"
                + "	a.AppointmentStatus\n"
                + "FROM Appointment a\n"
                + "JOIN Doctor d on a.DoctorID = d.DoctorID\n"
                + "JOIN Staff s on s.StaffID = d.StaffID\n"
                + "JOIN Patient p on p.PatientID = a.PatientID\n"
                + "Where d.DoctorID = ?";
        Object[] params = {doctorID};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    PatientDTO patient = new PatientDTO(rs.getString("FirstName"),
                            rs.getString("LastName"),
                            rs.getTimestamp("DOB"),
                            rs.getBoolean("Gender"),
                            rs.getString("UserAddress"),
                            rs.getString("PhoneNumber"),
                            rs.getString("Email"));
                    AppointmentDTO appointment = new AppointmentDTO(rs.getInt("AppointmentID"),
                            patient, rs.getString("AppointmentStatus"),
                            rs.getTimestamp("DateBegin"),
                            null,
                            rs.getString("Note"));
                    appointments.add(appointment);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return appointments;
    }

    /**
     * Get Detail of Patient Appointment by Doctor Id and Appointment Id.
     *
     * @param appointmentID
     * @param doctorID
     * @return
     */
    public AppointmentDTO getPatientAppointmentDetailOfDoctorByID(int appointmentID, int doctorID) {
        AppointmentDTO appointment = null;
        String sql = "SELECT a.AppointmentID,\n"
                + "	p.FirstName,\n"
                + "	p.LastName,\n"
                + "	p.Email,\n"
                + "	p.DOB,\n"
                + "	CASE WHEN p.Gender = 1 THEN 'Male' ELSE 'Female' END as Gender,\n"
                + "	p.UserAddress,\n"
                + "	p.PhoneNumber,\n"
                + "	a.DateBegin,\n"
                + "     a.DateEnd,\n"
                + "	a.Note,\n"
                + "	a.AppointmentStatus\n"
                + "FROM Appointment a\n"
                + "JOIN Doctor d on a.DoctorID = d.DoctorID\n"
                + "JOIN Staff s on s.StaffID = d.StaffID\n"
                + "JOIN Patient p on p.PatientID = a.PatientID\n"
                + "Where d.DoctorID = ? AND a.AppointmentID = ?";
        Object[] params = {doctorID, appointmentID};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    PatientDTO patient = new PatientDTO(rs.getString("FirstName"),
                            rs.getString("LastName"),
                            rs.getTimestamp("DOB"),
                            rs.getBoolean("Gender"),
                            rs.getString("UserAddress"),
                            rs.getString("PhoneNumber"),
                            rs.getString("Email"));
                    appointment = new AppointmentDTO(rs.getInt("AppointmentID"),
                            patient, rs.getString("AppointmentStatus"),
                            rs.getTimestamp("DateBegin"),
                            rs.getTimestamp("DateEnd"),
                            rs.getString("Note"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return appointment;
    }

//    /**
//     * Get all appointments for a specific user
//     */
//    public List<AppointmentDTO> getAppointmentsByUserId(int userId) {
//       // List<Appointment> appointments = new ArrayList<>();
//        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
//                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
//                + "CONCAT(p.FirstName, ' ', p.LastName) as DoctorName, "
//                + "s.SpecialtyName, "
//                + "ast.AppointmentStatusName "
//                + "FROM Appointment a "
//                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
//                + "LEFT JOIN Profile p ON d.DoctorID = p.UserProfileID "
//                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
//                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
//                + "WHERE a.UserID = ? "
//                + "ORDER BY a.DateBegin DESC";
//        ResultSet rs = null;
//
//        try {
//            Object[] params = {userId};
//            rs = executeSelectQuery(sql, params);
//
//            while (rs.next()) {
////                Appointment appointment = new Appointment();
////                appointment.setAppointmentID(rs.getInt("AppointmentID"));
////                appointment.setUserID(rs.getInt("UserID"));
////                appointment.setDoctorID(rs.getInt("DoctorID"));
////                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
////                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
////                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
////                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
////                appointment.setNote(rs.getString("Note"));
////                appointment.setDoctorName(rs.getString("DoctorName"));
////                appointment.setStatusName(rs.getString("AppointmentStatusName"));
////                appointment.setSpecialtyName(rs.getString("SpecialtyName"));
////
////                appointments.add(appointment);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResources(rs);
//        }
//
//        //return appointments;
//    }
//
//    /**
//     * Get all appointments (for admin view)
//     */
//    public List<Appointment> getAllAppointments() {
//        List<Appointment> appointments = new ArrayList<>();
//        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
//                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
//                + "CONCAT(pd.FirstName, ' ', pd.LastName) as DoctorName, "
//                + "CONCAT(pp.FirstName, ' ', pp.LastName) as PatientName, "
//                + "s.SpecialtyName, "
//                + "ast.AppointmentStatusName "
//                + "FROM Appointment a "
//                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
//                + "LEFT JOIN Profile pd ON d.DoctorID = pd.UserProfileID "
//                + "LEFT JOIN Profile pp ON a.UserID = pp.UserProfileID "
//                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
//                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
//                + "ORDER BY a.DateBegin DESC";
//
//        ResultSet rs = null;
//
//        try {
//            rs = executeSelectQuery(sql);
//
//            while (rs.next()) {
//                Appointment appointment = new Appointment();
//                appointment.setAppointmentID(rs.getInt("AppointmentID"));
//                appointment.setUserID(rs.getInt("UserID"));
//                appointment.setDoctorID(rs.getInt("DoctorID"));
//                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
//                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
//                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
//                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
//                appointment.setNote(rs.getString("Note"));
//                appointment.setDoctorName(rs.getString("DoctorName"));
//                appointment.setStatusName(rs.getString("AppointmentStatusName"));
//                appointment.setPatientName(rs.getString("PatientName"));
//                appointment.setSpecialtyName(rs.getString("SpecialtyName"));
//
//                appointments.add(appointment);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResources(rs);
//        }
//
//        return appointments;
//    }
//
//    /**
//     * Get appointment by ID
//     */
//    public Appointment getAppointmentById(int appointmentId) {
//        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
//                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
//                + "CONCAT(p.FirstName, ' ', p.LastName) as DoctorName, "
//                + "s.SpecialtyName, "
//                + "ast.AppointmentStatusName "
//                + "FROM Appointment a "
//                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
//                + "LEFT JOIN Profile p ON d.DoctorID = p.UserProfileID "
//                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
//                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
//                + "WHERE a.AppointmentID = ?";
//
//        ResultSet rs = null;
//
//        try {
//            Object[] params = {appointmentId};
//            rs = executeSelectQuery(sql, params);
//            if (rs.next()) {
//                Appointment appointment = new Appointment();
//                appointment.setAppointmentID(rs.getInt("AppointmentID"));
//                appointment.setUserID(rs.getInt("UserID"));
//                appointment.setDoctorID(rs.getInt("DoctorID"));
//                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
//                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
//                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
//                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
//                appointment.setNote(rs.getString("Note"));
//                appointment.setDoctorName(rs.getString("DoctorName"));
//                appointment.setStatusName(rs.getString("AppointmentStatusName"));
//                appointment.setSpecialtyName(rs.getString("SpecialtyName"));
//
//                return appointment;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResources(rs);
//        }
//
//        return null;
//    }
//
//    /**
//     * Cancel appointment by setting status to Canceled (status ID = 4)
//     */
//    public boolean cancelMyAppointment(int appointmentId) {
//        String sql = "UPDATE Appointment SET AppointmentStatusID = 4 WHERE AppointmentID = ?";
//        Object[] params = {appointmentId};
//        int rowsAffected = executeQuery(sql, params);
//        closeResources(null);
//        return rowsAffected > 0;
//    }
//
//    /**
//     * Search appointments by user ID and doctor name
//     */
//    public List<Appointment> searchAppointmentsByUserId(int userId, String searchQuery) {
//        List<Appointment> appointments = new ArrayList<>();
//        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
//                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
//                + "CONCAT(p.FirstName, ' ', p.LastName) as DoctorName, "
//                + "s.SpecialtyName, "
//                + "ast.AppointmentStatusName "
//                + "FROM Appointment a "
//                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
//                + "LEFT JOIN Profile p ON d.DoctorID = p.UserProfileID "
//                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
//                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
//                + "WHERE a.UserID = ? "
//                + "AND CONCAT(p.FirstName, ' ', p.LastName) LIKE ? "
//                + "ORDER BY a.DateBegin DESC";
//        ResultSet rs = null;
//        try {
//            Object[] params = {userId, "%" + searchQuery + "%"};
//            rs = executeSelectQuery(sql, params);
//            while (rs.next()) {
//                Appointment appointment = new Appointment();
//                appointment.setAppointmentID(rs.getInt("AppointmentID"));
//                appointment.setUserID(rs.getInt("UserID"));
//                appointment.setDoctorID(rs.getInt("DoctorID"));
//                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
//                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
//                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
//                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
//                appointment.setNote(rs.getString("Note"));
//                appointment.setDoctorName(rs.getString("DoctorName"));
//                appointment.setStatusName(rs.getString("AppointmentStatusName"));
//                appointment.setSpecialtyName(rs.getString("SpecialtyName"));
//
//                appointments.add(appointment);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResources(rs);
//        }
//
//        return appointments;
//    }
//
//    /**
//     * Get appointment info with doctor and patient info to view
//     */
//    public Appointment getAppointmentByIdFull(int appointmentId) {
//        String sql = "SELECT "
//                + "a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
//                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
//                + "CONCAT(pd.FirstName, ' ', pd.LastName) AS DoctorName, "
//                + "CONCAT(pp.FirstName, ' ', pp.LastName) AS PatientName, "
//                + "pp.Email AS PatientEmail, pp.PhoneNumber AS PatientPhone, pp.DOB AS PatientDOB, pp.UserAddress AS PatientAddress, "
//                + "CASE WHEN pp.Gender = 1 THEN 'Male' ELSE 'Female' END AS PatientGender, "
//                + "s.SpecialtyName, "
//                + "ast.AppointmentStatusName "
//                + "FROM Appointment a "
//                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
//                + "LEFT JOIN Profile pd ON d.DoctorID = pd.UserProfileID "
//                + "LEFT JOIN Profile pp ON a.UserID = pp.UserProfileID "
//                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
//                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
//                + "WHERE a.AppointmentID = ?";
//
//        ResultSet rs = null;
//        try {
//            Object[] params = {appointmentId};
//            rs = executeSelectQuery(sql, params);
//
//            if (rs.next()) {
//                Appointment appointment = new Appointment();
//                // appointment info
//                appointment.setAppointmentID(rs.getInt("AppointmentID"));
//                appointment.setUserID(rs.getInt("UserID"));
//                appointment.setDoctorID(rs.getInt("DoctorID"));
//                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
//                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
//                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
//                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
//                appointment.setNote(rs.getString("Note"));
//                appointment.setStatusName(rs.getString("AppointmentStatusName"));
//
//                // doctor info
//                appointment.setDoctorName(rs.getString("DoctorName"));
//                appointment.setSpecialtyName(rs.getString("SpecialtyName"));
//
//                // patient info
//                appointment.setPatientName(rs.getString("PatientName"));
//                appointment.setPatientEmail(rs.getString("PatientEmail"));
//                appointment.setPatientPhone(rs.getString("PatientPhone"));
//                appointment.setGender(rs.getString("PatientGender"));
//                appointment.setDoB(rs.getTimestamp("PatientDOB"));
//                appointment.setAddress(rs.getString("PatientAddress"));
//
//                return appointment;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResources(rs);
//        }
//
//        return null;
//    }
//
//    /**
//     * Search appointments by doctor name, patient name, specialty, or note
//     *
//     * @param searchQuery text is input into seaarch
//     * @return list appointment
//     */
//    public List<Appointment> searchAppointments(String searchQuery) {
//        List<Appointment> appointments = new ArrayList<>();
//        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
//                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
//                + "CONCAT(pd.FirstName, ' ', pd.LastName) AS DoctorName, "
//                + "CONCAT(pp.FirstName, ' ', pp.LastName) AS PatientName, "
//                + "s.SpecialtyName, "
//                + "ast.AppointmentStatusName "
//                + "FROM Appointment a "
//                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
//                + "LEFT JOIN Profile pd ON d.DoctorID = pd.UserProfileID "
//                + "LEFT JOIN Profile pp ON a.UserID = pp.UserProfileID "
//                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
//                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
//                + "WHERE CONCAT(pd.FirstName, ' ', pd.LastName) LIKE ? "
//                + "OR CONCAT(pp.FirstName, ' ', pp.LastName) LIKE ? "
//                + "OR s.SpecialtyName LIKE ? "
//                + "OR a.Note LIKE ? "
//                + "ORDER BY a.DateBegin DESC";
//        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//            String pattern = "%" + searchQuery.trim() + "%";
//            stmt.setString(1, pattern); // Doctor
//            stmt.setString(2, pattern); // Patient
//            stmt.setString(3, pattern); // Specialty
//            stmt.setString(4, pattern); // Note
//
//            try ( ResultSet rs = stmt.executeQuery()) {
//                while (rs.next()) {
//                    Appointment appointment = new Appointment();
//                    appointment.setAppointmentID(rs.getInt("AppointmentID"));
//                    appointment.setUserID(rs.getInt("UserID"));
//                    appointment.setDoctorID(rs.getInt("DoctorID"));
//                    appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
//                    appointment.setDateCreate(rs.getTimestamp("DateCreate"));
//                    appointment.setDateBegin(rs.getTimestamp("DateBegin"));
//                    appointment.setDateEnd(rs.getTimestamp("DateEnd"));
//                    appointment.setNote(rs.getString("Note"));
//                    appointment.setDoctorName(rs.getString("DoctorName"));
//                    appointment.setPatientName(rs.getString("PatientName"));
//                    appointment.setSpecialtyName(rs.getString("SpecialtyName"));
//                    appointment.setStatusName(rs.getString("AppointmentStatusName"));
//
//                    appointments.add(appointment);
//                }
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return appointments;
//    }
//
//    public List<Appointment> getAppointmentsByDoctorId(int doctorId) {
//        List<Appointment> list = new ArrayList<>();
//        String sql = "SELECT TOP 5\n"
//                + "	a.AppointmentID,\n"
//                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
//                + "    p.Email AS PatientEmail,\n"
//                + "    p.PhoneNumber AS PatientPhone,\n"
//                + "    a.DateBegin,\n"
//                + "    a.Note AS AppointmentNote,\n"
//                + "	ast.AppointmentStatusName AS Status\n"
//                + "FROM Appointment a\n"
//                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
//                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
//                + "INNER JOIN AppointmentStatus ast ON ast.AppointmentStatusID = a.AppointmentStatusID\n"
//                + "LEFT JOIN Prescription pr ON pr.AppointmentID = a.AppointmentID\n"
//                + "LEFT JOIN MedicalRecord mr ON mr.AppointmentID = a.AppointmentID\n"
//                + "WHERE a.DoctorID = ?";
//        Object[] params = {doctorId};
//        ResultSet rs = executeSelectQuery(sql, params);
//        try {
//            if (rs != null) {
//                while (rs.next()) {
//                    Appointment appointment = new Appointment(rs.getString("PatientName"), rs.getString("PatientEmail"), rs.getString("PatientPhone"), rs.getTimestamp("DateBegin"), rs.getString("AppointmentNote"), rs.getString("Status"), rs.getInt("AppointmentID"));
//                    list.add(appointment);
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            closeResources(rs);
//        }
//
//        return list;
//    }
//
//    public List<Appointment> getAllAppointmentsByDoctorId(int doctorId) {
//        List<Appointment> list = new ArrayList<>();
//        String sql = "SELECT \n"
//                + "	a.AppointmentID,\n"
//                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
//                + "    p.Email AS PatientEmail,\n"
//                + "    p.PhoneNumber AS PatientPhone,\n"
//                + "    a.DateBegin,\n"
//                + "    a.Note AS AppointmentNote,\n"
//                + "	ast.AppointmentStatusName AS Status\n"
//                + "FROM Appointment a\n"
//                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
//                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
//                + "INNER JOIN AppointmentStatus ast ON ast.AppointmentStatusID = a.AppointmentStatusID\n"
//                + "LEFT JOIN Prescription pr ON pr.AppointmentID = a.AppointmentID\n"
//                + "LEFT JOIN MedicalRecord mr ON mr.AppointmentID = a.AppointmentID\n"
//                + "WHERE a.DoctorID = ?  ";
//        Object[] params = {doctorId};
//        ResultSet rs = executeSelectQuery(sql, params);
//        try {
//            if (rs != null) {
//                while (rs.next()) {
//                    Appointment appointment = new Appointment(rs.getString("PatientName"), rs.getString("PatientEmail"), rs.getString("PatientPhone"), rs.getTimestamp("DateBegin"), rs.getString("AppointmentNote"), rs.getString("Status"), rs.getInt("AppointmentID"));
//                    list.add(appointment);
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            closeResources(rs);
//        }
//
//        return list;
//    }
//
//    public Appointment getDetailAppointmentById(int appointmentID, int doctorId) {
//        Appointment appointment = null;
//        String sql = "SELECT \n"
//                + "    a.AppointmentID,\n"
//                + "    a.DateBegin,\n"
//                + "    a.DateEnd,\n"
//                + "    ast.AppointmentStatusName AS AppointmentStatus,\n"
//                + "    a.Note AS AppointmentNote,\n"
//                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
//                + "    p.Email AS PatientEmail,\n"
//                + "    p.PhoneNumber AS PatientPhone,\n"
//                + "    CASE \n"
//                + "        WHEN p.Gender = 1 THEN 'Male'\n"
//                + "        ELSE 'Female'\n"
//                + "    END AS PatientGender,\n"
//                + "    p.DOB AS PatientDOB,\n"
//                + "    p.UserAddress AS PatientAddress\n"
//                + "FROM Appointment a\n"
//                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
//                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
//                + "INNER JOIN AppointmentStatus ast ON ast.AppointmentStatusID = a.AppointmentStatusID\n"
//                + "WHERE a.AppointmentID = ? AND a.DoctorID = ?";
//        Object[] params = {appointmentID, doctorId};
//        ResultSet rs = executeSelectQuery(sql, params);
//        try {
//
//            if (rs != null && rs.next()) {
//                appointment = new Appointment(
//                        rs.getInt("AppointmentID"),
//                        rs.getTimestamp("DateBegin"),
//                        rs.getTimestamp("DateEnd"),
//                        rs.getString("AppointmentNote"),
//                        rs.getString("PatientName"),
//                        rs.getString("PatientEmail"),
//                        rs.getString("PatientPhone"),
//                        rs.getString("AppointmentStatus"),
//                        rs.getTimestamp("PatientDOB"),
//                        rs.getString("PatientAddress"),
//                        rs.getString("PatientGender")
//                );
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            closeResources(rs);
//        }
//        return appointment;
//    }
//
//    public List<Appointment> searchAppointmentsByDoctor(int doctorId, String keyword) {
//        List<Appointment> list = new ArrayList<>();
//
//        String sql = "SELECT \n"
//                + "    a.AppointmentID,\n"
//                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
//                + "    p.Email AS PatientEmail,\n"
//                + "    p.PhoneNumber AS PatientPhone,\n"
//                + "    a.DateBegin,\n"
//                + "    a.Note AS AppointmentNote,\n"
//                + "    ast.AppointmentStatusName AS Status\n"
//                + "FROM Appointment a\n"
//                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
//                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
//                + "INNER JOIN AppointmentStatus ast ON ast.AppointmentStatusID = a.AppointmentStatusID\n"
//                + "LEFT JOIN Prescription pr ON pr.AppointmentID = a.AppointmentID\n"
//                + "LEFT JOIN MedicalRecord mr ON mr.AppointmentID = a.AppointmentID\n"
//                + "WHERE a.DoctorID = ? ";
//
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            sql += "AND (p.FirstName + ' ' + p.LastName LIKE ?) ";
//        }
//
//        sql += "ORDER BY a.DateBegin DESC";
//
//        List<Object> paramsList = new ArrayList<>();
//        paramsList.add(doctorId);
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            paramsList.add("%" + keyword.trim() + "%");
//        }
//        Object[] params = paramsList.toArray();
//        ResultSet rs = executeSelectQuery(sql, params);
//        try {
//            if (rs != null) {
//                while (rs.next()) {
//                    Appointment appointment = new Appointment(
//                            rs.getString("PatientName"),
//                            rs.getString("PatientEmail"),
//                            rs.getString("PatientPhone"),
//                            rs.getTimestamp("DateBegin"),
//                            rs.getString("AppointmentNote"),
//                            rs.getString("Status"),
//                            rs.getInt("AppointmentID")
//                    );
//                    list.add(appointment);
//                }
//
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            closeResources(rs);
//        }
//
//        return list;
//    }
//
//    /**
//     * Add appointment if user(patient) already have account get the list
//     * patient, if not create user by phone number
//     *
//     */
//    public boolean addAppointment(String existingPatientIdStr, String fullName, String phone,
//            boolean gender, int doctorId, String note) {
//
//        DBContext db = new DBContext();
//        try ( Connection conn = db.getConnection()) {
//            conn.setAutoCommit(false);
//
//            int userId = 0;
//
//            if (existingPatientIdStr != null && !existingPatientIdStr.isEmpty()) {
//                userId = Integer.parseInt(existingPatientIdStr);
//            } else {
//                String sqlCheck = "SELECT UserProfileID FROM Profile WHERE PhoneNumber = ?";
//                try ( PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
//                    psCheck.setString(1, phone);
//                    try ( ResultSet rs = psCheck.executeQuery()) {
//                        if (rs.next()) {
//                            userId = rs.getInt("UserProfileID");
//                        } else {
//                            String sqlUser = "INSERT INTO [User] (RoleID) VALUES (?)";
//                            try ( PreparedStatement psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS)) {
//                                psUser.setInt(1, 1);
//                                psUser.executeUpdate();
//                                try ( ResultSet rsUser = psUser.getGeneratedKeys()) {
//                                    if (rsUser.next()) {
//                                        userId = rsUser.getInt(1);
//                                    }
//                                }
//                            }
//                            String[] nameParts = fullName.trim().split("\\s+", 2);
//                            String firstName = nameParts[0];
//                            String lastName = nameParts.length > 1 ? nameParts[1] : "";
//
//                            String sqlProfile = "INSERT INTO [Profile] (UserProfileID, FirstName, LastName, PhoneNumber, Gender) VALUES (?, ?, ?, ?, ?)";
//                            try ( PreparedStatement psProfile = conn.prepareStatement(sqlProfile)) {
//                                psProfile.setInt(1, userId);
//                                psProfile.setString(2, firstName);
//                                psProfile.setString(3, lastName);
//                                psProfile.setString(4, phone);
//                                psProfile.setBoolean(5, gender);
//                                psProfile.executeUpdate();
//                            }
//                        }
//                    }
//                }
//            }
//
//            String sqlAppointment = "INSERT INTO Appointment (UserID, DoctorID, AppointmentStatusID, DateCreate, DateBegin, DateEnd, Note) "
//                    + "VALUES (?, ?, ?, GETDATE(), ?, ?, ?)";
//            try ( PreparedStatement psAppointment = conn.prepareStatement(sqlAppointment)) {
//                psAppointment.setInt(1, userId);
//                psAppointment.setInt(2, doctorId);
//                psAppointment.setInt(3, 2);
//
//                Timestamp dateBegin = new Timestamp(System.currentTimeMillis());
//                Timestamp dateEnd = new Timestamp(System.currentTimeMillis() + 3600 * 1000);
//                psAppointment.setTimestamp(4, dateBegin);
//                psAppointment.setTimestamp(5, dateEnd);
//                psAppointment.setString(6, note);
//
//                psAppointment.executeUpdate();
//            }
//
//            conn.commit();
//            return true;
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//    /**
//     * Cancel appointment by setting status to Canceled (status ID = 4) Only if
//     * current status is Pending or Approved(status ID = 1 and 2)
//     */
//    public boolean cancelAppointment(int appointmentId) {
//        String sql = "UPDATE Appointment SET AppointmentStatusID = 4 WHERE AppointmentID = ? AND (AppointmentStatusID = 1 OR AppointmentStatusID = 2)";
//
//        DBContext db = new DBContext();
//        try ( Connection conn = db.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//            stmt.setInt(1, appointmentId);
//            int rowsAffected = stmt.executeUpdate();
//            return rowsAffected > 0;
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//    /**
//     * Update appointment by setting status to Approved (status ID = 2) Only if
//     * current status is Pending(status ID)
//     */
//    public boolean approvedStatusAppointment(int appointmentId) {
//        String sql = "UPDATE Appointment "
//                + "SET AppointmentStatusID = 2 "
//                + "WHERE AppointmentID = ? AND AppointmentStatusID = 1";
//        DBContext db = new DBContext();
//        try ( Connection conn = db.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//            stmt.setInt(1, appointmentId);
//            int rowsAffected = stmt.executeUpdate();
//            return rowsAffected > 0;
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//    /**
//     * Book new appointment for logged-in patient
//     *
//     * @param userId Patient's user ID
//     * @param doctorId Doctor's ID
//     * @param note Appointment note
//     * @param appointmentDateTime Appointment start date and time
//     * @return true if appointment is booked successfully
//     * @note End time is set to NULL - will be determined by doctor when
//     * examination is complete
//     */
//    public boolean bookAppointment(int userId, int doctorId, String note, Timestamp appointmentDateTime) {
//        String sql = "INSERT INTO Appointment (UserID, DoctorID, AppointmentStatusID, DateBegin, DateEnd, Note) "
//                + "VALUES (?, ?, ?, ?, NULL, ?)";
//
//        // DateEnd is NULL - will be set by doctor when examination is complete
//        Object[] params = {
//            userId,
//            doctorId,
//            1, // Status 1 = Pending
//            appointmentDateTime,
//            note
//        };
//
//        try {
//            int rowsAffected = executeQuery(sql, params);
//            closeResources(null);
//            return rowsAffected > 0;
//        } catch (Exception e) {
//            e.printStackTrace();
//            closeResources(null);
//            return false;
//        }
//    }
//
//    /**
//     * Get the latest appointment for a specific user
//     *
//     * @param userId Patient's user ID
//     * @return Latest appointment timestamp or null if no appointments found
//     */
//    public Timestamp getLatestAppointmentByUserId(int userId) {
//        String sql = "SELECT TOP 1 DateBegin FROM Appointment "
//                + "WHERE UserID = ? AND AppointmentStatusID IN (1, 2) "
//                + "ORDER BY DateBegin DESC";
//
//        ResultSet rs = null;
//        try {
//            Object[] params = {userId};
//            rs = executeSelectQuery(sql, params);
//
//            if (rs.next()) {
//                return rs.getTimestamp("DateBegin");
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResources(rs);
//        }
//
//        return null;
//    }
//
//    /**
//     * Check if the new appointment time has valid 24-hour gap with all existing appointments
//     *
//     * @param userId User's ID
//     * @param newAppointmentTime New appointment time to check
//     * @return true if gap is valid, false if conflict found
//     */
//    public boolean isValidAppointmentTimeGap(int userId, Timestamp newAppointmentTime) {
//        String sql = "SELECT DateBegin FROM Appointment "
//                + "WHERE UserID = ? AND AppointmentStatusID IN (1, 2) "
//                + "ORDER BY DateBegin";
//
//        ResultSet rs = null;
//        try {
//            Object[] params = {userId};
//            rs = executeSelectQuery(sql, params);
//
//            java.time.LocalDateTime newTime = newAppointmentTime.toLocalDateTime();
//
//            while (rs.next()) {
//                Timestamp existingAppointment = rs.getTimestamp("DateBegin");
//                java.time.LocalDateTime existingTime = existingAppointment.toLocalDateTime();
//
//                // Calculate absolute difference in hours
//                long hoursDifference = Math.abs(java.time.Duration.between(existingTime, newTime).toHours());
//
//                // If any existing appointment is within 24 hours, return false
//                if (hoursDifference < 24) {
//                    return false;
//                }
//            }
//
//            return true; // All appointments have valid gap
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false; // Return false on error for safety
//        } finally {
//            closeResources(rs);
//        }
//    }
}
