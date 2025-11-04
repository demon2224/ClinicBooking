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
public class InvoiceDTO {

    private int invoiceID;
    private MedicalRecordDTO medicalRecordID;
    private PrescriptionDTO prescriptionID;
    private String paymentType;
    private String invoiceStatus;
    private Timestamp dateCreate;
    private Timestamp datePay;

    // add more fileds
    private String patientName;
    private String doctorName;
    private String specialty;
    private double fee;
    private String prescriptionNote;
    private String symptoms;
    private String diagnosis;
    private String medicalNote;

    public InvoiceDTO() {
    }

    public InvoiceDTO(int invoiceID, MedicalRecordDTO medicalRecordID, PrescriptionDTO prescriptionID, String paymentType, String invoiceStatus, Timestamp datePay) {
        this.invoiceID = invoiceID;
        this.medicalRecordID = medicalRecordID;
        this.prescriptionID = prescriptionID;
        this.paymentType = paymentType;
        this.invoiceStatus = invoiceStatus;
        this.datePay = datePay;
    }

    public InvoiceDTO(int invoiceID, String patientName, String doctorName, String specialty,
            String paymentType,String invoiceStatus, Timestamp dateCreate, Timestamp datePay,
            double fee) {
        this.invoiceID = invoiceID;
        this.patientName = patientName;
        this.doctorName = doctorName;
        this.specialty = specialty;
        this.paymentType = paymentType;
        this.invoiceStatus = invoiceStatus;
        this.dateCreate = dateCreate;
        this.datePay = datePay;
        this.fee = fee;
    }

    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public MedicalRecordDTO getMedicalRecordID() {
        return medicalRecordID;
    }

    public void setMedicalRecordID(MedicalRecordDTO medicalRecordID) {
        this.medicalRecordID = medicalRecordID;
    }

    public PrescriptionDTO getPrescriptionID() {
        return prescriptionID;
    }

    public void setPrescriptionID(PrescriptionDTO prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getInvoiceStatus() {
        return invoiceStatus;
    }

    public void setInvoiceStatus(String invoiceStatus) {
        this.invoiceStatus = invoiceStatus;
    }

    public Timestamp getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Timestamp dateCreate) {
        this.dateCreate = dateCreate;
    }

    public Timestamp getDatePay() {
        return datePay;
    }

    public void setDatePay(Timestamp datePay) {
        this.datePay = datePay;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }



    public String getPrescriptionNote() {
        return prescriptionNote;
    }

    public void setPrescriptionNote(String prescriptionNote) {
        this.prescriptionNote = prescriptionNote;
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

    public String getMedicalNote() {
        return medicalNote;
    }

    public void setMedicalNote(String medicalNote) {
        this.medicalNote = medicalNote;
    }

}
