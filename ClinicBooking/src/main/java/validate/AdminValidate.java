/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import java.time.LocalDate;
import java.time.Period;

/**
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class AdminValidate {

    // ===================== REGEX PATTERNS ===================== //
    public static final String USERNAME_REGEX = "^[A-Za-z0-9_]{8,}$";
    public static final String FULLNAME_REGEX = "^[A-Za-z\\s]+$";
    public static final String PHONE_REGEX = "^0\\d{9,10}$";
    public static final String ADDRESS_REGEX = "^.{5,}$";
    public static final String GENDER_REGEX = "^(true|false)$";
    public static final String ROLE_REGEX = "^(Doctor|Pharmacist|Receptionist|Admin)$";

    // 🔹 NEW: Password rules
    public static final int MIN_PASSWORD_LENGTH = 8;
    public static final int MAX_PASSWORD_LENGTH = 200;
    public static final String PASSWORD_REGEX = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[^A-Za-z0-9]).+$";

    // ===================== CONSTANT RULES ===================== //
    public static final int MIN_AGE = 18;
    public static final int MIN_EXPERIENCE = 0;
    public static final int MIN_PRICE = 0;

    // ===================== VALIDATION METHODS ===================== //
    /**
     * Check if input is null or empty.
     */
    public static boolean isEmpty(String input) {
        return input == null || input.trim().isEmpty();
    }

    /**
     * Check if username is valid.
     */
    public static boolean isValidUsername(String username) {
        return !isEmpty(username) && username.matches(USERNAME_REGEX);
    }

    /**
     * Check if full name is valid.
     */
    public static boolean isValidFullName(String fullName) {
        return !isEmpty(fullName) && fullName.matches(FULLNAME_REGEX);
    }

    /**
     * Check if phone number is valid.
     */
    public static boolean isValidPhone(String phone) {
        return !isEmpty(phone) && phone.matches(PHONE_REGEX);
    }

    /**
     * Check if address is valid.
     */
    public static boolean isValidAddress(String address) {
        return !isEmpty(address) && address.matches(ADDRESS_REGEX);
    }

    /**
     * Check if gender value is valid (true/false).
     */
    public static boolean isValidGender(String gender) {
        return gender != null && gender.matches(GENDER_REGEX);
    }

    /**
     * Check if role is one of the allowed roles.
     */
    public static boolean isValidRole(String role) {
        return role != null && role.matches(ROLE_REGEX);
    }

    /**
     * Check if job status is valid (Available, Unavailable, Retired).
     */
    public static boolean isValidJobStatus(String jobStatus) {
        return jobStatus != null
                && (jobStatus.equals("Available")
                || jobStatus.equals("Unavailable")
                || jobStatus.equals("Retired"));
    }

    /**
     * Validate date of birth (at least 18 years old).
     */
    public static boolean isValidDOB(LocalDate dob) {
        if (dob == null || dob.isAfter(LocalDate.now())) {
            return false;
        }
        return Period.between(dob, LocalDate.now()).getYears() >= MIN_AGE;
    }

    /**
     * Check if doctor's experience is a non-negative integer.
     */
    public static boolean isValidExperience(String experience) {
        try {
            int year = Integer.parseInt(experience);
            return year >= MIN_EXPERIENCE;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Check if doctor's price is a valid positive number or zero.
     */
    public static boolean isValidPrice(String price) {
        try {
            double p = Double.parseDouble(price);
            return p >= MIN_PRICE;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Check if hidden status is valid (0 = active, 1 = inactive).
     */
    public static boolean isValidHiddenStatus(String hidden) {
        return "0".equals(hidden) || "1".equals(hidden);
    }

    // ===================== 🔹 NEW PASSWORD VALIDATION ===================== //
    /**
     * Check if password meets the pattern rules.
     */
    public static boolean isValidPassword(String password) {
        return !isEmpty(password) && password.matches(PASSWORD_REGEX);
    }

    /**
     * Check if password length is valid (8–200 chars).
     */
    public static boolean isValidPasswordLength(String password) {
        return !isEmpty(password)
                && password.length() >= MIN_PASSWORD_LENGTH
                && password.length() <= MAX_PASSWORD_LENGTH;
    }
}
