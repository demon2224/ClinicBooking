/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class Invoice {
    private int invoiceId;
    private String patientName;
    private String doctorName;
    private String specialty;
    private double fee;
    private String paymentMethod;
    private String status;

    public Invoice() {
    }

    public Invoice(int invoiceId, String patientName, String doctorName, String specialty, double fee, String paymentMethod, String status) {
        this.invoiceId = invoiceId;
        this.patientName = patientName;
        this.doctorName = doctorName;
        this.specialty = specialty;
        this.fee = fee;
        this.paymentMethod = paymentMethod;
        this.status = status;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
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

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
