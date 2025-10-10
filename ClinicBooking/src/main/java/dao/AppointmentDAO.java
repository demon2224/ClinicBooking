/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Appointment;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Doctor;

/**
 * Appointment Data Access Object
 *
 * @author Le Anh Tuan - CE180905
 */
public class AppointmentDAO extends DBContext {

    /**
     * Get all appointments for a specific user
     */
    public List<Appointment> getAppointmentsByUserId(int userId) {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "CONCAT(p.FirstName, ' ', p.LastName) as DoctorName, "
                + "s.SpecialtyName, "
                + "ast.AppointmentStatusName "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Profile p ON d.DoctorID = p.UserProfileID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
                + "WHERE a.UserID = ? "
                + "ORDER BY a.DateBegin DESC";
        ResultSet rs = null;

        try {
            Object[] params = {userId};
            rs = executeSelectQuery(sql, params);

            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setUserID(rs.getInt("UserID"));
                appointment.setDoctorID(rs.getInt("DoctorID"));
                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));
                appointment.setDoctorName(rs.getString("DoctorName"));
                appointment.setStatusName(rs.getString("AppointmentStatusName"));
                appointment.setSpecialtyName(rs.getString("SpecialtyName"));

                appointments.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return appointments;
    }

    /**
     * Get all appointments (for admin view)
     */
    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "CONCAT(pd.FirstName, ' ', pd.LastName) as DoctorName, "
                + "CONCAT(pp.FirstName, ' ', pp.LastName) as PatientName, "
                + "s.SpecialtyName, "
                + "ast.AppointmentStatusName "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Profile pd ON d.DoctorID = pd.UserProfileID "
                + "LEFT JOIN Profile pp ON a.UserID = pp.UserProfileID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
                + "ORDER BY a.DateBegin DESC";

        ResultSet rs = null;

        try {
            rs = executeSelectQuery(sql);

            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setUserID(rs.getInt("UserID"));
                appointment.setDoctorID(rs.getInt("DoctorID"));
                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));
                appointment.setDoctorName(rs.getString("DoctorName"));
                appointment.setStatusName(rs.getString("AppointmentStatusName"));
                appointment.setPatientName(rs.getString("PatientName"));
                appointment.setSpecialtyName(rs.getString("SpecialtyName"));

                appointments.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return appointments;
    }

    /**
     * Get appointment by ID
     */
    public Appointment getAppointmentById(int appointmentId) {
        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "CONCAT(p.FirstName, ' ', p.LastName) as DoctorName, "
                + "s.SpecialtyName, "
                + "ast.AppointmentStatusName "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Profile p ON d.DoctorID = p.UserProfileID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
                + "WHERE a.AppointmentID = ?";

        ResultSet rs = null;

        try {
            Object[] params = {appointmentId};
            rs = executeSelectQuery(sql, params);
            if (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setUserID(rs.getInt("UserID"));
                appointment.setDoctorID(rs.getInt("DoctorID"));
                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));
                appointment.setDoctorName(rs.getString("DoctorName"));
                appointment.setStatusName(rs.getString("AppointmentStatusName"));
                appointment.setSpecialtyName(rs.getString("SpecialtyName"));

                return appointment;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return null;
    }

    /**
     * Cancel appointment by setting status to Canceled (status ID = 4)
     */
    public boolean cancelAppointment(int appointmentId) {
        String sql = "UPDATE Appointment SET AppointmentStatusID = 4 WHERE AppointmentID = ?";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, appointmentId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, stmt, conn);
        }
    }

    /**
     * Search appointments by user ID and search query (doctor name, specialty,
     * note)
     */
    public List<Appointment> searchAppointmentsByUserId(int userId, String searchQuery) {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "CONCAT(p.FirstName, ' ', p.LastName) as DoctorName, "
                + "s.SpecialtyName, "
                + "ast.AppointmentStatusName "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Profile p ON d.DoctorID = p.UserProfileID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
                + "WHERE a.UserID = ? AND ("
                + "CONCAT(p.FirstName, ' ', p.LastName) LIKE ? OR "
                + "s.SpecialtyName LIKE ? OR "
                + "a.Note LIKE ?) "
                + "ORDER BY a.DateBegin DESC";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            String searchPattern = "%" + searchQuery + "%";
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setUserID(rs.getInt("UserID"));
                appointment.setDoctorID(rs.getInt("DoctorID"));
                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));
                appointment.setDoctorName(rs.getString("DoctorName"));
                appointment.setStatusName(rs.getString("AppointmentStatusName"));
                appointment.setSpecialtyName(rs.getString("SpecialtyName"));

                appointments.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }

        return appointments;
    }

    /**
     * Get appointments by user ID and status
     */
    public List<Appointment> getAppointmentsByUserIdAndStatus(int userId, int statusId) {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "CONCAT(p.FirstName, ' ', p.LastName) as DoctorName, "
                + "s.SpecialtyName, "
                + "ast.AppointmentStatusName "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Profile p ON d.DoctorID = p.UserProfileID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
                + "WHERE a.UserID = ? AND a.AppointmentStatusID = ? "
                + "ORDER BY a.DateBegin DESC";

        ResultSet rs = null;

        try {
            Object[] params = {userId, statusId};
            rs = executeSelectQuery(sql, params);

            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setUserID(rs.getInt("UserID"));
                appointment.setDoctorID(rs.getInt("DoctorID"));
                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));
                appointment.setDoctorName(rs.getString("DoctorName"));
                appointment.setStatusName(rs.getString("AppointmentStatusName"));
                appointment.setSpecialtyName(rs.getString("SpecialtyName"));

                appointments.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return appointments;
    }

    public boolean approvedStatusAppointment(int appointmentId) {
        String sql = "UPDATE Appointment SET AppointmentStatusID = 2 WHERE AppointmentID = ? ";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, appointmentId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, stmt, conn);
        }
    }

    /**
     * Get full appointment info by ID (doctor, patient, specialty, status)
     */
    public Appointment getAppointmentByIdFull(int appointmentId) {
        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "CONCAT(pd.FirstName, ' ', pd.LastName) AS DoctorName, "
                + "CONCAT(pp.FirstName, ' ', pp.LastName) AS PatientName, "
                + "s.SpecialtyName, "
                + "ast.AppointmentStatusName "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Profile pd ON d.DoctorID = pd.UserProfileID "
                + "LEFT JOIN Profile pp ON a.UserID = pp.UserProfileID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
                + "WHERE a.AppointmentID = ?";

        ResultSet rs = null;

        try {
            Object[] params = {appointmentId};
            rs = executeSelectQuery(sql, params);

            if (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setUserID(rs.getInt("UserID"));
                appointment.setDoctorID(rs.getInt("DoctorID"));
                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));
                appointment.setDoctorName(rs.getString("DoctorName"));
                appointment.setPatientName(rs.getString("PatientName"));
                appointment.setStatusName(rs.getString("AppointmentStatusName"));
                appointment.setSpecialtyName(rs.getString("SpecialtyName"));

                return appointment;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return null;
    }

    /**
     * Search appointments by doctor name, patient name, specialty, or note
     *
     * @param searchQuery text nhập vào search
     * @return danh sách appointment khớp
     */
    public List<Appointment> searchAppointments(String searchQuery) {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "CONCAT(pd.FirstName, ' ', pd.LastName) AS DoctorName, "
                + "CONCAT(pp.FirstName, ' ', pp.LastName) AS PatientName, "
                + "s.SpecialtyName, "
                + "ast.AppointmentStatusName "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Profile pd ON d.DoctorID = pd.UserProfileID "
                + "LEFT JOIN Profile pp ON a.UserID = pp.UserProfileID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "LEFT JOIN AppointmentStatus ast ON a.AppointmentStatusID = ast.AppointmentStatusID "
                + "WHERE CONCAT(pd.FirstName, ' ', pd.LastName) LIKE ? "
                + "OR CONCAT(pp.FirstName, ' ', pp.LastName) LIKE ? "
                + "OR s.SpecialtyName LIKE ? "
                + "OR a.Note LIKE ? "
                + "ORDER BY a.DateBegin DESC";

        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            String pattern = "%" + searchQuery.trim() + "%";
            stmt.setString(1, pattern); // Doctor
            stmt.setString(2, pattern); // Patient
            stmt.setString(3, pattern); // Specialty
            stmt.setString(4, pattern); // Note

            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Appointment appointment = new Appointment();
                    appointment.setAppointmentID(rs.getInt("AppointmentID"));
                    appointment.setUserID(rs.getInt("UserID"));
                    appointment.setDoctorID(rs.getInt("DoctorID"));
                    appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
                    appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                    appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                    appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                    appointment.setNote(rs.getString("Note"));
                    appointment.setDoctorName(rs.getString("DoctorName"));
                    appointment.setPatientName(rs.getString("PatientName"));
                    appointment.setSpecialtyName(rs.getString("SpecialtyName"));
                    appointment.setStatusName(rs.getString("AppointmentStatusName"));

                    appointments.add(appointment);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointments;
    }

}
