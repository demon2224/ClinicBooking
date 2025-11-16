<%-- Document : Doctor Detail Created on : Oct 10, 2025, 12:46:40 PM Author : Nguyen Minh Khang - CE190728 --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dr.${doctor.staffID.firstName} ${doctor.staffID.lastName} - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <!-- Font Awesome Icons -->
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=${System.currentTimeMillis()}" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="doctors" />
        </jsp:include>

        <div class="doctor-detail-container">
            <div class="appointment-page-header">
                <h1><i class="fas fa-user-md"></i> Doctor Detail </h1>
            </div>
            <!-- Doctor Profile Card -->
            <div class="doctor-detail-card">
                <div class="doctor-detail-header">
                    <!-- Main Doctor Info (Left Side) -->
                    <div class="doctor-detail-main-info">
                        <div class="doctor-detail-avatar-container">
                            <c:choose>
                                <c:when test="${doctor.staffID.avatar != null && !empty doctor.staffID.avatar}">
                                    <img src="${pageContext.request.contextPath}/${doctor.staffID.avatar}"
                                         alt="Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}"
                                         class="doctor-detail-avatar"
                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assests/img/0.png'">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assests/img/0.png"
                                         alt="Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}"
                                         class="doctor-detail-avatar"
                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'">
                                    <div class="doctor-detail-avatar-fallback" style="display: none;">
                                        <i class="fas fa-user-md"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="doctor-detail-info">
                            <h1 class="doctor-detail-name">
                                Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}
                            </h1>
                            <c:if test="${not empty doctor.specialtyID.specialtyName}">
                                <p class="doctor-detail-specialty">
                                    <i class="fas fa-user-md"></i>
                                    ${doctor.specialtyID.specialtyName}
                                </p>
                            </c:if>
                            <div class="doctor-detail-contact">
                                <c:if test="${not empty doctor.staffID.phoneNumber}">
                                    <div class="doctor-detail-contact-item">
                                        <i class="fas fa-phone"></i>
                                        <span>${doctor.staffID.phoneNumber}</span>
                                    </div>
                                </c:if>
                                <c:if test="${not empty doctor.staffID.email}">
                                    <div class="doctor-detail-contact-item">
                                        <i class="fas fa-envelope"></i>
                                        <span>${doctor.staffID.email}</span>
                                    </div>
                                </c:if>
                            </div>
                            <c:if test="${not empty degrees}">
                                <div class="doctor-detail-qualifications">
                                    <h4 class="doctor-detail-qualifications-title">
                                        <i class="fas fa-graduation-cap"></i>
                                        Qualifications
                                    </h4>
                                    <c:forEach var="degree" items="${degrees}">
                                        <div class="doctor-detail-qualification-item">
                                            <div class="doctor-detail-qualification-icon">
                                                <i class="fas fa-certificate"></i>
                                            </div>
                                            <div class="doctor-detail-qualification-content">
                                                <div class="doctor-detail-qualification-name">
                                                    ${degree.degreeName}
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>

                        </div>
                    </div>
                    <div class="doctor-detail-side-info">
                        <div class="doctor-detail-side-item">
                            <span class="doctor-detail-side-label">
                                <i class="fas fa-star"></i>
                                Rating
                            </span>
                            <div class="doctor-detail-rating-display">
                                <c:choose>
                                    <c:when test="${averageRating > 0}">
                                        <span class="doctor-detail-stars">
                                            <c:forEach begin="1" end="5" var="star">
                                                <c:choose>
                                                    <c:when test="${star <= averageRating}">★</c:when>
                                                    <c:when test="${star - averageRating < 1}">⯨</c:when>
                                                    <c:otherwise>☆</c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </span>
                                        <span class="doctor-detail-side-value">
                                            <c:choose>
                                                <c:when test="${averageRating % 1 == 0}">
                                                    ${averageRating.intValue()}/5
                                                </c:when>
                                                <c:otherwise>
                                                    ${averageRating}/5
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="doctor-detail-side-value">No ratings</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="doctor-detail-side-item">
                            <span class="doctor-detail-side-label">
                                <i class="fas fa-check-circle"></i>
                                Status
                            </span>
                            <span class="doctor-detail-side-value">
                                ${doctor.staffID.jobStatus}
                            </span>
                        </div>
                        <div class="doctor-detail-side-item">
                            <span class="doctor-detail-side-label">
                                <i class="fas fa-user-md"></i>
                                Experience
                            </span>
                            <span class="doctor-detail-side-value">${doctor.yearExperience} years</span>
                        </div>
                        <div class="doctor-detail-actions">
                            <a href="${pageContext.request.contextPath}/manage-my-appointments?action=bookAppointment&doctorId=${doctor.doctorID}" class="doctor-detail-btn-book">
                                <i class="fas fa-calendar-plus"></i>
                                Book
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="doctor-detail-about-section">
                <div class="doctor-detail-about-header">
                    <h3 class="doctor-detail-about-title">
                        <i class="fas fa-info-circle"></i>
                        About Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}
                    </h3>
                </div>
                <div class="doctor-detail-about-content">
                    <c:choose>
                        <c:when test="${not empty doctor.staffID.bio}">
                            ${doctor.staffID.bio}
                        </c:when>
                        <c:otherwise>
                            <div class="doctor-detail-no-bio">
                                <i class="fas fa-user-md" style="font-size: 1.5rem; color: #dee2e6; margin-bottom: 0.5rem;"></i>
                                <p>No biography information available for this doctor.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <jsp:include page="DoctorReview.jsp" />
        </div>
        <jsp:include page="includes/footer.jsp" />

    </body>

</html>