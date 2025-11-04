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
                + "Where d.DoctorID = ? and a.AppointmentStatus = 'Approved' and CAST (a.DateBegin as DATE) = CAST (GETDATE() as DATE)";
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
                + "				LEFT JOIN MedicalRecord m on m.AppointmentID = a.AppointmentID\n"
                + "                Where d.DoctorID = ? and a.AppointmentID = ?";
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

                //PatientDTO
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                appointment.setPatientID(patient);

                //DoctorDTO
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                //StaffDTO
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

                //SpecialtyDTO
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
     * Search appointments by patient ID and doctor name
     */
    public List<AppointmentDTO> searchAppointmentsByPatientId(int patientId, String searchQuery) {
        List<AppointmentDTO> appointments = new ArrayList<>();
        String sql = "SELECT a.AppointmentID, a.PatientID, a.DoctorID, a.AppointmentStatus, "
                + "a.DateCreate, a.DateBegin, a.DateEnd, a.Note, "
                + "CONCAT(s.FirstName, ' ', s.LastName) as DoctorName, "
                + "sp.SpecialtyName "
                + "FROM Appointment a "
                + "LEFT JOIN Doctor d ON a.DoctorID = d.DoctorID "
                + "LEFT JOIN Staff s ON d.StaffID = s.StaffID "
                + "LEFT JOIN Specialty sp ON d.SpecialtyID = sp.SpecialtyID "
                + "WHERE a.PatientID = ? "
                + "AND CONCAT(s.FirstName, ' ', s.LastName) LIKE ? "
                + "ORDER BY a.DateBegin DESC";
        ResultSet rs = null;
        try {
            Object[] params = {patientId, "%" + searchQuery + "%"};
            rs = executeSelectQuery(sql, params);
            while (rs.next()) {
                AppointmentDTO appointment = new AppointmentDTO();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));

                // Set PatientDTO
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                appointment.setPatientID(patient);

                // Set DoctorDTO
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
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
     */
    public boolean isValidAppointmentTimeGap(int patientId, Timestamp newAppointmentTime) {
        String sql = "SELECT DateBegin FROM Appointment "
                + "WHERE PatientID = ? AND AppointmentStatus IN ('Pending', 'Approved') "
                + "ORDER BY DateBegin";

        ResultSet rs = null;
        try {
            Object[] params = {patientId};
            rs = executeSelectQuery(sql, params);

            java.time.LocalDateTime newTime = newAppointmentTime.toLocalDateTime();

            while (rs.next()) {
                Timestamp existingAppointment = rs.getTimestamp("DateBegin");
                java.time.LocalDateTime existingTime = existingAppointment.toLocalDateTime();

                long hoursDifference = Math.abs(java.time.Duration.between(existingTime, newTime).toHours());

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
     * @param doctorId Doctor's ID
     * @param newAppointmentTime Requested appointment time
     * @return true if doctor is available, false if doctor has conflicting
     * appointment
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
            Object[] params = {doctorId, newAppointmentTime};
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
     * @param doctorId Doctor's ID
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
            Object[] params = {doctorId, newAppointmentTime};
            rs = executeSelectQuery(sql, params);

            java.time.LocalDateTime newTime = newAppointmentTime.toLocalDateTime();

            while (rs.next()) {
                Timestamp existingAppointment = rs.getTimestamp("DateBegin");
                java.time.LocalDateTime existingTime = existingAppointment.toLocalDateTime();

                // Calculate absolute difference in minutes
                long minutesDifference = Math.abs(java.time.Duration.between(existingTime, newTime).toMinutes());

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
}
