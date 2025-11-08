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
    private static final String PHONE_REGEX = "^(0|\\+84)[0-9]{9}$";
    private static final String NAME_REGEX = "^[a-zA-Z\\s]{2,50}$";
    private static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{6,}$";
    private static final String ADDRESS_REGEX = "^[a-zA-Z0-9\\s,.-]{5,200}$";

    /**
     * Validate all profile input fields
     *
     * @param firstName   First name
     * @param lastName    Last name
     * @param phoneNumber Phone number
     * @param email       Email address
     * @param dob         Date of birth string
     * @param gender      Gender
     * @param address     Address
     * @return List of error messages (empty if valid)
     */
    public static List<String> validateProfileInput(String firstName, String lastName,
            String phoneNumber, String email,
            String dob, String gender, String address) {
        List<String> errors = new ArrayList<>();

        // Validate first name
        if (!isValidName(firstName)) {
            errors.add("Invalid name (2-50 characters, letters only)");
        }

        // Validate last name
        if (!isValidName(lastName)) {
            errors.add("Invalid last name (2-50 characters, letters only)");
        }

        // Validate phone
        if (!isValidPhoneNumber(phoneNumber)) {
            errors.add("Invalid phone number (10 digits, starting with 0)");
        }

        // Validate email
        if (!isValidEmail(email)) {
            errors.add("Invalid email");
        }

        // Validate address
        if (!isValidAddress(address)) {
            errors.add("Invalid address (5-200 characters, letters, numbers, spaces, commas, dots, and hyphens only)");
        }

        // Validate DOB
        if (!isValidDateOfBirth(dob)) {
            errors.add("Invalid date of birth (yyyy-MM-dd format, must be 18 years old or older)");
        }

        // Validate gender
        if (!isValidGender(gender)) {
            errors.add("Invalid gender");
        }

        return errors;
    }

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
     *
     * @param address Address to validate
     * @return true if valid
     */
    public static boolean isValidAddress(String address) {
        if (address == null || address.trim().isEmpty()) {
            return false;
        }
        return address.matches(ADDRESS_REGEX);
    }

    /**
     * Validate password for password change Password must contain: - At least 6
     * characters - At least one uppercase letter - At least one lowercase letter -
     * At
     * least one special character (@#$%^&+=!)
     *
     * @param password Password to validate
     * @return true if valid
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            return false;
        }
        return password.matches(PASSWORD_REGEX);
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

        if (password.length() < 6) {
            errors.add("Password must be at least 6 characters");
        }

        if (!password.matches(".*[A-Z].*")) {
            errors.add("Password must contain at least 1 uppercase letter");
        }

        if (!password.matches(".*[a-z].*")) {
            errors.add("Password must contain at least 1 lowercase letter");
        }

        if (!password.matches(".*[@#$%^&+=!].*")) {
            errors.add("Password must have at least 1 special character");
        }

        if (password.contains(" ")) {
            errors.add("Password cannot contain spaces");
        }

        return errors;
    }

    /**
     * Check if new password matches confirmation
     *
     * @param password        New password
     * @param confirmPassword Password confirmation
     * @return true if matched
     */
    public static boolean isPasswordMatch(String password, String confirmPassword) {
        if (password == null || confirmPassword == null) {
            return false;
        }
        return password.equals(confirmPassword);
    }
}
