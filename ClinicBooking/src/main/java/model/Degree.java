/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class Degree {

    private int degreeID;
    private String degreeName;

    public Degree() {
    }

    public Degree(int degreeID, String degreeName) {
        this.degreeID = degreeID;
        this.degreeName = degreeName;
    }

    public int getDegreeID() {
        return degreeID;
    }

    public void setDegreeID(int degreeID) {
        this.degreeID = degreeID;
    }

    public String getDegreeName() {
        return degreeName;
    }

    public void setDegreeName(String degreeName) {
        this.degreeName = degreeName;
    }

}
