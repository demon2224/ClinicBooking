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
public class AppointmentInvoice {

    private int appointmentInvoiceID;
    private Appointment appointment;
    private String paymentType;
    private LocalDateTime dateCreate;
    private LocalDateTime dayPay;
    private String invoiceStatus;

    public AppointmentInvoice() {
    }

    public int getAppointmentInvoiceID() {
        return appointmentInvoiceID;
    }

    public void setAppointmentInvoiceID(int appointmentInvoiceID) {
        this.appointmentInvoiceID = appointmentInvoiceID;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
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

    public String getInvoiceStatus() {
        return invoiceStatus;
    }

    public void setInvoiceStatus(String invoiceStatus) {
        this.invoiceStatus = invoiceStatus;
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
