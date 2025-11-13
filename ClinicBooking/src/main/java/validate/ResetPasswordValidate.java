/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class ResetPasswordValidate {
    public static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$";
    
    public static boolean isEmpty(String input) {
        return input == null || input.isBlank();
    }
    
    public static boolean isValidPassword(String input) {
        return input.matches(input);
    }
    
    public static boolean isValidConfirmPassword(String password, String confirmPassword) {
        return password.equals(confirmPassword);
        
    }
}
