/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class LoginValidate {
    
    public static final int MIN_LENGTH_USERNAME = 8;
    public static final int MAX_LENGTH_USERNAME = 200;
    public static final String USERNAME_REGEX = "^[a-zA-Z0-9]+$";
    
    public static final int MIN_LENGTH_PASSWORD = 8;
    public static final int MAX_LENGTH_PASSWORD = 200;
    public static final String PASSWORD_REGEX = "^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).+$";
    
    
    public static boolean isEmpty(String input) {
        return input == null || input.isBlank();
    }
    
    public static boolean isValidUsername(String input) {
        return input.matches(USERNAME_REGEX);
    }
    
    public static boolean isValidUsernameLength(String input) {
        return input.length() >= MIN_LENGTH_USERNAME && input.length() <= MAX_LENGTH_USERNAME;
    }
    
    public static boolean isValidPasswordLength(String input) {
        return input.length() >= MIN_LENGTH_PASSWORD && input.length() <= MAX_LENGTH_PASSWORD;
    }
    
    public static boolean isValidPassword(String input) {
        return input.matches(PASSWORD_REGEX);
    }
}
