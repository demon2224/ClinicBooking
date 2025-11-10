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
    public static final String MANAGE_FEEDBACK_JSP = "/WEB-INF/patient/ManageMyFeedback.jsp";
    public static final String MY_FEEDBACK_DETAIL_JSP = "/WEB-INF/patient/MyFeedbackDetail.jsp";
    public static final String MANAGE_FEEDBACK_URL = "/manage-my-feedback";

    // Validation constants
    public static final int MIN_RATE_SCORE = 1;
    public static final int MAX_RATE_SCORE = 5;
    public static final int MIN_CONTENT_LENGTH = 1;
    public static final int MAX_CONTENT_LENGTH = 500;

    // Error messages
    public static final String ERROR_CONTENT_LENGTH = "Content must be between " + MIN_CONTENT_LENGTH + " and "
            + MAX_CONTENT_LENGTH + " characters.";
    public static final String ERROR_GENERAL = "An error occurred while processing your request.";
    public static final String ERROR_INVALID_RATING = "Rating must be between " + MIN_RATE_SCORE + " and "
            + MAX_RATE_SCORE + ".";
    public static final String ERROR_INVALID_REVIEW_ID = "The review you requested could not be found.";
    public static final String ERROR_INVALID_DOCTOR_ID = "Please select a doctor you wish to review.";
    public static final String ERROR_REVIEW_NOT_FOUND = "Review not found!";
    public static final String ERROR_REQUIRED_REVIEW_ID = "An error occurred while trying to open this review. Please try again.";
    public static final String ERROR_UNAUTHORIZED_ACCESS = "You don't have permission to view this review.";
    public static final String ERROR_EXISTS_DOCTOR_REVIEW = "You have already reviewed this doctor.";
    public static final String ERROR_CANNOT_REVIEW_DOCTOR = "You can only review doctors from completed appointments within 24 hours.";
    public static final String ERROR_CANNOT_EDIT_REVIEW = "You can only edit your review within 24 hours of creating it.";
    public static final String ERROR_FAILED_SUBMIT_REVIEW = "Failed to submit your feedback. Please try again.";
    public static final String ERROR_FAILED_DELETE_REVIEW = "Failed to delete your feedback. Please try again.";
    public static final String ERROR_FAILED_UPDATE_REVIEW = "Failed to update your feedback. Please try again.";

    // Success messages
    public static final String SUCCESS_FEEDBACK_SUBMIT = "Your feedback has been submitted successfully!";
    public static final String SUCCESS_FEEDBACK_UPDATE = "Your feedback has been updated successfully!";
    public static final String SUCCESS_FEEDBACK_DELETE = "Your feedback has been deleted successfully!";

    // View modes
    public static final String VIEW_MODE_DETAIL = "detail";
    public static final String VIEW_MODE_LIST = "list";
}
