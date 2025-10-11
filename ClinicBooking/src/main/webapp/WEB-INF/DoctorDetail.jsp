<%-- Document : Doctor Detail Created on : Oct 10, 2025, 12:46:40 PM Author : Nguyen Minh Khang - CE190728 --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

            .doctor-profile-card {
                background: white;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                margin-bottom: 2rem;
                overflow: hidden;
            }

            .doctor-header {
                padding: 2rem;
                display: grid;
                grid-template-columns: 1fr 300px;
                gap: 2rem;
                align-items: start;
                position: relative;
            }

            .doctor-main-info {
                display: flex;
                gap: 1.5rem;
                align-items: flex-start;
            }

            .doctor-side-info {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 1.5rem;
                border: 1px solid #e9ecef;
            }

            .side-info-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.8rem 0;
                border-bottom: 1px solid #e9ecef;
            }

            .side-info-item:last-child {
                border-bottom: none;
            }

            .side-info-label {
                color: #6c757d;
                font-size: 0.9rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .side-info-value {
                font-weight: 600;
                color: #2c3e50;
            }

            .side-info-value.status-available {
                color: #28a745;
            }

            .rating-display {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .stars {
                color: #ffc107;
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
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
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

            .degree-item {
                display: flex;
                align-items: center;
                padding: 1rem;
                margin-bottom: 1rem;
                background: #f8f9fa;
                border-radius: 8px;
                border-left: 4px solid #28a745;
                transition: background-color 0.3s ease;
            }

            .degree-item:hover {
                background: #e9ecef;
            }

            .degree-item:last-child {
                margin-bottom: 0;
            }

            .degree-icon {
                font-size: 1.5rem;
                color: #28a745;
                margin-right: 1rem;
                width: 30px;
                text-align: center;
            }

            .degree-content {
                flex: 1;
            }

            .degree-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #2c3e50;
                margin: 0 0 0.3rem 0;
            }

            .degree-details {
                color: #6c757d;
                font-size: 0.9rem;
                margin: 0;
            }

            .qualifications-left {
                margin: 1.5rem 0;
            }

            .qualifications-title {
                color: #2c3e50;
                font-size: 1.1rem;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .qualifications-title i {
                color: #175cdd;
            }

            .qualification-item {
                display: flex;
                align-items: center;
                padding: 0.5rem 0;
                border-bottom: 1px solid #f1f3f4;
            }

            .qualification-icon {
                margin-right: 0.8rem;
                color: #28a745;
            }

            .qualification-content {
                flex: 1;
            }

            .qualification-name {
                font-weight: 600;
                color: #2c3e50;
                font-size: 0.95rem;
                margin-bottom: 0.2rem;
            }

            .qualification-details {
                color: #6c757d;
                font-size: 0.85rem;
            }

            .qualification-details i {
                margin-right: 0.3rem;
            }

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

            @media (max-width: 768px) {
                .container {
                    padding: 1rem;
                }

                .doctor-header {
                    grid-template-columns: 1fr;
                    gap: 1.5rem;
                    padding: 1.5rem;
                }

                .doctor-main-info {
                    flex-direction: column;
                    text-align: center;
                }

                .doctor-avatar {
                    width: 120px;
                    height: 120px;
                    margin: 0 auto;
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

                .doctor-side-info {
                    order: -1;
                }

                .degree-item {
                    flex-direction: column;
                    text-align: center;
                }

                .degree-icon {
                    margin-right: 0;
                    margin-bottom: 0.5rem;
                }

                .qualification-item {
                    flex-direction: column;
                    text-align: center;
                }

                .qualification-icon {
                    margin-right: 0;
                    margin-bottom: 0.5rem;
                }
            }
        </style>
    </head>

    <body>
        <!-- Header -->
        <header class="header">
            <div class="container">
                <!-- Logo -->
                <a href="${pageContext.request.contextPath}/home" class="logo">
                    <i class="fas fa-stethoscope"></i>
                    CLINIC
                </a>

                <!-- Navigation Menu -->
                <nav>
                    <ul class="nav-menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/home">Home</a>
                        </li>
                        <li>
                            <a href="#">About</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/doctor-list"
                               class="active">Doctors</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle">Portal</a>
                            <ul class="dropdown-menu">
                                <li><a href="${pageContext.request.contextPath}/manage-my-appointments">Manage
                                        My
                                        Appointments</a></li>
                                <li><a href="#">Manage My Medical Records</a></li>
                                <li><a href="#">Manage My Prescriptions</a></li>
                                <li><a href="#">Manage My Invoices</a></li>
                                <li><a href="#">My Feedbacks</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">Contact</a>
                        </li>
                    </ul>
                </nav>
                <div class="user-actions">
                    <!-- Register Button -->
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
                    <!-- Main Doctor Info (Left Side) -->
                    <div class="doctor-main-info">
                        <img src="${pageContext.request.contextPath}/${doctor.avatar}"
                             alt="Dr.${doctor.firstName} ${doctor.lastName}" class="doctor-avatar">

                        <div class="doctor-info">
                            <h1 class="doctor-name">
                                Dr. ${doctor.firstName} ${doctor.lastName}
                            </h1>
                            <c:if test="${not empty doctor.specialtyName}">
                                <p class="doctor-specialty">
                                    <i class="fas fa-stethoscope"></i>
                                    ${doctor.specialtyName}
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
                            </div>
                            <c:if test="${not empty degrees}">
                                <div class="qualifications-left">
                                    <h4 class="qualifications-title">
                                        <i class="fas fa-graduation-cap"></i>
                                        Qualifications
                                    </h4>
                                    <c:forEach var="degree" items="${degrees}">
                                        <div class="qualification-item">
                                            <div class="qualification-icon">
                                                <i class="fas fa-certificate"></i>
                                            </div>
                                            <div class="qualification-content">
                                                <div class="qualification-name">
                                                    ${degree.degreeName}
                                                </div>
                                                <div class="qualification-details">
                                                    <i class="fas fa-university"></i>${degree.grantor}
                                                    <c:if test="${not empty degree.dateEarn}">
                                                        •
                                                        <fmt:formatDate value="${degree.dateEarn}"
                                                                        pattern="MMM yyyy" />
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                    <div class="doctor-side-info">
                        <div class="side-info-item">
                            <span class="side-info-label">
                                <i class="fas fa-star"></i>
                                Rating
                            </span>
                            <div class="rating-display">
                                <span class="stars">★★★★☆</span>
                                <span class="side-info-value">4.0</span>
                            </div>
                        </div>
                        <div class="side-info-item">
                            <span class="side-info-label">
                                <i class="fas fa-check-circle"></i>
                                Status
                            </span>
                            <span
                                class="side-info-value ${doctor.jobStatusID == 1 ? 'status-available' : ''}">
                                <c:if test="${doctor.jobStatusID == 1}">Available</c:if>
                                <c:if test="${doctor.jobStatusID != 1}">${doctor.jobStatusDescription}
                                </c:if>
                            </span>
                        </div>
                        <div class="side-info-item">
                            <span class="side-info-label">
                                <i class="fas fa-user-md"></i>
                                Experience
                            </span>
                            <span class="side-info-value">${doctor.yearExperience} years</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>