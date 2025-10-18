/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constants;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class ManageMyFeedbackConstants {

    // JSP and URL constants
    public static final String MANAGE_FEEDBACK_JSP = "/WEB-INF/ManageMyFeedback.jsp";
    public static final String MY_FEEDBACK_DETAIL_JSP = "/WEB-INF/MyFeedbackDetail.jsp";
    public static final String MANAGE_FEEDBACK_URL = "/manage-my-feedback";

    // Encoding
    public static final String URL_ENCODING = "UTF-8";

    // Validation constants
    public static final int MIN_RATE_SCORE = 1;
    public static final int MAX_RATE_SCORE = 5;
    public static final int MIN_CONTENT_LENGTH = 10;
    public static final int MAX_CONTENT_LENGTH = 500;

    // Error messages
    public static final String ERROR_CONTENT_LENGTH = "Content must be between " + MIN_CONTENT_LENGTH + " and "
            + MAX_CONTENT_LENGTH + " characters.";
    public static final String ERROR_GENERAL = "An error occurred while processing your request.";
    public static final String ERROR_INVALID_RATING = "Rating must be between " + MIN_RATE_SCORE + " and "
            + MAX_RATE_SCORE + ".";
    public static final String ERROR_INVALID_REVIEW_ID = "Invalid review ID.";
    public static final String ERROR_NOT_FOUND = "Review not found!";
    public static final String ERROR_REQUIRED_REVIEW_ID = "Review ID is required.";
    public static final String ERROR_UNAUTHORIZED_ACCESS = "You don't have permission to view this review.";

    // Info messages
    public static final String MSG_CREATE_FORM_PLACEHOLDER = "Create feedback form will be implemented later.";
    public static final String MSG_CREATE_PLACEHOLDER = "Create feedback functionality will be implemented later. DoctorID: ";
    public static final String MSG_DELETE_PLACEHOLDER = "Delete functionality will be implemented later.";
    public static final String MSG_DELETE_POST_PLACEHOLDER = "Delete functionality will be implemented later. ReviewID: ";
    public static final String MSG_EDIT_PLACEHOLDER = "Edit functionality will be implemented later.";
    public static final String MSG_UPDATE_PLACEHOLDER = "Update functionality will be implemented later.";

    // View modes
    public static final String VIEW_MODE_CREATE = "create";
    public static final String VIEW_MODE_DETAIL = "detail";
    public static final String VIEW_MODE_EDIT = "edit";
    public static final String VIEW_MODE_LIST = "list";
}
