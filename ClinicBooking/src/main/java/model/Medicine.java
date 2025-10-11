/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class Medicine {
    
    private int medicineId;
    private String medicineType;
    private boolean medicineStatus;
    private String medicineName;
    private String medicineCode;
    private int quantity;
    private double price;
    private LocalDateTime dateCreated;

    public Medicine() {
    }

    public Medicine(int medicineId, String medicineType, boolean medicineStatus, String medicineName, String medicineCode, int quantity, double price, LocalDateTime dateCreated) {
        this.medicineId = medicineId;
        this.medicineType = medicineType;
        this.medicineStatus = medicineStatus;
        this.medicineName = medicineName;
        this.medicineCode = medicineCode;
        this.quantity = quantity;
        this.price = price;
        this.dateCreated = dateCreated;
    }

    public int getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(int medicineId) {
        this.medicineId = medicineId;
    }

    public String getMedicineType() {
        return medicineType;
    }

    public void setMedicineType(String medicineType) {
        this.medicineType = medicineType;
    }

    public boolean getMedicineStatus() {
        return medicineStatus;
    }

    public void setMedicineStatus(boolean medicineStatus) {
        this.medicineStatus = medicineStatus;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getMedicineCode() {
        return medicineCode;
    }

    public void setMedicineCode(String medicineCode) {
        this.medicineCode = medicineCode;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public LocalDateTime getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(LocalDateTime dateCreated) {
        this.dateCreated = dateCreated;
    }
    
    public String getDateCreateFormatDate() {
        if (this.dateCreated == null) {
            return "";
        }
        return this.dateCreated.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }
    
}
