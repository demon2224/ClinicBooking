/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class DoctorReviewDTO {

    private int doctorReviewID;
    private PatientDTO patientID;
    private DoctorDTO doctorID;
    private String content;
    private int rateScore;
    private Timestamp dateCreate;

    public DoctorReviewDTO() {
    }

    public int getDoctorReviewID() {
        return doctorReviewID;
    }

    public void setDoctorReviewID(int doctorReviewID) {
        this.doctorReviewID = doctorReviewID;
    }

    public PatientDTO getPatientID() {
        return patientID;
    }

    public void setPatientID(PatientDTO patientID) {
        this.patientID = patientID;
    }

    public DoctorDTO getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(DoctorDTO doctorID) {
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

    public Timestamp getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Timestamp dateCreate) {
        this.dateCreate = dateCreate;
    }

}
