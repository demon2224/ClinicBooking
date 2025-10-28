/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class ConsultationFeeDTO {

    private int consultationFeeID;
    private DoctorDTO doctorID;
    private SpecialtyDTO specialtyID;
    private double fee;

    public ConsultationFeeDTO() {
    }

    public int getConsultationFeeID() {
        return consultationFeeID;
    }

    public void setConsultationFeeID(int consultationFeeID) {
        this.consultationFeeID = consultationFeeID;
    }

    public DoctorDTO getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(DoctorDTO doctorID) {
        this.doctorID = doctorID;
    }

    public SpecialtyDTO getSpecialtyID() {
        return specialtyID;
    }

    public void setSpecialtyID(SpecialtyDTO specialtyID) {
        this.specialtyID = specialtyID;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

}
