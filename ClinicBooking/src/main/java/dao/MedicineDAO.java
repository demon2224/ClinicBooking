/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.MedicineViewModel;
import utils.DBContext;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class MedicineDAO extends DBContext {

    public List<MedicineViewModel> getAllMedicines() {
        String query = "SELECT m.MedicineID, mt.MedicineTypeName, m.MedicineStatus, m.MedicineName, m.MedicineCode, m.Price, m.Quantity, \n"
                + "		(SELECT TOP 1 subst.DateImport\n"
                + "		FROM [dbo].[StockTransaction] subst\n"
                + "		WHERE subst.MedicineID = m.MedicineID\n"
                + "		ORDER BY subst.DateImport DESC) AS LastStock\n"
                + "FROM [dbo].[Medicine] m\n"
                + "JOIN [dbo].[MedicineType] mt\n"
                + "ON mt.MedicineTypeID = m.MedicineType";
        ResultSet rs = null;
        List<MedicineViewModel> medicineList = new ArrayList<>();

        try {
            rs = executeSelectQuery(query);
            while (rs.next()) {
                
                MedicineViewModel medicine = new MedicineViewModel();
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
        }

        return medicineList;
    }

}
