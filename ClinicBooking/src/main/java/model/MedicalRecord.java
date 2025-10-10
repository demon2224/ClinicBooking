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
public class MedicalRecord {
    private int medicalRecordID;
    private int appointmentID;
    private int prescriptionID;
    private String symptoms;
    private String diagnosis;
    private String note;
    private Timestamp dateCreate;
    
    // Additional fields for display
    private String patientName;
    private String statusName;
    private Timestamp appointmentDateBegin;
    private String prescriptionStatusName;
    private Timestamp medicalRecordDateCreate;

    public MedicalRecord() {
    }

    public MedicalRecord(String diagnosis, String patientName, Timestamp appointmentDateBegin, String prescriptionStatusName, Timestamp medicalRecordDateCreate) {
        this.diagnosis = diagnosis;
        this.patientName = patientName;
        this.appointmentDateBegin = appointmentDateBegin;
        this.prescriptionStatusName = prescriptionStatusName;
        this.medicalRecordDateCreate = medicalRecordDateCreate;
    }
    
    // Getters and Setters

    public int getMedicalRecordID() {
        return medicalRecordID;
    }

    public void setMedicalRecordID(int medicalRecordID) {
        this.medicalRecordID = medicalRecordID;
    }

    public int getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    public int getPrescriptionID() {
        return prescriptionID;
    }

    public void setPrescriptionID(int prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Timestamp dateCreate) {
        this.dateCreate = dateCreate;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
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

    public Timestamp getMedicalRecordDateCreate() {
        return medicalRecordDateCreate;
    }

    public void setMedicalRecordDateCreate(Timestamp medicalRecordDateCreate) {
        this.medicalRecordDateCreate = medicalRecordDateCreate;
    }
    
}
