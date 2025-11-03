/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class MedicineInfomationValidate {

    public static final String MEDICINE_NAME_REGEX = "^[a-zA-Z\\s]+$";
    public static final String MEDICINE_CODE_REGEX = "^([a-zA-Z]){3}([0-9]){3}$";
    public static final String DATE_FORMAT = "yyyy-MM-dd";

    public static final int MIN_MEDICINE_NAME_LENGTH = 0;
    public static final int MEDICINE_CODE_LENGTH = 6;
    public static final int MIN_MEDICINE_QUANTITY = 0;
    public static final double MIN_MEDICINE_PRICE = 0;

    public static final int AVAILABLE_MEDICINE_STATUS = 1;
    public static final int UNAVAILABLE_MEDICINE_STATUS = 0;
    
    public static final int ACTIVE_MEDICINE_STATUS = 1;
    public static final int INTACTIVE_MEDICINE_STATUS = 0;
    
    public static final String[] MEDICINE_TYPE_LIST = {"Tablet", "Capsule", "Syrup", "Ointment", "Drops"};

    /**
     * Check the input is null or empty.
     *
     * @param input is the input need to check
     * @return True if the input is null or empty. False if not
     */
    public static boolean isEmpty(String input) {
        return input == null || input.isBlank();
    }

    /**
     * Check the name of medicine is valid or not. Valid medicine name is only
     * contains character or white space.
     *
     * @param medicineName is the name of medicine
     * @return True if medicine name is valid. False if it is invalid
     */
    public static boolean isValidMedicineName(String medicineName) {
        return medicineName.matches(MEDICINE_NAME_REGEX);
    }

    /**
     * Check the code of medicine is valid or not. Valid medicine code is first
     * 3 letters is character, last 3 letters is number.
     *
     * @param medicineCode is the code of medicine
     * @return True if medicine code is valid. False if it is invalid
     */
    public static boolean isValidMedicineCode(String medicineCode) {
        return medicineCode.matches(MEDICINE_CODE_REGEX);
    }

    /**
     * Check the length of medicine code is valid or not. Valid medicine code is
     * length = 6.
     *
     * @param medicineCode is the code of medicine
     * @return True if medicine code is valid. False if it is invalid
     */
    public static boolean isValidMedicineCodeLength(String medicineCode) {
        return medicineCode.length() == MEDICINE_CODE_LENGTH;
    }

    /**
     * Check the type of medicine is valid or not. Valid medicine type is all
     * the exist medicine type exist in the database.
     *
     * @param medicineType is the type of medicine
     * @return True if medicine type is valid. False if it is invalid
     */
    public static boolean isValidMedicineType(String medicineType) {
        for (String type : MEDICINE_TYPE_LIST) {
            if (type.equals(medicineType)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Check the quantity of medicine is valid or not. Valid medicine quantity
     * can not be negative.
     *
     * @param quantity is the quantity of medicine
     * @return True if medicine quantity is valid. False if it is invalid
     */
    public static boolean isValidMedicineQuantity(int quantity) {
        return quantity > MIN_MEDICINE_QUANTITY;
    }

    /**
     * Check the quantity of medicine is valid or not. Valid medicine quantity
     * can not be empty or contain character.
     *
     * @param medicineQuantity is the quantity of medicine
     * @return True if medicine quantity is valid. False if it is invalid
     */
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

    /**
     * Check the price of medicine is valid or not. Valid medicine price can not
     * be negative.
     *
     * @param price is the price of medicine
     * @return True if medicine price is valid. False if it is invalid
     */
    public static boolean isValidMedicinePrice(double price) {
        return price > MIN_MEDICINE_PRICE;
    }

    /**
     * Check the price of medicine is valid or not. Valid medicine price can not
     * be empty or contain character.
     *
     * @param medicinePrice is the price of medicine
     * @return True if medicine price is valid. False if it is invalid
     */
    public static boolean isValidMedicinePriceNumber(String medicinePrice) {
        double price;
        try {
            if (medicinePrice.length() <= MIN_MEDICINE_PRICE) {
                throw new NumberFormatException();
            }
            price = Double.parseDouble(medicinePrice);
        } catch (NumberFormatException ex) {
            return false;
        }

        return isValidMedicinePrice(price);
    }

    /**
     * Check if the status of medicine is valid or not. Valid medicine status
     * can not be anything else except 0 (unavailable) or 1 (available).
     *
     * @param status is the status of medicine
     * @return True if medicine status is valid. False if it is invalid
     */
    public static boolean isValidMedicineStatus(String status) {
        try {
            int statusValue = Integer.parseInt(status);
            return statusValue == UNAVAILABLE_MEDICINE_STATUS || statusValue == AVAILABLE_MEDICINE_STATUS;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    /**
     * Check if the status of medicine is valid or not. Valid medicine status
     * can not be anything else except 0 (unavailable) or 1 (available).
     *
     * @param activeStatus is the status of medicine
     * @return True if medicine status is valid. False if it is invalid
     */
    public static boolean isValidActiveMedicineStatus(String activeStatus) {
        try {
            int statusValue = Integer.parseInt(activeStatus);
            return statusValue == ACTIVE_MEDICINE_STATUS || statusValue == INTACTIVE_MEDICINE_STATUS;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
