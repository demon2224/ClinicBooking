/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class MedicineStockTransactionDTO {

    private int stockTransactionID;
    private MedicineDTO medicineID;
    private int quantity;
    private Timestamp dateImport;
    private Timestamp dateExpire;

    public MedicineStockTransactionDTO() {
    }

    public int getStockTransactionID() {
        return stockTransactionID;
    }

    public void setStockTransactionID(int stockTransactionID) {
        this.stockTransactionID = stockTransactionID;
    }

    public MedicineDTO getMedicineID() {
        return medicineID;
    }

    public void setMedicineID(MedicineDTO medicineID) {
        this.medicineID = medicineID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getDateImport() {
        return dateImport;
    }

    public void setDateImport(Timestamp dateImport) {
        this.dateImport = dateImport;
    }

    public Timestamp getDateExpire() {
        return dateExpire;
    }

    public void setDateExpire(Timestamp dateExpire) {
        this.dateExpire = dateExpire;
    }

}
