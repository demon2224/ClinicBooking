package validate;

/**
 * Validation utility for Appointment input fields.
 *
 * @author Ngo Quoc Hung - CE191184
 */
public class AppointmentValidate {

    private static final String NAME_REGEX = "^[A-Za-z\\s]+$"; // Chỉ chữ cái tiếng Anh và khoảng trắng
    private static final String PHONE_REGEX = "^0\\d{9,10}$";  // Bắt đầu bằng 0, tổng cộng 10 hoặc 11 số
    private static final int MAX_NOTE_LENGTH = 500;

    /**
     * Check if a string is null or empty.
     */
    public static boolean isEmpty(String input) {
        return input == null || input.trim().isEmpty();
    }

    /**
     * Validate full name (only English letters and spaces).
     */
    public static boolean isValidName(String name) {
        if (isEmpty(name)) {
            return false;
        }
        return name.matches(NAME_REGEX);
    }

    /**
     * Validate phone number (must start with 0, total 10 or 11 digits).
     */
    public static boolean isValidPhone(String phone) {
        if (isEmpty(phone)) {
            return false;
        }
        return phone.matches(PHONE_REGEX);
    }

    /**
     * Validate note (not exceed 500 characters).
     */
    public static boolean isValidNote(String note) {
        if (note == null) {
            return true; // note có thể để trống
        }
        return note.length() <= MAX_NOTE_LENGTH;
    }

    /**
     * Validate that required fields are not empty.
     */
    public static boolean areRequiredFieldsFilled(String name, String phone, String dateBegin, String doctorId) {
        return !isEmpty(name) && !isEmpty(phone) && !isEmpty(dateBegin) && !isEmpty(doctorId);
    }
}
