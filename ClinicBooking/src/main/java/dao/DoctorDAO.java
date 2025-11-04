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
                + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email, st.Avatar, st.Bio, st.JobStatus, st.Role, "
                + "s.SpecialtyName "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE d.DoctorID = ? AND st.Role = 'Doctor'";

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
                + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email, st.Avatar, st.Bio, st.JobStatus, st.Role, "
                + "s.SpecialtyName "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE st.Role = 'Doctor'");

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
                + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email, st.Avatar, st.Bio, st.JobStatus, st.Role, "
                + "s.SpecialtyName "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE st.JobStatus = 'Available' AND st.Role = 'Doctor'";

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
     * Retrieves the degrees of a specific doctor.
     *
     * @param doctorId The ID of the doctor.
     * @return A list of DoctorDegreeDTO for the doctor.
     */
    public List<DegreeDTO> getDoctorDegrees(int doctorId) {
        String sql = "SELECT DegreeID, DegreeName "
                + "FROM Degree "
                + "WHERE DoctorID = ?";

        List<DegreeDTO> degrees = new ArrayList<>();
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            while (rs != null && rs.next()) {
                DegreeDTO degree = new DegreeDTO();
                degree.setDegreeID(rs.getInt("DegreeID"));
                degree.setDegreeName(rs.getString("DegreeName"));
                degrees.add(degree);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return degrees;
    }

    /**
     * Retrieves reviews for a specific doctor.
     *
     * @param doctorId The ID of the doctor.
     * @return A list of DoctorReviewDTO for the doctor.
     */
    public List<DoctorReviewDTO> getReviewsByDoctorId(int doctorId) {
        String sql = "SELECT dr.Content, dr.RateScore, dr.DateCreate, "
                + "p.PatientID, p.FirstName, p.LastName "
                + "FROM DoctorReview dr "
                + "INNER JOIN Patient p ON dr.PatientID = p.PatientID "
                + "WHERE dr.DoctorID = ?";

        List<DoctorReviewDTO> reviews = new ArrayList<>();
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            while (rs != null && rs.next()) {
                DoctorReviewDTO review = new DoctorReviewDTO();
                review.setContent(rs.getString("Content"));
                review.setRateScore(rs.getInt("RateScore"));
                review.setDateCreate(rs.getTimestamp("DateCreate"));

                // Create PatientDTO
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));

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

    /**
     * Retrieves reviews for a specific patient (user).
     *
     * @param patientId The ID of the patient.
     * @return A list of DoctorReviewDTO for the patient.
     */
    public List<DoctorReviewDTO> getReviewsByUserId(int patientId) {
        String sql = "SELECT dr.DoctorReviewID, dr.Content, dr.RateScore, dr.DateCreate, "
                + "d.DoctorID, st.FirstName AS DoctorFirstName, st.LastName AS DoctorLastName, "
                + "s.SpecialtyName "
                + "FROM DoctorReview dr "
                + "INNER JOIN Doctor d ON dr.DoctorID = d.DoctorID "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE dr.PatientID = ? "
                + "ORDER BY dr.DateCreate DESC";

        List<DoctorReviewDTO> reviews = new ArrayList<>();
        Object[] params = {patientId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            while (rs != null && rs.next()) {
                DoctorReviewDTO review = new DoctorReviewDTO();
                review.setDoctorReviewID(rs.getInt("DoctorReviewID"));
                review.setContent(rs.getString("Content"));
                review.setRateScore(rs.getInt("RateScore"));
                review.setDateCreate(rs.getTimestamp("DateCreate"));

                // Create DoctorDTO with basic info
                DoctorDTO doctor = new DoctorDTO();
                doctor.setDoctorID(rs.getInt("DoctorID"));

                StaffDTO staff = new StaffDTO();
                staff.setFirstName(rs.getString("DoctorFirstName"));
                staff.setLastName(rs.getString("DoctorLastName"));
                doctor.setStaffID(staff);

                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                doctor.setSpecialtyID(specialty);

                review.setDoctorID(doctor);

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
     * Calculates the average rating for a specific doctor.
     *
     * @param doctorId The ID of the doctor.
     * @return The average rating as a double, or 0.0 if no reviews exist.
     */
    public double getAverageRatingByDoctorId(int doctorId) {
        String sql = "SELECT AVG(CAST(RateScore AS FLOAT)) AS AverageRating FROM DoctorReview WHERE DoctorID = ?";

        double averageRating = 0.0;
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null && rs.next()) {
                averageRating = rs.getDouble("AverageRating");
                // Round to 1 decimal place
                averageRating = Math.round(averageRating * 10.0) / 10.0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return averageRating;
    }

    /**
     * Get all specialties from the database.
     *
     * @return List of specialties
     */
    public List<SpecialtyDTO> getAllSpecialties() {
        String sql = "SELECT SpecialtyID, SpecialtyName, Price FROM Specialty";
        List<SpecialtyDTO> specialties = new ArrayList<>();
        ResultSet rs = null;

        try {
            rs = executeSelectQuery(sql, null);

            while (rs != null && rs.next()) {
                SpecialtyDTO s = new SpecialtyDTO();
                s.setSpecialtyID(rs.getInt("SpecialtyID"));
                s.setSpecialtyName(rs.getString("SpecialtyName"));
                s.setPrice(rs.getDouble("Price"));
                specialties.add(s);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return specialties;
    }

    public List<DoctorDTO> getDoctorsBySpecialty(int specialtyId) {
        String sql = "SELECT d.DoctorID, d.YearExperience, d.SpecialtyID, "
                + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email, st.Avatar, st.Bio, st.JobStatus, st.Role, "
                + "s.SpecialtyName "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE d.SpecialtyID = ? AND st.Role = 'Doctor'";

        List<DoctorDTO> doctors = new ArrayList<>();
        Object[] params = {specialtyId};
        ResultSet rs = executeSelectQuery(sql, params);

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

}
