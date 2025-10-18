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

    // The unique identifier for the medicine
    private int medicineId;

    // The type/category of the medicine
    private String medicineType;

    // The availability status of the medicine (true = available, false = unavailable)
    private boolean medicineStatus;

    // The name of the medicine
    private String medicineName;

    // The unique code identifier for the medicine
    private String medicineCode;

    // The current quantity in stock
    private int quantity;

    // The price of the medicine
    private double price;

    // The creation date time of the medicine record
    private LocalDateTime dateCreated;
    
     // The date time of the last stock transaction for this medicine
    private LocalDateTime lastStockTransaction;

    /**
     * Default constructor for Medicine.
     */
    public Medicine() {
    }

    /**
     * Constructs a Medicine with all properties specified.
     *
     * @param medicineId The unique identifier for the medicine
     * @param medicineType The type/category of the medicine
     * @param medicineStatus The availability status of the medicine
     * @param medicineName The name of the medicine
     * @param medicineCode The unique code for the medicine
     * @param quantity The current quantity in stock
     * @param price The price of the medicine
     * @param dateCreated The creation timestamp
     */
    public Medicine(int medicineId, String medicineType, boolean medicineStatus,
            String medicineName, String medicineCode, int quantity, double price,
            LocalDateTime dateCreated) {
        this.medicineId = medicineId;
        this.medicineType = medicineType;
        this.medicineStatus = medicineStatus;
        this.medicineName = medicineName;
        this.medicineCode = medicineCode;
        this.quantity = quantity;
        this.price = price;
        this.dateCreated = dateCreated;
    }

    // Getters and Setters with Javadoc
    /**
     * Gets the medicine ID.
     *
     * @return The medicine ID
     */
    public int getMedicineId() {
        return medicineId;
    }

    /**
     * Sets the medicine ID.
     *
     * @param medicineId The medicine ID to set
     */
    public void setMedicineId(int medicineId) {
        this.medicineId = medicineId;
    }

    /**
     * Gets the medicine type.
     *
     * @return The medicine type
     */
    public String getMedicineType() {
        return medicineType;
    }

    /**
     * Sets the medicine type.
     *
     * @param medicineType The medicine type to set
     */
    public void setMedicineType(String medicineType) {
        this.medicineType = medicineType;
    }

    /**
     * Gets the medicine status.
     *
     * @return The medicine status (true = available, false = unavailable)
     */
    public boolean getMedicineStatus() {
        return medicineStatus;
    }

    /**
     * Sets the medicine status.
     *
     * @param medicineStatus The medicine status to set
     */
    public void setMedicineStatus(boolean medicineStatus) {
        this.medicineStatus = medicineStatus;
    }

    /**
     * Gets the medicine name.
     *
     * @return The medicine name
     */
    public String getMedicineName() {
        return medicineName;
    }

    /**
     * Sets the medicine name.
     *
     * @param medicineName The medicine name to set
     */
    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    /**
     * Gets the medicine code.
     *
     * @return The medicine code
     */
    public String getMedicineCode() {
        return medicineCode;
    }

    /**
     * Sets the medicine code.
     *
     * @param medicineCode The medicine code to set (format: ABC123)
     */
    public void setMedicineCode(String medicineCode) {
        this.medicineCode = medicineCode;
    }

    /**
     * Gets the quantity in stock.
     *
     * @return The quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Sets the quantity in stock.
     *
     * @param quantity The quantity to set
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * Gets the medicine price.
     *
     * @return The price
     */
    public double getPrice() {
        return price;
    }

    /**
     * Sets the medicine price.
     *
     * @param price The price to set
     */
    public void setPrice(double price) {
        this.price = price;
    }

    /**
     * Gets the creation timestamp.
     *
     * @return The creation timestamp
     */
    public LocalDateTime getDateCreated() {
        return dateCreated;
    }

    /**
     * Sets the creation date time.
     *
     * @param dateCreated The creation date time to set
     */
    public void setDateCreated(LocalDateTime dateCreated) {
        this.dateCreated = dateCreated;
    }

    /**
     * Formats the creation date into a display-friendly string. Returns an
     * empty string if the creation date is null.
     *
     * @return Formatted date string in "dd/MM/yyyy HH:mm:ss" format, or empty
     * string if null
     */
    public String getDateCreateFormatDate() {
        if (this.dateCreated == null) {
            return "";
        }
        return this.dateCreated.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }
    
    /**
     * Gets the date time of the last stock transaction.
     *
     * @return The last stock transaction timestamp
     */
    public LocalDateTime getLastStockTransaction() {
        return lastStockTransaction;
    }

    /**
     * Sets the date time of the last stock transaction.
     *
     * @param lastStockTransaction The last stock transaction timestamp to set
     */
    public void setLastStockTransaction(LocalDateTime lastStockTransaction) {
        this.lastStockTransaction = lastStockTransaction;
    }

    /**
     * Formats the last stock transaction timestamp into a display-friendly
     * string. Returns an empty string if no transaction exists.
     *
     * @return Formatted date string in "dd/MM/yyyy HH:mm:ss" format, or empty
     * string if null
     */
    public String getLastStockTransactionFormatDate() {
        if (this.lastStockTransaction == null) {
            return "";
        }
        return this.lastStockTransaction.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }

}
