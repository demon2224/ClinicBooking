/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 * User Model Class
 * Represents a user in the system with account, profile, and role information
 * 
 * @author Le Anh Tuan - CE180905
 */
public class User {
    // User table fields
    private int userID;
    private int roleID;
    
    private Account account;
    
    private Profile profile;
    
    // Additional fields for display
    private String roleName;
    private String fullName;

    // Constructors
    public User() {
    }

    public User(int userID, int roleID, Account account, Profile profile) {
        this.userID = userID;
        this.roleID = roleID;
        this.account = account;
        this.profile = profile;
    }

    // Getters and Setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Profile getProfile() {
        return profile;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getFullName() {
        if ((profile.getFirstName() != null) && (profile.getLastName() != null)) {
            return profile.getFirstName() + " " + profile.getLastName();
        }
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    // Utility methods
    public String getGenderString() {
        return profile.isGender() ? "Male" : "Female";
    }

    public boolean isPatient() {
        return roleID == 1;
    }

    public boolean isReceptionist() {
        return roleID == 2;
    }

    public boolean isPharmacist() {
        return roleID == 3;
    }

    public boolean isDoctor() {
        return roleID == 4;
    }

    public boolean isAdmin() {
        return roleID == 5;
    }


}
