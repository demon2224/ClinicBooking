/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import model.PatientDTO;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Patient Data Access Object
 *
 * @author Le Anh Tuan - CE180905
 */
public class PatientDAO extends DBContext {

    /**
     * Get patient by ID
     *
     * @param patientId The ID of the patient to retrieve
     * @return PatientDTO object with complete information, null if not found
     */
    public PatientDTO getPatientById(int patientId) {
        String sql = "SELECT PatientID, AccountName, AccountPassword, DayCreated, Avatar, "
                + "FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Email "
                + "FROM Patient WHERE PatientID = ?";
        ResultSet rs = null;
        try {
            Object[] params = {patientId};
            rs = executeSelectQuery(sql, params);

            if (rs.next()) {
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setAccountName(rs.getString("AccountName"));
                patient.setAccountPassword(rs.getString("AccountPassword"));
                patient.setDayCreated(rs.getTimestamp("DayCreated"));
                patient.setAvatar(rs.getString("Avatar"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setDob(rs.getTimestamp("DOB"));
                patient.setGender(rs.getBoolean("Gender"));
                patient.setUserAddress(rs.getString("UserAddress"));
                patient.setPhoneNumber(rs.getString("PhoneNumber"));
                patient.setEmail(rs.getString("Email"));

                return patient;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return null;
    }

    /**
     * Get all patients
     *
     * @return List of PatientDTO
     */
    public List<PatientDTO> getAllPatients() {
        List<PatientDTO> patients = new ArrayList<>();
        String sql = "SELECT PatientID, AccountName, FirstName, LastName, PhoneNumber, Email "
                + "FROM Patient ORDER BY PatientID";

        ResultSet rs = null;
        try {
            rs = executeSelectQuery(sql, null);
            while (rs.next()) {
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setAccountName(rs.getString("AccountName"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setPhoneNumber(rs.getString("PhoneNumber"));
                patient.setEmail(rs.getString("Email"));

                patients.add(patient);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return patients;
    }

    /**
     * Get patient by account name (for login)
     *
     * @param accountName Account name
     * @return PatientDTO object or null if not found
     */
    public PatientDTO getPatientByAccountName(String accountName) {
        String sql = "SELECT PatientID, AccountName, AccountPassword, DayCreated, Avatar, "
                + "FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Email "
                + "FROM Patient WHERE AccountName = ?";
        ResultSet rs = null;
        try {
            Object[] params = {accountName};
            rs = executeSelectQuery(sql, params);

            if (rs.next()) {
                PatientDTO patient = new PatientDTO();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setAccountName(rs.getString("AccountName"));
                patient.setAccountPassword(rs.getString("AccountPassword"));
                patient.setDayCreated(rs.getTimestamp("DayCreated"));
                patient.setAvatar(rs.getString("Avatar"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setDob(rs.getTimestamp("DOB"));
                patient.setGender(rs.getBoolean("Gender"));
                patient.setUserAddress(rs.getString("UserAddress"));
                patient.setPhoneNumber(rs.getString("PhoneNumber"));
                patient.setEmail(rs.getString("Email"));

                return patient;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return null;
    }

    private String hashSha256(String raw) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] mess = md.digest(raw.getBytes());

            StringBuilder sb = new StringBuilder();
            for (byte b : mess) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }
    }

    public PatientDTO getPatientByUsernameAndPassword(String username, String password) {

        String query = "SELECT pt.PatientID, pt.AccountName, pt.AccountPassword, pt.DayCreated, pt.Avatar,\n"
                + "	pt.Bio, pt.FirstName, pt.LastName, pt.DOB, pt.Gender,\n"
                + "	pt.UserAddress, pt.PhoneNumber, pt.Email\n"
                + "FROM [dbo].[Patient] pt\n"
                + "WHERE pt.Hidden = 0\n"
                + "AND pt.AccountName = ?\n"
                + "AND pt.AccountPassword = ?;";
        Object[] params = {username, hashSha256(password)};
        ResultSet rs = null;
        PatientDTO patient = null;
        try {
            rs = executeSelectQuery(query, params);

            if (rs.next()) {
                patient = new PatientDTO();

                patient.setPatientID(rs.getInt("PatientID"));
                patient.setAccountName(rs.getString("AccountName"));
                patient.setAccountPassword(rs.getString("AccountPassword"));
                patient.setDayCreated(rs.getTimestamp("DayCreated"));
                patient.setAvatar(rs.getString("Avatar"));
                patient.setBio(rs.getString("Bio"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setDob(rs.getTimestamp("DOB"));
                patient.setGender(rs.getBoolean("Gender"));
                patient.setUserAddress(rs.getString("UserAddress"));
                patient.setPhoneNumber(rs.getString("PhoneNumber"));
                patient.setEmail(rs.getString("Email"));
                ;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return patient;
    }

    /**
     * Check if email already exists for another patient
     *
     * @param email Email to check
     * @param excludePatientId Patient ID to exclude from check (for update)
     * @return true if email exists for another patient
     */
    public boolean isEmailExistForOtherPatient(String email, int excludePatientId) {
        String sql = "SELECT COUNT(*) as count FROM Patient "
                + "WHERE Email = ? AND PatientID != ? AND Hidden = 0";
        ResultSet rs = null;
        try {
            Object[] params = {email, excludePatientId};
            rs = executeSelectQuery(sql, params);

            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return false;
    }

    /**
     * Update patient profile information
     *
     * @param patient Patient object with updated data
     * @return true if successful
     */
    public boolean updatePatientProfile(PatientDTO patient) {
        String sql = "UPDATE Patient SET FirstName = ?, LastName = ?, PhoneNumber = ?, "
                + "Email = ?, DOB = ?, Gender = ?, UserAddress = ?, Avatar = ? "
                + "WHERE PatientID = ?";

        Object[] params = {
            patient.getFirstName(),
            patient.getLastName(),
            patient.getPhoneNumber(),
            patient.getEmail(),
            patient.getDob(),
            patient.isGender(),
            patient.getUserAddress(),
            patient.getAvatar(),
            patient.getPatientID()
        };
        return executeQuery(sql, params) > 0;
    }

    /**
     * Update patient password
     *
     * @param patientId Patient ID
     * @param currentPassword Current password (for verification)
     * @param newPassword New password (will be hashed)
     * @return true if successful, false if current password incorrect or update failed
     */
    public boolean updatePatientPassword(int patientId, String currentPassword, String newPassword) {
        // First verify current password
        String sqlVerify = "SELECT COUNT(*) as count FROM Patient "
                + "WHERE PatientID = ? AND AccountPassword = ? AND Hidden = 0";
        ResultSet rs = null;

        try {
            Object[] paramsVerify = {patientId, hashSha256(currentPassword)};
            rs = executeSelectQuery(sqlVerify, paramsVerify);

            if (rs.next() && rs.getInt("count") > 0) {
                // Current password is correct, update to new password
                closeResources(rs);

                String sqlUpdate = "UPDATE Patient SET AccountPassword = ? WHERE PatientID = ?";
                Object[] paramsUpdate = {hashSha256(newPassword), patientId};

                return executeQuery(sqlUpdate, paramsUpdate) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return false;
    }

    /**
     * Search patients by keyword (used for autocomplete)
     *
     * @param keyword the string user typed (partial name)
     * @return list of top 10 matched patients (by first name or last name)
     */
    public List<PatientDTO> searchPatientsByName(String keyword) {
        List<PatientDTO> list = new ArrayList<>();
        String sql = "SELECT TOP 10 PatientID, FirstName, LastName "
                + "FROM Patient "
                + "WHERE FirstName LIKE ? OR LastName LIKE ? ORDER BY FirstName ASC";
        try {
            ResultSet rs = executeSelectQuery(sql, new Object[]{"%" + keyword + "%", "%" + keyword + "%"});
            while (rs.next()) {
                PatientDTO p = new PatientDTO();
                p.setPatientID(rs.getInt("PatientID"));
                p.setFirstName(rs.getString("FirstName"));
                p.setLastName(rs.getString("LastName"));
                list.add(p);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean register(String username, String password, String firstName, String lastName, String dob, String gender, String phoneNumber, String email) {
        String query = "INSERT INTO [dbo].[Patient] (AccountName, AccountPassword, Avatar, FirstName, LastName, DOB, Gender, PhoneNumber, Email)\n"
                + "VALUES\n"
                + "	(?, ?, NULL, ?, ?, ?, ?, ?, ?);";
        Object[] params = {username, hashSha256(password), firstName, lastName, dob, gender, phoneNumber, email};

        int result = executeQuery(query, params);
        closeResources(null);

        return result != 0;
    }

    public boolean isExistUsername(String username) {
        String query = "SELECT TOP 1 pt.AccountName\n"
                + "FROM [dbo].[Patient] pt\n"
                + "WHERE pt.AccountName = ?;";
        Object[] params = {username};
        ResultSet rs = null;
        boolean isExist = false;

        try {
            rs = executeSelectQuery(query, params);
            isExist = rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(PatientDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return isExist;
    }

    public int getTotalPatients() {
        int countPatient = 0;
        String sql = "SELECT COUNT(*) AS Total FROM Patient WHERE Hidden = 0";
        ResultSet rs = null;
        try {
            rs = executeSelectQuery(sql);
            if (rs.next()) {
                countPatient = rs.getInt("Total");
            }
        } catch (SQLException e) {
            Logger.getLogger(PatientDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(rs);
        }
        return countPatient;
    }

    public boolean isExistEmail(String email) {
        String query = "SELECT TOP 1 pt.Email\n"
                + "FROM [dbo].[Patient] pt\n"
                + "WHERE pt.Email = ?;";
        Object[] params = {email};
        ResultSet rs = executeSelectQuery(query, params);
        boolean isExist = false;

        try {
            isExist = rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(PatientDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return isExist;
    }

    public boolean updatePassword(String password, String email) {
        String query = "UPDATE [dbo].[Patient]\n"
                + "SET AccountPassword = ?\n"
                + "WHERE Email = ?;";
        Object[] params = {hashSha256(password), email};

        int result = executeQuery(query, params);
        closeResources(null);

        return result != 0;
    }
}
