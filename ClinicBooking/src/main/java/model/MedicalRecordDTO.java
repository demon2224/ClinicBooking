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
public class MedicalRecordDTO {

    private int medicalRecordID;
    private AppointmentDTO appointmentID;
    private PrescriptionDTO prescriptionDTO;
    private String symptoms;
    private String diagnosis;
    private String note;
    private Timestamp dateCreate;

    public MedicalRecordDTO() {
    }

    public int getMedicalRecordID() {
        return medicalRecordID;
    }

    public void setMedicalRecordID(int medicalRecordID) {
        this.medicalRecordID = medicalRecordID;
    }

    public AppointmentDTO getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(AppointmentDTO appointmentID) {
        this.appointmentID = appointmentID;
    }

    public PrescriptionDTO getPrescriptionDTO() {
        return prescriptionDTO;
    }

    public void setPrescriptionDTO(PrescriptionDTO prescriptionDTO) {
        this.prescriptionDTO = prescriptionDTO;
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

}
