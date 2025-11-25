/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.PatientDTO;
import model.StaffDTO;
import utils.DBContext;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class StaffDAO extends DBContext {

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
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }
    }

    public StaffDTO getStaffByUsernameAndPassword(String username, String password) {

        String query = "SELECT st.StaffID, st.JobStatus, st.Role, st.AccountName, st.AccountPassword, st.DayCreated, st.Avatar,\n"
                + "	st.Bio, st.FirstName, st.LastName, st.DOB, st.Gender,\n"
                + "	st.UserAddress, st.PhoneNumber, st.Email\n"
                + "FROM [dbo].[Staff] st\n"
                + "WHERE st.Hidden = 0\n"
                + "AND NOT st.JobStatus = 'Retired'\n"
                + "AND st.AccountName = ?\n"
                + "AND st.AccountPassword = ?;";
        Object[] params = {username, hashSha256(password)};
        ResultSet rs = null;
        StaffDTO staff = null;
        try {
            rs = executeSelectQuery(query, params);

            if (rs.next()) {
                staff = new StaffDTO();

                staff.setStaffID(rs.getInt("StaffID"));
                staff.setJobStatus(rs.getString("JobStatus"));
                staff.setRole(rs.getString("Role"));
                staff.setAccountName(rs.getString("AccountName"));
                staff.setAccountPassword(rs.getString("AccountPassword"));
                staff.setDaycreated(rs.getTimestamp("DayCreated"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setBio(rs.getString("Bio"));
                staff.setFirstName(rs.getString("FirstName"));
                staff.setLastName(rs.getString("LastName"));
                staff.setDob(rs.getTimestamp("DOB"));
                staff.setGender(rs.getBoolean("Gender"));
                staff.setUserAddress(rs.getString("UserAddress"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setEmail(rs.getString("Email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return staff;
    }

    // =========================== CRUD FOR ADMIN ===========================
    public List<StaffDTO> getAllStaffAccounts() {
        List<StaffDTO> list = new ArrayList<>();
        String sql = "SELECT StaffID, AccountName, FirstName, LastName, Role, PhoneNumber, DayCreated, Hidden "
                + "FROM Staff "
                + "ORDER BY Hidden ASC, DayCreated DESC;";

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

    public List<StaffDTO> getRecentStaffList(int limit) {
        List<StaffDTO> list = new ArrayList<>();
        // Giới hạn limit để an toàn
        if (limit <= 0) {
            limit = 10;
        }
        if (limit > 100) {
            limit = 100;
        }

        String sql = "SELECT TOP (" + limit + ") StaffID, AccountName, FirstName, LastName, Role, PhoneNumber, DayCreated, Hidden "
                + "FROM Staff "
                + "ORDER BY Hidden ASC, DayCreated DESC;";
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

    public StaffDTO getStaffById(int staffID) {
        StaffDTO s = null;
        String sql = "SELECT StaffID, JobStatus, Role, AccountName, DayCreated, Avatar, \n"
                + "       FirstName, LastName, DOB, Gender, UserAddress, PhoneNumber, Hidden \n"
                + "FROM Staff \n"
                + "WHERE StaffID = ?;";

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

    public List<StaffDTO> searchStaffAccounts(String keyword) {
        List<StaffDTO> list = new ArrayList<>();
        String sql = "SELECT StaffID, AccountName, FirstName, LastName, Role, PhoneNumber, DayCreated, Hidden \n"
                + "FROM Staff \n"
                + "WHERE AccountName LIKE ? OR FirstName LIKE ? OR LastName LIKE ?;";

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

    public int addStaffAccount(String accountName, String rawPassword, String fullName, String role,
            String phone, String jobStatus, String dob, boolean gender,
            String address, boolean hidden) {

        int staffID = -1;
        ResultSet rs = null;
        try {
            String hashedPassword = hashSha256(rawPassword);

            String[] parts = fullName.trim().split(" ", 2);
            String firstName = parts.length > 1 ? parts[0] : fullName;
            String lastName = parts.length > 1 ? parts[1] : "";

            String sql = "INSERT INTO Staff ( "
                    + "    AccountName, AccountPassword, Role, PhoneNumber, JobStatus, "
                    + "    DOB, Gender, UserAddress, Hidden, FirstName, LastName, DayCreated "
                    + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE()); "
                    + "SELECT SCOPE_IDENTITY() AS NewStaffID;";

            Object[] params = {
                accountName, hashedPassword, role, phone, jobStatus,
                dob, gender, address, hidden, firstName, lastName
            };

            rs = executeSelectQuery(sql, params);
            if (rs != null && rs.next()) {
                staffID = rs.getInt("NewStaffID");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }
        return staffID;
    }

    public boolean updateStaffAccount(int staffID, String accountName, String fullName, String role,
            String phone, String jobStatus, String dob,
            boolean gender, String address, boolean hidden) {

        String sql = "UPDATE Staff \n"
                + "SET AccountName=?, FirstName=?, LastName=?, Role=?, PhoneNumber=?, JobStatus=?, \n"
                + "    DOB=?, Gender=?, UserAddress=?, Hidden=? \n"
                + "WHERE StaffID=?;";

        String[] nameParts = fullName.trim().split("\\s+", 2);
        String firstName = nameParts[0];
        String lastName = nameParts.length > 1 ? nameParts[1] : "";

        Object[] params = {
            accountName, firstName, lastName, role, phone, jobStatus, dob, gender, address, hidden, staffID
        };

        int rows = executeQuery(sql, params);
        closeResources(null);
        return rows > 0;
    }

    public boolean deleteStaffAccount(int staffID) {
        String sql = "UPDATE Staff SET Hidden = 1 WHERE StaffID = ?;";
        int rows = executeQuery(sql, new Object[]{staffID});
        closeResources(null);
        return rows > 0;
    }

    public int countAllAccounts() {
        String sql = "SELECT COUNT(*) AS total FROM Staff;";
        try ( ResultSet rs = executeSelectQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countAccountsByStatus(boolean hidden) {
        String sql = "SELECT COUNT(*) AS total FROM Staff WHERE Hidden = ?;";
        try ( ResultSet rs = executeSelectQuery(sql, new Object[]{hidden})) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) AS total FROM Staff WHERE AccountName = ?";
        try ( ResultSet rs = executeSelectQuery(sql, new Object[]{username})) {
            if (rs.next()) {
                return rs.getInt("total") > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isPhoneExists(String phone) {
        String sql = "SELECT COUNT(*) AS total FROM Staff WHERE PhoneNumber = ?";
        try ( ResultSet rs = executeSelectQuery(sql, new Object[]{phone})) {
            if (rs.next()) {
                return rs.getInt("total") > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
