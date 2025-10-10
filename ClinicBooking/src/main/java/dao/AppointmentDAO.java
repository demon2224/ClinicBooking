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
import java.util.logging.Level;
import java.util.logging.Logger;
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
            closeResources(null);
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
            closeResources(rs);
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
            closeResources(null);
        }
    }

    public Appointment getAppointmentByIdFull(int appointmentId) {
        String sql = "SELECT "
                + "a.AppointmentID, a.UserID, a.DoctorID, a.AppointmentStatusID, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "CONCAT(pd.FirstName, ' ', pd.LastName) AS DoctorName, "
                + "CONCAT(pp.FirstName, ' ', pp.LastName) AS PatientName, "
                + "pp.Email AS PatientEmail, pp.PhoneNumber AS PatientPhone, pp.DOB AS PatientDOB, pp.UserAddress AS PatientAddress, "
                + "CASE WHEN pp.Gender = 1 THEN 'Male' ELSE 'Female' END AS PatientGender, "
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
                // Thông tin appointment
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setUserID(rs.getInt("UserID"));
                appointment.setDoctorID(rs.getInt("DoctorID"));
                appointment.setAppointmentStatusID(rs.getInt("AppointmentStatusID"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));
                appointment.setStatusName(rs.getString("AppointmentStatusName"));

                // Thông tin bác sĩ
                appointment.setDoctorName(rs.getString("DoctorName"));
                appointment.setSpecialtyName(rs.getString("SpecialtyName"));

                // Thông tin bệnh nhân
                appointment.setPatientName(rs.getString("PatientName"));
                appointment.setPatientEmail(rs.getString("PatientEmail"));
                appointment.setPatientPhone(rs.getString("PatientPhone"));
                appointment.setGender(rs.getString("PatientGender"));
                appointment.setDoB(rs.getTimestamp("PatientDOB"));
                appointment.setAddress(rs.getString("PatientAddress"));

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

    public List<Appointment> getAppointmentsByDoctorId(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT TOP 5\n"
                + "	a.AppointmentID,\n"
                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
                + "    p.Email AS PatientEmail,\n"
                + "    p.PhoneNumber AS PatientPhone,\n"
                + "    a.DateBegin,\n"
                + "    a.Note AS AppointmentNote,\n"
                + "	ast.AppointmentStatusName AS Status\n"
                + "FROM Appointment a\n"
                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
                + "INNER JOIN AppointmentStatus ast ON ast.AppointmentStatusID = a.AppointmentStatusID\n"
                + "LEFT JOIN Prescription pr ON pr.AppointmentID = a.AppointmentID\n"
                + "LEFT JOIN MedicalRecord mr ON mr.AppointmentID = a.AppointmentID\n"
                + "WHERE a.DoctorID = ?";
        try {
            Object[] params = {doctorId};
            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null) {
                while (rs.next()) {
                    Appointment appointment = new Appointment(rs.getString("PatientName"), rs.getString("PatientEmail"), rs.getString("PatientPhone"), rs.getTimestamp("DateBegin"), rs.getString("AppointmentNote"), rs.getString("Status"), rs.getInt("AppointmentID"));
                    list.add(appointment);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public List<Appointment> getAllAppointmentsByDoctorId(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "	a.AppointmentID,\n"
                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
                + "    p.Email AS PatientEmail,\n"
                + "    p.PhoneNumber AS PatientPhone,\n"
                + "    a.DateBegin,\n"
                + "    a.Note AS AppointmentNote,\n"
                + "	ast.AppointmentStatusName AS Status\n"
                + "FROM Appointment a\n"
                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
                + "INNER JOIN AppointmentStatus ast ON ast.AppointmentStatusID = a.AppointmentStatusID\n"
                + "LEFT JOIN Prescription pr ON pr.AppointmentID = a.AppointmentID\n"
                + "LEFT JOIN MedicalRecord mr ON mr.AppointmentID = a.AppointmentID\n"
                + "WHERE a.DoctorID = ?  ";
        try {
            Object[] params = {doctorId};
            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null) {
                while (rs.next()) {
                    Appointment appointment = new Appointment(rs.getString("PatientName"), rs.getString("PatientEmail"), rs.getString("PatientPhone"), rs.getTimestamp("DateBegin"), rs.getString("AppointmentNote"), rs.getString("Status"), rs.getInt("AppointmentID"));
                    list.add(appointment);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public Appointment getDetailAppointmentById(int appointmentID, int doctorId) {
        Appointment appointment = null;
        String sql = "SELECT \n"
                + "    a.AppointmentID,\n"
                + "    a.DateBegin,\n"
                + "    a.DateEnd,\n"
                + "    ast.AppointmentStatusName AS AppointmentStatus,\n"
                + "    a.Note AS AppointmentNote,\n"
                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
                + "    p.Email AS PatientEmail,\n"
                + "    p.PhoneNumber AS PatientPhone,\n"
                + "    CASE \n"
                + "        WHEN p.Gender = 1 THEN 'Male'\n"
                + "        ELSE 'Female'\n"
                + "    END AS PatientGender,\n"
                + "    p.DOB AS PatientDOB,\n"
                + "    p.UserAddress AS PatientAddress\n"
                + "FROM Appointment a\n"
                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
                + "INNER JOIN AppointmentStatus ast ON ast.AppointmentStatusID = a.AppointmentStatusID\n"
                + "WHERE a.AppointmentID = ? AND a.DoctorID = ?";

        try {
            Object[] params = {appointmentID, doctorId};
            ResultSet rs = executeSelectQuery(sql, params);

            if (rs != null && rs.next()) {
                appointment = new Appointment(
                        rs.getInt("AppointmentID"),
                        rs.getTimestamp("DateBegin"),
                        rs.getTimestamp("DateEnd"),
                        rs.getString("AppointmentNote"),
                        rs.getString("PatientName"),
                        rs.getString("PatientEmail"),
                        rs.getString("PatientPhone"),
                        rs.getString("AppointmentStatus"),
                        rs.getTimestamp("PatientDOB"),
                        rs.getString("PatientAddress"),
                        rs.getString("PatientGender")
                );
            }
            closeResources(rs);
        } catch (SQLException ex) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return appointment;
    }

    public List<Appointment> searchAppointmentsByDoctor(int doctorId, String keyword, String status) {
        List<Appointment> list = new ArrayList<>();

        String sql = "SELECT \n"
                + "    a.AppointmentID,\n"
                + "    p.FirstName + ' ' + p.LastName AS PatientName,\n"
                + "    p.Email AS PatientEmail,\n"
                + "    p.PhoneNumber AS PatientPhone,\n"
                + "    a.DateBegin,\n"
                + "    a.Note AS AppointmentNote,\n"
                + "    ast.AppointmentStatusName AS Status\n"
                + "FROM Appointment a\n"
                + "INNER JOIN [User] u ON a.UserID = u.UserID\n"
                + "INNER JOIN [Profile] p ON p.UserProfileID = u.UserID\n"
                + "INNER JOIN AppointmentStatus ast ON ast.AppointmentStatusID = a.AppointmentStatusID\n"
                + "LEFT JOIN Prescription pr ON pr.AppointmentID = a.AppointmentID\n"
                + "LEFT JOIN MedicalRecord mr ON mr.AppointmentID = a.AppointmentID\n"
                + "WHERE a.DoctorID = ? ";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND (p.FirstName + ' ' + p.LastName LIKE ?) ";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += "AND ast.AppointmentStatusName = ? ";
        }

        sql += "ORDER BY a.DateBegin DESC";

        try {

            List<Object> paramsList = new ArrayList<>();
            paramsList.add(doctorId);

            if (keyword != null && !keyword.trim().isEmpty()) {
                paramsList.add("%" + keyword.trim() + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                paramsList.add(status.trim());
            }

            Object[] params = paramsList.toArray();

            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null) {
                while (rs.next()) {
                    Appointment appointment = new Appointment(
                            rs.getString("PatientName"),
                            rs.getString("PatientEmail"),
                            rs.getString("PatientPhone"),
                            rs.getTimestamp("DateBegin"),
                            rs.getString("AppointmentNote"),
                            rs.getString("Status"),
                            rs.getInt("AppointmentID")
                    );
                    list.add(appointment);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public boolean addAppointmentWithNewPatient(String firstName, String lastName, String email, String phone,
            int gender, Date dob, String address,
            int doctorId, String note) {
        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psProfile = null;
        PreparedStatement psAppointment = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false); // dùng transaction

            // 1. Tạo User mới
            String sqlUser = "INSERT INTO [User] (RoleID) VALUES (?)";
            psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setInt(1, 1); // RoleID = 1 mặc định là patient
            int rowsUser = psUser.executeUpdate();

            if (rowsUser == 0) {
                conn.rollback();
                return false;
            }

            rs = psUser.getGeneratedKeys();
            int userId = 0;
            if (rs.next()) {
                userId = rs.getInt(1); // UserID vừa tạo
            } else {
                conn.rollback();
                return false;
            }

            // 2. Tạo Profile
            String sqlProfile = "INSERT INTO [Profile] (UserProfileID, FirstName, LastName, Email, PhoneNumber, Gender, DOB, UserAddress) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            psProfile = conn.prepareStatement(sqlProfile);
            psProfile.setInt(1, userId);
            psProfile.setString(2, firstName);
            psProfile.setString(3, lastName);
            psProfile.setString(4, email);
            psProfile.setString(5, phone);
            psProfile.setInt(6, gender);
            psProfile.setDate(7, dob);
            psProfile.setString(8, address);
            int rowsProfile = psProfile.executeUpdate();

            if (rowsProfile == 0) {
                conn.rollback();
                return false;
            }

            // 3. Tạo Appointment
            String sqlApp = "INSERT INTO Appointment (UserID, DoctorID, AppointmentStatusID, DateCreate, DateBegin, DateEnd, Note) "
                    + "VALUES (?, ?, ?, GETDATE(), ?, ?, ?)";
            psAppointment = conn.prepareStatement(sqlApp);
            psAppointment.setInt(1, userId);
            psAppointment.setInt(2, doctorId);
            psAppointment.setInt(3, 2); // Approved
            Timestamp dateBegin = new Timestamp(System.currentTimeMillis());
            Timestamp dateEnd = new Timestamp(System.currentTimeMillis() + 3600 * 1000);
            psAppointment.setTimestamp(4, dateBegin);
            psAppointment.setTimestamp(5, dateEnd);
            psAppointment.setString(6, note);

            int rowsApp = psAppointment.executeUpdate();
            if (rowsApp == 0) {
                conn.rollback();
                return false;
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
            }
            try {
                if (psUser != null) {
                    psUser.close();
                }
            } catch (SQLException e) {
            }
            try {
                if (psProfile != null) {
                    psProfile.close();
                }
            } catch (SQLException e) {
            }
            try {
                if (psAppointment != null) {
                    psAppointment.close();
                }
            } catch (SQLException e) {
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }
    }

}
