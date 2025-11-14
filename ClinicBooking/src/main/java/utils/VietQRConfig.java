package utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * VietQR Configuration - Quản lý config cho VietQR API
 *
 * @author Le Anh Tuan - CE180905
 */
public class VietQRConfig {

    private static Properties props = new Properties();

    static {
        try ( InputStream input = VietQRConfig.class.getClassLoader()
                .getResourceAsStream("vietqr.properties")) {

            if (input != null) {
                props.load(input);
            } else {
                throw new RuntimeException("vietqr.properties not found!");
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static String get(String key) {
        return props.getProperty(key);
    }
    
    // Convenience methods for VietQR Service
    public static String getBankCode() {
        return props.getProperty("vietqr.bank.code");
    }
    
    public static String getAccountNumber() {
        return props.getProperty("vietqr.account.number");
    }
    
    public static String getAccountName() {
        return props.getProperty("vietqr.account.name");
    }
    
    public static String getTemplate() {
        return props.getProperty("vietqr.template");
    }
    
    public static String getImageFormat() {
        return props.getProperty("vietqr.image.format");
    }
    
    public static String getApiUrl() {
        return props.getProperty("vietqr.api.url");
    }
    
    public static double getUsdToVndRate() {
        String rateStr = props.getProperty("vietqr.usd.to.vnd.rate");
        return rateStr != null ? Double.parseDouble(rateStr) : 25000.0; // Default rate
    }
}
