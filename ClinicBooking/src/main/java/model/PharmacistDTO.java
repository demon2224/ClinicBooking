/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class PharmacistDTO {

    private int pharmacistID;
    private StaffDTO staffID;

    public PharmacistDTO() {
    }

    public int getPharmacistID() {
        return pharmacistID;
    }

    public void setPharmacistID(int pharmacistID) {
        this.pharmacistID = pharmacistID;
    }

    public StaffDTO getStaffID() {
        return staffID;
    }

    public void setStaffID(StaffDTO staffID) {
        this.staffID = staffID;
    }

}
