package utils;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * VietQR Service - Handle VietQR code generation
 *
 * @author Le Anh Tuan - CE180905
 */
public class VietQRService {

    /**
     * Create VietQR image URL - Automatically convert USD to VND
     */
    public static String createVietQRImageUrl(double usdAmount, String description) {
        String bankCode = VietQRConfig.getBankCode();
        String accountNumber = VietQRConfig.getAccountNumber();
        String accountName = VietQRConfig.getAccountName();
        String template = VietQRConfig.getTemplate();
        String imageFormat = VietQRConfig.getImageFormat();
        String apiUrl = VietQRConfig.getApiUrl();

        // Convert USD to VND
        double vndAmount = convertUsdToVnd(usdAmount);
        String transferAmount = String.format("%.0f", vndAmount);

        // Create description with currency information
        String currencyDescription = description;
        try {
            // URL encode to avoid special character errors
            String encodedDescription = URLEncoder.encode(currencyDescription, StandardCharsets.UTF_8.toString());
            String encodedAccountName = URLEncoder.encode(accountName, StandardCharsets.UTF_8.toString());

            // Create VietQR URL
            return String.format("%s/%s-%s-%s.%s?amount=%s&addInfo=%s&accountName=%s",
                    apiUrl,
                    bankCode,
                    accountNumber,
                    template,
                    imageFormat,
                    transferAmount,
                    encodedDescription,
                    encodedAccountName);
        } catch (Exception e) {
            e.printStackTrace();
            // Fallback URL if encoding error occurs
            return String.format("%s/%s-%s-%s.%s?amount=%s",
                    apiUrl, bankCode, accountNumber, template, imageFormat, transferAmount);
        }
    }

    /**
     * Convert USD to VND using config rate
     */
    public static double convertUsdToVnd(double usdAmount) {
        double rate = VietQRConfig.getUsdToVndRate();
        return usdAmount * rate;
    }

    /**
     * Get formatted currency display string
     */
    public static String formatCurrencyDisplay(double usdAmount) {
        double vndAmount = convertUsdToVnd(usdAmount);
        return String.format("%.2f USD (≈ %.0f VNĐ)", usdAmount, vndAmount);
    }

    /**
     * Generate unique payment reference
     */
    public static String generatePaymentReference(int invoiceId, int patientId) {
        // Format: INV{invoiceId}-P{patientId}-{HHMM}
        SimpleDateFormat timeFormat = new SimpleDateFormat("HHmm");
        String currentTime = timeFormat.format(new Date());
        return String.format("INV%d-P%d-%s", invoiceId, patientId, currentTime);
    }
}
