/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.PatientDTO;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
}