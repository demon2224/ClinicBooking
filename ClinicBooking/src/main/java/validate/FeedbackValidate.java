/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import constants.ManageMyFeedbackConstants;

/**
 * Validation utility class for feedback-related operations
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class FeedbackValidate {

    /**
     * Validates content length
     *
     * @param content The content to validate
     * @return true if content is valid, false otherwise
     */
    public static boolean isValidContent(String content) {
        return content != null
                && content.trim().length() >= ManageMyFeedbackConstants.MIN_CONTENT_LENGTH
                && content.trim().length() <= ManageMyFeedbackConstants.MAX_CONTENT_LENGTH;
    }

    /**
     * Validates rating value
     *
     * @param rateScore The rating score to validate
     * @return true if rating is valid, false otherwise
     */
    public static boolean isValidRating(String rateScore) {
        if (rateScore == null || rateScore.trim().isEmpty()) {
            return false;
        }
        try {
            int rating = Integer.parseInt(rateScore.trim());
            return rating >= ManageMyFeedbackConstants.MIN_RATE_SCORE
                    && rating <= ManageMyFeedbackConstants.MAX_RATE_SCORE;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Validates review ID parameter
     *
     * @param reviewId The review ID to validate
     * @return true if review ID is valid, false otherwise
     */
    public static boolean isValidReviewId(String reviewId) {
        if (reviewId == null || reviewId.trim().isEmpty()) {
            return false;
        }
        try {
            int id = Integer.parseInt(reviewId.trim());
            return id > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Validates doctor ID parameter
     *
     * @param doctorId The doctor ID to validate
     * @return true if doctor ID is valid, false otherwise
     */
    public static boolean isValidDoctorId(String doctorId) {
        if (doctorId == null || doctorId.trim().isEmpty()) {
            return false;
        }
        try {
            int id = Integer.parseInt(doctorId.trim());
            return id > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Validates complete feedback data for creation
     *
     * @param content   The feedback content
     * @param rateScore The rating score
     * @param doctorId  The doctor ID
     * @return true if all data is valid, false otherwise
     */
    public static boolean isValidFeedbackData(String content, String rateScore, String doctorId) {
        return isValidContent(content)
                && isValidRating(rateScore)
                && isValidDoctorId(doctorId);
    }

    /**
     * Validates feedback data for update (without doctor ID)
     *
     * @param content   The feedback content
     * @param rateScore The rating score
     * @return true if data is valid, false otherwise
     */
    public static boolean isValidFeedbackUpdateData(String content, String rateScore) {
        return isValidContent(content) && isValidRating(rateScore);
    }

    /**
     * Validates all required parameters for creating a new feedback
     *
     * @param doctorId The doctor ID
     * @param content  The feedback content
     * @param rating   The rating score
     * @return ValidationResult with isValid flag and error message
     */
    public static ValidationResult validateCreateFeedback(String doctorId, String content, String rating) {
        if (!isValidDoctorId(doctorId)) {
            return new ValidationResult(false, ManageMyFeedbackConstants.ERROR_INVALID_DOCTOR_ID);
        }

        if (!isValidContent(content)) {
            return new ValidationResult(false, ManageMyFeedbackConstants.ERROR_CONTENT_LENGTH);
        }

        if (!isValidRating(rating)) {
            return new ValidationResult(false, ManageMyFeedbackConstants.ERROR_INVALID_RATING);
        }

        return new ValidationResult(true, null);
    }

    /**
     * Validates all required parameters for updating feedback
     *
     * @param reviewId The review ID
     * @param content  The feedback content
     * @param rating   The rating score
     * @return ValidationResult with isValid flag and error message
     */
    public static ValidationResult validateUpdateFeedback(String reviewId, String content, String rating) {
        if (!isValidReviewId(reviewId)) {
            return new ValidationResult(false, ManageMyFeedbackConstants.ERROR_REQUIRED_REVIEW_ID);
        }

        if (!isValidContent(content)) {
            return new ValidationResult(false, ManageMyFeedbackConstants.ERROR_CONTENT_LENGTH);
        }

        if (!isValidRating(rating)) {
            return new ValidationResult(false, ManageMyFeedbackConstants.ERROR_INVALID_RATING);
        }

        return new ValidationResult(true, null);
    }

    /**
     * Validates review ID for detail/edit/delete operations
     *
     * @param reviewId The review ID
     * @return ValidationResult with isValid flag and error message
     */
    public static ValidationResult validateReviewId(String reviewId) {
        if (!isValidReviewId(reviewId)) {
            return new ValidationResult(false, ManageMyFeedbackConstants.ERROR_REQUIRED_REVIEW_ID);
        }
        return new ValidationResult(true, null);
    }

    /**
     * Inner class to hold validation results
     */
    public static class ValidationResult {
        private final boolean isValid;
        private final String errorMessage;

        public ValidationResult(boolean isValid, String errorMessage) {
            this.isValid = isValid;
            this.errorMessage = errorMessage;
        }

        public boolean isValid() {
            return isValid;
        }

        public String getErrorMessage() {
            return errorMessage;
        }
    }
}
