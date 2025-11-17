/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class Patient {
    private int patientID;
    private String firstName;
    private String lastName;
    private LocalDateTime dob;
    private boolean gender;

    public Patient() {
    }

    public int getPatientID() {
        return patientID;
    }

    public void setPatientID(int patientID) {
        this.patientID = patientID;
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

    public LocalDateTime getDob() {
        return dob;
    }

    public void setDob(LocalDateTime dob) {
        this.dob = dob;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }
    
    public String getDobStringFormat() {
        if (this.dob == null) {
            return "";
        }
        return new SimpleDateFormat("dd/MM/yyyy").format(this.dob);
    }
    
    public String getGenderStringFormat() {
        return gender ? "Male" : "Female";
    }
}
