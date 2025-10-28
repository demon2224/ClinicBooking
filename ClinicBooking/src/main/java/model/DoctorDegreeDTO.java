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
public class DoctorDegreeDTO {

    private DoctorDTO doctorID;
    private DegreeDTO degreeID;
    private Timestamp dateEarn;
    private String grantor;

    public DoctorDegreeDTO() {
    }

    public DoctorDTO getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(DoctorDTO doctorID) {
        this.doctorID = doctorID;
    }

    public DegreeDTO getDegreeID() {
        return degreeID;
    }

    public void setDegreeID(DegreeDTO degreeID) {
        this.degreeID = degreeID;
    }

    public Timestamp getDateEarn() {
        return dateEarn;
    }

    public void setDateEarn(Timestamp dateEarn) {
        this.dateEarn = dateEarn;
    }

    public String getGrantor() {
        return grantor;
    }

    public void setGrantor(String grantor) {
        this.grantor = grantor;
    }

}
