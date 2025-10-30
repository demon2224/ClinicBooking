/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.DBContext;
import model.DoctorDTO;
import model.DoctorDegreeDTO;
import model.DegreeDTO;
import model.SpecialtyDTO;
import model.StaffDTO;
import model.DoctorReviewDTO;
import model.PatientDTO;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.RoleDTO;

/**
 * Class for managing doctor data.
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorDAO extends DBContext {

    // public DoctorDTO getDoctorById(int DoctorId) {
    // String sql = "select s.StaffID,\n"
    // + "d.DoctorID,\n"
    // + "r.RoleID,\n"
    // + "r.RoleName,\n"
    // + "CONCAT(s.LastName, ' ' , s.FirstName) as DoctorName,\n"
    // + "s.AccountName,\n"
    // + "s.AccountPassword,\n"
    // + "s.DayCreated,\n"
    // + "s.Avatar,\n"
    // + "s.DOB,CASE WHEN s.Gender = 1 THEN 'Male' ELSE 'Female' END as Gender,\n"
    // + "s.UserAddress,\n"
    // + "s.PhoneNumber,\n"
    // + "s.Email\n"
    // + "from Doctor d\n"
    // + "join Staff s on s.StaffID = d.StaffID\n"
    // + "join Role r on r.RoleID = s.RoleID\n"
    // + "where DoctorID = ?";
    // ResultSet rs = null;
    // try {
    // Object[] params = {DoctorId};
    // rs = executeSelectQuery(sql, params);

    // if (rs.next()) {
    // DoctorDTO doctor = new DoctorDTO();
    // StaffDTO staff = new StaffDTO();
    // RoleDTO role = new RoleDTO();

    // // set Staff info
    // staff.setStaffID(rs.getInt("StaffID"));
    // staff.setAccountName(rs.getString("AccountName"));
    // staff.setAccountPassword(rs.getString("AccountPassword"));
    // staff.setDaycreated(rs.getTimestamp("DayCreated"));
    // staff.setAvatar(rs.getString("Avatar"));
    // staff.setDob(rs.getTimestamp("DOB"));
    // staff.setGender(rs.getBoolean("Gender"));
    // staff.setUserAddress(rs.getString("UserAddress"));
    // staff.setPhoneNumber(rs.getString("PhoneNumber"));
    // staff.setEmail(rs.getString("Email"));

    // // set Role info (nếu có)
    // role.setRoleID(rs.getInt("RoleID"));
    // role.setRoleName(rs.getString("RoleName"));
    // staff.setRoleID(role);

    // // set Doctor info
    // doctor.setDoctorID(rs.getInt("DoctorID"));
    // doctor.setStaffID(staff);

    // return doctor;
    // }
    // } catch (SQLException e) {
    // e.printStackTrace();
    // } finally {
    // closeResources(rs);
    // }

    // return null;
    // }

    // /**
    // * Retrieves a specific doctor by their ID.
    // *
    // * @param doctorId The ID of the doctor to be retrieved.
    // * @return A Doctor object or null if not found.
    // */
    // public DoctorDTO getDoctorById(int doctorId) {
    //
    // String sql = "SELECT d.DoctorID, d.YearExperience, d.SpecialtyID, "
    // + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email,
    // st.Avatar, st.Bio, st.JobStatus, st.RoleID, "
    // + "s.SpecialtyName "
    // + "FROM Doctor d "
    // + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
    // + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
    // + "WHERE d.DoctorID = ? AND st.RoleID = 1";
    //
    // DoctorDTO doctor = null;
    // Object[] params = { doctorId };
    // ResultSet rs = executeSelectQuery(sql, params);
    // try {
    // if (rs != null && rs.next()) {
    // doctor = createDoctorDTOFromResultSet(rs);
    // }
    // } catch (SQLException ex) {
    // Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
    // } finally {
    // closeResources(rs);
    // }
    // return doctor;
    // }
    //

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
        Object[] params = { doctorId };
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
}
// /**
// * Retrieves doctors by their specialty name.
// *
// * @param specialtyName The name of the specialty.
// * @return A list of Doctor objects.
// */
// public List<DoctorDTO> getDoctorsBySpecialty(String specialtyName) {
//
// List<DoctorDTO> doctors = new ArrayList<>();
//
// String sql = "SELECT d.DoctorID, d.YearExperience, d.SpecialtyID, "
// + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email,
// st.Avatar, st.Bio, st.JobStatus, st.RoleID, "
// + "s.SpecialtyName "
// + "FROM Doctor d "
// + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
// + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
// + "WHERE s.SpecialtyName = ? AND st.RoleID = 1";
//
// Object[] params = { specialtyName };
// ResultSet rs = executeSelectQuery(sql, params);
// try {
// if (rs != null) {
// while (rs.next()) {
// DoctorDTO doctor = createDoctorDTOFromResultSet(rs);
// doctors.add(doctor);
// }
// }
// } catch (SQLException ex) {
// Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
// } finally {
// closeResources(rs);
// }
// return doctors;
// }
//
// /**
// * Retrieves available doctors (JobStatusID = 1).
// *
// * @return A list of available Doctor objects.
// */
// public List<DoctorDTO> getAvailableDoctors() {
//
// List<DoctorDTO> doctors = new ArrayList<>();
//
// String sql = "SELECT d.DoctorID, d.YearExperience, d.SpecialtyID, "
// + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email,
// st.Avatar, st.Bio, st.JobStatus, st.RoleID, "
// + "s.SpecialtyName "
// + "FROM Doctor d "
// + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
// + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
// + "WHERE st.JobStatus = 'Available' AND st.RoleID = 1";
//
// Object[] params = {};
// ResultSet rs = executeSelectQuery(sql, params);
// try {
// if (rs != null) {
// while (rs.next()) {
// DoctorDTO doctor = createDoctorDTOFromResultSet(rs);
// doctors.add(doctor);
// }
// }
// } catch (SQLException ex) {
// Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
// } finally {
// closeResources(rs);
// }
// return doctors;
// }
//
// /**
// * Search doctors by name, specialty, job status, and minimum year experience.
// *
// * @param searchName The doctor's name to search for (can be partial match).
// * @param specialtyName The specialty name to filter (null or empty for all).
// * @param jobStatusId The job status ID to filter (0 or null for all).
// * @param minExperience Minimum years of experience (0 or null for all).
// * @return A list of Doctor objects matching the search criteria.
// */
// public List<DoctorDTO> searchDoctors(String searchName, String specialtyName,
// Integer jobStatusId,
// Integer minExperience) {
//
// List<DoctorDTO> doctors = new ArrayList<>();
//
// StringBuilder sql = new StringBuilder(
// "SELECT d.DoctorID, d.YearExperience, d.SpecialtyID, "
// + "st.StaffID, st.FirstName, st.LastName, st.PhoneNumber, st.Email,
// st.Avatar, st.Bio, st.JobStatus, st.RoleID, "
// + "s.SpecialtyName "
// + "FROM Doctor d "
// + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
// + "LEFT JOIN Specialty s ON d.SpecialtyID = s.SpecialtyID "
// + "WHERE st.RoleID = 1");
//
// // Build parameters list dynamically
// List<Object> paramsList = new ArrayList<>();
//
// // Add search conditions dynamically
// if (searchName != null && !searchName.trim().isEmpty()) {
// sql.append(" AND (st.FirstName LIKE ? OR st.LastName LIKE ?)");
// String searchPattern = "%" + searchName.trim() + "%";
// paramsList.add(searchPattern);
// paramsList.add(searchPattern);
// }
// if (specialtyName != null && !specialtyName.trim().isEmpty()) {
// sql.append(" AND s.SpecialtyName = ?");
// paramsList.add(specialtyName.trim());
// }
// if (jobStatusId != null && jobStatusId > 0) {
// // Map jobStatusId=1 to 'Available', else no filter (can extend later)
// if (jobStatusId == 1) {
// sql.append(" AND st.JobStatus = 'Available'");
// }
// }
// if (minExperience != null && minExperience > 0) {
// sql.append(" AND d.YearExperience >= ?");
// paramsList.add(minExperience);
// }
// Object[] params = paramsList.toArray();
// ResultSet rs = executeSelectQuery(sql.toString(), params);
// try {
// if (rs != null) {
// while (rs.next()) {
// DoctorDTO doctor = createDoctorDTOFromResultSet(rs);
// doctors.add(doctor);
// }
// }
// } catch (SQLException ex) {
// Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
// } finally {
// closeResources(rs);
// }
// return doctors;
// }
//
// /**
// * Get all specialties from the database.
// *
// * @return A list of specialty names and IDs.
// */
// public List<String[]> getAllSpecialties() {
//
// List<String[]> specialties = new ArrayList<>();
//
// String sql = "SELECT SpecialtyID, SpecialtyName FROM Specialty ORDER BY
// SpecialtyName";
//
// Object[] params = {};
// ResultSet rs = executeSelectQuery(sql, params);
// try {
// if (rs != null) {
// while (rs.next()) {
// String[] specialty = new String[2];
// specialty[0] = String.valueOf(rs.getInt("SpecialtyID"));
// specialty[1] = rs.getString("SpecialtyName");
// specialties.add(specialty);
// }
// }
// } catch (SQLException ex) {
// Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
// } finally {
// closeResources(rs);
// }
// return specialties;
// }
//
// /**
// * Retrieves a list of reviews for a specific doctor.
// *
// * @param doctorId the ID of the doctor whose reviews are being retrieved
// * @return list of DoctorReviewDTO
// */
// public List<DoctorReviewDTO> getReviewsByDoctorId(int doctorId) {
// List<DoctorReviewDTO> reviews = new ArrayList<>();
// String sql = "SELECT dr.DoctorReviewID, dr.PatientID, dr.DoctorID,
// dr.Content, dr.RateScore, dr.DateCreate, "
// + "pt.FirstName AS PatientFirstName, pt.LastName AS PatientLastName,
// pt.Avatar AS PatientAvatar "
// + "FROM DoctorReview dr "
// + "INNER JOIN Patient pt ON dr.PatientID = pt.PatientID "
// + "WHERE dr.DoctorID = ? ORDER BY dr.DateCreate DESC";
//
// Object[] params = { doctorId };
// ResultSet rs = executeSelectQuery(sql, params);
// try {
// if (rs != null) {
// while (rs.next()) {
// DoctorReviewDTO review = new DoctorReviewDTO();
// review.setDoctorReviewID(rs.getInt("DoctorReviewID"));
//
// PatientDTO patient = new PatientDTO();
// patient.setPatientID(rs.getInt("PatientID"));
// patient.setFirstName(rs.getString("PatientFirstName"));
// patient.setLastName(rs.getString("PatientLastName"));
// patient.setAvatar(rs.getString("PatientAvatar"));
// review.setPatientID(patient);
//
// DoctorDTO doctor = new DoctorDTO();
// doctor.setDoctorID(rs.getInt("DoctorID"));
// review.setDoctorID(doctor);
//
// review.setContent(rs.getString("Content"));
// review.setRateScore(rs.getInt("RateScore"));
// review.setDateCreate(rs.getTimestamp("DateCreate"));
//
// reviews.add(review);
// }
// }
// } catch (SQLException ex) {
// Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
// } finally {
// closeResources(rs);
// }
// return reviews;
// }
//
// /**
// * Counts and returns the total number of reviews for a doctor.
// *
// * @param doctorId
// * @return
// */
// public int getReviewCountByDoctorId(int doctorId) {
// String sql = "SELECT COUNT(*) AS ReviewCount FROM DoctorReview WHERE DoctorID
// = ?";
// Object[] params = { doctorId };
// ResultSet rs = executeSelectQuery(sql, params);
// try {
// if (rs != null && rs.next()) {
// return rs.getInt("ReviewCount");
// }
// } catch (SQLException ex) {
// Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
// } finally {
// closeResources(rs);
// }
// return 0;
// }
//
// /**
// * Retrieves a list of reviews written by a specific patient (user).
// * Includes basic doctor info (name) via Staff join.
// */
// public List<DoctorReviewDTO> getReviewsByPatientId(int patientId) {
// List<DoctorReviewDTO> reviews = new ArrayList<>();
// String sql = "SELECT dr.DoctorReviewID, dr.PatientID, dr.DoctorID,
// dr.Content, dr.RateScore, dr.DateCreate, "
// + "st.FirstName AS DoctorFirstName, st.LastName AS DoctorLastName "
// + "FROM DoctorReview dr "
// + "INNER JOIN Doctor d ON dr.DoctorID = d.DoctorID "
// + "INNER JOIN Staff st ON d.StaffID = st.StaffID "
// + "WHERE dr.PatientID = ? ORDER BY dr.DateCreate DESC";
//
// Object[] params = { patientId };
// ResultSet rs = executeSelectQuery(sql, params);
// try {
// if (rs != null) {
// while (rs.next()) {
// DoctorReviewDTO review = new DoctorReviewDTO();
// review.setDoctorReviewID(rs.getInt("DoctorReviewID"));
//
// PatientDTO patient = new PatientDTO();
// patient.setPatientID(rs.getInt("PatientID"));
// review.setPatientID(patient);
//
// DoctorDTO doctor = new DoctorDTO();
// doctor.setDoctorID(rs.getInt("DoctorID"));
// StaffDTO staff = new StaffDTO();
// staff.setFirstName(rs.getString("DoctorFirstName"));
// staff.setLastName(rs.getString("DoctorLastName"));
// doctor.setStaffID(staff);
// review.setDoctorID(doctor);
//
// review.setContent(rs.getString("Content"));
// review.setRateScore(rs.getInt("RateScore"));
// review.setDateCreate(rs.getTimestamp("DateCreate"));
// reviews.add(review);
// }
// }
// } catch (SQLException ex) {
// Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
// } finally {
// closeResources(rs);
// }
// return reviews;
// }
//
//
// /**
// * Retrieves all academic degrees earned by a specific doctor.
// *
// * @param doctorId the ID of the doctor whose degrees are being retrieved
// * @return a list of DoctorDegree objects representing the doctor's degrees,
// or
// * an
// * empty list if none are found or an error occurs
// */
// public List<DoctorDegreeDTO> getDoctorDegrees(int doctorId) {
//
// List<DoctorDegreeDTO> degrees = new ArrayList<>();
//
// String sql = "SELECT dd.DoctorID, dd.DegreeID, dd.DateEarn, dd.Grantor,
// d.DegreeName "
// + "FROM DoctorDegree dd INNER JOIN Degree d ON dd.DegreeID = d.DegreeID "
// + "WHERE dd.DoctorID = ? ORDER BY dd.DateEarn DESC";
//
// Object[] params = { doctorId };
// ResultSet rs = executeSelectQuery(sql, params);
// try {
// if (rs != null) {
// while (rs.next()) {
// DoctorDegreeDTO doctorDegree = new DoctorDegreeDTO();
//
// DoctorDTO doctor = new DoctorDTO();
// doctor.setDoctorID(rs.getInt("DoctorID"));
// doctorDegree.setDoctorID(doctor);
//
// DegreeDTO degreeDTO = new DegreeDTO();
// degreeDTO.setDegreeID(rs.getInt("DegreeID"));
// degreeDTO.setDegreeName(rs.getString("DegreeName"));
// doctorDegree.setDegreeID(degreeDTO);
//
// doctorDegree.setDateEarn(rs.getTimestamp("DateEarn"));
// doctorDegree.setGrantor(rs.getString("Grantor"));
//
// degrees.add(doctorDegree);
// }
// }
// } catch (SQLException ex) {
// Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
// } finally {
// closeResources(rs);
// }
// return degrees;
// }
