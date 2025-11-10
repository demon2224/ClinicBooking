/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constants;

/**
 * Constants for ManageMyInvoiceController
 *
 * @author Le Anh Tuan - CE180905
 */
public class ManageMyInvoiceConstants {
    
    // URL Patterns and Paths
    public static final String BASE_URL = "/manage-my-invoices";
    public static final String DETAIL_PAGE_JSP = "/WEB-INF/patient/MyInvoiceDetail.jsp";
    public static final String LIST_PAGE_JSP = "/WEB-INF/patient/MyInvoiceList.jsp";
    
    // Request Parameters
    public static final String PARAM_ID = "id";
    public static final String PARAM_SEARCH = "search";
    
    // Session Attributes
    public static final String SESSION_PATIENT_ID = "patientId";
    public static final String SESSION_SUCCESS_MESSAGE = "successMessage";
    public static final String SESSION_ERROR_MESSAGE = "errorMessage";
    
    // Request Attributes
    public static final String ATTR_INVOICE_LIST = "invoiceList";
    public static final String ATTR_INVOICE = "invoice";
    public static final String ATTR_SEARCH_QUERY = "searchQuery";
    
    // Error Messages
    public static final String ERROR_INVALID_INVOICE_ID = "Invalid invoice ID.";
    public static final String ERROR_INVOICE_NOT_FOUND = "Invoice not found.";
    public static final String ERROR_UNAUTHORIZED_ACCESS = "You are not authorized to view this invoice.";
    public static final String ERROR_GENERAL = "An error occurred while processing your request.";
    public static final String ERROR_SESSION_EXPIRED = "Your session has expired. Please log in again.";
    
}
