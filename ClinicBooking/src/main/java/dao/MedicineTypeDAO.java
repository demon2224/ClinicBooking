///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package dao;
//
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//import model.MedicineType;
//import utils.DBContext;
//
///**
// *
// * @author Vu Minh Khang - CE191371
// */
//public class MedicineTypeDAO extends DBContext {
//
//    /**
//     * Get all record of medicine type.
//     *
//     * @return a list contain all medicine type
//     */
//    public List<MedicineType> getAllMedicineType() {
//        String query = "SELECT mt.MedicineTypeID, mt.MedicineTypeName\n"
//                + "FROM [dbo].[MedicineType] mt;";
//        ResultSet rs = null;
//        List<MedicineType> medicineTypeList = new ArrayList<>();
//
//        try {
//            rs = executeSelectQuery(query);
//
//            while (rs.next()) {
//                MedicineType medicineType = new MedicineType();
//
//                medicineType.setMedicineId(rs.getInt("MedicineTypeID"));
//                medicineType.setMedicineType(rs.getString("MedicineTypeName"));
//
//                medicineTypeList.add(medicineType);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(MedicineTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            closeResources(rs);
//        }
//
//        return medicineTypeList;
//    }
//}
