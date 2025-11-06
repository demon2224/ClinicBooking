/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.DoctorDTO;
import model.StaffDTO;
import utils.DBContext;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class AdminDAO extends DBContext {

    /**
     * Get all staff accounts (for admin view)
     *
     * @return list of staff
     */
    public List<StaffDTO> getAllStaffAccounts() {
        List<StaffDTO> list = new ArrayList<>();
        String sql = "SELECT StaffID, AccountName, FirstName, LastName, Role, PhoneNumber, DayCreated, [Hidden] "
                + "FROM Staff "
                + "ORDER BY [Hidden] ASC";
        ResultSet rs = null;

        try {
            rs = executeSelectQuery(sql);

            while (rs.next()) {
                StaffDTO s = new StaffDTO();
                s.setStaffID(rs.getInt("StaffID"));
                s.setAccountName(rs.getString("AccountName"));
                s.setFirstName(rs.getString("FirstName"));
                s.setLastName(rs.getString("LastName"));
                s.setRole(rs.getString("Role"));
                s.setPhoneNumber(rs.getString("PhoneNumber"));
                s.setDaycreated(rs.getTimestamp("DayCreated"));
                s.setHidden(rs.getBoolean("Hidden"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return list;
    }

    /**
     * Get staff account by ID
     */
    public StaffDTO getStaffById(int staffID) {
        StaffDTO s = null;
        String sql = "SELECT StaffID, JobStatus, [Role], AccountName, DayCreated, Avatar, "
                + "FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, [Hidden] "
                + "FROM Staff WHERE StaffID = ?";
        ResultSet rs = null;

        try {
            rs = executeSelectQuery(sql, new Object[]{staffID});
            if (rs.next()) {
                s = new StaffDTO();
                s.setStaffID(rs.getInt("StaffID"));
                s.setJobStatus(rs.getString("JobStatus"));
                s.setRole(rs.getString("Role"));
                s.setAccountName(rs.getString("AccountName"));
                s.setDaycreated(rs.getTimestamp("DayCreated"));
                s.setAvatar(rs.getString("Avatar"));
                s.setFirstName(rs.getString("FirstName"));
                s.setLastName(rs.getString("LastName"));
                s.setDob(rs.getTimestamp("DOB"));
                s.setGender(rs.getBoolean("Gender"));
                s.setUserAddress(rs.getString("UserAddress"));
                s.setPhoneNumber(rs.getString("PhoneNumber"));
                s.setHidden(rs.getBoolean("Hidden"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return s;
    }

    /**
     * Search staff accounts by name or username
     */
    public List<StaffDTO> searchStaffAccounts(String keyword) {
        List<StaffDTO> list = new ArrayList<>();
        String sql = "SELECT StaffID, AccountName, FirstName, LastName, Role, PhoneNumber, DayCreated, Hidden "
                + "FROM Staff "
                + "WHERE AccountName LIKE ? OR FirstName LIKE ? OR LastName LIKE ?";
        ResultSet rs = null;

        try {
            String searchPattern = "%" + keyword + "%";
            rs = executeSelectQuery(sql, new Object[]{searchPattern, searchPattern, searchPattern});

            while (rs.next()) {
                StaffDTO s = new StaffDTO();
                s.setStaffID(rs.getInt("StaffID"));
                s.setAccountName(rs.getString("AccountName"));
                s.setFirstName(rs.getString("FirstName"));
                s.setLastName(rs.getString("LastName"));
                s.setRole(rs.getString("Role"));
                s.setPhoneNumber(rs.getString("PhoneNumber"));
                s.setDaycreated(rs.getTimestamp("DayCreated"));
                s.setHidden(rs.getBoolean("Hidden"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return list;
    }

    public boolean updateStaffAccount(int staffID, String accountName, String fullName, String role,
            String phone, String dob, boolean gender, String address, boolean hidden) {
        String sql = "UPDATE Staff SET AccountName=?, FirstName=?, LastName=?, Role=?, PhoneNumber=?, DOB=?, Gender=?, UserAddress=?, Hidden=? "
                + "WHERE StaffID=?";
        String[] nameParts = fullName.trim().split("\\s+", 2);
        String firstName = nameParts[0];
        String lastName = nameParts.length > 1 ? nameParts[1] : "";

        Object[] params = {accountName, firstName, lastName, role, phone, dob, gender, address, hidden, staffID};
        int rows = executeQuery(sql, params);
        closeResources(null);
        return rows > 0;
    }

//    public int insertStaffAccount(String accountName, String fullName, String role,
//            String phone, String dob, boolean gender, String address, boolean hidden) {
//        String sql = "INSERT INTO Staff (AccountName, FirstName, LastName, Role, PhoneNumber, DOB, Gender, UserAddress, Hidden, DayCreated) "
//                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
//        String[] nameParts = fullName.trim().split("\\s+", 2);
//        String firstName = nameParts[0];
//        String lastName = nameParts.length > 1 ? nameParts[1] : "";
//
//        Object[] params = {accountName, firstName, lastName, role, phone, dob, gender, address, hidden};
//        int generatedId = executeInsert(sql, params);
//        closeResources(null);
//        return generatedId;
//    }

    public boolean deleteStaffAccount(int staffID) {
        String sql = "UPDATE Staff SET Hidden = 1 WHERE StaffID = ?";
        Object[] params = {staffID};
        int rows = executeQuery(sql, params);
        closeResources(null);
        return rows > 0;
    }

}
