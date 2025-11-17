/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class DegreeDTO {

    private int degreeID;
    private String degreeName;
    private StaffDTO staff;

    public DegreeDTO() {
    }

    public int getDegreeID() {
        return degreeID;
    }

    public void setDegreeID(int degreeID) {
        this.degreeID = degreeID;
    }

    public String getDegreeName() {
        return degreeName;
    }

    public void setDegreeName(String degreeName) {
        this.degreeName = degreeName;
    }

    public StaffDTO getDoctorID() {
        return staff;
    }

    public void setDoctorID(StaffDTO doctorID) {
        this.staff = doctorID;
    }

}
