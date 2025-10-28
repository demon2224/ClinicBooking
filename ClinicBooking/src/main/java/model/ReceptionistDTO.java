/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class ReceptionistDTO {

    private int receptionistID;
    private StaffDTO staffID;

    public ReceptionistDTO() {
    }

    public int getReceptionistID() {
        return receptionistID;
    }

    public void setReceptionistID(int receptionistID) {
        this.receptionistID = receptionistID;
    }

    public StaffDTO getStaffID() {
        return staffID;
    }

    public void setStaffID(StaffDTO staffID) {
        this.staffID = staffID;
    }

}
