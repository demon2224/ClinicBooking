/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
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
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                staff.setEmail(rs.getString("Email"));;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return staff;
    }
}
