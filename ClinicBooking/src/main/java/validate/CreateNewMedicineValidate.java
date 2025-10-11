/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import model.MedicineType;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class CreateNewMedicineValidate {

    public static final String MEDICINE_NAME_REGEX = "^[a-zA-Z\\s]+$";
    public static final String MEDICINE_CODE_REGEX = "^([a-zA-Z]){3}([0-9]){3}$";
    public static final String DATE_FORMAT = "yyyy-MM-dd";

    public static final int MIN_MEDICINE_NAME_LENGTH = 0;
    public static final int MEDICINE_CODE_LENGTH = 6;
    public static final int MIN_MEDICINE_QUANTITY = 0;
    public static final int MIN_MEDICINE_PRICE = 0;

    public static final int AVAILABLE_MEDICINE_STATUS = 1;
    public static final int UNAVAILABLE_MEDICINE_STATUS = 0;

    public static boolean isValidMedicineName(String medicineName) {
        return medicineName.matches(MEDICINE_NAME_REGEX);
    }

    public static boolean isValidMedicineCode(String medicineCode) {
        return medicineCode.matches(MEDICINE_CODE_REGEX);
    }

    public static boolean isValidMedicineCodeLength(String medicineCode) {
        return medicineCode.length() != MEDICINE_CODE_LENGTH;
    }

    public static boolean isValidMedicineType(String medicineType, List<MedicineType> medicineTypeList) {
        for (MedicineType medicineTypeName : medicineTypeList) {
            if (medicineTypeName.equals(medicineType)) {
                return true;
            }
        }

        return false;
    }

    public static boolean isValidMedicineQuantity(int quantity) {
        return quantity > MIN_MEDICINE_QUANTITY;
    }

    public static boolean isValidMedicneQuantityNumber(String medicineQuantity) {
        int quantity;
        try {
            if (medicineQuantity.length() <= MIN_MEDICINE_NAME_LENGTH) {
                throw new NumberFormatException();
            }
            quantity = Integer.parseInt(medicineQuantity);
        } catch (NumberFormatException ex) {
            return false;
        }

        return isValidMedicineQuantity(quantity);
    }

    public static boolean isValidMedicinePrice(int price) {
        return price > MIN_MEDICINE_PRICE;
    }

    public static boolean isValidMedicinePriceNumber(String medicinePrice) {
        int price;
        try {
            if (medicinePrice.length() <= MIN_MEDICINE_PRICE) {
                throw new NumberFormatException();
            }
            price = Integer.parseInt(medicinePrice);
        } catch (NumberFormatException ex) {
            return false;
        }

        return isValidMedicinePrice(price);
    }

    public static boolean isValidExpiryDate(String dateStr) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(DATE_FORMAT);
            LocalDate expiryDate = LocalDate.parse(dateStr, formatter);
            LocalDate today = LocalDate.now();

            return expiryDate.isAfter(today);
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    public static boolean isValidMedicineStatus(String status) {
        try {
            int statusValue = Integer.parseInt(status);
            return statusValue == UNAVAILABLE_MEDICINE_STATUS || statusValue == AVAILABLE_MEDICINE_STATUS;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
}
