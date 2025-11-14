/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class DoctorDTO {

    private int doctorID;
    private StaffDTO staffID;
    private SpecialtyDTO specialtyID;
    private int yearExperience;
    
     private double totalRevenue;

    public DoctorDTO() {
    }

    public DoctorDTO(int doctorID, StaffDTO staffID, SpecialtyDTO specialtyID, int yearExperience) {
        this.doctorID = doctorID;
        this.staffID = staffID;
        this.specialtyID = specialtyID;
        this.yearExperience = yearExperience;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }

    public StaffDTO getStaffID() {
        return staffID;
    }

    public void setStaffID(StaffDTO staffID) {
        this.staffID = staffID;
    }

    public SpecialtyDTO getSpecialtyID() {
        return specialtyID;
    }

    public void setSpecialtyID(SpecialtyDTO specialtyID) {
        this.specialtyID = specialtyID;
    }

    public int getYearExperience() {
        return yearExperience;
    }

    public void setYearExperience(int yearExperience) {
        this.yearExperience = yearExperience;
    }

    public String getDoctorName() {
        if (staffID != null) {
            return staffID.getFirstName() + " " + staffID.getLastName();
        }
        return "";
    }

    public String getSpecialtyName() {
        if (specialtyID != null) {
            return specialtyID.getSpecialtyName();
        }
        return "";
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    
}
