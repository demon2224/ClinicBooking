/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 * Appointment Model Class
 *
 * @author Le Anh Tuan - CE180905
 */
public class Appointment {

    private int appointmentID;
    private int userID;
    private int doctorID;
    private int appointmentStatusID;
    private Timestamp dateCreate;
    private Timestamp dateBegin;
    private Timestamp dateEnd;
    private String note;

    // Additional fields for display
    private String doctorName;
    private String statusName;
    private String patientName;
    private String specialtyName;
    private int SpecialtyID;
    
    private String patientEmail;
    private String patientPhone;
    private String appointmentStatusName;
    
    

    public Appointment() {
    }

    public Appointment(int appointmentID, int userID, int doctorID, int appointmentStatusID,
            Timestamp dateCreate, Timestamp dateBegin, Timestamp dateEnd, String note) {
        this.appointmentID = appointmentID;
        this.userID = userID;
        this.doctorID = doctorID;
        this.appointmentStatusID = appointmentStatusID;
        this.dateCreate = dateCreate;
        this.dateBegin = dateBegin;
        this.dateEnd = dateEnd;
        this.note = note;
    }

    public Appointment(String patientName, String patientEmail, String patientPhone, Timestamp dateBegin, String note, String appointmentStatusName){
        this.patientName = patientName;
        this.patientEmail = patientEmail;
        this.patientPhone = patientPhone;
        this.dateBegin = dateBegin;
        this.note = note;
        this.appointmentStatusName = appointmentStatusName; 
    }
    
    // Getters and Setters
    public int getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }

    public int getAppointmentStatusID() {
        return appointmentStatusID;
    }

    public void setAppointmentStatusID(int appointmentStatusID) {
        this.appointmentStatusID = appointmentStatusID;
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

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getSpecialtyName() {
        return specialtyName;
    }

    public void setSpecialtyName(String specialtyName) {
        this.specialtyName = specialtyName;
    }

    public String getPatientEmail() {
        return patientEmail;
    }

    public void setPatientEmail(String patientEmail) {
        this.patientEmail = patientEmail;
    }

    public String getPatientPhone() {
        return patientPhone;
    }

    public void setPatientPhone(String patientPhone) {
        this.patientPhone = patientPhone;
    }

    public String getAppointmentStatusName() {
        return appointmentStatusName;
    }

    public void setAppointmentStatusName(String appointmentStatusName) {
        this.appointmentStatusName = appointmentStatusName;
    }

    
    
    @Override
    public String toString() {
        return "Appointment{"
                + "appointmentID=" + appointmentID
                + ", userID=" + userID
                + ", doctorID=" + doctorID
                + ", appointmentStatusID=" + appointmentStatusID
                + ", dateCreate=" + dateCreate
                + ", dateBegin=" + dateBegin
                + ", dateEnd=" + dateEnd
                + ", note='" + note + '\''
                + '}';
    }
}
