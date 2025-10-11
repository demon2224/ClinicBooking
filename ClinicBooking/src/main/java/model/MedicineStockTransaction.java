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
    
    private int StockTransactionID;
    
    private Medicine medicine;
    private int quantity;
    private LocalDateTime dateImport;
    private LocalDateTime dateExpire;

    public MedicineStockTransaction() {
    }

    public int getStockTransactionID() {
        return StockTransactionID;
    }

    public void setStockTransactionID(int StockTransactionID) {
        this.StockTransactionID = StockTransactionID;
    }

    public Medicine getMedicine() {
        return medicine;
    }

    public void setMedicine(Medicine medicine) {
        this.medicine = medicine;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getDateImport() {
        return dateImport;
    }

    public void setDateImport(LocalDateTime dateImport) {
        this.dateImport = dateImport;
    }

    public LocalDateTime getDateExpire() {
        return dateExpire;
    }

    public void setDateExpire(LocalDateTime dateExpire) {
        this.dateExpire = dateExpire;
    }
    
    public double getTotalValue() {
        return this.medicine.getPrice() * this.quantity;
    }
    
    public String getDateImportFormatDate() {
        if (this.dateImport == null) {
            return "";
        }
        return this.dateImport.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }
    
    public String getDateExpireFormatDate() {
        if (this.dateExpire == null) {
            return "";
        }
        return this.dateExpire.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }
}
