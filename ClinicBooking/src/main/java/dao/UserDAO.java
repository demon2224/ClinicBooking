/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.User;
import utils.DBContext;
import java.sql.*;

/**
 * User Data Access Object
 *
 * @author Le Anh Tuan - CE180905
 */
public class UserDAO extends DBContext {

    /**
     * Get user by ID with full information from User, Account, and Profile
     * tables
     *
     * @param userId The ID of the user to retrieve
     * @return User object with complete information, null if not found
     */
    public User getUserById(int userId) {
        String sql = "SELECT u.UserID, u.RoleID, "
                + "a.AccountName, a.AccountPassword, a.DayCreated, a.Avatar, a.Bio, "
                + "p.FirstName, p.LastName, p.DOB, p.Gender, p.UserAddress, p.PhoneNumber, p.Email, "
                + "r.RoleName "
                + "FROM [User] u "
                + "LEFT JOIN Account a ON u.UserID = a.UserAccountID "
                + "LEFT JOIN Profile p ON u.UserID = p.UserProfileID "
                + "LEFT JOIN Role r ON u.RoleID = r.RoleID "
                + "WHERE u.UserID = ?";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();

                // User table fields
                user.setUserID(rs.getInt("UserID"));
                user.setRoleID(rs.getInt("RoleID"));

                // Account table fields
                user.setAccountName(rs.getString("AccountName"));
                user.setAccountPassword(rs.getString("AccountPassword"));
                user.setDayCreated(rs.getTimestamp("DayCreated"));
                user.setAvatar(rs.getString("Avatar"));
                user.setBio(rs.getString("Bio"));

                // Profile table fields
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setDob(rs.getDate("DOB"));
                user.setGender(rs.getBoolean("Gender"));
                user.setUserAddress(rs.getString("UserAddress"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setEmail(rs.getString("Email"));

                // Additional fields
                user.setRoleName(rs.getString("RoleName"));

                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }

        return null;
    }
}
