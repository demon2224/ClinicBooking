/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class Account {
    
    private int userId;
    
     // Account table fields
    private String accountName;
    private String accountPassword;
    private LocalDateTime dayCreated;
    private String avatar;
    private String bio;

    public Account() {
    }

    public Account(int userId, String accountName, String accountPassword, LocalDateTime dayCreated, String avatar, String bio) {
        this.userId = userId;
        this.accountName = accountName;
        this.accountPassword = accountPassword;
        this.dayCreated = dayCreated;
        this.avatar = avatar;
        this.bio = bio;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public LocalDateTime getDayCreated() {
        return dayCreated;
    }

    public void setDayCreated(LocalDateTime dayCreated) {
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
    
    
    
}
