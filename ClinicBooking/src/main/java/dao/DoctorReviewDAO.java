/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DoctorReview;
import utils.DBContext;

/**
 * Data Access Object for Doctor Review operations
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorReviewDAO extends DBContext {

    public List<DoctorReview> getReviewsByDoctorId(int doctorId) {
        List<DoctorReview> reviews = new ArrayList<>();
        String sql = "SELECT dr.DoctorReviewID, dr.DoctorID, dr.Content, "
                + "dr.RateScore, dr.DateCreate, "
                + "CONCAT(p.FirstName, ' ', p.LastName) AS ReviewerFullName, "
                + "a.Avatar AS ReviewerAvatar "
                + "FROM DoctorReview dr "
                + "INNER JOIN [User] u ON dr.UserID = u.UserID "
                + "INNER JOIN Profile p ON u.UserID = p.UserProfileID "
                + "LEFT JOIN Account a ON u.UserID = a.UserAccountID "
                + "WHERE dr.DoctorID = ? "
                + "ORDER BY dr.DateCreate DESC";

        try {
            Object[] params = {doctorId};
            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null) {
                while (rs.next()) {
                    DoctorReview review = new DoctorReview();
                    review.setDoctorReviewID(rs.getInt("DoctorReviewID"));
                    review.setDoctorID(rs.getInt("DoctorID"));
                    review.setContent(rs.getString("Content"));
                    review.setRateScore(rs.getInt("RateScore"));
                    // Convert Timestamp to LocalDateTime
                    Timestamp timestamp = rs.getTimestamp("DateCreate");
                    if (timestamp != null) {
                        review.setDateCreate(timestamp.toLocalDateTime());
                    }
                    review.setReviewerFullName(rs.getString("ReviewerFullName"));
                    review.setReviewerAvatar(rs.getString("ReviewerAvatar"));
                    reviews.add(review);
                }
                closeResources(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reviews;
    }

    public double getAverageRatingByDoctorId(int doctorId) {
        String sql = "SELECT AVG(CAST(RateScore AS FLOAT)) AS AvgRating FROM DoctorReview WHERE DoctorID = ?";
        try {
            Object[] params = {doctorId};
            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null && rs.next()) {
                double avgRating = rs.getDouble("AvgRating");
                closeResources(rs);
                return Math.round(avgRating * 10.0) / 10.0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0.0;
    }

    public int getReviewCountByDoctorId(int doctorId) {
        String sql = "SELECT COUNT(*) AS ReviewCount FROM DoctorReview WHERE DoctorID = ?";
        try {
            Object[] params = {doctorId};
            ResultSet rs = executeSelectQuery(sql, params);
            if (rs != null && rs.next()) {
                int count = rs.getInt("ReviewCount");
                closeResources(rs);
                return count;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
