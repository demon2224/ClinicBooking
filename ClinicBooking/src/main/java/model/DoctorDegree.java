/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorDegree {

    private int doctorID;
    private int degreeID;
    private Date dateEarn;
    private String grantor;

    public DoctorDegree() {
    }

    public DoctorDegree(int doctorID, int degreeID, Date dateEarn, String grantor) {
        this.doctorID = doctorID;
        this.degreeID = degreeID;
        this.dateEarn = dateEarn;
        this.grantor = grantor;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }

    public int getDegreeID() {
        return degreeID;
    }

    public void setDegreeID(int degreeID) {
        this.degreeID = degreeID;
    }

    public Date getDateEarn() {
        return dateEarn;
    }

    public void setDateEarn(Date dateEarn) {
        this.dateEarn = dateEarn;
    }

    public String getGrantor() {
        return grantor;
    }

    public void setGrantor(String grantor) {
        this.grantor = grantor;
    }

}
