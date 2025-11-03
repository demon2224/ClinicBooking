/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.DBContext;
import model.DoctorDTO;
import model.SpecialtyDTO;
import model.StaffDTO;
import model.DoctorReviewDTO;
import model.DegreeDTO;
import model.PatientDTO;
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
     * Retrieves a specific doctor by their ID.
     *
     * @param doctorId The ID of the doctor to be retrieved.
     * @return A Doctor object or null if not found.
     */
    public DoctorDTO getDoctorById(int doctorId) {

        String sql = "SELECT d.DoctorID, d.YearExperience, d.SpecialtyID, "
                + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email, st.Avatar, st.Bio, st.JobStatus, st.RoleID, "
                + "s.SpecialtyName "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE d.DoctorID = ? AND st.RoleID = 1";

        DoctorDTO doctor = null;
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null && rs.next()) {
                doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                // Tạo Staff object
                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setEmail(rs.getString("Email"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setJobStatus(rs.getString("JobStatus"));
                doctor.setStaffID(staff);

                // Tạo Specialty object
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return doctor;
    }

    /**
     * Searches for doctors based on multiple criteria.
     *
     * @param keyword The search keyword.
     * @param specialtyId The specialty ID to filter by.
     * @return A list of doctors matching the criteria.
     */
    public List<DoctorDTO> searchDoctors(String keyword, Integer specialtyId) {
        StringBuilder sql = new StringBuilder("SELECT d.DoctorID, d.YearExperience, d.SpecialtyID, "
                + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email, st.Avatar, st.Bio, st.JobStatus, st.RoleID, "
                + "s.SpecialtyName "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE st.RoleID = 1");

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (st.FirstName LIKE ? OR st.LastName LIKE ? OR s.SpecialtyName LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (specialtyId != null) {
            sql.append(" AND d.SpecialtyID = ?");
            params.add(specialtyId);
        }

        List<DoctorDTO> doctors = new ArrayList<>();
        ResultSet rs = executeSelectQuery(sql.toString(), params.toArray());
        try {
            while (rs != null && rs.next()) {
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setEmail(rs.getString("Email"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setJobStatus(rs.getString("JobStatus"));
                doctor.setStaffID(staff);

                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                doctors.add(doctor);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return doctors;
    }

    /**
     * Retrieves a list of available doctors.
     *
     * @return A list of available doctors.
     */
    public List<DoctorDTO> getAvailableDoctors() {
        String sql = "SELECT d.DoctorID, d.YearExperience, d.SpecialtyID, "
                + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email, st.Avatar, st.Bio, st.JobStatus, st.RoleID, "
                + "s.SpecialtyName "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE st.JobStatus = 'Available' AND st.RoleID = 1";

        List<DoctorDTO> doctors = new ArrayList<>();
        ResultSet rs = executeSelectQuery(sql, null);
        try {
            while (rs != null && rs.next()) {
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));

                StaffDTO staff = new StaffDTO();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setEmail(rs.getString("Email"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setJobStatus(rs.getString("JobStatus"));
                doctor.setStaffID(staff);

                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                doctors.add(doctor);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return doctors;
    }

    /**
     * Retrieves reviews for a specific doctor.
     *
     * @param doctorId The ID of the doctor.
     * @return A list of DoctorReviewDTO for the doctor.
     */
    public List<DoctorReviewDTO> getReviewsByDoctorId(int doctorId) {
        String sql = "SELECT dr.Content AS ReviewContent, dr.RateScore AS Rating, dr.DateCreate AS ReviewDate, "
                + "p.PatientID, p.FirstName AS ReviewerFirstName, p.LastName AS ReviewerLastName "
                + "FROM DoctorReview dr "
                + "INNER JOIN Patient p ON dr.PatientID = p.PatientID "
                + "WHERE dr.DoctorID = ?";

        List<DoctorReviewDTO> reviews = new ArrayList<>();
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            while (rs != null && rs.next()) {
                DoctorReviewDTO review = new DoctorReviewDTO();
                review.setContent(rs.getString("ReviewContent"));
                review.setRateScore(rs.getInt("Rating"));
                review.setDateCreate(rs.getTimestamp("ReviewDate"));

                // Create PatientDTO
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("ReviewerFirstName"));
                patient.setLastName(rs.getString("ReviewerLastName"));

                // Set PatientDTO to DoctorReviewDTO
                review.setPatientID(patient);

                reviews.add(review);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return reviews;
    }

    /**
     * Retrieves the count of reviews for a specific doctor.
     *
     * @param doctorId The ID of the doctor.
     * @return The count of reviews for the doctor.
     */
    public int getReviewCountByDoctorId(int doctorId) {
        String sql = "SELECT COUNT(*) AS ReviewCount FROM DoctorReview WHERE DoctorID = ?";

        int reviewCount = 0;
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null && rs.next()) {
                reviewCount = rs.getInt("ReviewCount");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return reviewCount;
    }
}
