<%--
    Document : DoctorDetail
    Created on : Oct 10, 2025, 12:46:40 PM
    Author : Nguyen Minh Khang - CE190728
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dr.${doctor.firstName} ${doctor.lastName} - CLINIC</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet"
              type="text/css" />

        <style>
            body {
                margin: 0;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                padding-top: 80px;
                background-color: #f8f9fa;
                line-height: 1.6;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 2rem;
            }

            /* Doctor Profile Card */
            .doctor-profile-card {
                background: white;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                margin-bottom: 2rem;
                overflow: hidden;
            }

            .doctor-header {
                padding: 2rem;
                display: flex;
                gap: 2rem;
                align-items: flex-start;
                position: relative;
            }

            .doctor-avatar {
                width: 160px;
                height: 160px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #e9ecef;
                flex-shrink: 0;
            }

            .doctor-info {
                flex: 1;
            }

            .doctor-name {
                font-size: 2rem;
                font-weight: 700;
                color: #2c3e50;
                margin: 0 0 0.5rem 0;
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .availability-badge {
                background: #28a745;
                color: white;
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
            }

            .doctor-specialty {
                font-size: 1.1rem;
                color: #6c757d;
                margin-bottom: 0.5rem;
            }

            .doctor-credentials {
                color: #495057;
                margin-bottom: 1rem;
            }

            .doctor-languages {
                color: #6c757d;
                font-size: 0.95rem;
                margin-bottom: 1rem;
            }

            .contact-info {
                display: flex;
                gap: 2rem;
                margin-bottom: 1rem;
            }

            .contact-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: #495057;
            }

            .contact-item i {
                color: #175cdd;
                width: 18px;
            }

            .rating-section {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 1rem;
            }

            .rating-stars {
                display: flex;
                align-items: center;
                gap: 0.2rem;
            }

            .star {
                color: #ffc107;
                font-size: 1.2rem;
            }

            .rating-score {
                font-size: 1.1rem;
                font-weight: 600;
                color: #2c3e50;
            }

            .rating-count {
                color: #6c757d;
                font-size: 0.9rem;
            }

            .recommendation-badge {
                background: #d4edda;
                color: #155724;
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 600;
            }

            /* Action Buttons */
            .doctor-actions {
                display: flex;
                gap: 1rem;
                margin-top: 1.5rem;
            }

            .btn-action {
                padding: 0.8rem 2rem;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.95rem;
            }

            .btn-primary {
                background: #175cdd;
                color: white;
            }

            .btn-primary:hover {
                background: #1449c0;
                transform: translateY(-2px);
            }

            .btn-outline {
                background: white;
                color: #175cdd;
                border: 2px solid #175cdd;
            }

            .btn-outline:hover {
                background: #175cdd;
                color: white;
            }

            .btn-light {
                background: #f8f9fa;
                color: #495057;
                border: 1px solid #dee2e6;
            }

            .btn-light:hover {
                background: #e9ecef;
            }

            /* Statistics Cards */
            .doctor-stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                text-align: center;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
                border-left: 4px solid #175cdd;
            }

            .stat-icon {
                font-size: 2rem;
                color: #175cdd;
                margin-bottom: 0.5rem;
            }

            .stat-value {
                font-size: 1.5rem;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 0.3rem;
            }

            .stat-label {
                color: #6c757d;
                font-size: 0.9rem;
            }

            /* About Section */
            .about-section {
                background: white;
                border-radius: 12px;
                padding: 2rem;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
                margin-bottom: 2rem;
            }

            .section-title {
                font-size: 1.4rem;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .section-title i {
                color: #175cdd;
            }

            .bio-text {
                color: #495057;
                line-height: 1.7;
            }

            /* Reviews Section */
            .reviews-section {
                background: white;
                border-radius: 12px;
                padding: 2rem;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            }

            .reviews-header {
                display: flex;
                justify-content: between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .review-item {
                border-bottom: 1px solid #e9ecef;
                padding: 1.5rem 0;
            }

            .review-item:last-child {
                border-bottom: none;
            }

            .reviewer-info {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 0.8rem;
            }

            .reviewer-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: #175cdd;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
            }

            .reviewer-details h4 {
                margin: 0;
                font-size: 1rem;
                font-weight: 600;
                color: #2c3e50;
            }

            .review-meta {
                display: flex;
                align-items: center;
                gap: 1rem;
                font-size: 0.85rem;
                color: #6c757d;
            }

            .review-rating {
                display: flex;
                gap: 0.1rem;
            }

            .review-content {
                color: #495057;
                margin-bottom: 0.8rem;
            }

            .review-recommendation {
                display: inline-flex;
                align-items: center;
                gap: 0.3rem;
                background: #d4edda;
                color: #155724;
                padding: 0.2rem 0.6rem;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: 600;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .container {
                    padding: 1rem;
                }

                .doctor-header {
                    flex-direction: column;
                    text-align: center;
                    padding: 1.5rem;
                }

                .doctor-avatar {
                    width: 120px;
                    height: 120px;
                }

                .doctor-name {
                    font-size: 1.5rem;
                    justify-content: center;
                }

                .contact-info {
                    flex-direction: column;
                    gap: 0.8rem;
                }

                .doctor-actions {
                    flex-direction: column;
                }

                .doctor-stats {
                    grid-template-columns: repeat(2, 1fr);
                    gap: 1rem;
                }
            }
        </style>
    </head>

    <body>
        <!-- Header (same as DoctorList) -->
        <header class="header">
            <div class="header-content">
                <!-- Logo Section -->
                <div class="logo-section">
                    <div class="logo">
                        <i class="fas fa-heart-pulse"></i>
                        <span class="logo-text">CLINIC</span>
                    </div>
                </div>

                <!-- Navigation Menu -->
                <nav class="nav-menu">
                    <a href="#" class="nav-item active">
                        <i class="fas fa-home"></i>
                        Home
                    </a>
                    <a href="#" class="nav-item">
                        <i class="fas fa-user-md"></i>
                        Doctors
                    </a>
                    <a href="#" class="nav-item">
                        <i class="fas fa-calendar-check"></i>
                        Appointments
                    </a>
                    <a href="#" class="nav-item">
                        <i class="fas fa-info-circle"></i>
                        About
                    </a>
                    <a href="#" class="nav-item">
                        <i class="fas fa-phone"></i>
                        Contact
                    </a>
                </nav>

                <!-- User Actions -->
                <div class="user-actions">
                    <a href="#" class="btn btn-register">
                        <i class="fas fa-user-plus"></i>
                        Register
                    </a>
                    <a href="#" class="btn btn-login">
                        <i class="fas fa-sign-in-alt"></i>
                        Login
                    </a>
                </div>
            </div>
        </header>

        <div class="container">
            <!-- Doctor Profile Card -->
            <div class="doctor-profile-card">
                <div class="doctor-header">
                    <img src="${pageContext.request.contextPath}/${doctor.avatar}"
                         alt="Dr.${doctor.firstName} ${doctor.lastName}" class="doctor-avatar">

                    <div class="doctor-info">
                        <h1 class="doctor-name">
                            Dr.${doctor.firstName} ${doctor.lastName}
                            <c:if test="${doctor.jobStatusID == 1}">
                                <span class="availability-badge">Available</span>
                            </c:if>
                        </h1>

                        <c:if test="${not empty doctor.specialtyName}">
                            <p class="doctor-specialty">
                                <i class="fas fa-stethoscope"></i>
                                ${doctor.specialtyName}
                            </p>
                        </c:if>

                        <!-- Credentials will be added when degree data is available -->
                        <c:if test="${not empty doctor.credentials}">
                            <p class="doctor-credentials">
                                <i class="fas fa-graduation-cap"></i>
                                ${doctor.credentials}
                            </p>
                        </c:if>

                        <!-- Languages will be added when language data is available -->
                        <c:if test="${not empty doctor.languages}">
                            <p class="doctor-languages">
                                <i class="fas fa-language"></i>
                                Speaks: ${doctor.languages}
                            </p>
                        </c:if>

                        <div class="contact-info">
                            <c:if test="${not empty doctor.phoneNumber}">
                                <div class="contact-item">
                                    <i class="fas fa-phone"></i>
                                    <span>${doctor.phoneNumber}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty doctor.email}">
                                <div class="contact-item">
                                    <i class="fas fa-envelope"></i>
                                    <span>${doctor.email}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty doctor.hospital}">
                                <div class="contact-item">
                                    <i class="fas fa-hospital"></i>
                                    <span>${doctor.hospital}</span>
                                </div>
                            </c:if>
                        </div>

                        <!-- Rating section will be shown when rating data is available -->
                        <c:if test="${not empty doctor.rating and doctor.rating > 0}">
                            <div class="rating-section">
                                <div class="rating-stars">
                                    <c:forEach begin="1" end="${doctor.rating}" var="i">
                                        <i class="fas fa-star star"></i>
                                    </c:forEach>
                                    <c:forEach begin="${doctor.rating + 1}" end="5" var="i">
                                        <i class="far fa-star star"></i>
                                    </c:forEach>
                                </div>
                                <span class="rating-score">${doctor.rating}</span>
                                <c:if test="${not empty doctor.reviewCount and doctor.reviewCount > 0}">
                                    <span class="rating-count">${doctor.reviewCount} Reviews</span>
                                </c:if>
                                <c:if test="${not empty doctor.recommendationPercentage}">
                                    <span class="recommendation-badge">
                                        <i class="fas fa-thumbs-up"></i>
                                        ${doctor.recommendationPercentage}% Recommended
                                    </span>
                                </c:if>
                            </div>
                        </c:if>

                        <div class="doctor-actions">
                            <a href="#" class="btn-action btn-primary">
                                <i class="fas fa-calendar-plus"></i>
                                Book Appointment
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="doctor-stats">
                <c:if test="${not empty doctor.appointmentCount and doctor.appointmentCount > 0}">
                    <div class="stat-card">
                        <i class="fas fa-calendar-check stat-icon"></i>
                        <div class="stat-value">${doctor.appointmentCount}+</div>
                        <div class="stat-label">Appointment Booked</div>
                    </div>
                </c:if>
                <c:if test="${not empty doctor.yearExperience and doctor.yearExperience > 0}">
                    <div class="stat-card">
                        <i class="fas fa-user-md stat-icon"></i>
                        <div class="stat-value">${doctor.yearExperience}</div>
                        <div class="stat-label">Years of Experience</div>
                    </div>
                </c:if>
                <c:if test="${not empty doctor.awards and doctor.awards > 0}">
                    <div class="stat-card">
                        <i class="fas fa-trophy stat-icon"></i>
                        <div class="stat-value">${doctor.awards}+</div>
                        <div class="stat-label">Awards</div>
                    </div>
                </c:if>
                <c:if test="${not empty doctor.consultationFee and doctor.consultationFee > 0}">
                    <div class="stat-card">
                        <i class="fas fa-dollar-sign stat-icon"></i>
                        <div class="stat-value">
                            <c:choose>
                                <c:when
                                    test="${not empty doctor.consultationFeeMin and not empty doctor.consultationFeeMax}">
                                    ${doctor.consultationFeeMin}₫ - ${doctor.consultationFeeMax}₫
                                </c:when>
                                <c:otherwise>
                                    ${doctor.consultationFee}₫
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">for a Session</div>
                    </div>
                </c:if>
            </div>

            <!-- Doctor Bio Section - Only show if bio data is available -->
            <c:if test="${not empty doctor.bio and not empty doctor.bio.trim()}">
                <div class="about-section">
                    <h2 class="section-title">
                        <i class="fas fa-user"></i>
                        Doctor Bio
                    </h2>
                    <p class="bio-text">
                        ${doctor.bio}
                    </p>
                </div>
            </c:if>

            <!-- Reviews Section - Only show if reviews data is available -->
            <c:if test="${not empty reviews and not empty reviews.size() and reviews.size() > 0}">
                <div class="reviews-section">
                    <div class="reviews-header">
                        <h2 class="section-title">
                            <i class="fas fa-star"></i>
                            Reviews (${reviews.size()})
                        </h2>
                    </div>

                    <!-- Dynamic Reviews -->
                    <c:forEach items="${reviews}" var="review">
                        <div class="review-item">
                            <div class="reviewer-info">
                                <div class="reviewer-avatar">
                                    ${fn:substring(review.reviewerName, 0, 1).toUpperCase()}
                                </div>
                                <div class="reviewer-details">
                                    <h4>${review.reviewerName}</h4>
                                    <div class="review-meta">
                                        <c:if test="${not empty review.rating and review.rating > 0}">
                                            <div class="review-rating">
                                                <c:forEach begin="1" end="${review.rating}" var="i">
                                                    <i class="fas fa-star star"></i>
                                                </c:forEach>
                                                <c:forEach begin="${review.rating + 1}" end="5" var="i">
                                                    <i class="far fa-star star"></i>
                                                </c:forEach>
                                                <span>${review.rating}.0</span>
                                            </div>
                                            <span>|</span>
                                        </c:if>
                                        <c:if test="${not empty review.dateCreated}">
                                            <span>${review.dateCreated}</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${not empty review.content and not empty review.content.trim()}">
                                <p class="review-content">
                                    ${review.content}
                                </p>
                            </c:if>
                            <c:if test="${review.recommended}">
                                <span class="review-recommendation">
                                    <i class="fas fa-thumbs-up"></i>
                                    Yes, Recommend for Appointment
                                </span>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

    </body>

</html>