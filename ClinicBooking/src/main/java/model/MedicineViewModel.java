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

    private LocalDateTime lastStockTransaction;

    public MedicineViewModel() {
    }

    public MedicineViewModel(LocalDateTime lastStockTransaction) {
        this.lastStockTransaction = lastStockTransaction;
    }

    public MedicineViewModel(LocalDateTime lastStockTransaction, int medicineId, String medicineType, boolean medicineStatus, String medicineName, String medicineCode, int quantity, double price, LocalDateTime dateCreated) {
        super(medicineId, medicineType, medicineStatus, medicineName, medicineCode, quantity, price, dateCreated);
        this.lastStockTransaction = lastStockTransaction;
    }

    public LocalDateTime getLastStockTransaction() {
        return lastStockTransaction;
    }

    public void setLastStockTransaction(LocalDateTime lastStockTransaction) {
        this.lastStockTransaction = lastStockTransaction;
    }

    public String getLastStockTransactionFormatDate() {
        if (this.lastStockTransaction == null) {
            return "";
        }
        return this.lastStockTransaction.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }
}
