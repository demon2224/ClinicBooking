/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class AvatarValidate {

    /**
     * Check if avatar path is valid
     *
     * @param avatarPath Path to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidAvatarPath(String avatarPath) {
        return avatarPath != null && !avatarPath.trim().isEmpty();
    }
}
