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
    private MedicineDTO medicineIID;
    private int Dosage;
    private String instruction;

    public PrescriptionItemDTO(PrescriptionDTO prescriptionID, MedicineDTO medicineIID, int Dosage, String instruction) {
        this.prescriptionID = prescriptionID;
        this.medicineIID = medicineIID;
        this.Dosage = Dosage;
        this.instruction = instruction;
    }

    public PrescriptionDTO getPrescriptionID() {
        return prescriptionID;
    }

    public void setPrescriptionID(PrescriptionDTO prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public MedicineDTO getMedicineIID() {
        return medicineIID;
    }

    public void setMedicineIID(MedicineDTO medicineIID) {
        this.medicineIID = medicineIID;
    }

    public int getDosage() {
        return Dosage;
    }

    public void setDosage(int Dosage) {
        this.Dosage = Dosage;
    }

    public String getInstruction() {
        return instruction;
    }

    public void setInstruction(String instruction) {
        this.instruction = instruction;
    }

}
