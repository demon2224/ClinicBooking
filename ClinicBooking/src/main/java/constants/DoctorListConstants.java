/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constants;

/**
 *
 * @author Nguyen Minh Khang - CE190728
 */
public class DoctorListConstants {

    // Job status id
    public static final int AVAILABLE_ID = 1;
    // Experience range limits
    public static final int MIN_EXPERIENCE_YEARS = 0;
    public static final int MAX_EXPERIENCE_YEARS = 50;
    // Avatar path configuration
    public static final String DEFAULT_AVATAR = "assests/img/0.png";
    public static final String AVATAR_BASE_PATH = "assests/img/";
    public static final String AVATAR_PATH_PREFIX = "assests/";
    // JSP and URL constants
    public static final String DOCTOR_LIST_JSP = "/WEB-INF/DoctorList.jsp";
    public static final String DOCTOR_DETAIL_JSP = "/WEB-INF/DoctorDetail.jsp";
    public static final String DOCTOR_LIST_URL = "/doctor-list";
    public static final String DOCTOR_DETAIL_URL = "/doctor-detail";

    // Encoding and error message
    public static final String URL_ENCODING = "UTF-8";
    public static final String ERROR_LOADING_DOCTORS_MSG = "Error loading doctor list: ";
}
