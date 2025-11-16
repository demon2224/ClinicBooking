/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Validation class for profile form data
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class ProfileValidate {

    // Regular expressions
    private static final String EMAIL_REGEX = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
    private static final String PHONE_REGEX = "^(0|\\+84)[0-9]{9,10}$";
    private static final String NAME_REGEX = "^[a-zA-Z\\s]{2,50}$";
    private static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$";
    private static final String ADDRESS_REGEX = "^[a-zA-Z0-9\\s,.-]{5,200}$";

    /**
     * Validate name (first name or last name)
     *
     * @param name Name to validate
     * @return true if valid
     */
    public static boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return name.matches(NAME_REGEX);
    }

    /**
     * Validate email address
     *
     * @param email Email to validate
     * @return true if valid
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return email.matches(EMAIL_REGEX);
    }

    /**
     * Validate phone number
     *
     * @param phoneNumber Phone to validate
     * @return true if valid
     */
    public static boolean isValidPhoneNumber(String phoneNumber) {
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            return false;
        }
        return phoneNumber.matches(PHONE_REGEX);
    }

    /**
     * Validate date of birth Must be at least 18 years old
     *
     * @param dobString Date string (yyyy-MM-dd format)
     * @return true if valid
     */
    public static boolean isValidDateOfBirth(String dobString) {
        if (dobString == null || dobString.trim().isEmpty()) {
            return false;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false);
            Date dob = sdf.parse(dobString);

            // Check if date is not in the future
            Date now = new Date();
            if (dob.after(now)) {
                return false;
            }

            // Calculate age properly using Calendar
            java.util.Calendar dobCal = java.util.Calendar.getInstance();
            dobCal.setTime(dob);

            java.util.Calendar nowCal = java.util.Calendar.getInstance();
            nowCal.setTime(now);

            int age = nowCal.get(java.util.Calendar.YEAR) - dobCal.get(java.util.Calendar.YEAR);

            // If birthday hasn't occurred this year, subtract 1
            int currentMonth = nowCal.get(java.util.Calendar.MONTH);
            int currentDay = nowCal.get(java.util.Calendar.DAY_OF_MONTH);
            int birthMonth = dobCal.get(java.util.Calendar.MONTH);
            int birthDay = dobCal.get(java.util.Calendar.DAY_OF_MONTH);

            if (currentMonth < birthMonth || (currentMonth == birthMonth && currentDay < birthDay)) {
                age--;
            }

            return age >= 18;

        } catch (ParseException e) {
            return false;
        }
    }

    /**
     * Validate gender value
     *
     * @param gender Gender string
     * @return true if valid
     */
    public static boolean isValidGender(String gender) {
        if (gender == null || gender.trim().isEmpty()) {
            return false;
        }
        return gender.equals("Male") || gender.equals("Female") || gender.equals("Other");
    }

    /**
     * Validate address
     * Address is optional, so null or empty is valid
     * If provided, must match address format
     *
     * @param address Address to validate
     * @return true if valid (null/empty is valid)
     */
    public static boolean isValidAddress(String address) {
        // Address is optional, so null or empty is valid
        if (address == null || address.trim().isEmpty()) {
            return true;
        }
        return address.matches(ADDRESS_REGEX);
    }

    /**
     * Validate password with detailed error messages
     *
     * @param password Password to validate
     * @return List of specific error messages (empty if valid)
     */
    public static List<String> validatePasswordStrength(String password) {
        List<String> errors = new ArrayList<>();

        if (password == null || password.trim().isEmpty()) {
            errors.add("Password cannot be blank");
            return errors;
        }

        if (password.length() < 8) {
            errors.add("Password must be at least 8 characters");
        }

        if (!password.matches(".*[A-Z].*")) {
            errors.add("Password must contain at least 1 uppercase letter");
        }

        if (!password.matches(".*[a-z].*")) {
            errors.add("Password must contain at least 1 lowercase letter");
        }

        if (!password.matches(".*[0-9].*")) {
            errors.add("Password must contain at least 1 number");
        }

        if (!password.matches(".*[@#$%^&+=!].*")) {
            errors.add("Password must contain at least 1 special character");
        }

        if (password.contains(" ")) {
            errors.add("Password cannot contain spaces");
        }

        return errors;
    }

    /**
     * Check if new password matches confirmation
     *
     * @param password New password
     * @param confirmPassword Password confirmation
     * @return true if matched
     */
    public static boolean isPasswordMatch(String password, String confirmPassword) {
        if (password == null || confirmPassword == null) {
            return false;
        }
        return password.equals(confirmPassword);
    }

    /**
     * Validate first name and return error message if invalid
     *
     * @param firstName First name to validate
     * @return Error message if invalid, null if valid
     */
    public static String validateFirstName(String firstName) {
        if (firstName == null || firstName.trim().isEmpty()) {
            return "First name is required";
        } else if (!isValidName(firstName)) {
            return "First name must be 2-50 characters and contain only letters";
        }
        return null;
    }

    /**
     * Validate last name and return error message if invalid
     *
     * @param lastName Last name to validate
     * @return Error message if invalid, null if valid
     */
    public static String validateLastName(String lastName) {
        if (lastName == null || lastName.trim().isEmpty()) {
            return "Last name is required";
        } else if (!isValidName(lastName)) {
            return "Last name must be 2-50 characters and contain only letters";
        }
        return null;
    }

    /**
     * Validate phone number format and return error message if invalid
     * Note: This only validates format, not uniqueness
     *
     * @param phoneNumber Phone number to validate
     * @return Error message if invalid, null if valid
     */
    public static String validatePhoneNumberFormat(String phoneNumber) {
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            return "Phone number is required";
        } else if (!isValidPhoneNumber(phoneNumber)) {
            return "Phone number must start with 0 or +84, followed by 9-10 digits";
        }
        return null;
    }

    /**
     * Validate email format and return error message if invalid
     * Note: This only validates format, not uniqueness
     *
     * @param email Email to validate
     * @return Error message if invalid, null if valid
     */
    public static String validateEmailFormat(String email) {
        if (email == null || email.trim().isEmpty()) {
            return "Email is required";
        } else if (!isValidEmail(email)) {
            return "Email format is invalid";
        }
        return null;
    }

    /**
     * Validate address and return error message if invalid
     * Address is optional, so null or empty is valid
     *
     * @param address Address to validate
     * @return Error message if invalid, null if valid
     */
    public static String validateAddress(String address) {
        // Address is optional, only validate if provided
        if (address != null && !address.trim().isEmpty() && !isValidAddress(address)) {
            return "Address must be 5-200 characters (letters, numbers, spaces, commas, dots, hyphens only)";
        }
        return null;
    }

    /**
     * Validate date of birth and return error message if invalid
     *
     * @param dobStr Date of birth string (yyyy-MM-dd format)
     * @return Error message if invalid, null if valid
     */
    public static String validateDob(String dobStr) {
        if (dobStr == null || dobStr.trim().isEmpty()) {
            return "Date of birth is required";
        } else if (!isValidDateOfBirth(dobStr)) {
            return "You must be at least 18 years old";
        }
        return null;
    }

    /**
     * Validate gender and return error message if invalid
     *
     * @param genderStr Gender string
     * @return Error message if invalid, null if valid
     */
    public static String validateGender(String genderStr) {
        if (genderStr == null || genderStr.trim().isEmpty()) {
            return "Gender is required";
        } else if (!isValidGender(genderStr)) {
            return "Gender must be Male or Female";
        }
        return null;
    }

    /**
     * Validate current password (check if not empty)
     *
     * @param currentPassword Current password
     * @return Error message if invalid, null if valid
     */
    public static String validateCurrentPassword(String currentPassword) {
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            return "Current password is required";
        }
        return null;
    }

    /**
     * Validate password match between new password and confirmation
     *
     * @param newPassword New password
     * @param confirmPassword Password confirmation
     * @return Error message if invalid, null if valid
     */
    public static String validatePasswordMatch(String newPassword, String confirmPassword) {
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            return "Password confirmation is required";
        }
        
        if (!isPasswordMatch(newPassword, confirmPassword)) {
            return "New password and confirmation do not match";
        }
        
        return null;
    }

    /**
     * Validate that new password is different from current password
     *
     * @param currentPassword Current password
     * @param newPassword New password
     * @return Error message if invalid, null if valid
     */
    public static String validatePasswordDifferent(String currentPassword, String newPassword) {
        if (currentPassword != null && currentPassword.equals(newPassword)) {
            return "New password must be different from current password";
        }
        return null;
    }
}
