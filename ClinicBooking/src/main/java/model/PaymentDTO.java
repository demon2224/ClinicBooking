package model;

/**
 * PaymentDTO - Encapsulate payment information
 * @author Le Anh Tuan - CE180905
 */
public class PaymentDTO {
    private String bankName;
    private String accountNumber;
    private String accountName;
    private String paymentReference;
    private String vietQrImageUrl;
    private String currencyDisplay;
    private double vndAmount;

    public PaymentDTO() {
    }

    public PaymentDTO(String bankName, String accountNumber, String accountName,
                      String paymentReference, String vietQrImageUrl, 
                      String currencyDisplay, double vndAmount) {
        this.bankName = bankName;
        this.accountNumber = accountNumber;
        this.accountName = accountName;
        this.paymentReference = paymentReference;
        this.vietQrImageUrl = vietQrImageUrl;
        this.currencyDisplay = currencyDisplay;
        this.vndAmount = vndAmount;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getPaymentReference() {
        return paymentReference;
    }

    public void setPaymentReference(String paymentReference) {
        this.paymentReference = paymentReference;
    }

    public String getVietQrImageUrl() {
        return vietQrImageUrl;
    }

    public void setVietQrImageUrl(String vietQrImageUrl) {
        this.vietQrImageUrl = vietQrImageUrl;
    }

    public String getCurrencyDisplay() {
        return currencyDisplay;
    }

    public void setCurrencyDisplay(String currencyDisplay) {
        this.currencyDisplay = currencyDisplay;
    }

    public double getVndAmount() {
        return vndAmount;
    }

    public void setVndAmount(double vndAmount) {
        this.vndAmount = vndAmount;
    }
}