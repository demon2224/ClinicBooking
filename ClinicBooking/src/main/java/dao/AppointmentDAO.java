/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.AppointmentDTO;
import model.DoctorDTO;
import utils.DBContext;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.PatientDTO;
import model.SpecialtyDTO;
import model.StaffDTO;

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
                + "	a.AppointmentStatus,\n"
                + " CASE WHEN mr.MedicalRecordID IS NOT NULL THEN 1 ELSE 0 END as HasRecord\n"
                + "FROM Appointment a\n"
                + "JOIN Doctor d on a.DoctorID = d.DoctorID\n"
                + "JOIN Staff s on s.StaffID = d.StaffID\n"
                + "JOIN Patient p on p.PatientID = a.PatientID\n"
                + "LEFT JOIN MedicalRecord mr on mr.AppointmentID = a.AppointmentID\n"
                + "Where d.DoctorID = ? "
                + "and not a.AppointmentStatus = 'Canceled'"
                + "ORDER BY a.DateBegin DESC";
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
                    appointment.setHasRecord(rs.getInt("HasRecord") == 1);
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
                + "                	p.FirstName,\n"
                + "                	p.LastName,\n"
                + "                	p.Email,\n"
                + "                	p.DOB,\n"
                + "                	CASE WHEN p.Gender = 1 THEN 'Male' ELSE 'Female' END as Gender,\n"
                + "                	p.UserAddress,\n"
                + "                	p.PhoneNumber,\n"
                + "                	a.DateBegin,\n"
                + "                     a.DateEnd,\n"
                + "                	a.Note,\n"
                + "                	a.AppointmentStatus,\n"
                + "			m.MedicalRecordID\n"
                + "                FROM Appointment a\n"
                + "                JOIN Doctor d on a.DoctorID = d.DoctorID\n"
                + "                JOIN Staff s on s.StaffID = d.StaffID\n"
                + "                JOIN Patient p on p.PatientID = a.PatientID\n"
                + "		   LEFT JOIN MedicalRecord m on m.AppointmentID = a.AppointmentID\n"
                + "                Where d.DoctorID = ? and a.AppointmentID = ?";
        Object[] params = {doctorID, appointmentID};
        ResultSet rs = executeSelectQuery(sql, params);
        try {

            if (rs.next()) {
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

        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return appointment;
    }

    public List<AppointmentDTO> searchPatientAppointmentByPatientName(int doctorID, String keyword) {
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
                + "	a.AppointmentStatus,\n"
                + " CASE WHEN mr.MedicalRecordID IS NOT NULL THEN 1 ELSE 0 END as HasRecord\n"
                + "FROM Appointment a\n"
                + "JOIN Doctor d on a.DoctorID = d.DoctorID\n"
                + "JOIN Staff s on s.StaffID = d.StaffID\n"
                + "JOIN Patient p on p.PatientID = a.PatientID\n"
                + "LEFT JOIN MedicalRecord mr on mr.AppointmentID = a.AppointmentID\n"
                + "Where d.DoctorID = ?"
                + "and not a.AppointmentStatus = 'Canceled'"
                + "AND (p.FirstName LIKE ? OR p.LastName LIKE ?)"
                + "ORDER BY a.DateBegin DESC";

        Object[] params = {
            doctorID,
            "%" + keyword + "%",
            "%" + keyword + "%"
        };

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
                    appointment.setHasRecord(rs.getInt("HasRecord") == 1);
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

    /*
     * Get all appointments for a specific patient
     */
    public List<AppointmentDTO> getAppointmentsByPatientId(int patientId) {
        List<AppointmentDTO> appointments = new ArrayList<>();
        String sql = "SELECT a.AppointmentID, a.PatientID, a.DoctorID, a.AppointmentStatus, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "s.StaffID, s.FirstName, s.LastName, s.PhoneNumber, s.Email, s.Avatar, s.Bio, s.JobStatus, "
                + "sp.SpecialtyID, sp.SpecialtyName, d.YearExperience "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "WHERE a.PatientID = ? "
                + "ORDER BY a.DateBegin DESC";
        ResultSet rs = null;

        try {
            Object[] params = {patientId};
            rs = executeSelectQuery(sql, params);

            while (rs.next()) {
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));

                // PatientDTO
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                appointment.setPatientID(patient);

                // DoctorDTO
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                // StaffDTO
                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setJobStatus(rs.getString("JobStatus"));
                doctor.setStaffID(staff);

                // SpecialtyDTO
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                appointment.setDoctorID(doctor);

                appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));

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
     *
     * @param appointmentId
     */
    public AppointmentDTO getAppointmentById(int appointmentId) {
        String sql = "SELECT a.AppointmentID, a.PatientID, a.DoctorID, a.AppointmentStatus, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "s.StaffID, s.FirstName, s.LastName, s.PhoneNumber, s.Email, s.Avatar, s.Bio, s.JobStatus, "
                + "sp.SpecialtyID, sp.SpecialtyName, d.YearExperience "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "WHERE a.AppointmentID = ?";

        ResultSet rs = null;

        try {
            Object[] params = {appointmentId};
            rs = executeSelectQuery(sql, params);
            if (rs.next()) {
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));

                // Set PatientDTO
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                appointment.setPatientID(patient);

                // Set DoctorDTO v?i nested StaffDTO v� SpecialtyDTO
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                // T?o StaffDTO
                model.StaffDTO staff = new model.StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setJobStatus(rs.getString("JobStatus"));
                doctor.setStaffID(staff);

                // T?o SpecialtyDTO
                model.SpecialtyDTO specialty = new model.SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                appointment.setDoctorID(doctor);

                appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));

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
     * Get appointment info with doctor and patient info to view
     */
    public AppointmentDTO getAppointmentByIdFull(int appointmentId) {
        String sql = "SELECT "
                + "a.AppointmentID, a.PatientID, a.DoctorID, a.AppointmentStatus, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, "
                + "p.Email AS PatientEmail, p.PhoneNumber AS PatientPhone, "
                + "p.DOB AS PatientDOB, p.UserAddress AS PatientAddress, p.Gender AS PatientGender, "
                + "s.StaffID, s.FirstName AS StaffFirstName, s.LastName AS StaffLastName, "
                + "s.Email AS StaffEmail, s.PhoneNumber AS StaffPhone, "
                + "s.Gender AS StaffGender, s.UserAddress AS StaffAddress, "
                + "sp.SpecialtyName, d.YearExperience "
                + "FROM Appointment a "
                + "LEFT JOIN Patient p ON a.PatientID = p.PatientID "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "WHERE a.AppointmentID = ?";

        ResultSet rs = null;
        try {
            Object[] params = {appointmentId};
            rs = executeSelectQuery(sql, params);

            if (rs.next()) {
                // ===== Appointment =====
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));

                // ===== Patient =====
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("PatientFirstName"));
                patient.setLastName(rs.getString("PatientLastName"));
                patient.setEmail(rs.getString("PatientEmail"));
                patient.setPhoneNumber(rs.getString("PatientPhone"));
                patient.setDob(rs.getTimestamp("PatientDOB"));
                patient.setUserAddress(rs.getString("PatientAddress"));
                patient.setGender(rs.getBoolean("PatientGender"));
                appointment.setPatientID(patient);

                // ===== Doctor =====
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                // ===== Staff (Doctor personal info) =====
                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("StaffFirstName"));
                staff.setLastName(rs.getString("StaffLastName"));
                staff.setEmail(rs.getString("StaffEmail"));
                staff.setPhoneNumber(rs.getString("StaffPhone"));
                staff.setUserAddress(rs.getString("StaffAddress"));
                staff.setGender(rs.getBoolean("StaffGender"));
                doctor.setStaffID(staff);

                // ===== Specialty =====
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                appointment.setDoctorID(doctor);

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
     * @param searchQuery text is input into seaarch
     * @return list appointment
     */
    public List<AppointmentDTO> searchAppointments(String searchQuery) {
        List<AppointmentDTO> appointments = new ArrayList<>();
        DBContext db = new DBContext();

        String sql = "SELECT "
                + "a.AppointmentID, a.AppointmentStatus, a.DateCreate, a.DateBegin, a.DateEnd, a.Note, a.Hidden, "
                + "p.PatientID, p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, "
                + "p.DOB AS PatientDOB, p.Gender AS PatientGender, p.UserAddress AS PatientAddress, "
                + "p.PhoneNumber AS PatientPhone, p.Email AS PatientEmail, "
                + "d.DoctorID, d.YearExperience, "
                + "s.StaffID, s.FirstName AS StaffFirstName, s.LastName AS StaffLastName, "
                + "s.Email AS StaffEmail, s.PhoneNumber AS StaffPhone, s.UserAddress AS StaffAddress, "
                + "sp.SpecialtyID, sp.SpecialtyName "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Patient p ON a.PatientID = p.PatientID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "WHERE CONCAT(s.FirstName, ' ', s.LastName) LIKE ? "
                + "OR CONCAT(p.FirstName, ' ', p.LastName) LIKE ? "
                + "OR sp.SpecialtyName LIKE ? "
                + "ORDER BY a.DateBegin DESC";

        String pattern = "%" + searchQuery.trim() + "%";
        Object[] params = {pattern, pattern, pattern};

        ResultSet rs = null;

        try {
            rs = db.executeSelectQuery(sql, params);

            while (rs != null && rs.next()) {
                // --- Appointment ---
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));
                appointment.setHidden(rs.getBoolean("Hidden"));

                // --- Patient ---
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("PatientFirstName"));
                patient.setLastName(rs.getString("PatientLastName"));
                patient.setDob(rs.getTimestamp("PatientDOB"));
                patient.setGender(rs.getBoolean("PatientGender"));
                patient.setUserAddress(rs.getString("PatientAddress"));
                patient.setPhoneNumber(rs.getString("PatientPhone"));
                patient.setEmail(rs.getString("PatientEmail"));
                appointment.setPatientID(patient);

                // --- Doctor ---
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                // --- Staff (doctors profile) ---
                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("StaffFirstName"));
                staff.setLastName(rs.getString("StaffLastName"));
                staff.setEmail(rs.getString("StaffEmail"));
                staff.setPhoneNumber(rs.getString("StaffPhone"));
                staff.setUserAddress(rs.getString("StaffAddress"));
                doctor.setStaffID(staff);

                // --- Specialty ---
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                appointment.setDoctorID(doctor);

                appointments.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeResources(rs);
        }

        return appointments;
    }

    /**
     * Cancel appointment by setting status to Canceled
     */
    public boolean cancelMyAppointment(int appointmentId) {
        String sql = "UPDATE Appointment SET AppointmentStatus = 'Canceled' WHERE AppointmentID = ?";
        Object[] params = {appointmentId};
        int rowsAffected = executeQuery(sql, params);
        closeResources(null);
        return rowsAffected > 0;
    }

    /**
     * Search appointments doctor name and specialty by patient id
     */
    public List<AppointmentDTO> searchAppointmentsByPatientId(int patientId, String searchQuery) {
        List<AppointmentDTO> appointments = new ArrayList<>();
        String sql = "SELECT a.AppointmentID, a.PatientID, a.DoctorID, a.AppointmentStatus, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "s.StaffID, s.FirstName, s.LastName, s.PhoneNumber, s.Email, s.Avatar, s.Bio, s.JobStatus, "
                + "sp.SpecialtyID, sp.SpecialtyName, d.YearExperience "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "WHERE a.PatientID = ? "
                + "AND (CONCAT(s.FirstName, ' ', s.LastName) LIKE ? OR sp.SpecialtyName LIKE ?) "
                + "ORDER BY a.DateBegin DESC";
        ResultSet rs = null;
        try {
            Object[] params = {patientId, "%" + searchQuery + "%", "%" + searchQuery + "%"};
            rs = executeSelectQuery(sql, params);
            while (rs.next()) {
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));

                // Set PatientDTO
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                appointment.setPatientID(patient);

                // Set DoctorDTO with full information
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                // Set StaffDTO
                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setJobStatus(rs.getString("JobStatus"));
                doctor.setStaffID(staff);

                // Set SpecialtyDTO
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                appointment.setDoctorID(doctor);

                // Set appointment details
                appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));

                appointments.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return appointments;
    }

    public boolean addAppointment(String existingPatientIdStr, String firstName, String lastName, String phone,
            boolean gender, int doctorId, LocalDateTime dateBegin, LocalDateTime dateEnd, String note) {

        String sqlCheck = "SELECT PatientID FROM Patient WHERE PhoneNumber = ?";
        String sqlInsertPatient = "INSERT INTO Patient (FirstName, LastName, PhoneNumber, Gender, Hidden) VALUES (?, ?, ?, ?, 1)";
        String sqlAppointment = "INSERT INTO Appointment "
                + "(PatientID, DoctorID, AppointmentStatus, DateCreate, DateBegin, DateEnd, Note, Hidden) "
                + "VALUES (?, ?, ?, GETDATE(), ?, ?, ?, 1)";

        try ( Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            int patientId = 0;

            // Nếu có existingPatientId -> dùng luôn
            if (existingPatientIdStr != null && !existingPatientIdStr.trim().isEmpty()) {
                patientId = Integer.parseInt(existingPatientIdStr);
            } else {
                // check theo phone xem patient có tồn tại chưa
                if (phone != null && !phone.trim().isEmpty()) {
                    try ( PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
                        psCheck.setString(1, phone);
                        try ( ResultSet rs = psCheck.executeQuery()) {
                            if (rs.next()) {
                                patientId = rs.getInt("PatientID");
                            }
                        }
                    }
                }

                // nếu patient chưa có -> insert mới
                if (patientId == 0) {
                    try ( PreparedStatement psInsert = conn.prepareStatement(sqlInsertPatient, Statement.RETURN_GENERATED_KEYS)) {
                        psInsert.setString(1, firstName);
                        psInsert.setString(2, lastName);
                        psInsert.setString(3, phone);
                        psInsert.setBoolean(4, gender);
                        int rows = psInsert.executeUpdate();
                        if (rows > 0) {
                            try ( ResultSet rsGen = psInsert.getGeneratedKeys()) {
                                if (rsGen.next()) {
                                    patientId = rsGen.getInt(1);
                                }
                            }
                        }
                    }
                }
            }

            if (patientId == 0) {
                conn.rollback();
                return false;
            }

            // Thêm appointment
            try ( PreparedStatement psAppt = conn.prepareStatement(sqlAppointment)) {
                psAppt.setInt(1, patientId);
                psAppt.setInt(2, doctorId);
                psAppt.setString(3, "Pending");
                psAppt.setTimestamp(4, Timestamp.valueOf(dateBegin));
                psAppt.setTimestamp(5, Timestamp.valueOf(dateEnd));
                psAppt.setString(6, note);

                int inserted = psAppt.executeUpdate();
                if (inserted <= 0) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Cancel appointment by setting status to Canceled Only if current status
     * is Pending or Approved
     */
    public boolean cancelAppointment(int appointmentId) {
        String sql = "UPDATE Appointment"
                + " SET AppointmentStatus = 'Canceled' "
                + " WHERE AppointmentID = ? AND "
                + "(AppointmentStatus = 'Pending' OR AppointmentStatus = 'Approved')";

        Object[] params = {appointmentId};
        int rowsAffected = executeQuery(sql, params);
        return rowsAffected > 0;
    }

    /**
     * Update appointment by setting status to Approved Only if current status
     * is Pending and then setting to Completed Only if current status is
     * Approved
     */
    public boolean updateStatusAppointment(int appointmentId) {
        String sql = "UPDATE Appointment "
                + "SET AppointmentStatus = 'Approved' "
                + "WHERE AppointmentID = ? AND AppointmentStatus = 'Pending' ";

        Object[] params = {appointmentId};
        int rowsAffected = executeQuery(sql, params);
        return rowsAffected > 0;
    }

    /**
     * Get all appointments
     *
     * @return appointments
     */
    public List<AppointmentDTO> getAllAppointments() {
        List<AppointmentDTO> appointments = new ArrayList<>();
        String sql = "SELECT "
                + "a.AppointmentID, "
                + "a.PatientID, "
                + "a.DoctorID, "
                + "a.AppointmentStatus, "
                + "a.DateCreate, "
                + "a.DateBegin, "
                + "a.DateEnd, "
                + "a.Note, "
                + "CONCAT(ds.FirstName, ' ', ds.LastName) AS DoctorName, "
                + "ds.Email AS DoctorEmail, "
                + "ds.PhoneNumber AS DoctorPhone, "
                + "ds.DOB AS DoctorDOB, "
                + "CASE WHEN ds.Gender = 1 THEN 'Male' ELSE 'Female' END AS DoctorGender, "
                + "ds.UserAddress AS DoctorAddress, "
                + "s.SpecialtyName, "
                + "CONCAT(p.FirstName, ' ', p.LastName) AS PatientName, "
                + "p.Email AS PatientEmail, "
                + "p.PhoneNumber AS PatientPhone, "
                + "p.DOB AS PatientDOB, "
                + "CASE WHEN p.Gender = 1 THEN 'Male' ELSE 'Female' END AS PatientGender, "
                + "p.UserAddress AS PatientAddress "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff ds ON d.StaffID = ds.StaffID "
                + "LEFT JOIN Patient p ON a.PatientID = p.PatientID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "ORDER BY a.DateBegin DESC";

        ResultSet rs = null;
        try {
            rs = executeSelectQuery(sql);
            while (rs.next()) {
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setDateEnd(rs.getTimestamp("DateEnd"));
                appointment.setNote(rs.getString("Note"));

                // Doctor info
                StaffDTO staff = new StaffDTO();
                String doctorFullName = rs.getString("DoctorName");
                if (doctorFullName != null) {
                    String[] parts = doctorFullName.split(" ", 2);
                    staff.setFirstName(parts[0]);
                    staff.setLastName(parts.length > 1 ? parts[1] : "");
                }
                staff.setEmail(rs.getString("DoctorEmail"));
                staff.setPhoneNumber(rs.getString("DoctorPhone"));
                staff.setDob(rs.getTimestamp("DoctorDOB"));
                staff.setUserAddress(rs.getString("DoctorAddress"));
                staff.setGender("Male".equals(rs.getString("DoctorGender")));

                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setStaffID(staff);

                // Specialty
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);
                appointment.setDoctorID(doctor);

                // Patient info
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                String patientFullName = rs.getString("PatientName");
                if (patientFullName != null) {
                    String[] parts = patientFullName.split(" ", 2);
                    patient.setFirstName(parts[0]);
                    patient.setLastName(parts.length > 1 ? parts[1] : "");
                }
                patient.setEmail(rs.getString("PatientEmail"));
                patient.setPhoneNumber(rs.getString("PatientPhone"));
                patient.setDob(rs.getTimestamp("PatientDOB"));
                patient.setGender("Male".equals(rs.getString("PatientGender")));
                patient.setUserAddress(rs.getString("PatientAddress"));
                appointment.setPatientID(patient);

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
     * Book new appointment for logged-in patient
     */
    public boolean bookAppointment(int patientId, int doctorId, String note, Timestamp appointmentDateTime) {
        String sql = "INSERT INTO Appointment (PatientID, DoctorID, AppointmentStatus, DateBegin, DateEnd, Note) "
                + "VALUES (?, ?, ?, ?, NULL, ?)";

        Object[] params = {
            patientId,
            doctorId,
            "Pending",
            appointmentDateTime,
            note
        };
        boolean result = false;

        try {
            int rowsAffected = executeQuery(sql, params);
            closeResources(null);
            result = rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null);
        }

        return result;
    }

    /**
     * Check if the new appointment time has valid 24-hour gap
     *
     * @param patientId
     */
    public boolean isValidAppointmentTimeGap(int patientId, Timestamp newAppointmentTime) {
        String sql = "SELECT DateBegin FROM Appointment "
                + "WHERE PatientID = ? AND AppointmentStatus IN ('Pending', 'Approved') "
                + "ORDER BY DateBegin";

        ResultSet rs = null;
        try {
            Object[] params = {patientId};
            rs = executeSelectQuery(sql, params);

            while (rs.next()) {
                Timestamp existingAppointment = rs.getTimestamp("DateBegin");

                // Calculate absolute difference in milliseconds
                long timeDifferenceMs = Math.abs(existingAppointment.getTime() - newAppointmentTime.getTime());

                // Convert to hours (1 hour = 3,600,000 milliseconds)
                long hoursDifference = timeDifferenceMs / (60 * 60 * 1000);

                if (hoursDifference < 24) {
                    return false;
                }
            }

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(rs);
        }
    }

    /**
     * Check if doctor is available at exact time (no appointment at same time)
     * A doctor cannot have 2 appointments with different patients at the same
     * time
     *
     * @param doctorId Doctor's ID
     * @param appointmentDateTime Exact appointment time
     * @return true if available, false if already booked
     */
    public boolean isDoctorAvailableAtExactTime(int doctorId, Timestamp appointmentDateTime) {
        String sql = "SELECT AppointmentID FROM Appointment "
                + "WHERE DoctorID = ? "
                + "AND AppointmentStatus IN ('Pending', 'Approved') "
                + "AND DateBegin = ?";

        ResultSet rs = null;
        try {
            Object[] params = {doctorId, appointmentDateTime};
            rs = executeSelectQuery(sql, params);

            // If any appointment found at exact time, doctor is not available
            if (rs != null && rs.next()) {
                return false;
            }

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false on error for safety
        } finally {
            closeResources(rs);
        }
    }

    /**
     * Check if the new appointment has valid 30-minute gap with doctor's other
     * appointments Appointments must be at least 30 minutes apart for the same
     * doctor (includes exact time match)
     *
     * @param doctorId Doctor's ID
     * @param newAppointmentTime New appointment time
     * @return true if gap is valid, false if conflict found
     */
    public boolean hasValid30MinuteGap(int doctorId, Timestamp newAppointmentTime) {
        String sql = "SELECT DateBegin FROM Appointment "
                + "WHERE DoctorID = ? "
                + "AND AppointmentStatus IN ('Pending', 'Approved') "
                + "AND CAST(DateBegin AS DATE) = CAST(? AS DATE) "
                + "ORDER BY DateBegin";

        ResultSet rs = null;
        try {
            Object[] params = {doctorId, newAppointmentTime};
            rs = executeSelectQuery(sql, params);

            while (rs.next()) {
                Timestamp existingAppointment = rs.getTimestamp("DateBegin");

                // Calculate absolute difference in milliseconds
                long timeDifferenceMs = Math.abs(existingAppointment.getTime() - newAppointmentTime.getTime());

                // Convert to minutes (1 minute = 60,000 milliseconds)
                long minutesDifference = timeDifferenceMs / (60 * 1000);

                // If any existing appointment is within 30 minutes, return false
                if (minutesDifference < 30) {
                    return false;
                }
            }

            return true; // All appointments have valid gap

        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false on error for safety
        } finally {
            closeResources(rs);
        }
    }

    /**
     * Count today's appointments for a doctor
     */
    public int countTodayAppointmentsByDoctor(int doctorId) {
        String sql = "SELECT COUNT(*) AS Total FROM Appointment "
                + "WHERE DoctorID = ? AND CAST(DateBegin AS DATE) = CAST(GETDATE() AS DATE) "
                + "AND AppointmentStatus = 'Approved'";
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }
        return 0;
    }

    /**
     * Get doctors from completed appointments for a patient within 24 hours
     * Only returns doctors that the patient can review (completed within 24h
     * and not yet reviewed)
     *
     * @param patientId The patient ID
     * @return List of doctors eligible for review
     */
    public List<DoctorDTO> getDoctorsEligibleForReview(int patientId) {
        List<DoctorDTO> doctors = new ArrayList<>();
        // Logic: Ch? l?y doctors t? appointment g?n nh?t ch?a ???c review
        String sql = "SELECT DISTINCT d.DoctorID, s.StaffID, s.FirstName, s.LastName, "
                + "sp.SpecialtyID, sp.SpecialtyName, a.DateEnd "
                + "FROM Appointment a "
                + "JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "JOIN Staff s ON d.StaffID = s.StaffID "
                + "JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "WHERE a.PatientID = ? "
                + "AND a.AppointmentStatus = 'Completed' "
                + "AND DATEDIFF(HOUR, a.DateEnd, GETDATE()) <= 24 "
                + "AND a.DateEnd = ( "
                + "    SELECT MAX(a2.DateEnd) FROM Appointment a2 "
                + "    WHERE a2.PatientID = a.PatientID "
                + "    AND a2.DoctorID = a.DoctorID "
                + "    AND a2.AppointmentStatus = 'Completed' "
                + "    AND DATEDIFF(HOUR, a2.DateEnd, GETDATE()) <= 24 "
                + ") "
                + "AND ( "
                + "    SELECT COUNT(*) FROM DoctorReview dr "
                + "    WHERE dr.PatientID = a.PatientID "
                + "    AND dr.DoctorID = a.DoctorID "
                + ") < ( "
                + "    SELECT COUNT(*) FROM Appointment a3 "
                + "    WHERE a3.PatientID = a.PatientID "
                + "    AND a3.DoctorID = a.DoctorID "
                + "    AND a3.AppointmentStatus = 'Completed' "
                + "    AND a3.DateEnd <= a.DateEnd "
                + ") "
                + "ORDER BY a.DateEnd DESC";

        Object[] params = {patientId};
        ResultSet rs = executeSelectQuery(sql, params);

        try {
            if (rs != null) {
                while (rs.next()) {
                    StaffDTO staff = new StaffDTO();
                    staff.setStaffID(rs.getInt("StaffID"));
                    staff.setFirstName(rs.getString("FirstName"));
                    staff.setLastName(rs.getString("LastName"));

                    SpecialtyDTO specialty = new SpecialtyDTO();
                    specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                    specialty.setSpecialtyName(rs.getString("SpecialtyName"));

                    DoctorDTO doctor = new DoctorDTO();
                    doctor.setDoctorID(rs.getInt("DoctorID"));
                    doctor.setStaffID(staff);
                    doctor.setSpecialtyID(specialty);

                    doctors.add(doctor);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return doctors;
    }

    /**
     * Check if a patient can review a specific doctor Patient must have a
     * completed appointment within 24 hours and not yet reviewed
     *
     * @param patientId The patient ID
     * @param doctorId The doctor ID
     * @return true if eligible, false otherwise
     */
    public boolean canPatientReviewDoctor(int patientId, int doctorId) {
        // Logic: Ch? cho ph�p review appointment g?n nh?t ch?a ???c review
        String sql = "SELECT COUNT(*) AS Total FROM Appointment a "
                + "WHERE a.PatientID = ? "
                + "AND a.DoctorID = ? "
                + "AND a.AppointmentStatus = 'Completed' "
                + "AND DATEDIFF(HOUR, a.DateEnd, GETDATE()) <= 24 "
                + "AND a.DateEnd = ( "
                + "    SELECT MAX(a2.DateEnd) FROM Appointment a2 "
                + "    WHERE a2.PatientID = a.PatientID "
                + "    AND a2.DoctorID = a.DoctorID "
                + "    AND a2.AppointmentStatus = 'Completed' "
                + "    AND DATEDIFF(HOUR, a2.DateEnd, GETDATE()) <= 24 "
                + ") "
                + "AND ( "
                + "    SELECT COUNT(*) FROM DoctorReview dr "
                + "    WHERE dr.PatientID = a.PatientID "
                + "    AND dr.DoctorID = a.DoctorID "
                + ") < ( "
                + "    SELECT COUNT(*) FROM Appointment a3 "
                + "    WHERE a3.PatientID = a.PatientID "
                + "    AND a3.DoctorID = a.DoctorID "
                + "    AND a3.AppointmentStatus = 'Completed' "
                + "    AND a3.DateEnd <= a.DateEnd "
                + ")";

        Object[] params = {patientId, doctorId};
        ResultSet rs = executeSelectQuery(sql, params);

        try {
            if (rs != null && rs.next()) {
                return rs.getInt("Total") > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return false;
    }

    /**
     * Check if a review can be edited (within 24 hours of creation)
     *
     * @param reviewId The review ID
     * @param patientId The patient ID (for security)
     * @return true if can edit, false otherwise
     */
    public boolean canEditReview(int reviewId, int patientId) {
        String sql = "SELECT COUNT(*) AS Total FROM DoctorReview "
                + "WHERE DoctorReviewID = ? "
                + "AND PatientID = ? "
                + "AND DATEDIFF(HOUR, DateCreate, GETDATE()) <= 24";

        Object[] params = {reviewId, patientId};
        ResultSet rs = executeSelectQuery(sql, params);

        try {
            if (rs != null && rs.next()) {
                return rs.getInt("Total") > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return false;
    }

    public int countAppointmentsToday() {
        String sql = "SELECT COUNT(*) AS total "
                + "FROM Appointment "
                + "WHERE AppointmentStatus IN ('Pending', 'Approved', 'Completed') "
                + "AND DateBegin >= CAST(GETDATE() AS DATE) "
                + "AND DateBegin < DATEADD(DAY, 1, CAST(GETDATE() AS DATE)) ";
        try ( ResultSet rs = executeSelectQuery(sql)) {
            if (rs != null && rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countCompletedAppointmentsToday() {
        String sql = " SELECT COUNT(*) AS total "
                + "FROM Appointment "
                + "WHERE AppointmentStatus = 'Completed' "
                + "AND DateEnd >= CAST(GETDATE() AS DATE) "
                + "AND DateEnd < DATEADD(DAY, 1, CAST(GETDATE() AS DATE)) ";
        try ( ResultSet rs = executeSelectQuery(sql)) {
            if (rs != null && rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<AppointmentDTO> getUpcomingAppointmentsByDoctorID(int doctorID) {
        List<AppointmentDTO> appointments = new ArrayList<>();
        String sql = "SELECT TOP 5 a.AppointmentID, a.DateBegin, a.AppointmentStatus, a.Note, "
                + "p.PatientID, p.FirstName, p.LastName, p.PhoneNumber, p.Email,"
                + " CASE WHEN mr.MedicalRecordID IS NOT NULL THEN 1 ELSE 0 END as HasRecord\n"
                + "FROM Appointment a "
                + "JOIN Patient p ON a.PatientID = p.PatientID "
                + "LEFT JOIN MedicalRecord mr on mr.AppointmentID = a.AppointmentID\n"
                + "WHERE a.DoctorID = ? "
                + "AND a.AppointmentStatus = 'Approved' "
                + "  AND DateBegin > DATEADD(MINUTE, -30, GETDATE())"
                + "ORDER BY a.DateBegin ASC";
        Object[] params = {doctorID};
        ResultSet rs = executeSelectQuery(sql, params);

        try {
            while (rs.next()) {
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setPhoneNumber(rs.getString("PhoneNumber"));
                patient.setEmail(rs.getString("Email"));

                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setPatientID(patient);
                appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setNote(rs.getString("Note"));
                appointment.setHasRecord(rs.getInt("HasRecord") == 1);
                appointments.add(appointment);
            }
        } catch (SQLException e) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(rs);
        }

        return appointments;
    }

    /**
     * Returns the total number of appointments in the system.
     *
     * This method executes a simple COUNT query on the Appointment table and
     * retrieves the aggregated result.
     *
     * @return the total number of appointments, or 0 if an error occurs
     */
    public int getTotalAppointments() {
        int countAppointment = 0;
        String sql = "SELECT COUNT(*) AS Total FROM Appointment";
        ResultSet rs = null;
        try {
            rs = executeSelectQuery(sql);
            if (rs.next()) {
                countAppointment = rs.getInt("Total");
            }
        } catch (Exception e) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(rs);
        }
        return countAppointment;
    }

    /**
     * Returns the number of appointments filtered by a specific status.
     *
     * This method performs a COUNT query on the Appointment table using the
     * provided status as a filter condition.
     *
     * @param status the appointment status to filter by
     * @return the number of appointments matching the given status, or 0 if an
     * error occurs
     */
    public int getAppointmentsByStatus(String status) {
        int countAppStatus = 0;
        String sql = "SELECT COUNT(*) AS Total FROM Appointment WHERE AppointmentStatus = ?";
        ResultSet rs = null;
        try {
            rs = executeSelectQuery(sql, new Object[]{status});
            if (rs.next()) {
                countAppStatus = rs.getInt("Total");
            }
        } catch (Exception e) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(rs);
        }
        return countAppStatus;
    }

    /**
     * Retrieves the top doctors ranked by their total number of appointments.
     *
     * This method executes a SQL query that joins Doctor, Staff, Specialty, and
     * Appointment tables to count appointments per doctor. It returns the top N
     * doctors sorted by appointment count in descending order.
     *
     * @param limit the maximum number of doctors to return (for top 5)
     * @return a list of AppointmentDTO objects containing: - DoctorDTO (with
     * nested StaffDTO and SpecialtyDTO) - totalAppointments (the number of
     * appointments per doctor) Returns an empty list if no data is found or an
     * exception occurs.
     *
     * @see AppointmentDTO
     * @see DoctorDTO
     * @see StaffDTO
     * @see SpecialtyDTO
     */
    public List<AppointmentDTO> getTopDoctorsByAppointments(int limit) {
        List<AppointmentDTO> appointments = new ArrayList<>();
        String sql = "SELECT TOP (?) "
                + "d.DoctorID, d.StaffID, d.SpecialtyID, d.YearExperience, "
                + "s.FirstName, s.LastName, s.PhoneNumber, s.Email, s.Avatar, "
                + "sp.SpecialtyName, sp.Price, "
                + "COUNT(a.AppointmentID) AS TotalAppointments "
                + "FROM Doctor d "
                + "JOIN Staff s ON d.StaffID = s.StaffID "
                + "JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "LEFT JOIN Appointment a ON d.DoctorID = a.DoctorID "
                + "WHERE s.Hidden = 0 "
                + "GROUP BY d.DoctorID, d.StaffID, d.SpecialtyID, d.YearExperience, "
                + "s.FirstName, s.LastName, s.PhoneNumber, s.Email, s.Avatar, "
                + "sp.SpecialtyName, sp.Price "
                + "ORDER BY TotalAppointments DESC";

        ResultSet rs = null;
        try {
            rs = executeSelectQuery(sql, new Object[]{limit});
            while (rs.next()) {

                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));

                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                specialty.setPrice(rs.getDouble("Price"));

                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setStaffID(staff);
                doctor.setSpecialtyID(specialty);
                doctor.setYearExperience(rs.getInt("YearExperience"));

                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setDoctorID(doctor);
                appointment.setTotalAppointments(rs.getInt("TotalAppointments"));

                appointments.add(appointment);
            }
        } catch (SQLException e) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(rs);
        }
        return appointments;
    }

    public boolean completedMyAppointment(int appointmentId) {
        String sql = "UPDATE Appointment SET AppointmentStatus = 'Completed' WHERE AppointmentID = ? and AppointmentStatus = 'Approved'";
        Object[] params = {appointmentId};
        int rowsAffected = executeQuery(sql, params);
        closeResources(null);
        return rowsAffected > 0;
    }

    public String getAppointmentStatusByID(int appointmentID) {
        String status = null;
        String sql = "SELECT AppointmentStatus FROM Appointment WHERE AppointmentID = ?";
        Object[] params = {appointmentID};

        ResultSet rs = executeSelectQuery(sql, params);

        try {
            if (rs != null && rs.next()) {
                status = rs.getString("AppointmentStatus");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return status;
    }

    /**
     * Get consultation fee for a doctor (from Specialty)
     *
     * @param doctorId Doctor ID
     * @return Consultation fee in VND
     */
    public double getConsultationFee(int doctorId) {
        String sql = "SELECT ISNULL(s.Price, 0) AS ConsultationFee "
                + "FROM Doctor d "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE d.DoctorID = ?";

        ResultSet rs = null;
        try {
            Object[] params = {doctorId};
            rs = executeSelectQuery(sql, params);

            if (rs != null && rs.next()) {
                return rs.getDouble("ConsultationFee");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return 0;
    }

    /**
     * Book appointment WITH consultation payment (NGHIỆP VỤ VIỆT NAM) Status =
     * "Pending" (chờ lễ tân xác nhận)
     *
     * @param patientId Patient ID
     * @param doctorId Doctor ID
     * @param note Patient note
     * @param appointmentDateTime Appointment date time
     * @param consultationFee Consultation fee paid
     * @param paymentType "Cash", "QR", "Card"
     * @return Appointment ID if success, -1 if failed
     */
    public int bookAppointmentWithPayment(int patientId, int doctorId, String note,
            Timestamp appointmentDateTime,
            double consultationFee,
            String paymentType) {
        String sql = "INSERT INTO Appointment "
                + "(PatientID, DoctorID, AppointmentStatus, DateBegin, DateEnd, Note, DateCreate) "
                + "VALUES (?, ?, ?, ?, NULL, ?, GETDATE())";

        Connection localConn = null;
        PreparedStatement localStatement = null;
        ResultSet rs = null;
        try {
            localConn = getConnection();
            localStatement = localConn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            localStatement.setInt(1, patientId);
            localStatement.setInt(2, doctorId);
            localStatement.setString(3, "Pending"); // Status "Pending" - chờ lễ tân xác nhận
            localStatement.setTimestamp(4, appointmentDateTime);
            localStatement.setString(5, note); // Save original patient note only

            int rowsAffected = localStatement.executeUpdate();

            if (rowsAffected > 0) {
                rs = localStatement.getGeneratedKeys();
                if (rs != null && rs.next()) {
                    return rs.getInt(1); // Return appointment ID
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (localStatement != null) {
                    localStatement.close();
                }
                if (localConn != null) {
                    localConn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return -1;
    }

    /**
     * Get booked time slots for a doctor on a specific date Dùng để ẩn time
     * slots đã bị book trong UI
     *
     * @param doctorId Doctor ID
     * @param date Date to check (format: yyyy-MM-dd)
     * @return List of booked time strings (format: "HH:mm")
     */
    public List<String> getBookedTimeSlots(int doctorId, String date) {
        List<String> bookedSlots = new ArrayList<>();

        // Convert date to SQL date range
        String sql = "SELECT FORMAT(DateBegin, 'HH:mm') AS TimeSlot "
                + "FROM Appointment "
                + "WHERE DoctorID = ? "
                + "AND CAST(DateBegin AS DATE) = CAST(? AS DATE) "
                + "AND AppointmentStatus IN ('Pending', 'Approved') "
                + "ORDER BY DateBegin";

        ResultSet rs = null;
        try {
            Object[] params = {doctorId, date};
            rs = executeSelectQuery(sql, params);

            //  Đọc hết ResultSet vào List TRƯỚC KHI đóng connection
            if (rs != null) {
                while (rs.next()) {
                    try {
                        String timeSlot = rs.getString("TimeSlot");
                        if (timeSlot != null) {
                            bookedSlots.add(timeSlot);
                        }
                    } catch (SQLException e) {
                        // Skip invalid row, continue reading
                        e.printStackTrace();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //  Đảm bảo đóng connection sau khi đọc hết ResultSet
            if (rs != null) {
                try {
                    closeResources(rs);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        return bookedSlots;
    }

    /**
     * Get completed appointments (hóa đơn khám đã hoàn thành) Lấy các
     * appointments có status "Completed" (đã khám xong)
     *
     * @param patientId Patient ID
     * @return List of completed appointments (hóa đơn khám)
     */
    public List<AppointmentDTO> getCompletedAppointmentsByPatientId(int patientId) {
        List<AppointmentDTO> appointments = new ArrayList<>();

        String sql = "SELECT a.AppointmentID, a.AppointmentStatus, a.DateCreate, a.DateBegin, a.Note, "
                + "d.DoctorID, s.StaffID, s.FirstName AS DoctorFirstName, s.LastName AS DoctorLastName, "
                + "sp.SpecialtyID, sp.SpecialtyName, sp.Price AS ConsultationFee "
                + "FROM Appointment a "
                + "JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "WHERE a.PatientID = ? "
                + "AND a.AppointmentStatus = 'Completed' "
                + "ORDER BY a.DateCreate DESC";

        ResultSet rs = null;
        try {
            Object[] params = {patientId};
            rs = executeSelectQuery(sql, params);

            while (rs != null && rs.next()) {
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                appointment.setDateCreate(rs.getTimestamp("DateCreate"));
                appointment.setDateBegin(rs.getTimestamp("DateBegin"));
                appointment.setNote(rs.getString("Note"));

                // Doctor info
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));

                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("DoctorFirstName"));
                staff.setLastName(rs.getString("DoctorLastName"));
                doctor.setStaffID(staff);

                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                specialty.setPrice(rs.getDouble("ConsultationFee"));
                doctor.setSpecialtyID(specialty);

                appointment.setDoctorID(doctor);
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
     * Lấy danh sách appointment của bác sĩ theo tháng/năm Chỉ lấy những slot
     * Pending hoặc Approved
     */
    public List<AppointmentDTO> getAppointmentsByDoctorAndMonth(int doctorId, int month, int year) {
        List<AppointmentDTO> list = new ArrayList<>();
        String sql = "SELECT AppointmentID, PatientID, DoctorID, AppointmentStatus, DateBegin, DateEnd, Note "
                + "FROM Appointment "
                + "WHERE DoctorID = ? "
                + "AND MONTH(DateBegin) = ? "
                + "AND YEAR(DateBegin) = ? "
                + "AND AppointmentStatus IN ('Pending', 'Approved')";

        ResultSet rs = null;
        try {
            rs = executeSelectQuery(sql, new Object[]{doctorId, month, year});
            while (rs.next()) {
                AppointmentDTO appt = new AppointmentDTO();
                appt.setAppointmentID(rs.getInt("AppointmentID"));
                appt.setAppointmentStatus(rs.getString("AppointmentStatus"));
                appt.setDateBegin(rs.getTimestamp("DateBegin"));
                appt.setDateEnd(rs.getTimestamp("DateEnd"));
                appt.setNote(rs.getString("Note"));
                list.add(appt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return list;
    }

}
