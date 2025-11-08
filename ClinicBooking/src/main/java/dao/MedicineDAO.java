/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.MedicineDTO;
import utils.DBContext;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class MedicineDAO extends DBContext {

    /**
     * Get all record of all medicines.
     *
     * @return a list contain all medicine information
     */
    public List<MedicineDTO> getAllMedicines() {

        String query = "SELECT m.MedicineID, m.MedicineType, m.MedicineStatus, m.MedicineName, m.MedicineCode, m.Quantity, m.Price, m.DateCreate, m.[Hidden]\n"
                + "FROM [dbo].[Medicine] m\n"
                + "ORDER BY Hidden ASC;";

        ResultSet rs = null;
        List<MedicineDTO> medicineList = new ArrayList<>();

        try {
            rs = executeSelectQuery(query);
            while (rs.next()) {

                MedicineDTO medicine = new MedicineDTO();
                medicine.setMedicineID(rs.getInt("MedicineID"));
                medicine.setMedicineType(rs.getString("MedicineType"));
                medicine.setMedicineStatus(rs.getBoolean("MedicineStatus"));
                medicine.setMedicineName(rs.getString("MedicineName"));
                medicine.setMedicineCode(rs.getString("MedicineCode"));
                medicine.setQuantity(rs.getInt("Quantity"));
                medicine.setPrice(rs.getDouble("Price"));
                medicine.setDateCreate(rs.getObject("DateCreate", Timestamp.class));
                medicine.setIsHidden(rs.getBoolean("Hidden"));

                medicineList.add(medicine);
            }
        } catch (SQLException ex) {
            Logger.getLogger(MedicineDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return medicineList;
    }

    /**
     * Get a specific medicine information by medicineId.
     *
     * @param medicineId is the medicine want to get information
     * @return an object contain information of a medicine
     */
    public MedicineDTO getMedicineById(int medicineId) {

        String query = "SELECT m.MedicineID, m.MedicineType, m.MedicineStatus, m.MedicineName, m.MedicineCode, m.Quantity, m.Price, m.DateCreate, m.[Hidden]\n"
                + "FROM [dbo].[Medicine] m\n"
                + "WHERE m.MedicineID = ?;";

        ResultSet rs = null;
        Object[] params = {medicineId};
        MedicineDTO medicine = null;

        try {
            rs = executeSelectQuery(query, params);
            while (rs.next()) {

                medicine = new MedicineDTO();
                medicine.setMedicineID(rs.getInt("MedicineID"));
                medicine.setMedicineType(rs.getString("MedicineType"));
                medicine.setMedicineStatus(rs.getBoolean("MedicineStatus"));
                medicine.setMedicineName(rs.getString("MedicineName"));
                medicine.setMedicineCode(rs.getString("MedicineCode"));
                medicine.setQuantity(rs.getInt("Quantity"));
                medicine.setPrice(rs.getDouble("Price"));
                medicine.setDateCreate(rs.getObject("DateCreate", Timestamp.class));
                medicine.setIsHidden(rs.getBoolean("Hidden"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(MedicineDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return medicine;
    }

    /**
     * Get all record of all medicine match with user search input.
     *
     * @param medicineType is the type of medicine
     * @param medicineName is the name of medicine
     * @param medicineCode is the code of medicine
     * @return a list contain all medicine match with user search input
     */
    public List<MedicineDTO> searchMedicineByTypeNameCode(String medicineType, String medicineName, String medicineCode) {

        String query = "SELECT m.MedicineID, m.MedicineType, m.MedicineStatus, m.MedicineName, m.MedicineCode, m.Quantity, m.Price, m.DateCreate, m.[Hidden]\n"
                + "FROM [dbo].[Medicine] m\n"
                + "WHERE m.MedicineCode LIKE ?\n"
                + "OR m.MedicineType LIKE ?\n"
                + "OR m.MedicineName LIKE ?;";
        Object[] params = {"%" + medicineCode + "%",
            "%" + medicineType + "%",
            "%" + medicineName + "%"};
        ResultSet rs = null;
        List<MedicineDTO> medicineList = new ArrayList<>();

        try {
            rs = executeSelectQuery(query, params);

            while (rs.next()) {
                MedicineDTO medicine = new MedicineDTO();

                medicine.setMedicineID(rs.getInt("MedicineID"));
                medicine.setMedicineType(rs.getString("MedicineType"));
                medicine.setMedicineStatus(rs.getBoolean("MedicineStatus"));
                medicine.setMedicineName(rs.getString("MedicineName"));
                medicine.setMedicineCode(rs.getString("MedicineCode"));
                medicine.setQuantity(rs.getInt("Quantity"));
                medicine.setPrice(rs.getDouble("Price"));
                medicine.setDateCreate(rs.getObject("DateCreate", Timestamp.class));
                medicine.setIsHidden(rs.getBoolean("Hidden"));

                medicineList.add(medicine);
            }
        } catch (SQLException ex) {
            Logger.getLogger(MedicineDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return medicineList;
    }

    public boolean createNewMedicine(String medicineName, String medicineCode, String medicineType, double price, int status) {
        String query = "INSERT INTO [dbo].[Medicine] (MedicineType, MedicineStatus, MedicineName, MedicineCode, Price, Hidden)\n"
                + "VALUES\n"
                + "	(?, ?, ?, ?, ?, ?, 1);";
        Object[] params = {medicineType, status, medicineName, medicineCode, price};
        int rs = executeQuery(query, params);
        closeResources(null);

        return rs != 0;
    }

    public boolean editMedicine(String medicineType, int medicineStatus, String medicineName, String medicineCode, double price, int medicineID) {

        String query = "UPDATE [dbo].[Medicine]\n"
                + "SET\n"
                + "	MedicineType = ?,\n"
                + "	MedicineStatus = ?,\n"
                + "	MedicineName = ?,\n"
                + "	MedicineCode = ?,\n"
                + "	Price = ?\n"
                + "WHERE MedicineID = ?"
                + "AND Hidden = 0;";
        Object[] params = {medicineType, medicineStatus, medicineName, medicineCode, price, medicineID};

        int rs = executeQuery(query, params);
        closeResources(null);

        return rs != 0;
    }

    public boolean deleteMedicine(int medicineID) {

        String query = "UPDATE [dbo].[Medicine]\n"
                + "SET Hidden = 1\n"
                + "WHERE MedicineID = ?;";
        Object[] params = {medicineID};

        int rs = executeQuery(query, params);
        closeResources(null);

        return rs != 0;
    }

    public boolean importMedicine(int quantity, int medicineID) {

        String query = "UPDATE [dbo].[Medicine]\n"
                + "SET Quantity = Quantity + ?\n"
                + "WHERE MedicineID = ?;";
        Object[] params = {quantity, medicineID};

        int rs = executeQuery(query, params);
        closeResources(null);

        return rs != 0;
    }

    public boolean isExistMedicineID(int medicineID) {

        String query = "SELECT m.MedicineID\n"
                + "FROM [dbo].[Medicine] m\n"
                + "WHERE m.MedicineID = ?\n"
                + "AND m.Hidden = 0;";
        Object[] params = {medicineID};
        ResultSet rs = null;
        int medicine = 0;

        try {
            rs = executeSelectQuery(query, params);
            if (rs.next()) {
                medicine = rs.getInt("MedicineID");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PrescriptionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return medicine != 0;
    }

    public int getQuantityMedicineByMedicineID(int medicineID) {

        String query = "SELECT m.Quantity\n"
                + "FROM [dbo].[Medicine] m\n"
                + "WHERE m.MedicineID = ?\n"
                + "AND m.Hidden = 0;";
        Object[] params = {medicineID};
        ResultSet rs = null;
        int quantity = 0;

        try {
            rs = executeSelectQuery(query, params);
            if (rs.next()) {
                quantity = rs.getInt("Quantity");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PrescriptionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return quantity;
    }

    public boolean isExistMedicineCode(String medicineCode) {

        String query = "SELECT m.MedicineID\n"
                + "from [dbo].[Medicine] m\n"
                + "WHERE m.MedicineCode = ?;";
        Object[] params = {medicineCode};
        ResultSet rs = null;

        try {
            rs = executeSelectQuery(query, params);
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(MedicineDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return false;
    }

    public String getMedicineCodeByMedicineID(int medicineID) {

        String query = "SELECT m.MedicineCode\n"
                + "from [dbo].[Medicine] m\n"
                + "WHERE m.MedicineID = ?;";
        Object[] params = {medicineID};
        ResultSet rs = null;
        String medicineCode = null;

        try {
            rs = executeSelectQuery(query, params);
            if (rs.next()) {
                medicineCode = rs.getString("MedicineCode");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PrescriptionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return medicineCode;
    }
}
