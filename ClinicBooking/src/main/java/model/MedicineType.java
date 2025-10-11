/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class MedicineType {
    
    // The unique identifier for the medicine type
    private int medicineId;
    
    // The name/description of the medicine type
    private String medicineType;

    /**
     * Default constructor for MedicineType.
     */
    public MedicineType() {
    }

    /**
     * Constructs a MedicineType with specified ID and type name.
     *
     * @param medicineId   The unique identifier for the medicine type
     * @param medicineType The name/description of the medicine type
     */
    public MedicineType(int medicineId, String medicineType) {
        this.medicineId = medicineId;
        this.medicineType = medicineType;
    }

    /**
     * Gets the medicine type ID.
     *
     * @return The medicine type ID
     */
    public int getMedicineId() {
        return medicineId;
    }

    /**
     * Sets the medicine type ID.
     *
     * @param medicineId The medicine type ID to set
     */
    public void setMedicineId(int medicineId) {
        this.medicineId = medicineId;
    }

    /**
     * Gets the medicine type name.
     *
     * @return The medicine type name
     */
    public String getMedicineType() {
        return medicineType;
    }

    /**
     * Sets the medicine type name.
     *
     * @param medicineType The medicine type name to set
     */
    public void setMedicineType(String medicineType) {
        this.medicineType = medicineType;
    }
    
}
