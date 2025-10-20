/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Medicine;
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
    public List<Medicine> getAllMedicines() {
        String query = "SELECT m.MedicineID, mt.MedicineTypeName, m.MedicineStatus, m.MedicineName, m.MedicineCode, m.Price, m.Quantity, \n"
                + "		(SELECT TOP 1 subst.DateImport\n"
                + "		FROM [dbo].[MedicineStockTransaction] subst\n"
                + "		WHERE subst.MedicineID = m.MedicineID\n"
                + "		ORDER BY subst.DateImport DESC) AS LastStock\n"
                + "FROM [dbo].[Medicine] m\n"
                + "JOIN [dbo].[MedicineType] mt\n"
                + "ON mt.MedicineTypeID = m.MedicineTypeID;";

        ResultSet rs = null;
        List<Medicine> medicineList = new ArrayList<>();

        try {
            rs = executeSelectQuery(query);
            while (rs.next()) {

                Medicine medicine = new Medicine();
                medicine.setMedicineId(rs.getInt("MedicineID"));
                medicine.setMedicineType(rs.getString("MedicineTypeName"));
                medicine.setMedicineStatus(rs.getBoolean("MedicineStatus"));
                medicine.setMedicineName(rs.getString("MedicineName"));
                medicine.setMedicineCode(rs.getString("MedicineCode"));
                medicine.setPrice(rs.getDouble("Price"));
                medicine.setQuantity(rs.getInt("Quantity"));
                medicine.setLastStockTransaction(rs.getObject("LastStock", LocalDateTime.class));

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
    public Medicine getMedicineById(int medicineId) {
        String query = "SELECT m.MedicineID, mt.MedicineTypeName, m.MedicineStatus, m.MedicineName, m.MedicineCode, m.Quantity, m.Price, m.DateCreate, \n"
                + "             (SELECT TOP 1 subst.DateImport\n"
                + "		FROM [dbo].[MedicineStockTransaction] subst\n"
                + "		WHERE subst.MedicineID = m.MedicineID\n"
                + "		ORDER BY subst.DateImport DESC) AS LastStock\n"
                + "FROM [dbo].[Medicine] m\n"
                + "JOIN [dbo].[MedicineType] mt\n"
                + "ON mt.MedicineTypeID = m.MedicineTypeID\n"
                + "WHERE m.MedicineID = ?;";

        ResultSet rs = null;
        Object[] params = {medicineId};
        Medicine medicine = null;

        try {
            rs = executeSelectQuery(query, params);
            while (rs.next()) {

                medicine = new Medicine();
                medicine.setMedicineId(rs.getInt("MedicineID"));
                medicine.setMedicineType(rs.getString("MedicineTypeName"));
                medicine.setMedicineStatus(rs.getBoolean("MedicineStatus"));
                medicine.setMedicineName(rs.getString("MedicineName"));
                medicine.setMedicineCode(rs.getString("MedicineCode"));
                medicine.setPrice(rs.getDouble("Price"));
                medicine.setQuantity(rs.getInt("Quantity"));
                medicine.setDateCreated(rs.getObject("DateCreate", LocalDateTime.class));
                medicine.setLastStockTransaction(rs.getObject("LastStock", LocalDateTime.class));
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
    public List<Medicine> searchMedicineByTypeNameCode(String medicineType, String medicineName, String medicineCode) {
        String query = "SELECT m.MedicineID, mt.MedicineTypeName, m.MedicineStatus, m.MedicineName, m.MedicineCode, m.Quantity, m.Price, m.DateCreate, \n"
                + "		(SELECT TOP 1 subst.DateImport\n"
                + "		FROM [dbo].[MedicineStockTransaction] subst\n"
                + "		WHERE subst.MedicineID = m.MedicineID\n"
                + "		ORDER BY subst.DateImport DESC) AS LastStock\n"
                + "FROM [dbo].[Medicine] m\n"
                + "JOIN [dbo].[MedicineType] mt\n"
                + "ON mt.MedicineTypeID = m.MedicineTypeID\n"
                + "WHERE m.MedicineCode LIKE ?\n"
                + "OR mt.MedicineTypeName LIKE ?\n"
                + "OR m.MedicineName LIKE ?;";
        Object[] params = {"%" + medicineCode + "%",
            "%" + medicineType + "%",
            "%" + medicineName + "%"};
        ResultSet rs = null;
        List<Medicine> medicineList = new ArrayList<>();

        try {
            rs = executeSelectQuery(query, params);

            while (rs.next()) {
                Medicine medicine = new Medicine();

                medicine.setMedicineId(rs.getInt("MedicineID"));
                medicine.setMedicineType(rs.getString("MedicineTypeName"));
                medicine.setMedicineStatus(rs.getBoolean("MedicineStatus"));
                medicine.setMedicineName(rs.getString("MedicineName"));
                medicine.setMedicineCode(rs.getString("MedicineCode"));
                medicine.setPrice(rs.getDouble("Price"));
                medicine.setQuantity(rs.getInt("Quantity"));
                medicine.setDateCreated(rs.getObject("DateCreate", LocalDateTime.class));
                medicine.setLastStockTransaction(rs.getObject("LastStock", LocalDateTime.class));

                medicineList.add(medicine);
            }
        } catch (SQLException ex) {
            Logger.getLogger(MedicineDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return medicineList;
    }

    public int createNewMedicine(String medicineName, String medicineCode, String medicineType, double price, int status) {
        String query = "INSERT INTO [dbo].[Medicine] (MedicineTypeID, MedicineStatus, MedicineName, MedicineCode, Price)\n"
                + "VALUES \n"
                + "	((SELECT TOP 1 mt.MedicineTypeID\n"
                + "	FROM [dbo].[MedicineType] mt\n"
                + "	WHERE mt.MedicineTypeName LIKE ?)\n"
                + "	, ?, ?, ?, ?);";
        Object[] params = {medicineType, status, medicineName, medicineCode, price};
        int rs;

        rs = executeQuery(query, params);
        closeResources(null);

        return rs;
    }

    public int editMedicine(String medicineName, String medicineCode, String medicineType, double price, int status, int medicineID) {
        String query = "UPDATE [dbo].[Medicine]\n"
                + "SET MedicineTypeID =\n"
                + "	(SELECT TOP 1 mt.MedicineTypeID\n"
                + "	FROM [dbo].[MedicineType] mt\n"
                + "	WHERE mt.MedicineTypeName LIKE ?)\n"
                + "	, MedicineStatus = ?, MedicineName = ?, MedicineCode = ?, Price = ?\n"
                + "WHERE MedicineID = ?;";
        Object[] params = {medicineType, status, medicineName, medicineCode, price, medicineID};
        int rs;

        rs = executeQuery(query, params);
        closeResources(null);

        return rs;
    }

}
