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
public class AppointmentDTO {

    private int appointmentID;
    private PatientDTO patientID;
    private DoctorDTO doctorID;
    private String appointmentStatus;
    private Timestamp dateCreate;
    private Timestamp dateBegin;
    private Timestamp dateEnd;
    private String note;
    private boolean hidden;

    public AppointmentDTO() {
    }

    /**
     * Constructor for View My Patient Appointment List
     *
     * @param appointmentID
     * @param patientID
     * @param appointmentStatus
     * @param dateBegin
     * @param note
     */
    public AppointmentDTO(int appointmentID, PatientDTO patientID, String appointmentStatus, Timestamp dateBegin, Timestamp dateEnd, String note) {
        this.appointmentID = appointmentID;
        this.patientID = patientID;
        this.appointmentStatus = appointmentStatus;
        this.dateBegin = dateBegin;
        this.dateEnd = dateEnd;
        this.note = note;
    }

    // Getter & Setter
    public int getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    public PatientDTO getPatientID() {
        return patientID;
    }

    public void setPatientID(PatientDTO patientID) {
        this.patientID = patientID;
    }

    public DoctorDTO getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(DoctorDTO doctorID) {
        this.doctorID = doctorID;
    }

    public String getAppointmentStatus() {
        return appointmentStatus;
    }

    public void setAppointmentStatus(String appointmentStatus) {
        this.appointmentStatus = appointmentStatus;
    }

    public Timestamp getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Timestamp dateCreate) {
        this.dateCreate = dateCreate;
    }

    public Timestamp getDateBegin() {
        return dateBegin;
    }

    public void setDateBegin(Timestamp dateBegin) {
        this.dateBegin = dateBegin;
    }

    public Timestamp getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(Timestamp dateEnd) {
        this.dateEnd = dateEnd;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public boolean isHidden() {
        return hidden;
    }

    public void setHidden(boolean hidden) {
        this.hidden = hidden;
    }

}
