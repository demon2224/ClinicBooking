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
public class MedicineViewModel extends Medicine {

    // The date time of the last stock transaction for this medicine
    private LocalDateTime lastStockTransaction;

    /**
     * Default constructor for MedicineViewModel.
     */
    public MedicineViewModel() {
    }

    /**
     * Constructs a MedicineViewModel with only the last stock transaction time.
     *
     * @param lastStockTransaction The date time of the last stock transaction
     */
    public MedicineViewModel(LocalDateTime lastStockTransaction) {
        this.lastStockTransaction = lastStockTransaction;
    }

    /**
     * Constructs a complete MedicineViewModel with all properties.
     *
     * @param lastStockTransaction The date time of the last stock transaction
     * @param medicineId The unique identifier for the medicine
     * @param medicineType The type/category of the medicine
     * @param medicineStatus The availability status of the medicine
     * @param medicineName The name of the medicine
     * @param medicineCode The unique code for the medicine
     * @param quantity The current quantity in stock
     * @param price The price of the medicine
     * @param dateCreated The creation date of the medicine record
     */
    public MedicineViewModel(LocalDateTime lastStockTransaction, int medicineId,
            String medicineType, boolean medicineStatus, String medicineName,
            String medicineCode, int quantity, double price, LocalDateTime dateCreated) {
        super(medicineId, medicineType, medicineStatus, medicineName,
                medicineCode, quantity, price, dateCreated);
        this.lastStockTransaction = lastStockTransaction;
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
