/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class Appointment {
    private int appointmentID;
    private Account account;
    private Staff staff;
    private String appointmentStatus;
    private LocalDateTime dateCreate;
    private LocalDateTime dateBegin;
    private LocalDateTime dateEnd;
    private String note;
    private boolean hidden;
    private int totalAppointments;
    private Patient patient;

    public Appointment() {
    }

    public int getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public String getAppointmentStatus() {
        return appointmentStatus;
    }

    public void setAppointmentStatus(String appointmentStatus) {
        this.appointmentStatus = appointmentStatus;
    }

    public LocalDateTime getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(LocalDateTime dateCreate) {
        this.dateCreate = dateCreate;
    }

    public LocalDateTime getDateBegin() {
        return dateBegin;
    }

    public void setDateBegin(LocalDateTime dateBegin) {
        this.dateBegin = dateBegin;
    }

    public LocalDateTime getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(LocalDateTime dateEnd) {
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

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getDoctorName() {
        if (staff != null && (staff.getFirstName() != null || staff.getLastName() != null)) {
            return staff.getFirstName() + " " + staff.getLastName();
        }
        return "";
    }

    public String getSpecialtyName() {
        if (staff != null && staff.getSpecialty() != null) {
            return staff.getSpecialty().getSpecialtyName();
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

    public boolean getAble() {
        LocalDateTime end = this.dateBegin.plusMinutes(30);
        LocalDateTime begin = this.dateBegin.minusMinutes(5);
        LocalDateTime now = LocalDateTime.now();
        return now.isAfter(begin) && now.isBefore(end);
    }
}
