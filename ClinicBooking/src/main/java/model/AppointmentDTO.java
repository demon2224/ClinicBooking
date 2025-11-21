/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

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
    private int totalAppointments;
    private boolean hasRecord;

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

    public boolean isHasRecord() {
        return hasRecord;
    }

    public void setHasRecord(boolean hasRecord) {
        this.hasRecord = hasRecord;
    }

    public String getDoctorName() {
        if (doctorID != null && doctorID.getStaffID() != null) {
            return doctorID.getStaffID().getFirstName() + " " + doctorID.getStaffID().getLastName();
        }
        return "";
    }

    public String getSpecialtyName() {
        if (doctorID != null && doctorID.getSpecialtyID() != null) {
            return doctorID.getSpecialtyID().getSpecialtyName();
        }
        return "";
    }

    public String getPatientName() {
        if (patientID != null) {
            return patientID.getFirstName() + " " + patientID.getLastName();
        }
        return "";
    }

    public String getStatusName() {
        return appointmentStatus;
    }

    public int getTotalAppointments() {
        return totalAppointments;
    }

    public void setTotalAppointments(int totalAppointments) {
        this.totalAppointments = totalAppointments;
    }

    /**
     * Duoc phep tao medical record trong khoang thoi gian truoc 5p va tre 30p
     *
     * @return
     */
    public boolean getAble() {
        LocalDateTime end = this.dateBegin.toLocalDateTime().plusMinutes(30);
        LocalDateTime begin = this.dateBegin.toLocalDateTime().minusMinutes(5);
        LocalDateTime now = LocalDateTime.now();
        return now.isAfter(begin) && now.isBefore(end);

    }

}
