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
public class Prescription {
    private int prescriptionID;
    private int appointmentID;
    private int prescriptionStatusID;
    private Timestamp dateCreate;
    private String note;
    
    // Additional fields for display
    private String patientName;
    private Timestamp appointmentDateBegin;
    private String prescriptionStatusName;

    public Prescription() {
    }

    public Prescription(String patientName, Timestamp appointmentDateBegin, String note, String prescriptionStatusName, Timestamp dateCreate) {
        this.dateCreate = dateCreate;
        this.note = note;
        this.patientName = patientName;
        this.appointmentDateBegin = appointmentDateBegin;
        this.prescriptionStatusName = prescriptionStatusName;
    }
    
    // Getters and Setters

    public int getPrescriptionID() {
        return prescriptionID;
    }

    public void setPrescriptionID(int prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public int getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    public int getPrescriptionStatusID() {
        return prescriptionStatusID;
    }

    public void setPrescriptionStatusID(int prescriptionStatusID) {
        this.prescriptionStatusID = prescriptionStatusID;
    }

    public Timestamp getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Timestamp dateCreate) {
        this.dateCreate = dateCreate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public Timestamp getAppointmentDateBegin() {
        return appointmentDateBegin;
    }

    public void setAppointmentDateBegin(Timestamp appointmentDateBegin) {
        this.appointmentDateBegin = appointmentDateBegin;
    }

    public String getPrescriptionStatusName() {
        return prescriptionStatusName;
    }

    public void setPrescriptionStatusName(String prescriptionStatusName) {
        this.prescriptionStatusName = prescriptionStatusName;
    }
    
    
}
