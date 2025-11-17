/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class DoctorReview {
    private int doctorReviewID;
    private Account account;
    private Staff staff;
    private String content;
    private int rateScore;
    private LocalDateTime dateCreate;

    public DoctorReview() {
    }

    public int getDoctorReviewID() {
        return doctorReviewID;
    }

    public void setDoctorReviewID(int doctorReviewID) {
        this.doctorReviewID = doctorReviewID;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
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

    
}
