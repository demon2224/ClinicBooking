/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Timestamp;

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
    
    // Account table fields
    private String accountName;
    private String accountPassword;
    private Timestamp dayCreated;
    private String avatar;
    private String bio;
    
    // Profile table fields
    private String firstName;
    private String lastName;
    private Date dob;
    private boolean gender; // 0 = Female, 1 = Male
    private String userAddress;
    private String phoneNumber;
    private String email;
    
    // Additional fields for display
    private String roleName;
    private String fullName;

    // Constructors
    public User() {
    }

    public User(int userID, int roleID, String accountName, String firstName, String lastName) {
        this.userID = userID;
        this.roleID = roleID;
        this.accountName = accountName;
        this.firstName = firstName;
        this.lastName = lastName;
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

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getAccountPassword() {
        return accountPassword;
    }

    public void setAccountPassword(String accountPassword) {
        this.accountPassword = accountPassword;
    }

    public Timestamp getDayCreated() {
        return dayCreated;
    }

    public void setDayCreated(Timestamp dayCreated) {
        this.dayCreated = dayCreated;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getFullName() {
        if (firstName != null && lastName != null) {
            return firstName + " " + lastName;
        }
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    // Utility methods
    public String getGenderString() {
        return gender ? "Male" : "Female";
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

    @Override
    public String toString() {
        return "User{" +
                "userID=" + userID +
                ", roleID=" + roleID +
                ", accountName='" + accountName + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                '}';
    }
}
