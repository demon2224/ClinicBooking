/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorReview {

    private int doctorReviewID;
    private int userID;
    private int doctorID;
    private String content;
    private int rateScore;
    private LocalDateTime dateCreate;

    private String reviewerFullName;
    private String reviewerAvatar;

    public DoctorReview() {
    }

    public DoctorReview(int doctorReviewID, int userID, int doctorID, String content, int rateScore, LocalDateTime dateCreate, String reviewerFullName, String reviewerAvatar) {
        this.doctorReviewID = doctorReviewID;
        this.userID = userID;
        this.doctorID = doctorID;
        this.content = content;
        this.rateScore = rateScore;
        this.dateCreate = dateCreate;
        this.reviewerFullName = reviewerFullName;
        this.reviewerAvatar = reviewerAvatar;
    }

    public int getDoctorReviewID() {
        return doctorReviewID;
    }

    public void setDoctorReviewID(int doctorReviewID) {
        this.doctorReviewID = doctorReviewID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getRateScore() {
        return rateScore;
    }

    public void setRateScore(int rateScore) {
        this.rateScore = rateScore;
    }

    public LocalDateTime getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(LocalDateTime dateCreate) {
        this.dateCreate = dateCreate;
    }

    public String getReviewerFullName() {
        return reviewerFullName;
    }

    public void setReviewerFullName(String reviewerFullName) {
        this.reviewerFullName = reviewerFullName;
    }

    public String getReviewerAvatar() {
        return reviewerAvatar;
    }

    public void setReviewerAvatar(String reviewerAvatar) {
        this.reviewerAvatar = reviewerAvatar;
    }

}
