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

            h1 {
                color: #2c3e50;
                font-weight: 600;
                margin: 2rem 0 1rem 0;
                text-align: center;
                font-size: 2rem;
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

            /* Doctor Reviews Section */
            .reviews-section {
                background: white;
                border-radius: 12px;
                padding: 2rem;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
                margin-bottom: 2rem;
            }

            .reviews-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #f1f3f4;
            }

            .reviews-title {
                font-size: 1.4rem;
                font-weight: 700;
                color: #2c3e50;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .reviews-title i {
                color: #175cdd;
            }

            .reviews-count {
                background: #175cdd;
                color: white;
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 600;
            }

            .review-item {
                border-bottom: 1px solid #e9ecef;
                padding: 1.5rem 0;
                transition: background-color 0.3s ease;
            }

            .review-item:hover {
                background-color: #f8f9fa;
                margin: 0 -1rem;
                padding: 1.5rem 1rem;
                border-radius: 8px;
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
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background: #175cdd;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
                font-size: 1.1rem;
                flex-shrink: 0;
            }

            .reviewer-details {
                flex: 1;
            }

            .reviewer-name {
                font-size: 1rem;
                font-weight: 600;
                color: #2c3e50;
                margin: 0 0 0.2rem 0;
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
                align-items: center;
                gap: 0.3rem;
            }

            .rating-stars {
                display: flex;
                gap: 0.1rem;
            }

            .rating-star {
                color: #ffc107;
                font-size: 0.9rem;
            }

            .rating-star.empty {
                color: #dee2e6;
            }

            .rating-score {
                font-weight: 600;
                color: #2c3e50;
            }

            .review-content {
                color: #495057;
                line-height: 1.6;
                margin-top: 0.8rem;
                font-size: 0.95rem;
            }

            .no-reviews {
                text-align: center;
                color: #6c757d;
                font-style: italic;
                padding: 2rem;
            }

            /* About Doctor Section */
            .about-section {
                background: white;
                border-radius: 12px;
                padding: 2rem;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
                margin-bottom: 2rem;
            }

            .about-header {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #f1f3f4;
            }

            .about-title {
                font-size: 1.4rem;
                font-weight: 700;
                color: #2c3e50;
                margin: 0;
            }

            .about-title i {
                color: #175cdd;
            }

            .about-content {
                color: #495057;
                line-height: 1.7;
                font-size: 0.95rem;
                text-align: justify;
            }

            .no-bio {
                text-align: center;
                color: #6c757d;
                font-style: italic;
                padding: 1.5rem;
            }

            /* Book Button Style - Match DoctorList */
            .btn-book {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                padding: 0.8rem 1.5rem;
                border: 2px solid #175cdd;
                background-color: #175cdd;
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-size: 0.9rem;
                font-weight: 600;
                transition: all 0.2s ease;
                cursor: pointer;
                width: 100%;
                box-sizing: border-box;
            }

            .btn-book:hover {
                background-color: #135bb8;
                border-color: #135bb8;
                color: white;
                text-decoration: none;
            }

            .btn-book i {
                font-size: 1rem;
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
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="doctors" />
        </jsp:include>
        <h1>Doctor Detail</h1>
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
                                                    <i
                                                        class="fas fa-university"></i>${degree.grantor}
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
                                <c:if test="${doctor.jobStatusID != 1}">
                                    ${doctor.jobStatusDescription}
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
                        <div class="doctor-actions">
                            <a href="#" class="btn-book">
                                <i class="fas fa-calendar-plus"></i>
                                Book
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="about-section">
                <div class="about-header">
                    <h3 class="about-title">
                        <i class="fas fa-info-circle"></i>
                        About Dr. ${doctor.firstName} ${doctor.lastName}
                    </h3>
                </div>
                <div class="about-content">
                    <c:choose>
                        <c:when test="${not empty doctor.bio}">
                            ${doctor.bio}
                        </c:when>
                        <c:otherwise>
                            <div class="no-bio">
                                <i class="fas fa-user-md"
                                   style="font-size: 1.5rem; color: #dee2e6; margin-bottom: 0.5rem;"></i>
                                <p>No biography information available for this doctor.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="reviews-section">
                <div class="reviews-header">
                    <h3 class="reviews-title">
                        <i class="fas fa-star"></i>
                        Doctor Reviews
                    </h3>
                    <span class="reviews-count">
                        <c:choose>
                            <c:when test="${not empty doctorReviews}">
                                ${fn:length(doctorReviews)} Reviews
                            </c:when>
                            <c:otherwise>
                                No Reviews
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <c:choose>
                    <c:when test="${not empty doctorReviews}">
                        <c:forEach var="review" items="${doctorReviews}">
                            <div class="review-item">
                                <div class="reviewer-info">
                                    <div class="reviewer-avatar">
                                        ${fn:substring(review.reviewerFullName, 0, 1)}
                                    </div>
                                    <div class="reviewer-details">
                                        <p class="reviewer-name">${review.reviewerFullName}</p>
                                        <div class="review-meta">
                                            <div class="review-rating">
                                                <div class="rating-stars">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i
                                                            class="fas fa-star rating-star ${i <= review.rateScore ? '' : 'empty'}"></i>
                                                    </c:forEach>
                                                </div>
                                                <span
                                                    class="rating-score">${review.rateScore}/5</span>
                                            </div>
                                            <span class="review-date">
                                                ${review.dateCreate.toString().substring(0,
                                                  16).replace('T', ' ')}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="review-content">
                                    ${review.content}
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-reviews">
                            <i class="fas fa-comments"
                               style="font-size: 2rem; color: #dee2e6; margin-bottom: 1rem;"></i>
                            <p>No reviews available for this doctor yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>

</html>