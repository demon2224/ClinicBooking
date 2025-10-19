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
    private int medicineTypeId;
    
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
     * @param medicineTypeId   The unique identifier for the medicine type
     * @param medicineType The name/description of the medicine type
     */
    public MedicineType(int medicineTypeId, String medicineType) {
        this.medicineTypeId = medicineTypeId;
        this.medicineType = medicineType;
    }

    /**
     * Gets the medicine type ID.
     *
     * @return The medicine type ID
     */
    public int getMedicineTypeId() {
        return medicineTypeId;
    }

    /**
     * Sets the medicine type ID.
     *
     * @param medicineTypeId The medicine type ID to set
     */
    public void setMedicineId(int medicineTypeId) {
        this.medicineTypeId = medicineTypeId;
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
