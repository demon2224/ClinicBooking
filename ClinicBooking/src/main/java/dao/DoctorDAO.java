/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.DBContext;
import model.DoctorDTO;
import model.PatientDTO;
import model.StaffDTO;
import model.SpecialtyDTO;
import model.DegreeDTO;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DoctorReviewDTO;

/**
 * Class for managing doctor data.
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorDAO extends DBContext {

    public DoctorDTO getDoctorByStaffID(int staffID) {

        String query = "SELECT \n"
                + "	st.StaffID, st.JobStatus, st.Role, st.AccountName, st.AccountPassword,\n"
                + "	st.DayCreated, st.Avatar, st.Bio, st.FirstName, st.LastName,\n"
                + "	st.DOB, st.Gender, st.UserAddress, st.PhoneNumber, st.Email,\n"
                + "	st.Hidden, dt.DoctorID, dt.SpecialtyID, dt.YearExperience, sp.SpecialtyName,\n"
                + "	sp.Price\n"
                + "FROM [dbo].[Staff] st\n"
                + "JOIN [dbo].[Doctor] dt\n"
                + "ON dt.StaffID = st.StaffID\n"
                + "JOIN [dbo].[Specialty] sp\n"
                + "ON sp.SpecialtyID = dt.SpecialtyID\n"
                + "WHERE dt.StaffID = ?;";

        DoctorDTO doctor = null;
        Object[] params = {staffID};
        ResultSet rs = null;
        try {
            rs = executeSelectQuery(query, params);
            
            if (rs.next()) {
                
                StaffDTO staff = new StaffDTO();      
                
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setJobStatus(rs.getString("JobStatus"));
                staff.setRole(rs.getString("Role"));
                staff.setAccountName(rs.getString("AccountName"));
                staff.setAccountPassword(rs.getString("AccountPassword"));
                staff.setDaycreated(rs.getObject("DayCreated", Timestamp.class));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setDob(rs.getObject("DOB", Timestamp.class));
                staff.setGender(rs.getBoolean("Gender"));
                staff.setUserAddress(rs.getString("UserAddress"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setEmail(rs.getString("Email"));
                staff.setHidden(rs.getBoolean("Hidden"));
                
                SpecialtyDTO specialty = new SpecialtyDTO();
                specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
                specialty.setSpecialtyName(rs.getString("SpecialtyName"));
                specialty.setPrice(rs.getInt("Price"));
                
                doctor = new DoctorDTO();
                
                doctor.setStaffID(staff);
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setYearExperience(rs.getInt("YearExperience"));
                
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return doctor;
    }

    /**
     * Retrieves a specific doctor by their ID.
     *
     * @param doctorId The ID of the doctor to be retrieved.
     * @return A DoctorDTO object or null if not found.
     */
    public DoctorDTO getDoctorById(int doctorId) {

        String sql = "SELECT d.DoctorID, d.StaffID, d.SpecialtyID, d.YearExperience, "
                + "st.FirstName, st.LastName, st.PhoneNumber, st.Email, "
                + "st.Avatar, st.Bio, st.JobStatus, st.[Role], "
                + "s.SpecialtyName, s.Price "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "INNER JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE d.DoctorID = ? AND st.[Role] = 'Doctor'";

        DoctorDTO doctor = null;
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null && rs.next()) {
                doctor = createDoctorFromResultSet(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return doctor;
    }

    /**
     * Retrieves doctors by their specialty name.
     *
     * @param specialtyID
     * @return A list of DoctorDTO objects.
     */
    public List<DoctorDTO> getDoctorsBySpecialty(int specialtyID) {
        String sql = "SELECT d.DoctorID, d.YearExperience, d.SpecialtyID, "
                + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email, st.Avatar, st.Bio, st.JobStatus, st.Role, "
                + "s.SpecialtyName "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE d.SpecialtyID = ? AND st.Role = 'Doctor'";

        List<DoctorDTO> doctors = new ArrayList<>();
        Object[] params = {specialtyID};
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

    /**
     * Retrieves available doctors (JobStatus = 'Available').
     *
     * @return A list of available DoctorDTO objects.
     */
    public List<DoctorDTO> getAvailableDoctors() {

        List<DoctorDTO> doctors = new ArrayList<>();

        String sql = "SELECT d.DoctorID, d.StaffID, d.SpecialtyID, d.YearExperience, "
                + "st.FirstName, st.LastName, st.PhoneNumber, st.Email, "
                + "st.Avatar, st.Bio, st.JobStatus, st.[Role], "
                + "s.SpecialtyName, s.Price "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "INNER JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE st.JobStatus = 'Available' AND st.[Role] = 'Doctor'";

        Object[] params = {};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    DoctorDTO doctor = createDoctorFromResultSet(rs);
                    doctors.add(doctor);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return doctors;
    }

    /**
     * Search doctors by name and specialty only.
     *
     * @param searchName The doctor's name to search for (can be partial match).
     * @param specialtyName The specialty name to filter (null or empty for
     * all).
     * @return A list of DoctorDTO objects matching the search criteria.
     */
    public List<DoctorDTO> searchDoctors(String searchName, String specialtyName) {

        List<DoctorDTO> doctors = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT d.DoctorID, d.StaffID, d.SpecialtyID, d.YearExperience, "
                + "st.FirstName, st.LastName, st.PhoneNumber, st.Email, "
                + "st.Avatar, st.Bio, st.JobStatus, st.[Role], "
                + "s.SpecialtyName, s.Price "
                + "FROM Doctor d "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "INNER JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE st.[Role] = 'Doctor' AND st.JobStatus = 'Available'");

        // Build parameters list dynamically
        List<Object> paramsList = new ArrayList<>();

        // Add search conditions dynamically
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append(" AND (st.FirstName LIKE ? OR st.LastName LIKE ?)");
            String searchPattern = "%" + searchName.trim() + "%";
            paramsList.add(searchPattern);
            paramsList.add(searchPattern);
        }
        if (specialtyName != null && !specialtyName.trim().isEmpty()) {
            sql.append(" AND s.SpecialtyName = ?");
            paramsList.add(specialtyName.trim());
        }

        Object[] params = paramsList.toArray();
        ResultSet rs = executeSelectQuery(sql.toString(), params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    DoctorDTO doctor = createDoctorFromResultSet(rs);
                    doctors.add(doctor);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
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

        Object[] params = {};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    String[] specialty = new String[2];
                    specialty[0] = String.valueOf(rs.getInt("SpecialtyID"));
                    specialty[1] = rs.getString("SpecialtyName");
                    specialties.add(specialty);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return specialties;
    }

    /**
     * Builds and returns a DoctorDTO object from the current row of a
     * ResultSet.
     *
     * @param rs the ResultSet positioned at the current doctor record
     * @return a fully populated DoctorDTO object created from the ResultSet
     * data
     * @throws SQLException if any SQL access or column retrieval error occurs
     */
    private DoctorDTO createDoctorFromResultSet(ResultSet rs) throws SQLException {

        DoctorDTO doctor = new DoctorDTO();
        doctor.setDoctorID(rs.getInt("DoctorID"));
        doctor.setYearExperience(rs.getInt("YearExperience"));

        // Create StaffDTO
        StaffDTO staff = new StaffDTO();
        staff.setStaffID(rs.getInt("StaffID"));
        staff.setFirstName(rs.getString("FirstName"));
        staff.setLastName(rs.getString("LastName"));
        staff.setEmail(rs.getString("Email"));
        staff.setPhoneNumber(rs.getString("PhoneNumber"));
        staff.setAvatar(rs.getString("Avatar"));
        staff.setBio(rs.getString("Bio"));
        staff.setJobStatus(rs.getString("JobStatus"));
        staff.setRole(rs.getString("Role"));
        doctor.setStaffID(staff);

        // Create SpecialtyDTO
        SpecialtyDTO specialty = new SpecialtyDTO();
        specialty.setSpecialtyID(rs.getInt("SpecialtyID"));
        specialty.setSpecialtyName(rs.getString("SpecialtyName"));
        specialty.setPrice(rs.getDouble("Price"));
        doctor.setSpecialtyID(specialty);

        return doctor;
    }

    /**
     * Retrieves all academic degrees earned by a specific doctor.
     *
     * @param doctorId the ID of the doctor whose degrees are being retrieved
     * @return a list of DegreeDTO objects representing the doctor's degrees, or
     * an empty list if none are found or an error occurs
     */
    public List<DegreeDTO> getDoctorDegrees(int doctorId) {

        List<DegreeDTO> degrees = new ArrayList<>();

        String sql = "SELECT DegreeID, DegreeName, DoctorID "
                + "FROM Degree "
                + "WHERE DoctorID = ? ORDER BY DegreeID";

        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null) {
                while (rs.next()) {
                    DegreeDTO degree = new DegreeDTO();
                    degree.setDegreeID(rs.getInt("DegreeID"));
                    degree.setDegreeName(rs.getString("DegreeName"));
                    degrees.add(degree);
                }
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
     * Creates a new doctor review/feedback.
     *
     * @param patientId The ID of the patient creating the review.
     * @param doctorId The ID of the doctor being reviewed.
     * @param content The review content.
     * @param rateScore The rating score (1-5).
     * @return true if the review was created successfully, false otherwise.
     */
    public boolean createDoctorReview(int patientId, int doctorId, String content, int rateScore) {
        String sql = "INSERT INTO DoctorReview (PatientID, DoctorID, Content, RateScore, DateCreate, [Hidden]) "
                + "VALUES (?, ?, ?, ?, GETDATE(), 0)";

        Object[] params = {patientId, doctorId, content, rateScore};

        try {
            int rowsAffected = executeQuery(sql, params);
            return rowsAffected > 0;
        } catch (Exception ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    /**
     * Updates an existing doctor review/feedback.
     *
     * @param reviewId The ID of the review to update.
     * @param patientId The ID of the patient who created the review.
     * @param content The updated review content.
     * @param rateScore The updated rating score (1-5).
     * @return true if the review was updated successfully, false otherwise.
     */
    public boolean updateDoctorReview(int reviewId, int patientId, String content, int rateScore) {
        String sql = "UPDATE DoctorReview SET Content = ?, RateScore = ? "
                + "WHERE DoctorReviewID = ? AND PatientID = ?";

        Object[] params = {content, rateScore, reviewId, patientId};

        try {
            int rowsAffected = executeQuery(sql, params);
            return rowsAffected > 0;
        } catch (Exception ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    /**
     * Deletes a doctor review/feedback.
     *
     * @param reviewId The ID of the review to delete.
     * @param patientId The ID of the patient who created the review.
     * @return true if the review was deleted successfully, false otherwise.
     */
    public boolean deleteDoctorReview(int reviewId, int patientId) {
        String sql = "DELETE FROM DoctorReview WHERE DoctorReviewID = ? AND PatientID = ?";

        Object[] params = {reviewId, patientId};

        try {
            int rowsAffected = executeQuery(sql, params);
            return rowsAffected > 0;
        } catch (Exception ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    /**
     * Gets a specific review by ID and patient ID (for security).
     *
     * @param reviewId The ID of the review.
     * @param patientId The ID of the patient who created the review.
     * @return DoctorReviewDTO if found, null otherwise.
     */
    public DoctorReviewDTO getReviewByIdAndPatientId(int reviewId, int patientId) {
        String sql = "SELECT dr.DoctorReviewID, dr.Content, dr.RateScore, dr.DateCreate, "
                + "d.DoctorID, st.FirstName AS DoctorFirstName, st.LastName AS DoctorLastName, "
                + "s.SpecialtyName "
                + "FROM DoctorReview dr "
                + "INNER JOIN Doctor d ON dr.DoctorID = d.DoctorID "
                + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
                + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
                + "WHERE dr.DoctorReviewID = ? AND dr.PatientID = ?";

        Object[] params = {reviewId, patientId};
        ResultSet rs = executeSelectQuery(sql, params);

        try {
            if (rs != null && rs.next()) {
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

                return review;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return null;
    }

    /**
     * Checks if a patient has already reviewed a specific doctor.
     *
     * @param patientId The ID of the patient.
     * @param doctorId The ID of the doctor.
     * @return true if the patient has already reviewed this doctor, false
     * otherwise.
     */
    public boolean hasPatientReviewedDoctor(int patientId, int doctorId) {
        String sql = "SELECT COUNT(*) as ReviewCount FROM DoctorReview WHERE PatientID = ? AND DoctorID = ?";

        Object[] params = {patientId, doctorId};
        ResultSet rs = executeSelectQuery(sql, params);

        try {
            if (rs != null && rs.next()) {
                return rs.getInt("ReviewCount") > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return false;
    }

}
