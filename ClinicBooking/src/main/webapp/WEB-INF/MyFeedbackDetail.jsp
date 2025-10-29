<%--
    Document   : MyFeedbackDetail
    Created on : Oct 18, 2025, 1:30:04 PM
    Author     : Nguyen Minh Khang - CE190728
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback Detail - CLINIC</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>

        <style>
            /* Force clear browser cache */
            * {
                box-sizing: border-box;
            }

            /* Override any conflicting styles */
            .appointment-page-header,
            .appointment-page-header * {
                position: static !important;
                float: none !important;
                clear: both !important;
            }

            /* Force header to be at top */
            .appointment-main-content > .appointment-page-header:first-child {
                margin-top: 0 !important;
                order: -999 !important;
            }

            body.appointment-page {
                margin: 0 !important;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                padding-top: 80px !important; /* Space for fixed header */
                background-color: #f8fafc !important;
                overflow-x: hidden !important;
            }

            .appointment-main-content {
                padding: 2rem !important;
                max-width: 1200px !important;
                margin: 0 auto !important;
                min-height: calc(100vh - 80px) !important;
                position: relative !important;
                z-index: 1 !important;
                display: flex !important;
                flex-direction: column !important;
            }

            .appointment-page-header {
                background: #175CDD !important;
                padding: 2rem !important;
                border-radius: 0.5rem !important;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
                margin-bottom: 2rem !important;
                position: relative !important;
                z-index: 9999 !important;
                order: -1 !important;
                width: 100% !important;
                display: block !important;
            }

            .appointment-page-header h1 {
                color: white !important;
                margin: 0 0 0.5rem 0 !important;
                font-size: 2rem !important;
                font-weight: 600 !important;
                display: flex !important;
                align-items: center !important;
                gap: 0.75rem !important;
                text-align: left !important;
                line-height: 1.2 !important;
            }



            .feedback-section {
                background: white !important;
                border-radius: 0.5rem !important;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
                overflow: hidden !important;
                position: relative !important;
                z-index: 1 !important;
                margin-top: 0 !important;
                clear: both !important;
                order: 3 !important;
            }

            .feedback-content {
                padding: 2rem;
            }

            .feedback-card {
                background: white !important;
                border: 1px solid #e2e8f0 !important;
                border-radius: 0.5rem !important;
                padding: 1.5rem !important;
                margin-bottom: 1.5rem !important;
                transition: transform 0.2s ease, box-shadow 0.2s ease !important;
                position: relative !important;
            }

            .feedback-card:hover {
                transform: translateY(-2px) !important;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1) !important;
            }

            .feedback-header {
                display: flex !important;
                justify-content: space-between !important;
                align-items: flex-start !important;
                margin-bottom: 1rem !important;
                gap: 1rem !important;
            }

            .feedback-doctor {
                flex: 1 !important;
            }

            .doctor-name {
                font-size: 1.125rem !important;
                font-weight: 600 !important;
                color: #175CDD !important;
                margin-bottom: 0.25rem !important;
                display: flex !important;
                align-items: center !important;
                gap: 0.5rem !important;
            }

            .feedback-meta {
                display: flex !important;
                flex-direction: column !important;
                gap: 0.5rem !important;
                align-items: flex-end !important;
                min-width: fit-content !important;
            }

            .feedback-date {
                color: #64748b !important;
                font-size: 0.875rem !important;
                display: flex !important;
                align-items: center !important;
                gap: 0.25rem !important;
            }

            .feedback-rating {
                display: flex !important;
                align-items: center !important;
                gap: 0.5rem !important;
            }

            .rating-stars {
                display: flex !important;
                gap: 0.125rem !important;
            }

            .rating-stars .fas.fa-star {
                color: #fbbf24 !important;
                font-size: 0.875rem !important;
            }

            .rating-stars .fas.fa-star.text-muted {
                color: #d1d5db !important;
            }

            .rating-score {
                font-weight: 600 !important;
                color: #374151 !important;
                font-size: 0.875rem !important;
            }

            .feedback-content-text {
                background: #f8fafc !important;
                border: 1px solid #e2e8f0 !important;
                border-radius: 0.375rem !important;
                padding: 1rem !important;
                margin-bottom: 1rem !important;
                font-size: 0.875rem !important;
                line-height: 1.5 !important;
                color: #374151 !important;
            }

            .feedback-actions {
                display: flex !important;
                gap: 0.75rem !important;
                justify-content: flex-start !important;
                flex-wrap: wrap !important;
            }

            .btn-action {
                padding: 0.5rem 1rem !important;
                border: none !important;
                border-radius: 0.375rem !important;
                font-size: 0.875rem !important;
                font-weight: 500 !important;
                cursor: pointer !important;
                transition: all 0.3s ease !important;
                text-decoration: none !important;
                display: inline-flex !important;
                align-items: center !important;
                gap: 0.25rem !important;
            }

            .btn-view {
                background-color: #175CDD !important;
                color: white !important;
            }

            .btn-view:hover {
                background-color: #1d4ed8 !important;
            }

            .btn-edit {
                background-color: #059669 !important;
                color: white !important;
            }

            .btn-edit:hover {
                background-color: #047857 !important;
            }

            .btn-delete {
                background-color: #dc2626 !important;
                color: white !important;
            }

            .btn-delete:hover {
                background-color: #b91c1c !important;
            }

            .btn-create {
                background-color: #175CDD !important;
                color: white !important;
            }

            .btn-create:hover {
                background-color: #1d4ed8 !important;
            }

            /* Doctor Info Section Styles */
            .info-section {
                background: white !important;
                border: 1px solid #e2e8f0 !important;
                border-radius: 0.5rem !important;
                padding: 1.5rem !important;
                margin-bottom: 1.5rem !important;
            }

            .section-title {
                color: #175CDD !important;
                font-size: 1.125rem !important;
                font-weight: 600 !important;
                margin-bottom: 1rem !important;
                display: flex !important;
                align-items: center !important;
                gap: 0.5rem !important;
            }

            .info-grid {
                display: grid !important;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)) !important;
                gap: 1rem !important;
            }

            .info-item {
                display: flex !important;
                align-items: flex-start !important;
                gap: 0.75rem !important;
            }

            .info-icon {
                background: #175CDD !important;
                color: #fff !important;
                font-size: 1.5rem !important;
                margin-top: 0.25rem !important;
                min-width: 2.5rem !important;
                min-height: 2.5rem !important;
                border-radius: 0.75rem !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                box-shadow: 0 2px 8px rgba(23,92,221,0.08) !important;
                padding: 0.5rem !important;
            }

            .info-content h4 {
                color: #374151 !important;
                font-size: 0.875rem !important;
                font-weight: 600 !important;
                margin: 0 0 0.25rem 0 !important;
            }

            .info-content p {
                color: #1e293b !important;
                font-size: 0.875rem !important;
                margin: 0 !important;
                line-height: 1.4 !important;
            }

            .stars {
                color: #fbbf24 !important;
                margin-right: 0.25rem !important;
            }

            /* Review Content Styles */
            .review-content-section {
                margin-top: 0 !important;
                padding: 1rem !important;
                background: #f8fafc !important;
                border: 1px solid #e2e8f0 !important;
                border-radius: 0.375rem !important;
                border-left: 4px solid #175CDD !important;
            }

            .review-text {
                color: #1e293b !important;
                font-size: 0.875rem !important;
                margin: 0 !important;
                line-height: 1.5 !important;
            }

            /* Modal styles */
            .modal {
                display: none !important;
                position: fixed !important;
                z-index: 1000 !important;
                left: 0 !important;
                top: 0 !important;
                width: 100% !important;
                height: 100% !important;
                background-color: rgba(0,0,0,0.5) !important;
                align-items: center !important;
                justify-content: center !important;
            }

            .modal-content {
                background-color: white !important;
                margin: auto !important;
                padding: 0 !important;
                border-radius: 12px !important;
                width: 90% !important;
                max-width: 500px !important;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1) !important;
            }

            .modal-header {
                padding: 1.5rem !important;
                border-bottom: 1px solid #e2e8f0 !important;
                display: flex !important;
                justify-content: space-between !important;
                align-items: center !important;
            }

            .modal-header h3 {
                margin: 0 !important;
                color: #1a202c !important;
                font-size: 1.25rem !important;
                font-weight: 600 !important;
            }

            .close {
                color: #6b7280 !important;
                font-size: 1.5rem !important;
                font-weight: bold !important;
                cursor: pointer !important;
                border: none !important;
                background: none !important;
            }

            .close:hover {
                color: #374151 !important;
            }

            .modal-body {
                padding: 1.5rem !important;
            }

            .modal-footer {
                padding: 1.5rem !important;
                border-top: 1px solid #e2e8f0 !important;
                display: flex !important;
                justify-content: flex-end !important;
                gap: 1rem !important;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .appointment-main-content {
                    padding: 1rem !important;
                }

                .appointment-page-header {
                    padding: 1.5rem !important;
                }

                .appointment-page-header h1 {
                    font-size: 1.5rem;
                }

                .info-section {
                    padding: 1rem !important;
                }

                .info-grid {
                    grid-template-columns: 1fr !important;
                }
            }
        </style>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp" />

        <!-- Main Content -->
        <main class="appointment-main-content">
            <!-- Page Header -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-star"></i> Feedback Detail</h1>
            </div>

            <!-- Feedback Information Section -->
            <div class="info-section">
                <h3 class="section-title">
                    <i class="fas fa-info-circle"></i>
                    Feedback Information
                </h3>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <div class="info-content">
                            <h4>Doctor Name</h4>
                            <p>Dr. ${reviewDetail.doctorID.staffID.firstName} ${reviewDetail.doctorID.staffID.lastName}</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="info-content">
                            <h4>Your Rating</h4>
                            <p>
                                <span class="stars">
                                    <c:forEach begin="1" end="5" var="star">
                                        <i class="fas fa-star ${star <= reviewDetail.rateScore ? '' : 'text-muted'}"></i>
                                    </c:forEach>
                                </span>
                                ${reviewDetail.rateScore}/5
                            </p>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="info-content">
                            <h4>Review Date</h4>
                            <p>
                                <c:choose>
                                    <c:when test="${reviewDetail.dateCreate != null}">
                                        <fmt:formatDate value="${reviewDetail.dateCreate}" pattern="yyyy-MM-dd"/>
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="info-content">
                            <h4>Review Time</h4>
                            <p>
                                <c:choose>
                                    <c:when test="${reviewDetail.dateCreate != null}">
                                        <fmt:formatDate value="${reviewDetail.dateCreate}" pattern="HH:mm:ss"/>
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Your Review Section -->
            <div class="info-section">
                <h3 class="section-title">
                    <i class="fas fa-comment"></i>
                    Your Review
                </h3>
                <div class="review-content-section">
                    <p class="review-text">${reviewDetail.content}</p>
                </div>
            </div>
        </main>
    </body>
</html>
