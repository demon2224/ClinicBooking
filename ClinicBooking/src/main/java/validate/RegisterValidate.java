/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import java.time.LocalDate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class RegisterValidate {

    public static final int MIN_LENGTH_USERNAME = 8;
    public static final int MAX_LENGTH_USERNAME = 200;
    public static final String USERNAME_REGEX = "^[a-zA-Z0-9 ]+$";

    public static final int MIN_LENGTH_PASSWORD = 8;
    public static final int MAX_LENGTH_PASSWORD = 200;
    public static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$";

    public static final int MIN_LENGTH_FIRSTNAME = 1;
    public static final int MAX_LENGTH_FIRSTNAME = 200;
    public static final String FIRSTNAME_REGEX = "^[a-zA-Z ]+$";

    public static final int MIN_LENGTH_LASTNAME = 1;
    public static final int MAX_LENGTH_LASTNAME = 200;
    public static final String LASTNAME_REGEX = "^[a-zA-Z ]+$";

    public static final int MALE_SEX_VALUE = 1;
    public static final int FEMALE_SEX_VALUE = 0;

    public static final String EMAIL_REGEX = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";

    public static final String PHONE_REGEX = "^(0|\\+84)[0-9]{9}$";

    public static final int MIN_AGE = 18;
    public static final int MAX_AGE = 120;

    public static boolean isEmpty(String input) {
        return input == null || input.isBlank();
    }

    public static boolean isValidUsernameFormat(String input) {
        return input.matches(USERNAME_REGEX);
    }

    public static boolean isValidUsernameLength(String input) {
        return input.length() >= MIN_LENGTH_USERNAME && input.length() <= MAX_LENGTH_USERNAME;
    }

    public static boolean isValidPasswordLength(String input) {
        return input.length() >= MIN_LENGTH_PASSWORD && input.length() <= MAX_LENGTH_PASSWORD;
    }

    public static boolean isValidPasswordFormat(String input) {
        return input.matches(PASSWORD_REGEX);
    }

    public static boolean isValidPassword(String input) {
        return !isEmpty(input) && isValidPasswordLength(input) && isValidPasswordFormat(input);
    }

    public static boolean isValidUsername(String input) {
        return !isEmpty(input) && isValidUsernameLength(input) && isValidUsernameFormat(input);
    }

    public static boolean isValidFirstNameLength(String input) {
        return input.length() >= MIN_LENGTH_FIRSTNAME && input.length() <= MAX_LENGTH_FIRSTNAME;
    }

    public static boolean isValidLastNameLength(String input) {
        return input.length() >= MIN_LENGTH_LASTNAME && input.length() <= MAX_LENGTH_LASTNAME;
    }

    public static boolean isValidFirstName(String input) {
        return input.matches(FIRSTNAME_REGEX);
    }

    public static boolean isValidLastName(String input) {
        return input.matches(LASTNAME_REGEX);
    }

    public static boolean isValidSex(String input) {
        try {
            int sex = Integer.parseInt(input);
            return sex == MALE_SEX_VALUE || sex == FEMALE_SEX_VALUE;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isValidEmail(String input) {
        return input.matches(EMAIL_REGEX);
    }

    public static boolean isValidPhoneNumber(String input) {
        return input.matches(PHONE_REGEX);
    }

    public static boolean isValidDateFormat(String input) {
        try {
            LocalDate dob = LocalDate.parse(input);
            return dob != null;
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isValidDob(String input) {
        LocalDate dob = LocalDate.parse(input);
        LocalDate today = LocalDate.now();

        if (dob.isAfter(today)) {
            return false;
        }

        LocalDate minDob = LocalDate.now().minusYears(MIN_AGE);
        LocalDate maxDob = LocalDate.now().minusYears(MAX_AGE);

        return dob.isBefore(minDob) && dob.isAfter(maxDob);
    }
}
