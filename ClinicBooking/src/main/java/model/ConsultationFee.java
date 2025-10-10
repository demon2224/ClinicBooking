/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class ConsultationFee {

    private int consultationFeeID;
    private int doctorID;
    private int specialtyID;
    private double fee;

    public ConsultationFee() {
    }

    public ConsultationFee(int consultationFeeID, int doctorID, int specialtyID, double fee) {
        this.consultationFeeID = consultationFeeID;
        this.doctorID = doctorID;
        this.specialtyID = specialtyID;
        this.fee = fee;
    }

    public int getConsultationFeeID() {
        return consultationFeeID;
    }

    public void setConsultationFeeID(int consultationFeeID) {
        this.consultationFeeID = consultationFeeID;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }

    public int getSpecialtyID() {
        return specialtyID;
    }

    public void setSpecialtyID(int specialtyID) {
        this.specialtyID = specialtyID;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

}
