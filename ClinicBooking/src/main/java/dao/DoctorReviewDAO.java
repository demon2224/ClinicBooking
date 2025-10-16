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

    /**
     * Retrieves a list of reviews for a specific doctor.
     *
     * @param doctorId the ID of the doctor whose reviews are being retrieved
     * @return a list of DoctorReview objects representing the reviews for the doctor, or
     * an empty list if none are found or an error occurs
     */
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

        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
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
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return reviews;
    }

    /**
     * Calculates and returns the average rating for a doctor based on their reviews.
     *
     * @param doctorId the ID of the doctor whose average rating is being calculated
     * @return the average rating (rounded to one decimal place) for the doctor, or 0.0 if
     * no ratings are found or an error occurs
     */
    public double getAverageRatingByDoctorId(int doctorId) {
        String sql = "SELECT AVG(CAST(RateScore AS FLOAT)) AS AvgRating FROM DoctorReview WHERE DoctorID = ?";
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null && rs.next()) {
                // Return the average rating, rounded to one decimal place
                double avgRating = rs.getDouble("AvgRating");
                return Math.round(avgRating * 10.0) / 10.0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs); // Close the result set
        }
        return 0.0;  // Return 0 if no ratings are found or an error occurs
    }

    /**
     * Counts and returns the total number of reviews for a doctor.
     *
     * @param doctorId the ID of the doctor whose reviews are being counted
     * @return the total number of reviews for the doctor, or 0 if none are found or an
     * error occurs
     */
    public int getReviewCountByDoctorId(int doctorId) {
        String sql = "SELECT COUNT(*) AS ReviewCount FROM DoctorReview WHERE DoctorID = ?";
        Object[] params = {doctorId};
        ResultSet rs = executeSelectQuery(sql, params);
        try {
            if (rs != null && rs.next()) {
                // Return the count of reviews
                int count = rs.getInt("ReviewCount");
                return count;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }
        return 0;  // Return 0 if no reviews are found or an error occurs
    }
}
