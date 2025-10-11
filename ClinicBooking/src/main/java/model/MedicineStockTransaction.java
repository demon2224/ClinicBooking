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
public class MedicineStockTransaction {

    // The unique identifier for the stock transaction
    private int StockTransactionID;

    // The medicine associated with this transaction
    private Medicine medicine;

    // The quantity of medicine in this transaction
    private int quantity;

    // The date and time when the medicine was imported
    private LocalDateTime dateImport;

    // The expiration date and time of the medicine
    private LocalDateTime dateExpire;

    /**
     * Default constructor for MedicineStockTransaction.
     */
    public MedicineStockTransaction() {
    }

    /**
     * Gets the stock transaction ID.
     *
     * @return The unique identifier for this transaction
     */
    public int getStockTransactionID() {
        return StockTransactionID;
    }

    /**
     * Sets the stock transaction ID.
     *
     * @param StockTransactionID The ID to set for this transaction
     */
    public void setStockTransactionID(int StockTransactionID) {
        this.StockTransactionID = StockTransactionID;
    }

    /**
     * Gets the medicine associated with this transaction.
     *
     * @return The medicine object
     */
    public Medicine getMedicine() {
        return medicine;
    }

    /**
     * Sets the medicine for this transaction.
     *
     * @param medicine The medicine to associate with this transaction
     */
    public void setMedicine(Medicine medicine) {
        this.medicine = medicine;
    }

    /**
     * Gets the quantity of medicine in this transaction.
     *
     * @return The quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Sets the quantity for this transaction.
     *
     * @param quantity The quantity to set
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * Gets the import date and time.
     *
     * @return The import timestamp
     */
    public LocalDateTime getDateImport() {
        return dateImport;
    }

    /**
     * Sets the import date and time.
     *
     * @param dateImport The import timestamp to set
     */
    public void setDateImport(LocalDateTime dateImport) {
        this.dateImport = dateImport;
    }

    /**
     * Gets the expiration date and time.
     *
     * @return The expiration timestamp
     */
    public LocalDateTime getDateExpire() {
        return dateExpire;
    }

    /**
     * Sets the expiration date and time.
     *
     * @param dateExpire The expiration timestamp to set
     */
    public void setDateExpire(LocalDateTime dateExpire) {
        this.dateExpire = dateExpire;
    }

    /**
     * Calculates the total value of this transaction.
     *
     * @return The total value (price * quantity)
     */
    public double getTotalValue() {
        return this.medicine.getPrice() * this.quantity;
    }

    /**
     * Formats the import date into a display-friendly string.
     *
     * @return Formatted date string in "dd/MM/yyyy HH:mm:ss" format, or empty
     * string if null
     */
    public String getDateImportFormatDate() {
        if (this.dateImport == null) {
            return "";
        }
        return this.dateImport.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }

    /**
     * Formats the expiration date into a display-friendly string.
     *
     * @return Formatted date string in "dd/MM/yyyy HH:mm:ss" format, or empty
     * string if null
     */
    public String getDateExpireFormatDate() {
        if (this.dateExpire == null) {
            return "";
        }
        return this.dateExpire.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }
}
