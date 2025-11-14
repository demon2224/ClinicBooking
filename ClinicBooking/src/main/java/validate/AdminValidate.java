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
    public static final String USERNAME_REGEX = "^[A-Za-z0-9]{8,200}$";  // BR-06
    public static final String FULLNAME_REGEX = "^[A-Za-z\\s]+$";        // BR-07 + BR-08
    public static final String PHONE_REGEX = "^0\\d{9,10}$";             // BR-12
    public static final String ADDRESS_REGEX = "^.{5,}$";                // >= 5 chars
    public static final String GENDER_REGEX = "^(true|false)$";
    public static final String ROLE_REGEX = "^(Doctor|Pharmacist|Receptionist|Admin)$";

    // PASSWORD RULE (BR-10)
    public static final int MIN_PASSWORD_LENGTH = 8;
    public static final int MAX_PASSWORD_LENGTH = 200;
    public static final String PASSWORD_REGEX
            = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[^A-Za-z0-9]).+$";

    // ===================== CONSTANT RULES ===================== //
    public static final int MIN_AGE = 18;
    public static final int MAX_AGE = 120;

    public static final int MIN_EXPERIENCE = 0;
    public static final double MIN_PRICE = 0;

    // ===================== BASIC CHECK ===================== //
    public static boolean isEmpty(String input) {
        return input == null || input.trim().isEmpty();
    }

    // ===================== ACCOUNT VALIDATION ===================== //
    public static boolean isValidUsername(String username) {
        return !isEmpty(username) && username.matches(USERNAME_REGEX);
    }

    public static boolean isValidFullName(String fullName) {
        return !isEmpty(fullName) && fullName.matches(FULLNAME_REGEX);
    }

    public static boolean isValidPhone(String phone) {
        return !isEmpty(phone) && phone.matches(PHONE_REGEX);
    }

    public static boolean isValidAddress(String address) {
        return !isEmpty(address) && address.matches(ADDRESS_REGEX);
    }

    public static boolean isValidGender(String gender) {
        return gender != null && gender.matches(GENDER_REGEX);
    }

    public static boolean isValidRole(String role) {
        return role != null && role.matches(ROLE_REGEX);
    }

    public static boolean isValidJobStatus(String jobStatus) {
        return jobStatus != null
                && (jobStatus.equals("Available")
                || jobStatus.equals("Unavailable")
                || jobStatus.equals("Retired"));
    }

    public static boolean isValidHiddenStatus(String hidden) {
        return "0".equals(hidden) || "1".equals(hidden);
    }

    // ===================== PASSWORD ===================== //
    public static boolean isValidPassword(String password) {
        return !isEmpty(password)
                && password.length() >= MIN_PASSWORD_LENGTH
                && password.length() <= MAX_PASSWORD_LENGTH
                && password.matches(PASSWORD_REGEX);
    }

    // ===================== DATE OF BIRTH (BR-17) ===================== //
    public static boolean isValidDOB(LocalDate dob) {
        if (dob == null || dob.isAfter(LocalDate.now())) {
            return false;
        }
        int age = Period.between(dob, LocalDate.now()).getYears();
        return age >= MIN_AGE && age <= MAX_AGE;
    }

    // ===================== DOCTOR EXPERIENCE ===================== //
    public static boolean isValidExperience(String experience, LocalDate dob) {
        try {
            int exp = Integer.parseInt(experience);
            if (exp < MIN_EXPERIENCE) {
                return false;
            }

            int age = Period.between(dob, LocalDate.now()).getYears();
            int maxExp = Math.max(0, age - MIN_AGE);
            return exp <= maxExp;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    // ===================== PRICE ===================== //
    public static boolean isValidPrice(String price) {
        try {
            double p = Double.parseDouble(price);
            return p >= MIN_PRICE;  // BR-50
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
