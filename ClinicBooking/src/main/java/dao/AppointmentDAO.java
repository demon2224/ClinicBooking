/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.AppointmentDTO;
import model.DoctorDTO;
import utils.DBContext;
import java.sql.*;
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
                + "	a.AppointmentStatus\n"
                + "FROM Appointment a\n"
                + "JOIN Doctor d on a.DoctorID = d.DoctorID\n"
                + "JOIN Staff s on s.StaffID = d.StaffID\n"
                + "JOIN Patient p on p.PatientID = a.PatientID\n"
                + "Where d.DoctorID = ? "
                + "and a.AppointmentStatus = 'Approved'"
                + "ORDER BY ABS(DATEDIFF(SECOND, a.DateBegin, GETDATE()))";
        // + "and CAST (a.DateBegin as DATE) = CAST (GETDATE() as DATE)";
        Object[] params = { doctorID };
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
        Object[] params = { doctorID, appointmentID };
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
                + "	a.AppointmentStatus\n"
                + "FROM Appointment a\n"
                + "JOIN Doctor d on a.DoctorID = d.DoctorID\n"
                + "JOIN Staff s on s.StaffID = d.StaffID\n"
                + "JOIN Patient p on p.PatientID = a.PatientID\n"
                + "Where d.DoctorID = ? and a.AppointmentStatus = 'Approved'"
                + "AND CAST (a.DateBegin as DATE) = CAST (GETDATE() as DATE)"
                + "AND (p.FirstName LIKE ? OR p.LastName LIKE ?)";

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
            Object[] params = { patientId };
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
            Object[] params = { appointmentId };
            rs = executeSelectQuery(sql, params);
            if (rs.next()) {
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));

                // Set PatientDTO
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                appointment.setPatientID(patient);

                // Set DoctorDTO với nested StaffDTO và SpecialtyDTO
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                // Tạo StaffDTO
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

                // Tạo SpecialtyDTO
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
            Object[] params = { appointmentId };
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
        Object[] params = { pattern, pattern, pattern };

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

                // --- Staff (doctor’s profile) ---
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
        Object[] params = { appointmentId };
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
            Object[] params = { patientId, "%" + searchQuery + "%", "%" + searchQuery + "%" };
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

    /**
     * Add appointment if patient already exists by phone number or ID. If not,
     * create a new patient and then insert appointment.
     */
    public boolean addAppointment(String existingPatientIdStr, String fullName, String phone,
            boolean gender, int doctorId, String note) {

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);

            int patientId = 0;

            if (existingPatientIdStr != null && !existingPatientIdStr.isEmpty()) {
                patientId = Integer.parseInt(existingPatientIdStr);
            } else {
                // check phonenumber already exsit or not
                String sqlCheck = "SELECT PatientID FROM Patient WHERE PhoneNumber = ?";
                try (PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
                    psCheck.setString(1, phone);
                    try (ResultSet rs = psCheck.executeQuery()) {
                        if (rs.next()) {
                            patientId = rs.getInt("PatientID");
                        } else {
                            // add new pateint
                            String[] nameParts = fullName.trim().split("\\s+", 2);
                            String firstName = nameParts[0];
                            String lastName = nameParts.length > 1 ? nameParts[1] : "";

                            String sqlInsert = "INSERT INTO Patient (FirstName, LastName, PhoneNumber, Gender, Hidden) "
                                    + "VALUES (?, ?, ?, ?, 1)";
                            try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert,
                                    Statement.RETURN_GENERATED_KEYS)) {
                                psInsert.setString(1, firstName);
                                psInsert.setString(2, lastName);
                                psInsert.setString(3, phone);
                                psInsert.setBoolean(4, gender);
                                psInsert.executeUpdate();

                                try (ResultSet rsGen = psInsert.getGeneratedKeys()) {
                                    if (rsGen.next()) {
                                        patientId = rsGen.getInt(1);
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // add new appointmnet
            String sqlAppointment = "INSERT INTO Appointment "
                    + "(PatientID, DoctorID, AppointmentStatus, DateCreate, DateBegin, DateEnd, Note, Hidden) "
                    + "VALUES (?, ?, 'Pending', GETDATE(), ?, ?, ?, 1)";
            try (PreparedStatement psAppt = conn.prepareStatement(sqlAppointment)) {
                Timestamp dateBegin = new Timestamp(System.currentTimeMillis());
                Timestamp dateEnd = new Timestamp(System.currentTimeMillis() + 3600 * 1000);

                psAppt.setInt(1, patientId);
                psAppt.setInt(2, doctorId);
                psAppt.setTimestamp(3, dateBegin);
                psAppt.setTimestamp(4, dateEnd);
                psAppt.setString(5, note);

                psAppt.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
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

        Object[] params = { appointmentId };
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
                + "SET AppointmentStatus = CASE "
                + "WHEN AppointmentStatus = 'Pending' THEN 'Approved' "
                + "WHEN AppointmentStatus = 'Approved' THEN 'Completed' "
                + "ELSE AppointmentStatus "
                + "END "
                + "WHERE AppointmentID = ?";

        Object[] params = { appointmentId };
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

        try {
            int rowsAffected = executeQuery(sql, params);
            closeResources(null);
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            closeResources(null);
            return false;
        }
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
            Object[] params = { patientId };
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
     * Check if doctor is available at the requested time (no conflicting
     * appointments with status Pending, Approved, or Completed)
     *
     * @param doctorId           Doctor's ID
     * @param newAppointmentTime Requested appointment time
     * @return true if doctor is available, false if doctor has conflicting
     *         appointment
     */
    public boolean isDoctorAvailable(int doctorId, Timestamp newAppointmentTime) {
        // Check for appointments that overlap with the new appointment time
        // Considering that each appointment is 30 minutes long (DateBegin to DateEnd)
        String sql = "SELECT AppointmentID FROM Appointment "
                + "WHERE DoctorID = ? "
                + "AND AppointmentStatus IN ('Pending', 'Approved', 'Completed') "
                + "AND DateBegin = ?";

        ResultSet rs = null;
        try {
            Object[] params = { doctorId, newAppointmentTime };
            rs = executeSelectQuery(sql, params);

            // If any appointment found at the exact time, doctor is not available
            if (rs.next()) {
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
     * doctor
     *
     * @param doctorId           Doctor's ID
     * @param newAppointmentTime New appointment time
     * @return true if gap is valid, false if conflict found
     */
    public boolean hasValid30MinuteGap(int doctorId, Timestamp newAppointmentTime) {
        String sql = "SELECT DateBegin FROM Appointment "
                + "WHERE DoctorID = ? "
                + "AND AppointmentStatus IN ('Pending', 'Approved', 'Completed') "
                + "AND CAST(DateBegin AS DATE) = CAST(? AS DATE) "
                + "ORDER BY DateBegin";

        ResultSet rs = null;
        try {
            Object[] params = { doctorId, newAppointmentTime };
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
                + "AND AppointmentStatus IN ('Approved', 'Pending')";
        Object[] params = { doctorId };
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
     * Only returns doctors that the patient can review (completed within 24h and
     * not yet reviewed)
     *
     * @param patientId The patient ID
     * @return List of doctors eligible for review
     */
    public List<DoctorDTO> getDoctorsEligibleForReview(int patientId) {
        List<DoctorDTO> doctors = new ArrayList<>();
        String sql = "SELECT DISTINCT d.DoctorID, s.StaffID, s.FirstName, s.LastName, "
                + "sp.SpecialtyID, sp.SpecialtyName "
                + "FROM Appointment a "
                + "JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "JOIN Staff s ON d.StaffID = s.StaffID "
                + "JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "WHERE a.PatientID = ? "
                + "AND a.AppointmentStatus = 'Completed' "
                + "AND DATEDIFF(HOUR, a.DateEnd, GETDATE()) <= 24 "
                + "AND NOT EXISTS ( "
                + "    SELECT 1 FROM DoctorReview dr "
                + "    WHERE dr.PatientID = a.PatientID "
                + "    AND dr.DoctorID = d.DoctorID "
                + "    AND dr.AppointmentID = a.AppointmentID "
                + ") "
                + "ORDER BY a.DateEnd DESC";

        Object[] params = { patientId };
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
     * Check if a patient can review a specific doctor
     * Patient must have a completed appointment within 24 hours and not yet
     * reviewed
     *
     * @param patientId The patient ID
     * @param doctorId  The doctor ID
     * @return true if eligible, false otherwise
     */
    public boolean canPatientReviewDoctor(int patientId, int doctorId) {
        String sql = "SELECT COUNT(*) AS Total FROM Appointment a "
                + "WHERE a.PatientID = ? "
                + "AND a.DoctorID = ? "
                + "AND a.AppointmentStatus = 'Completed' "
                + "AND DATEDIFF(HOUR, a.DateEnd, GETDATE()) <= 24 "
                + "AND NOT EXISTS ( "
                + "    SELECT 1 FROM DoctorReview dr "
                + "    WHERE dr.PatientID = a.PatientID "
                + "    AND dr.DoctorID = a.DoctorID "
                + "    AND dr.AppointmentID = a.AppointmentID "
                + ")";

        Object[] params = { patientId, doctorId };
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
     * @param reviewId  The review ID
     * @param patientId The patient ID (for security)
     * @return true if can edit, false otherwise
     */
    public boolean canEditReview(int reviewId, int patientId) {
        String sql = "SELECT COUNT(*) AS Total FROM DoctorReview "
                + "WHERE DoctorReviewID = ? "
                + "AND PatientID = ? "
                + "AND DATEDIFF(HOUR, DateCreate, GETDATE()) <= 24";

        Object[] params = { reviewId, patientId };
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

}
