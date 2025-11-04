/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.PatientDTO;


/**
 * User Data Access Object
 *
 * @author Le Anh Tuan - CE180905
 */
public class UserDAO extends DBContext {

//    /**
//     * Get user by ID with full information from User, Account, and Profile tables
//     *
//     * @param userId The ID of the user to retrieve
//     * @return User object with complete information, null if not found
//     */
//    public User getUserById(int userId) {
//        String sql = "SELECT u.UserID, u.RoleID, "
//                + "a.AccountName, a.AccountPassword, a.DayCreated, a.Avatar, a.Bio, "
//                + "p.FirstName, p.LastName, p.DOB, p.Gender, p.UserAddress, p.PhoneNumber, p.Email, "
//                + "r.RoleName, u.RoleID "
//                + "FROM [User] u "
//                + "LEFT JOIN Account a ON u.UserID = a.UserAccountID "
//                + "LEFT JOIN Profile p ON u.UserID = p.UserProfileID "
//                + "LEFT JOIN Role r ON u.RoleID = r.RoleID "
//                + "WHERE u.UserID = ?";
//        ResultSet rs = null;
//        try {
//            Object[] params = {userId};
//            rs = executeSelectQuery(sql, params);
//
//            if (rs.next()) {
//                User user = new User();
//
//                // User table fields
//                user.setUserID(rs.getInt("UserID"));
//                user.setRoleID(rs.getInt("RoleID"));
//
//                // Account table fields
//                Account account = new Account();
//                account.setAccountName(rs.getString("AccountName"));
//                account.setAccountPassword(rs.getString("AccountPassword"));
//                account.setDayCreated(rs.getObject("DayCreated", LocalDateTime.class));
//                account.setAvatar(rs.getString("Avatar"));
//                account.setBio(rs.getString("Bio"));
//
//                user.setAccount(account);
//
//                // Profile table fields
//                Profile profile = new Profile();
//                profile.setFirstName(rs.getString("FirstName"));
//                profile.setLastName(rs.getString("LastName"));
//                profile.setDob(rs.getDate("DOB"));
//                profile.setGender(rs.getBoolean("Gender"));
//                profile.setUserAddress(rs.getString("UserAddress"));
//                profile.setPhoneNumber(rs.getString("PhoneNumber"));
//                profile.setEmail(rs.getString("Email"));
//
//                user.setProfile(profile);
//
//                // Additional fields
//                user.setRoleID(rs.getInt("RoleID"));
//                user.setRoleName(rs.getString("RoleName"));
//
//                return user;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResources(rs);
//        }
//
//        return null;
//    }

    /**
     *
     * @return List of Patient
     */
    public List<PatientDTO> getAllPatients() {
        List<PatientDTO> patients = new ArrayList<>();
        String sql = "SELECT PatientID, FirstName, LastName, PhoneNumber "
                + "FROM [Patient]"; 

        ResultSet rs = null;
        try {
            rs = executeSelectQuery(sql, null);
            while (rs.next()) {
                int userId = rs.getInt("UserID");
                String fname = rs.getString("FirstName");
                String lname =  rs.getString("LastName");
                //String fullName = rs.getString("FirstName") + " " + rs.getString("LastName");
                String phone = rs.getString("PhoneNumber");

                PatientDTO p = new PatientDTO();
                p.setPatientID(userId);
                p.setFirstName(fname);
                p.setLastName(lname);
                p.setPhoneNumber(phone);

                patients.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs);
        }

        return patients;
    }

}
