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
import model.MedicineStockTransaction;
import model.MedicineViewModel;
import utils.DBContext;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class MedicineStockTransactionDAO extends DBContext {

    /**
     * Get all record in table MedicineStockTransaction of a specific medicine
     * with medicineId.
     *
     * @param medicineId is the medicine want to get all record
     * @return a list contain all medicine stock transaction record of a medicine
     */
    public List<MedicineStockTransaction> getMedicineStockTransactionByMedicineId(int medicineId) {
        String query = "SELECT m.MedicineID, m.MedicineName, m.MedicineCode, mst.Quantity, m.Price, mst.DateImport, mst.DateExpire\n"
                + "FROM [dbo].[MedicineStockTransaction] mst\n"
                + "JOIN [dbo].[Medicine] m\n"
                + "ON m.MedicineID = mst.MedicineID\n"
                + "WHERE mst.MedicineID = ?\n"
                + "ORDER BY mst.DateImport DESC;";
        Object[] params = {medicineId};
        ResultSet rs = null;
        List<MedicineStockTransaction> medicineStockTransactionList = new ArrayList<>();

        try {
            rs = executeSelectQuery(query, params);
            if (rs.next()) {
                MedicineStockTransaction medicineStockTransaction = new MedicineStockTransaction();

                MedicineViewModel medicine = new MedicineViewModel();
                medicine.setMedicineId(rs.getInt("MedicineID"));
                medicine.setMedicineName(rs.getString("MedicineName"));
                medicine.setMedicineCode(rs.getString("MedicineCode"));
                medicine.setPrice(rs.getDouble("Price"));

                medicineStockTransaction.setMedicine(medicine);
                medicineStockTransaction.setQuantity(rs.getInt("Quantity"));
                medicineStockTransaction.setDateImport(rs.getObject("DateImport", LocalDateTime.class));
                medicineStockTransaction.setDateExpire(rs.getObject("DateExpire", LocalDateTime.class));

                medicineStockTransactionList.add(medicineStockTransaction);
            }
        } catch (SQLException ex) {
            Logger.getLogger(MedicineStockTransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(rs);
        }

        return medicineStockTransactionList;
    }

}
