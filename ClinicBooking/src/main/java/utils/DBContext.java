/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author Le Anh Tuan - CE180905
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    private final String DB_URL = "jdbc:sqlserver://127.0.0.1:1433;databaseName=clinicbookingdatabase;encrypt=false";
    private final String DB_USER = "sa";
    private final String DB_PWD = "123456";

    private Connection conn;
    private PreparedStatement statement;

    public DBContext() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get database connection
     *
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
    }

    /**
     * Execute Select Query with parameters
     *
     * @param query SQL query string
     * @param params Parameters for the query
     * @return ResultSet
     */
    public ResultSet executeSelectQuery(String query, Object[] params) {
        try {
            conn = getConnection();
            statement = conn.prepareStatement(query);

            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    statement.setObject(i + 1, params[i]);
                }
            }
            return statement.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    /**
     * Execute Select Query with no parameters
     *
     * @param query SQL query string
     * @return ResultSet
     */
    public ResultSet executeSelectQuery(String query) {
        return executeSelectQuery(query, null);
    }

    /**
     * Execute INSERT/UPDATE/DELETE queries
     *
     * @param query SQL query string
     * @param params Parameters for the query
     * @return Number of affected rows
     */
    public int executeQuery(String query, Object[] params) {
        try {
            conn = getConnection();
            statement = conn.prepareStatement(query);

            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    statement.setObject(i + 1, params[i]);
                }
            }
            return statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    /**
     * Close ResultSet, PreparedStatement, and Connection safely
     *
     * @param rs the ResultSet need to close
     */
    public void closeResources(ResultSet rs) {
        try {
            if (this.conn != null) {
                conn.close();
            }
            if (this.statement != null) {
                statement.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
