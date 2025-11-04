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

    /**
     * Get appointment info with doctor and patient info to view
     */
    public AppointmentDTO getAppointmentByIdFull(int appointmentId) {
        String sql = "SELECT "
                + "a.AppointmentID, "
                + "a.PatientID, "
                + "a.DoctorID, "
                + "a.AppointmentStatus, "
                + "a.DateCreate, "
                + "a.DateBegin, "
                + "a.DateEnd, "
                + "a.Note, "
                + "p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, "
                + "p.Email AS PatientEmail, p.PhoneNumber AS PatientPhone, "
                + "p.DOB AS PatientDOB, p.UserAddress AS PatientAddress, "
                + "p.Gender AS PatientGender, "
                + "s.FirstName AS StaffFirstName, s.LastName AS StaffLastName, "
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

                // --- Gán doctor vào appointment ---
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
    /**
     * Cancel appointment by setting status to Canceled Only if current status
     * is Pending or Approved
     */
    public boolean cancelAppointment(int appointmentId) {
        String sql = "UPDATE Appointment"
                + " SET AppointmentStatus = 'Canceled' "
                + " WHERE AppointmentID = ? AND "
                + "(AppointmentStatus = 'Pending' OR AppointmentStatus = 'Approved')";

        DBContext db = new DBContext();
        Object[] params = {appointmentId};
        int rowsAffected = db.executeQuery(sql, params);
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
        DBContext db = new DBContext();
        Object[] params = {appointmentId};
        int rowsAffected = db.executeQuery(sql, params);
        return rowsAffected > 0;
    }
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

    /**
     * Get all appointments (for admin view)
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
