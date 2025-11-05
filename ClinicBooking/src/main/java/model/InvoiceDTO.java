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
    private SpecialtyDTO specialtyID;
    private String paymentType;
    private String invoiceStatus;
    private Timestamp dateCreate;
    private Timestamp datePay;
    
    private double totalFee;

    public InvoiceDTO() {
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

    public SpecialtyDTO getSpecialtyID() {
        return specialtyID;
    }

    public void setSpecialtyID(SpecialtyDTO specialtyID) {
        this.specialtyID = specialtyID;
    }

    public double getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(double totalFee) {
        this.totalFee = totalFee;
    }
    
}
