/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class Doctor {

    private int doctorID;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private String avatar;
    private String bio;
    private String specialtyName;
    private String jobStatusDescription;
    private int yearExperience;
    private int userID;
    private int jobStatusID;
    private int specialtyID;

    public Doctor() {
    }

    public Doctor(int doctorID, String firstName, String lastName, String email, String phoneNumber,
            String avatar, String bio, String specialtyName, String jobStatusDescription,
            int yearExperience, int userID, int jobStatusID, int specialtyID) {
        this.doctorID = doctorID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.avatar = avatar;
        this.bio = bio;
        this.specialtyName = specialtyName;
        this.jobStatusDescription = jobStatusDescription;
        this.yearExperience = yearExperience;
        this.userID = userID;
        this.jobStatusID = jobStatusID;
        this.specialtyID = specialtyID;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
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

    public String getSpecialtyName() {
        return specialtyName;
    }

    public void setSpecialtyName(String specialtyName) {
        this.specialtyName = specialtyName;
    }

    public String getJobStatusDescription() {
        return jobStatusDescription;
    }

    public void setJobStatusDescription(String jobStatusDescription) {
        this.jobStatusDescription = jobStatusDescription;
    }

    public int getYearExperience() {
        return yearExperience;
    }

    public void setYearExperience(int yearExperience) {
        this.yearExperience = yearExperience;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getJobStatusID() {
        return jobStatusID;
    }

    public void setJobStatusID(int jobStatusID) {
        this.jobStatusID = jobStatusID;
    }

    public int getSpecialtyID() {
        return specialtyID;
    }

    public void setSpecialtyID(int specialtyID) {
        this.specialtyID = specialtyID;
    }

    public String getFullName() {
        return "Dr. " + firstName + " " + lastName;
    }

    public boolean isAvailable() {
        return jobStatusID == 1;
    }
}
