/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

/**
 *
 * @author Le Thien Tri - CE191249
 */
public class CreatePrescriptionValidate {

    public static final int MIN_DOSAGE = 0;

    public static boolean isEmpty(String input) {
        return input == null || input.isBlank();
    }

    public static boolean isValidDosageNumber(int dosage, int maxQuantity) {
        return dosage > 0 && dosage <= maxQuantity;
    }

    public static boolean isValidDosage(String input) {
        try {
            int dosage = Integer.parseInt(input);

            return dosage > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isValidMedicineID(String input) {
        try {
            int medicineID = Integer.parseInt(input);

            return medicineID > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

}
