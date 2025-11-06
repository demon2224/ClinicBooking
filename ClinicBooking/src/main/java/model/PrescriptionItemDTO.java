/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class PrescriptionItemDTO {

    private PrescriptionDTO prescriptionID;
    private MedicineDTO medicineID;
    private int dosage;
    private String instruction;

    public PrescriptionItemDTO() {
    }

    public PrescriptionItemDTO(PrescriptionDTO prescriptionID, MedicineDTO medicineID, int Dosage, String instruction) {
        this.prescriptionID = prescriptionID;
        this.medicineID = medicineID;
        this.dosage = Dosage;
        this.instruction = instruction;
    }

    public PrescriptionDTO getPrescriptionID() {
        return prescriptionID;
    }

    public void setPrescriptionID(PrescriptionDTO prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public MedicineDTO getMedicineID() {
        return medicineID;
    }

    public void setMedicineID(MedicineDTO medicineIID) {
        this.medicineID = medicineIID;
    }

    public int getDosage() {
        return dosage;
    }

    public void setDosage(int Dosage) {
        this.dosage = Dosage;
    }

    public String getInstruction() {
        return instruction;
    }

    public void setInstruction(String instruction) {
        this.instruction = instruction;
    }

    public String getSubTotal() {
        return String.format("%.2f", this.medicineID.getPrice() * this.dosage);
    }

}
