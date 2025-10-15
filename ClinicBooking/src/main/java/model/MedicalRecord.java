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
    private Timestamp medicalRecordDateCreate;

    // Additional fields for display
    // Patient info
    private String patientName;
    private String email;
    private String phone;
    private String gender;
    private String address;
    private Timestamp doB;

    // Appointment info
    private String appointmentStatus;
    private Timestamp appointmentDateBegin;
    private Timestamp dateEnd;
    private String appointmentNote;

    // Prescription info
    private String prescriptionStatusName;
    private String prescriptionNote;

    // invoice info
    private int invoiceID;
    private Timestamp datePay;
    private String invoiceStatus;
    private String paymentType;
    private Timestamp invoiceCreateDate;
    private int fee;

    public MedicalRecord() {
    }

    public MedicalRecord(String diagnosis, String patientName, Timestamp appointmentDateBegin, String appointmentStatus, Timestamp medicalRecordDateCreate, int medicalRecordID) {
        this.diagnosis = diagnosis;
        this.patientName = patientName;
        this.appointmentDateBegin = appointmentDateBegin;
        this.appointmentStatus = appointmentStatus;
        this.medicalRecordDateCreate = medicalRecordDateCreate;
        this.medicalRecordID = medicalRecordID;
    }

    public MedicalRecord(int medicalRecordID,
            int appointmentID,
            int prescriptionID,
            String symptoms,
            String diagnosis,
            String note,
            Timestamp medicalRecordDateCreate,
            String patientName,
            String email,
            String phone,
            String gender,
            String address,
            Timestamp doB,
            String appointmentStatus,
            Timestamp appointmentDateBegin,
            Timestamp dateEnd,
            String appointmentNote,
            String prescriptionStatusName,
            String prescriptionNote,
            int invoiceID,
            Timestamp datePay,
            String invoiceStatus,
            String paymentType,
            Timestamp invoiceCreateDate,
            int fee) {
        this.medicalRecordID = medicalRecordID;
        this.appointmentID = appointmentID;
        this.prescriptionID = prescriptionID;
        this.symptoms = symptoms;
        this.diagnosis = diagnosis;
        this.note = note;
        this.medicalRecordDateCreate = medicalRecordDateCreate;
        this.patientName = patientName;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.address = address;
        this.doB = doB;
        this.appointmentStatus = appointmentStatus;
        this.appointmentDateBegin = appointmentDateBegin;
        this.dateEnd = dateEnd;
        this.appointmentNote = appointmentNote;
        this.prescriptionStatusName = prescriptionStatusName;
        this.prescriptionNote = prescriptionNote;
        this.invoiceID = invoiceID;
        this.datePay = datePay;
        this.invoiceStatus = invoiceStatus;
        this.paymentType = paymentType;
        this.invoiceCreateDate = invoiceCreateDate;
        this.fee = fee;
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

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getStatusName() {
        return appointmentStatus;
    }

    public void setStatusName(String statusName) {
        this.appointmentStatus = statusName;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Timestamp getDob() {
        return doB;
    }

    public void setDob(Timestamp doB) {
        this.doB = doB;
    }

    public String getAppointmentStatus() {
        return appointmentStatus;
    }

    public void setAppointmentStatus(String appointmentStatus) {
        this.appointmentStatus = appointmentStatus;
    }

    public Timestamp getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(Timestamp dateEnd) {
        this.dateEnd = dateEnd;
    }

    public String getAppointmentNote() {
        return appointmentNote;
    }

    public void setAppointmentNote(String appointmentNote) {
        this.appointmentNote = appointmentNote;
    }

    public String getPrescriptionNote() {
        return prescriptionNote;
    }

    public void setPrescriptionNote(String prescriptionNote) {
        this.prescriptionNote = prescriptionNote;
    }

    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public Timestamp getDatePay() {
        return datePay;
    }

    public void setDatePay(Timestamp datePay) {
        this.datePay = datePay;
    }

    public String getInvoiceStatus() {
        return invoiceStatus;
    }

    public void setInvoiceStatus(String invoiceStatus) {
        this.invoiceStatus = invoiceStatus;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public Timestamp getInvoiceCreateDate() {
        return invoiceCreateDate;
    }

    public void setInvoiceCreateDate(Timestamp invoiceCreateDate) {
        this.invoiceCreateDate = invoiceCreateDate;
    }

    public int getFee() {
        return fee;
    }

    public void setFee(int fee) {
        this.fee = fee;
    }

}
