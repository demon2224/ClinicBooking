/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class PrescriptionDTO {

    private int prescriptionID;
    private AppointmentDTO appointmentID;
    private String prescriptionStatus;
    private Timestamp dateCreate;
    private String note;
    private boolean hidden;
    private List<PrescriptionItemDTO> prescriptionItemList;

    public PrescriptionDTO() {
    }

    public int getPrescriptionID() {
        return prescriptionID;
    }

    public void setPrescriptionID(int prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public AppointmentDTO getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(AppointmentDTO appointmentID) {
        this.appointmentID = appointmentID;
    }

    public String getPrescriptionStatus() {
        return prescriptionStatus;
    }

    public void setPrescriptionStatus(String prescriptionStatus) {
        this.prescriptionStatus = prescriptionStatus;
    }

    public Timestamp getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Timestamp dateCreate) {
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

    @Override
    public String toString() {
        return "PrescriptionDTO{" + "prescriptionID=" + prescriptionID + ", appointmentID=" + appointmentID + ", prescriptionStatus=" + prescriptionStatus + ", dateCreate=" + dateCreate + ", note=" + note + ", hidden=" + hidden + '}';
    }

}
