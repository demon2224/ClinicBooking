/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class PrescriptionInvoice {
    private int prescriptionInvoiceID;
    private Prescription prescription;
    private String paymentType;
    private String invoiceStatus;
    private LocalDateTime dateCreate;
    private LocalDateTime dayPay;

    public PrescriptionInvoice() {
    }

    public int getPrescriptionInvoiceID() {
        return prescriptionInvoiceID;
    }

    public void setPrescriptionInvoiceID(int prescriptionInvoiceID) {
        this.prescriptionInvoiceID = prescriptionInvoiceID;
    }

    public Prescription getPrescription() {
        return prescription;
    }

    public void setPrescription(Prescription prescription) {
        this.prescription = prescription;
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

    public LocalDateTime getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(LocalDateTime dateCreate) {
        this.dateCreate = dateCreate;
    }

    public LocalDateTime getDayPay() {
        return dayPay;
    }

    public void setDayPay(LocalDateTime dayPay) {
        this.dayPay = dayPay;
    }
    
    public String getDateCreatedFormatString() {
        if (this.dateCreate == null) {
            return "";
        }
        return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(this.dateCreate);
    }

    public String getDayPayFormatString() {
        if (this.dayPay == null) {
            return "";
        }
        return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(this.dayPay);
    }
}
