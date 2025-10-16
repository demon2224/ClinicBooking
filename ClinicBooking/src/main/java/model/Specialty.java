/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class Specialty {

    private int specialtyId;
    private String spcialtyName;

    public Specialty() {
    }

    public Specialty(int specialtyId, String spcialtyName) {
        this.specialtyId = specialtyId;
        this.spcialtyName = spcialtyName;
    }

    public int getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(int specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getSpcialtyName() {
        return spcialtyName;
    }

    public void setSpcialtyName(String spcialtyName) {
        this.spcialtyName = spcialtyName;
    }
}
