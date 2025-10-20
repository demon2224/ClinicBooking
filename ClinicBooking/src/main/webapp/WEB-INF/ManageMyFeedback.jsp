<%--
    Document   : ManageMyFeedback
    Created on : Oct 16, 2025, 4:35:03 PM
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
        <title>My Feedbacks - CLINIC</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>

        <style>
            /* Force clear browser cache */
            * {
                box-sizing: border-box;
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
                margin-bottom: 0 !important;
                position: relative !important;
                z-index: 5 !important;
                order: 1 !important;
            }

            .appointment-page-header h1 {
                color: white !important;
                margin: 0 0 0.5rem 0;
                font-size: 2rem;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .appointment-page-header p {
                color: #64748b;
                margin: 0;
                font-size: 1.1rem;
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

            .section-header {
                background: white !important;
                color: #175CDD !important;
                padding: 1.5rem 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #e2e8f0 !important;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
            }

            .section-header h2 {
                margin: 0;
                font-size: 1.25rem;
                font-weight: 600;
            }

            .section-header .btn-action {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
            }

            .feedback-content {
                padding: 2rem;
            }

            .feedback-card {
                border: 1px solid #e2e8f0;
                border-radius: 0.5rem;
                padding: 1.5rem;
                margin-bottom: 1rem;
                transition: all 0.3s ease;
            }

            .feedback-card:hover {
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                border-color: #175CDD;
            }

            .feedback-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 1rem;
            }

            .feedback-info {
                flex: 1;
            }

            .feedback-doctor {
                color: #175CDD;
                font-weight: 600;
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }

            .feedback-date {
                color: #64748b;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
            }

            .feedback-rating {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                margin-bottom: 1rem;
            }

            .rating-stars {
                display: flex;
                gap: 0.125rem;
            }

            .rating-stars i {
                color: #fbbf24;
                font-size: 1rem;
            }

            .rating-score {
                color: #1e293b;
                font-weight: 500;
                font-size: 0.9rem;
            }

            .feedback-content-text {
                color: #374151;
                line-height: 1.6;
                margin-bottom: 1rem;
                padding: 1rem;
                background: #f8fafc;
                border-radius: 0.375rem;
                border-left: 4px solid #175CDD;
            }

            .feedback-actions {
                display: flex;
                gap: 0.5rem;
                margin-top: 1rem;
            }

            .btn-action {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
            }

            .btn-view {
                background: #e0f2fe;
                color: #0891b2;
            }

            .btn-view:hover {
                background: #bae6fd;
            }

            .btn-edit {
                background: #f3e8ff;
                color: #7c3aed;
            }

            .btn-edit:hover {
                background: #e9d5ff;
            }

            .btn-delete {
                background: #fee2e2;
                color: #dc2626;
            }

            .btn-delete:hover {
                background: #fecaca;
            }

            .btn-create {
                background: #dcfce7;
                color: #166534;
            }

            .btn-create:hover {
                background: #bbf7d0;
            }

            .appointment-alert {
                padding: 1rem;
                margin-bottom: 1rem;
                border-radius: 0.375rem;
                font-weight: 500;
            }

            .appointment-alert-success {
                background: #dcfce7;
                color: #166534;
                border: 1px solid #bbf7d0;
            }

            .appointment-alert-error {
                background: #fee2e2;
                color: #dc2626;
                border: 1px solid #fecaca;
            }

            .text-muted {
                color: #64748b;
                font-size: 0.9rem;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 2rem;
                color: #64748b;
            }

            .empty-state i {
                font-size: 3rem;
                margin-bottom: 1rem;
                color: #cbd5e1;
            }

            .empty-state h3 {
                margin: 0 0 0.5rem 0;
                color: #1e293b;
            }

            /* Detail View Styles */
            .detail-view {
                background: white;
                border-radius: 0.5rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 2rem;
                margin-bottom: 2rem;
            }

            .detail-header {
                border-bottom: 1px solid #e2e8f0;
                padding-bottom: 1rem;
                margin-bottom: 2rem;
            }

            .detail-title {
                color: #175CDD;
                font-size: 1.5rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
            }

            .detail-subtitle {
                color: #64748b;
                font-size: 1rem;
            }

            .detail-section {
                margin-bottom: 2rem;
            }

            .detail-section h3 {
                color: #1e293b;
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 1rem;
            }

            .detail-item {
                display: flex;
                margin-bottom: 0.75rem;
            }

            .detail-label {
                font-weight: 500;
                color: #374151;
                min-width: 120px;
            }

            .detail-value {
                color: #1e293b;
                flex: 1;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                color: #175CDD;
                text-decoration: none;
                font-weight: 500;
                margin-bottom: 1rem;
            }

            .back-link:hover {
                color: #1e40af;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .appointment-main-content {
                    padding: 1rem;
                }

                .appointment-page-header {
                    padding: 1.5rem;
                }

                .feedback-header {
                    flex-direction: column;
                    gap: 1rem;
                }

                .feedback-actions {
                    flex-wrap: wrap;
                }
            }

            @media (max-width: 480px) {
                .appointment-main-content {
                    padding: 0.5rem;
                }

                .appointment-page-header {
                    padding: 1rem;
                }

                .appointment-page-header h1 {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="manage-feedback" />
        </jsp:include>

        <!-- Main Content -->
        <main class="appointment-main-content">
            <!-- Page Header -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-comments"></i> My Feedbacks</h1>
            </div>

            <!-- Message Display -->
            <c:if test="${not empty successMessage}">
                <div class="appointment-alert appointment-alert-success">
                    <i class="fas fa-check-circle"></i> ${successMessage}
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="appointment-alert appointment-alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="appointment-alert appointment-alert-success">
                    <i class="fas fa-info-circle"></i> ${message}
                </div>
            </c:if>

            <!-- Check view mode -->
            <c:choose>
                <c:when test="${viewMode == 'create'}">
                    <!-- Create View -->
                    <div class="detail-view">
                        <div class="detail-header">
                            <div class="detail-title">Create New Review</div>
                            <div class="detail-subtitle">Share your experience with a doctor</div>
                        </div>

                        <div class="empty-state">
                            <i class="fas fa-plus-circle"></i>
                            <h3>Create New Review</h3>
                            <p>Create review functionality will be implemented later.</p>
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- List View (Default) -->
                    <!-- Action Section -->
                    <div class="feedback-section">
                        <div class="section-header">
                            <a href="${pageContext.request.contextPath}/manage-my-feedback?action=create"
                               class="btn-action btn-create">
                                <i class="fas fa-plus"></i>
                                New Review
                            </a>
                        </div>

                        <div class="feedback-content">
                            <c:choose>
                                <c:when test="${empty myReviews}">
                                    <!-- Empty State -->
                                    <div class="empty-state">
                                        <i class="fas fa-comments"></i>
                                        <h3>No Reviews Found</h3>
                                        <p>You haven't written any reviews yet. Share your experience with doctors!</p>
                                        <a href="${pageContext.request.contextPath}/manage-my-feedback?action=create"
                                           class="btn-action btn-create">
                                            <i class="fas fa-plus"></i> Write Your First Review
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- Display Reviews -->
                                    <c:forEach var="review" items="${myReviews}">
                                        <div class="feedback-card">
                                            <div class="feedback-header">
                                                <div class="feedback-info">
                                                    <div class="feedback-doctor">
                                                        <i class="fas fa-user-md"></i>
                                                        ${review.doctorName != null ? review.doctorName : 'Unknown Doctor'}
                                                    </div>
                                                    <div class="feedback-date">
                                                        <i class="fas fa-calendar"></i>
                                                        <c:choose>
                                                            <c:when test="${review.dateCreate != null}">
                                                                ${review.dateCreate.toLocalDate()}
                                                            </c:when>
                                                            <c:otherwise>
                                                                N/A
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="feedback-content-text">
                                                ${review.content}
                                            </div>

                                            <div class="feedback-actions">
                                                <a href="${pageContext.request.contextPath}/manage-my-feedback?action=detail&reviewId=${review.doctorReviewID}"
                                                   class="btn-action btn-view">
                                                    <i class="fas fa-eye"></i> View Detail
                                                </a>
                                                <a href="${pageContext.request.contextPath}/manage-my-feedback?action=edit&reviewId=${review.doctorReviewID}"
                                                   class="btn-action btn-edit">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <button class="btn-action btn-delete"
                                                        data-review-id="${review.doctorReviewID}">
                                                    <i class="fas fa-trash"></i> Delete
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <!-- JavaScript for interactivity -->
        <script>
            // Delete review confirmation
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.btn-delete').forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault();
                        const reviewId = this.getAttribute('data-review-id');
                        if (confirm('Are you sure you want to delete this review? This action cannot be undone.')) {
                            // Create form to submit deletion
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/manage-my-feedback';

                            const actionInput = document.createElement('input');
                            actionInput.type = 'hidden';
                            actionInput.name = 'action';
                            actionInput.value = 'delete';

                            const idInput = document.createElement('input');
                            idInput.type = 'hidden';
                            idInput.name = 'reviewID';
                            idInput.value = reviewId;

                            form.appendChild(actionInput);
                            form.appendChild(idInput);
                            document.body.appendChild(form);
                            form.submit();
                        }
                    });
                });
            });
        </script>
    </body>
</html>
