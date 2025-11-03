/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class MedicineDTO {

    // The unique identifier for the medicine
    private int medicineID;

    // The name of the medicine
    private String medicineName;

    // The unique code identifier for the medicine
    private String medicineCode;

    // The type of the medicine
    private String medicineType;

    // The availability status of the medicine (true = available, false = unavailable)
    private boolean medicineStatus;

    // The current quantity in stock
    private int quantity;

    // The price of the medicine per unit
    private double price;

    // The creation date time of the medicine record
    private Timestamp dateCreate;

    // The active status of medicine
    private boolean isHidden;

    /**
     * Default constructor for Medicine.
     */
    public MedicineDTO() {
    }

    /**
     * Constructs a Medicine with all properties specified.
     *
     * @param medicineID The unique identifier for the medicine
     * @param medicineType The type/category of the medicine
     * @param medicineStatus The availability status of the medicine
     * @param medicineName The name of the medicine
     * @param medicineCode The unique code for the medicine
     * @param quantity The current quantity in stock
     * @param price The price of the medicine
     * @param dateCreate The creation timestamp
     * @param isHidden The active status of medicine
     */
    public MedicineDTO(int medicineID, String medicineName, String medicineCode, String medicineType, boolean medicineStatus, int quantity, double price, Timestamp dateCreate, boolean isHidden) {
        this.medicineID = medicineID;
        this.medicineName = medicineName;
        this.medicineCode = medicineCode;
        this.medicineType = medicineType;
        this.medicineStatus = medicineStatus;
        this.quantity = quantity;
        this.price = price;
        this.dateCreate = dateCreate;
        this.isHidden = isHidden;
    }

    /**
     * Gets the medicine ID.
     *
     * @return The medicine ID
     */
    public int getMedicineID() {
        return medicineID;
    }

    /**
     * Sets the medicine ID.
     *
     * @param medicineID The medicine ID to set
     */
    public void setMedicineID(int medicineID) {
        this.medicineID = medicineID;
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
    public boolean isMedicineStatus() {
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
    public Timestamp getDateCreate() {
        return dateCreate;
    }

    /**
     * Sets the creation date time.
     *
     * @param dateCreate The creation date time to set
     */
    public void setDateCreate(Timestamp dateCreate) {
        this.dateCreate = dateCreate;
    }

    /**
     * Gets the active status of medicine.
     * 
     * @return The active status of medicine
     */
    public boolean isIsHidden() {
        return isHidden;
    }

    /**
     * Sets the active status of medicine.
     * 
     * @param isHidden The active status of medicine to set
     */
    public void setIsHidden(boolean isHidden) {
        this.isHidden = isHidden;
    }

    /**
     * Formats the creation date into a display-friendly string. Returns an
     * empty string if the creation date is null.
     *
     * @return Formatted date string in "dd/MM/yyyy HH:mm:ss" format, or empty
     * string if null
     */
    public String getDateCreateFormatDate() {
        if (this.dateCreate == null) {
            return "";
        }
        return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(this.dateCreate);
    }

    /**
     * Return all attribute of this instance in format of string.
     *
     * @return string present the attribute of Medicine
     */
    @Override
    public String toString() {
        return "MedicineDTO{" + "medicineID=" + medicineID + ", medicineName=" + medicineName + ", medicineCode=" + medicineCode + ", medicineType=" + medicineType + ", medicineStatus=" + medicineStatus + ", quantity=" + quantity + ", price=" + price + ", dateCreate=" + dateCreate + ", isHidden=" + isHidden + '}';
    }

}
