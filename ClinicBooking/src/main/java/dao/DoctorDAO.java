/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.DBContext;
import model.Doctor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Class for managing doctor data.
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorDAO extends DBContext {

    /**
     * Retrieves all doctors from the database.
     *
     * @return List of Doctor objects.
     */
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT d.DoctorID, d.YearExperience, d.JobStatusID, d.SpecialtyID, "
                + "p.FirstName, p.LastName, p.PhoneNumber, p.Email, "
                + "a.Avatar, a.Bio, "
                + "s.SpecialtyName, "
                + "js.JobStatusDescription "
                + "FROM Doctor d "
                + "INNER JOIN [User] u ON d.DoctorID = u.UserID "
                + "INNER JOIN Profile p ON u.UserID = p.UserProfileID "
                + "INNER JOIN Account a ON u.UserID = a.UserAccountID "
                + "INNER JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "INNER JOIN JobStatus js ON d.JobStatusID = js.JobStatusID "
                + "WHERE u.RoleID = 4";

        try {
            ResultSet rs = executeSelectQuery(sql);
            if (rs != null) {
                // Populate the list with Doctor objects
                while (rs.next()) {
                    Doctor doctor = createDoctorFromResultSet(rs);
                    doctors.add(doctor);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return doctors;
    }

    /**
     * Retrieves a specific doctor by their ID.
     *
     * @param doctorId The ID of the doctor to be retrieved.
     * @return A Doctor object or null if not found.
     */
    public Doctor getDoctorById(int doctorId) {
        String sql = "SELECT d.DoctorID, d.YearExperience, d.JobStatusID, d.SpecialtyID, "
                + "p.FirstName, p.LastName, p.PhoneNumber, p.Email, "
                + "a.Avatar, a.Bio, "
                + "s.SpecialtyName, "
                + "js.JobStatusDescription "
                + "FROM Doctor d "
                + "INNER JOIN [User] u ON d.DoctorID = u.UserID "
                + "INNER JOIN Profile p ON u.UserID = p.UserProfileID "
                + "INNER JOIN Account a ON u.UserID = a.UserAccountID "
                + "INNER JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "INNER JOIN JobStatus js ON d.JobStatusID = js.JobStatusID "
                + "WHERE d.DoctorID = ? AND u.RoleID = 4";

        Doctor doctor = null;
        try {
            Object[] params = { doctorId };
            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null && rs.next()) {
                doctor = createDoctorFromResultSet(rs);
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return doctor;
    }

    /**
     * Retrieves doctors by their specialty name.
     *
     * @param specialtyName The name of the specialty.
     * @return A list of Doctor objects.
     */
    public List<Doctor> getDoctorsBySpecialty(String specialtyName) {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT d.DoctorID, d.YearExperience, d.JobStatusID, d.SpecialtyID, "
                + "p.FirstName, p.LastName, p.PhoneNumber, p.Email, "
                + "a.Avatar, a.Bio, "
                + "s.SpecialtyName, "
                + "js.JobStatusDescription "
                + "FROM Doctor d "
                + "INNER JOIN [User] u ON d.DoctorID = u.UserID "
                + "INNER JOIN Profile p ON u.UserID = p.UserProfileID "
                + "INNER JOIN Account a ON u.UserID = a.UserAccountID "
                + "INNER JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "INNER JOIN JobStatus js ON d.JobStatusID = js.JobStatusID "
                + "WHERE s.SpecialtyName = ? AND u.RoleID = 4";

        try {
            Object[] params = { specialtyName };
            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null) {
                while (rs.next()) {
                    Doctor doctor = createDoctorFromResultSet(rs);
                    doctors.add(doctor);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return doctors;
    }

    /**
     * Retrieves available doctors (JobStatusID = 1).
     *
     * @return A list of available Doctor objects.
     */
    public List<Doctor> getAvailableDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT d.DoctorID, d.YearExperience, d.JobStatusID, d.SpecialtyID, "
                + "p.FirstName, p.LastName, p.PhoneNumber, p.Email, "
                + "a.Avatar, a.Bio, "
                + "s.SpecialtyName, "
                + "js.JobStatusDescription "
                + "FROM Doctor d "
                + "INNER JOIN [User] u ON d.DoctorID = u.UserID "
                + "INNER JOIN Profile p ON u.UserID = p.UserProfileID "
                + "INNER JOIN Account a ON u.UserID = a.UserAccountID "
                + "INNER JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "INNER JOIN JobStatus js ON d.JobStatusID = js.JobStatusID "
                + "WHERE d.JobStatusID = 1 AND u.RoleID = 4";

        try {
            ResultSet rs = executeSelectQuery(sql);
            if (rs != null) {
                while (rs.next()) {
                    Doctor doctor = createDoctorFromResultSet(rs);
                    doctors.add(doctor);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return doctors;
    }

    /**
     * Search doctors by name, specialty, job status, and minimum year experience.
     *
     * @param searchName    The doctor's name to search for (can be partial match).
     * @param specialtyName The specialty name to filter (null or empty for all).
     * @param jobStatusId   The job status ID to filter (0 or null for all).
     * @param minExperience Minimum years of experience (0 or null for all).
     * @return A list of Doctor objects matching the search criteria.
     */
    public List<Doctor> searchDoctors(String searchName, String specialtyName, Integer jobStatusId,
            Integer minExperience) {
        List<Doctor> doctors = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT d.DoctorID, d.YearExperience, d.JobStatusID, d.SpecialtyID, "
                        + "p.FirstName, p.LastName, p.PhoneNumber, p.Email, "
                        + "a.Avatar, a.Bio, "
                        + "s.SpecialtyName, "
                        + "js.JobStatusDescription "
                        + "FROM Doctor d "
                        + "INNER JOIN [User] u ON d.DoctorID = u.UserID "
                        + "INNER JOIN Profile p ON u.UserID = p.UserProfileID "
                        + "INNER JOIN Account a ON u.UserID = a.UserAccountID "
                        + "INNER JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                        + "INNER JOIN JobStatus js ON d.JobStatusID = js.JobStatusID "
                        + "WHERE u.RoleID = 4");

        // Build parameters list dynamically
        List<Object> paramsList = new ArrayList<>();

        // Add search conditions dynamically
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append(" AND (p.FirstName LIKE ? OR p.LastName LIKE ?)");
            String searchPattern = "%" + searchName.trim() + "%";
            paramsList.add(searchPattern);
            paramsList.add(searchPattern);
        }
        if (specialtyName != null && !specialtyName.trim().isEmpty()) {
            sql.append(" AND s.SpecialtyName = ?");
            paramsList.add(specialtyName.trim());
        }
        if (jobStatusId != null && jobStatusId > 0) {
            sql.append(" AND d.JobStatusID = ?");
            paramsList.add(jobStatusId);
        }
        if (minExperience != null && minExperience > 0) {
            sql.append(" AND d.YearExperience >= ?");
            paramsList.add(minExperience);
        }

        try {
            Object[] params = paramsList.toArray();
            ResultSet rs = executeSelectQuery(sql.toString(), params);
            if (rs != null) {
                while (rs.next()) {
                    Doctor doctor = createDoctorFromResultSet(rs);
                    doctors.add(doctor);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return doctors;
    }

    /**
     * Get all specialties from the database.
     *
     * @return A list of specialty names and IDs.
     */
    public List<String[]> getAllSpecialties() {
        List<String[]> specialties = new ArrayList<>();
        String sql = "SELECT SpecialtyID, SpecialtyName FROM Specialty ORDER BY SpecialtyName";

        try {
            ResultSet rs = executeSelectQuery(sql);
            if (rs != null) {
                while (rs.next()) {
                    String[] specialty = new String[2];
                    specialty[0] = String.valueOf(rs.getInt("SpecialtyID"));
                    specialty[1] = rs.getString("SpecialtyName");
                    specialties.add(specialty);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return specialties;
    }

    /**
     * Helper method to create Doctor object from ResultSet
     * Reuses code to avoid duplication
     */
    private Doctor createDoctorFromResultSet(ResultSet rs) throws SQLException {
        Doctor doctor = new Doctor();
        doctor.setDoctorID(rs.getInt("DoctorID"));
        doctor.setFirstName(rs.getString("FirstName"));
        doctor.setLastName(rs.getString("LastName"));
        doctor.setEmail(rs.getString("Email"));
        doctor.setPhoneNumber(rs.getString("PhoneNumber"));
        doctor.setAvatar(rs.getString("Avatar"));
        doctor.setBio(rs.getString("Bio"));
        doctor.setSpecialtyName(rs.getString("SpecialtyName"));
        doctor.setJobStatusDescription(rs.getString("JobStatusDescription"));
        doctor.setYearExperience(rs.getInt("YearExperience"));
        doctor.setUserID(rs.getInt("DoctorID")); // UserID = DoctorID based on database structure
        doctor.setJobStatusID(rs.getInt("JobStatusID"));
        doctor.setSpecialtyID(rs.getInt("SpecialtyID"));
        return doctor;
    }
}
