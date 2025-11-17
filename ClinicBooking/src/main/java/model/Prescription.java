/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class Prescription {
    private int prescriptionID;;
    private String prescriptionStatus;
    private LocalDateTime dateCreate;
    private String note;
    private boolean hidden;
    private List<PrescriptionItemDTO> prescriptionItemList;

    public Prescription() {
    }

    public int getPrescription() {
        return prescriptionID;
    }

    public void setPrescriptionID(int prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public String getPrescriptionStatus() {
        return prescriptionStatus;
    }

    public void setPrescriptionStatus(String prescriptionStatus) {
        this.prescriptionStatus = prescriptionStatus;
    }

    public LocalDateTime getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(LocalDateTime dateCreate) {
        this.dateCreate = dateCreate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public boolean isHidden() {
        return hidden;
    }

    public void setHidden(boolean hidden) {
        this.hidden = hidden;
    }

    public List<PrescriptionItemDTO> getPrescriptionItemList() {
        return prescriptionItemList;
    }

    public void setPrescriptionItemList(List<PrescriptionItemDTO> prescriptionItemList) {
        this.prescriptionItemList = prescriptionItemList;
    }
    
    public String getDateCreateFormatDate() {
        if (this.dateCreate == null) {
            return "";
        }
        return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(this.dateCreate);
    }

    public String getTotalValue() {
        if (this.prescriptionItemList == null) {
            return "0.0";
        }
        return calculateTotalValue();
    }

    private String calculateTotalValue() {
        double totalValue = 0.0;
        for (PrescriptionItemDTO prescriptionItemDTO : prescriptionItemList) {
            totalValue += prescriptionItemDTO.getMedicineID().getPrice() * prescriptionItemDTO.getDosage();
        }
        return String.format("%.2f", totalValue);
    }

    public boolean getIsExpired() {
        return this.dateCreate.plusHours(24).isBefore(LocalDateTime.now());
    }
}
