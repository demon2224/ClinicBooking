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
                + "INNER JOIN JobStatus js ON d.JobStatusID = js.JobStatusID";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            // Populate the list with Doctor objects
            while (rs.next()) {
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
                doctors.add(doctor); // Add to the list
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs, ps, conn);
        }

        return doctors; // Return the list of doctors
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
                + "WHERE d.DoctorID = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Doctor doctor = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, doctorId); // Set the doctor ID parameter
            rs = ps.executeQuery();

            if (rs.next()) {
                doctor = new Doctor(); // Instantiate the Doctor object
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
                doctor.setUserID(rs.getInt("UserID"));
                doctor.setJobStatusID(rs.getInt("JobStatusID"));
                doctor.setSpecialtyID(rs.getInt("SpecialtyID"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs, ps, conn);
        }

        return doctor; // Return the doctor or null if not found
    }

    /**
     * Retrieves doctors by their specialty ID.
     *
     * @param specialtyId The ID of the specialty.
     * @return A list of Doctor objects.
     */
    public List<Doctor> getDoctorsBySpecialty(int specialtyId) {
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
                + "WHERE d.SpecialtyID = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, specialtyId);  // Set the specialty ID parameter
            rs = ps.executeQuery();

            while (rs.next()) {
                Doctor doctor = new Doctor(); // Create Doctor object
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
                doctors.add(doctor);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs, ps, conn);
        }

        return doctors; // Return the list of doctors
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
                + "WHERE d.JobStatusID = 1";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
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
                doctors.add(doctor);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs, ps, conn);
        }

        return doctors; // Return the list of available doctors
    }
}
