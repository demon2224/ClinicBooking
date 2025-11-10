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

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

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
                color: #d1d5db;
                font-size: 1rem;
            }

            .rating-stars i.active {
                color: #fbbf24;
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
                word-wrap: break-word
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
            .star-rating {
                direction: rtl;
                display: flex;
                justify-content: flex-start;
            }

            .star-rating input[type="radio"] {
                display: none;
            }

            .star-label {
                color: #ddd;
                font-size: 2rem;
                cursor: pointer;
                transition: color 0.2s;
                margin: 0 2px;
            }

            .star-rating input[type="radio"]:checked ~ .star-label,
            .star-rating input[type="radio"]:hover ~ .star-label {
                color: #fbbf24;
            }

            .star-rating .star-label:hover {
                color: #fbbf24;
            }

            /* Rating validation error */
            .invalid-feedback {
                display: block;
                margin-top: 0.25rem;
                font-size: 0.875rem;
                color: #dc3545;
            }

            /* Modal Enhancements */
            .modal-header {
                background: #f8fafc;
                border-bottom: 1px solid #e2e8f0;
            }

            .modal-title {
                color: #175CDD;
                font-weight: 600;
            }

            .form-label {
                color: #374151;
                margin-bottom: 0.5rem;
            }

            .form-select:focus,
            .form-control:focus {
                border-color: #175CDD;
                box-shadow: 0 0 0 0.2rem rgba(23, 92, 221, 0.25);
            }

            .btn-primary {
                background-color: #175CDD;
                border-color: #175CDD;
            }

            .btn-primary:hover {
                background-color: #1e40af;
                border-color: #1e40af;
            }

            /* Ensure modal displays properly - Override any custom CSS conflicts */
            .modal {
                z-index: 1050 !important;
                position: fixed !important;
                top: 0 !important;
                left: 0 !important;
                width: 100% !important;
                height: 100% !important;
                overflow-x: hidden !important;
                overflow-y: auto !important;
                outline: 0 !important;
            }

            .modal.show {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
            }

            .modal-backdrop {
                z-index: 1040 !important;
                position: fixed !important;
                top: 0 !important;
                left: 0 !important;
                width: 100vw !important;
                height: 100vh !important;
                background-color: rgba(0, 0, 0, 0.5) !important;
            }

            .modal-dialog {
                margin: 0 auto !important;
                position: relative !important;
                width: auto !important;
                max-width: 800px !important;
                pointer-events: none !important;
            }

            .modal-dialog-centered {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                min-height: 100vh !important;
            }

            .modal.fade .modal-dialog {
                transform: translateY(-50px) !important;
                transition: transform 0.3s ease-out !important;
            }

            .modal.show .modal-dialog {
                transform: translateY(0) !important;
            }

            .modal-content {
                position: relative !important;
                display: flex !important;
                flex-direction: column !important;
                width: 100% !important;
                pointer-events: auto !important;
                background-color: #fff !important;
                background-clip: padding-box !important;
                border: 1px solid rgba(0, 0, 0, 0.2) !important;
                border-radius: 0.3rem !important;
                outline: 0 !important;
            }

            /* Ensure button style is not overridden */
            .btn-action.btn-create {
                cursor: pointer !important;
                pointer-events: auto !important;
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
        <jsp:include page="../includes/header.jsp">
            <jsp:param name="activePage" value="manage-feedback" />
        </jsp:include>

        <!-- Main Content -->
        <main class="appointment-main-content">
            <!-- Page Header -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-comments"></i> My Feedbacks</h1>
            </div>
            <div class="feedback-section">
                <div class="section-header">
                    <button type="button" class="btn-action btn-create" data-bs-toggle="modal" data-bs-target="#createFeedbackModal">
                        <i class="fas fa-plus"></i>
                        New Feedback
                    </button>
                </div>
                <div class="feedback-content">
                    <c:choose>
                        <c:when test="${empty myReviews}">
                            <!-- Empty State -->
                            <div class="empty-state">
                                <i class="fas fa-comments"></i>
                                <h3>No Feedbacks Found</h3>
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
                                                Dr. ${review.doctorID.staffID.firstName} ${review.doctorID.staffID.lastName}
                                            </div>
                                            <div class="feedback-date">
                                                <i class="fas fa-calendar"></i>
                                                <c:choose>
                                                    <c:when test="${review.dateCreate != null}">
                                                        <fmt:formatDate value="${review.dateCreate}" pattern="yyyy-MM-dd"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        N/A
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="feedback-rating">
                                        <div class="rating-stars">
                                            <c:forEach begin="1" end="5" var="star">
                                                <i class="fas fa-star ${star <= review.rateScore ? 'active' : ''}"></i>
                                            </c:forEach>
                                        </div>
                                        <span class="rating-score">${review.rateScore}/5</span>
                                    </div>

                                    <div class="feedback-content-text">
                                        ${review.content}
                                    </div>

                                    <div class="feedback-actions">
                                        <a href="${pageContext.request.contextPath}/manage-my-feedback?action=detail&reviewId=${review.doctorReviewID}"
                                           class="btn-action btn-view">
                                            <i class="fas fa-eye"></i> View Detail
                                        </a>
                                        <c:if test="${canEditMap[review.doctorReviewID]}">
                                            <button type="button" class="btn-action btn-edit"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#editFeedbackModal"
                                                    data-review-id="${review.doctorReviewID}"
                                                    data-doctor-name="Dr. ${review.doctorID.staffID.firstName} ${review.doctorID.staffID.lastName}"
                                                    data-specialty="${review.doctorID.specialtyID.specialtyName}"
                                                    data-rating="${review.rateScore}"
                                                    data-content="${review.content}">
                                                <i class="fas fa-edit"></i> Edit
                                            </button>
                                        </c:if>
                                        <c:if test="${!canEditMap[review.doctorReviewID]}">
                                            <button type="button" class="btn-action btn-edit" disabled
                                                    style="opacity: 0.5; cursor: not-allowed;"
                                                    title="You can only edit within 24 hours of creating the review">
                                                <i class="fas fa-edit"></i> Edit
                                            </button>
                                        </c:if>
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
        </main>

        <!-- Create Feedback Modal -->
        <div class="modal fade" id="createFeedbackModal" tabindex="-1" aria-labelledby="createFeedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createFeedbackModalLabel">
                            <i class="fas fa-plus-circle"></i> Write New Feedback
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="createFeedbackForm" method="post" action="${pageContext.request.contextPath}/manage-my-feedback">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="create">

                            <!-- Doctor Selection -->
                            <div class="mb-3">
                                <label for="doctorSelect" class="form-label fw-bold">
                                    <i class="fas fa-user-md"></i> Select Doctor <span class="text-danger">*</span>
                                </label>
                                <c:choose>
                                    <c:when test="${empty availableDoctors}">
                                        <div class="alert alert-warning">
                                            <i class="fas fa-info-circle"></i>
                                            You can only feedback doctors from completed appointments within 24 hours.
                                        </div>
                                        <select class="form-select" id="doctorSelect" name="doctorId" disabled>
                                            <option value="">No doctors available for review</option>
                                        </select>
                                    </c:when>
                                    <c:otherwise>
                                        <select class="form-select" id="doctorSelect" name="doctorId">
                                            <option value="">Choose a doctor from your completed appointments...</option>
                                            <c:forEach var="doctor" items="${availableDoctors}">
                                                <option value="${doctor.doctorID}">
                                                    Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName} - ${doctor.specialtyID.specialtyName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="form-text">
                                            <i class="fas fa-clock"></i> You can feedback doctors from appointments completed within the last 24 hours.
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="invalid-feedback" id="doctorError" style="display: none;">
                                    Please select a doctor.
                                </div>
                            </div>

                            <!-- Rating -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-star"></i> Your Rating <span class="text-danger">*</span>
                                </label>
                                <input type="hidden" name="rating" id="ratingValue">
                                <div class="rating-input">
                                    <div class="star-rating">
                                        <input type="radio" name="ratingDisplay" value="5" id="star5">
                                        <label for="star5" class="star-label">★</label>
                                        <input type="radio" name="ratingDisplay" value="4" id="star4">
                                        <label for="star4" class="star-label">★</label>
                                        <input type="radio" name="ratingDisplay" value="3" id="star3">
                                        <label for="star3" class="star-label">★</label>
                                        <input type="radio" name="ratingDisplay" value="2" id="star2">
                                        <label for="star2" class="star-label">★</label>
                                        <input type="radio" name="ratingDisplay" value="1" id="star1">
                                        <label for="star1" class="star-label">★</label>
                                    </div>
                                    <div class="invalid-feedback" id="ratingError" style="display: none;">
                                        Please select a rating.
                                    </div>
                                </div>
                            </div>

                            <!-- Review Content -->
                            <div class="mb-3">
                                <label for="reviewContent" class="form-label fw-bold">
                                    <i class="fas fa-comment"></i> Your Feedback <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" id="reviewContent" name="content" rows="5"
                                          maxlength="500" placeholder="Share your experience with this doctor..."></textarea>
                                <div class="invalid-feedback" id="contentError" style="display: none;">
                                    Please write your feedback (1-500 characters).
                                </div>
                                <div class="form-text">
                                    <span id="charCount">0</span>/500 characters
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                            <button type="submit" class="btn btn-primary" ${empty availableDoctors ? 'disabled' : ''}>
                                <i class="fas fa-paper-plane"></i> Submit
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Feedback Modal -->
        <div class="modal fade" id="editFeedbackModal" tabindex="-1" aria-labelledby="editFeedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editFeedbackModalLabel">
                            <i class="fas fa-edit"></i> Edit Your Feedback
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="editFeedbackForm" method="post" action="${pageContext.request.contextPath}/manage-my-feedback">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="reviewId" id="editReviewId">

                            <!-- Doctor Info (Read-only) -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-user-md"></i> Doctor
                                </label>
                                <div class="form-control bg-light" id="editDoctorInfo" readonly style="background-color: #e9ecef;">
                                    <!-- Will be populated by JavaScript -->
                                </div>
                            </div>

                            <!-- Rating -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-star"></i> Your Rating <span class="text-danger">*</span>
                                </label>
                                <input type="hidden" name="rating" id="editRatingValue">
                                <div class="rating-input">
                                    <div class="star-rating">
                                        <input type="radio" name="editRatingDisplay" value="5" id="editStar5">
                                        <label for="editStar5" class="star-label">★</label>
                                        <input type="radio" name="editRatingDisplay" value="4" id="editStar4">
                                        <label for="editStar4" class="star-label">★</label>
                                        <input type="radio" name="editRatingDisplay" value="3" id="editStar3">
                                        <label for="editStar3" class="star-label">★</label>
                                        <input type="radio" name="editRatingDisplay" value="2" id="editStar2">
                                        <label for="editStar2" class="star-label">★</label>
                                        <input type="radio" name="editRatingDisplay" value="1" id="editStar1">
                                        <label for="editStar1" class="star-label">★</label>
                                    </div>
                                    <div class="invalid-feedback" id="editRatingError" style="display: none;">
                                        Please select a rating.
                                    </div>
                                </div>
                            </div>

                            <!-- Review Content -->
                            <div class="mb-3">
                                <label for="editReviewContent" class="form-label fw-bold">
                                    <i class="fas fa-comment"></i> Your Feedback <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" id="editReviewContent" name="content" rows="5"
                                          maxlength="500" placeholder="Share your experience with this doctor..."></textarea>
                                <div class="invalid-feedback" id="editContentError" style="display: none;">
                                    Please write your feedback (1-500 characters).
                                </div>
                                <div class="form-text">
                                    <span id="editCharCount">0</span>/500 characters
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Update
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Success Modal -->
        <div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content text-center border-0 shadow-lg">
                    <div class="modal-body p-5">
                        <i class="fa-solid fa-circle-check text-success fa-4x mb-3"></i>
                        <h4 class="mb-3 text-success fw-bold">Success!</h4>
                        <p class="text-secondary mb-4" id="successMessage">${successMessage}</p>
                        <button type="button" class="btn btn-success px-4" data-bs-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Error Modal -->
        <div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content text-center border-0 shadow-lg">
                    <div class="modal-body p-5">
                        <i class="fa-solid fa-circle-xmark text-danger fa-4x mb-3"></i>
                        <h4 class="mb-3 text-danger fw-bold">Error!</h4>
                        <p class="text-secondary mb-4" id="errorMessage">${errorMessage}</p>
                        <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirm Delete</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this feedback? This action cannot be undone.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Get form elements
                const createFeedbackForm = document.getElementById('createFeedbackForm');
                const doctorSelect = document.getElementById('doctorSelect');
                const reviewContent = document.getElementById('reviewContent');
                const ratingDisplayInputs = document.querySelectorAll('input[name="ratingDisplay"]');
                const ratingValue = document.getElementById('ratingValue');

                // Get error message elements
                const doctorError = document.getElementById('doctorError');
                const contentError = document.getElementById('contentError');
                const ratingError = document.getElementById('ratingError');

                // Rating functionality - sync display rating with hidden input
                ratingDisplayInputs.forEach(input => {
                    input.addEventListener('change', function () {
                        if (ratingValue) {
                            ratingValue.value = this.value;
                        }
                        // Hide error when rating is selected
                        if (ratingError) {
                            ratingError.style.display = 'none';
                        }
                    });
                });

                // Hide doctor error when selection changes
                if (doctorSelect) {
                    doctorSelect.addEventListener('change', function () {
                        if (this.value && doctorError) {
                            doctorError.style.display = 'none';
                        }
                    });
                }

                // Hide content error when typing
                if (reviewContent) {
                    reviewContent.addEventListener('input', function () {
                        if (this.value.trim().length > 0 && contentError) {
                            contentError.style.display = 'none';
                        }
                    });
                }

                // Form validation
                if (createFeedbackForm) {
                    createFeedbackForm.addEventListener('submit', function (e) {
                        let isValid = true;

                        // Validate doctor selection
                        if (!doctorSelect || !doctorSelect.value) {
                            if (doctorError) {
                                doctorError.style.display = 'block';
                            }
                            isValid = false;
                        }

                        // Validate content
                        if (!reviewContent || reviewContent.value.trim().length === 0) {
                            if (contentError) {
                                contentError.style.display = 'block';
                            }
                            isValid = false;
                        }

                        // Validate rating
                        if (!ratingValue || !ratingValue.value) {
                            if (ratingError) {
                                ratingError.style.display = 'block';
                            }
                            isValid = false;
                        }

                        if (!isValid) {
                            e.preventDefault();
                            return false;
                        }
                    });
                }

                // Character counter for review content
                const charCount = document.getElementById('charCount');

                if (reviewContent && charCount) {
                    reviewContent.addEventListener('input', function () {
                        const currentLength = this.value.length;
                        charCount.textContent = currentLength;

                        if (currentLength > 480) {
                            charCount.style.color = '#dc2626';
                        } else if (currentLength > 400) {
                            charCount.style.color = '#f59e0b';
                        } else {
                            charCount.style.color = '#64748b';
                        }
                    });
                }

                // Edit Modal - Load review data
                const editFeedbackModal = document.getElementById('editFeedbackModal');
                if (editFeedbackModal) {
                    editFeedbackModal.addEventListener('show.bs.modal', function (event) {
                        const button = event.relatedTarget;
                        const reviewId = button.getAttribute('data-review-id');
                        const doctorName = button.getAttribute('data-doctor-name');
                        const specialty = button.getAttribute('data-specialty');
                        const rating = button.getAttribute('data-rating');
                        const content = button.getAttribute('data-content');

                        // Populate form fields
                        document.getElementById('editReviewId').value = reviewId;
                        document.getElementById('editDoctorInfo').textContent = doctorName + ' - ' + specialty;
                        document.getElementById('editReviewContent').value = content;
                        document.getElementById('editRatingValue').value = rating;

                        // Update character count
                        const editCharCount = document.getElementById('editCharCount');
                        if (editCharCount) {
                            editCharCount.textContent = content.length;
                        }

                        // Set rating stars
                        const ratingInput = document.querySelector(`input[name="editRatingDisplay"][value="${rating}"]`);
                        if (ratingInput) {
                            ratingInput.checked = true;
                        }
                    });
                }

                // Edit form - Rating functionality
                const editRatingDisplayInputs = document.querySelectorAll('input[name="editRatingDisplay"]');
                const editRatingValue = document.getElementById('editRatingValue');
                const editRatingError = document.getElementById('editRatingError');

                editRatingDisplayInputs.forEach(input => {
                    input.addEventListener('change', function () {
                        if (editRatingValue) {
                            editRatingValue.value = this.value;
                        }
                        if (editRatingError) {
                            editRatingError.style.display = 'none';
                        }
                    });
                });

                // Edit form - Character counter
                const editReviewContent = document.getElementById('editReviewContent');
                const editCharCount = document.getElementById('editCharCount');
                const editContentError = document.getElementById('editContentError');

                if (editReviewContent && editCharCount) {
                    editReviewContent.addEventListener('input', function () {
                        const currentLength = this.value.length;
                        editCharCount.textContent = currentLength;

                        if (currentLength > 480) {
                            editCharCount.style.color = '#dc2626';
                        } else if (currentLength > 400) {
                            editCharCount.style.color = '#f59e0b';
                        } else {
                            editCharCount.style.color = '#64748b';
                        }

                        if (this.value.trim().length > 0 && editContentError) {
                            editContentError.style.display = 'none';
                        }
                    });
                }

                // Edit form validation
                const editFeedbackForm = document.getElementById('editFeedbackForm');
                if (editFeedbackForm) {
                    editFeedbackForm.addEventListener('submit', function (e) {
                        let isValid = true;

                        // Validate content
                        if (!editReviewContent || editReviewContent.value.trim().length === 0) {
                            if (editContentError) {
                                editContentError.style.display = 'block';
                            }
                            isValid = false;
                        }

                        // Validate rating
                        if (!editRatingValue || !editRatingValue.value) {
                            if (editRatingError) {
                                editRatingError.style.display = 'block';
                            }
                            isValid = false;
                        }

                        if (!isValid) {
                            e.preventDefault();
                            return false;
                        }
                    });
                }

                // Delete functionality
                const deleteButtons = document.querySelectorAll('.btn-delete');
                const deleteModal = document.getElementById('deleteModal');
                const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
                let reviewIdToDelete = null;

                deleteButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        reviewIdToDelete = this.getAttribute('data-review-id');
                        const modal = new bootstrap.Modal(deleteModal);
                        modal.show();
                    });
                });

                if (confirmDeleteBtn) {
                    confirmDeleteBtn.addEventListener('click', function () {
                        if (reviewIdToDelete) {
                            // Create form and submit
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/manage-my-feedback';

                            const actionInput = document.createElement('input');
                            actionInput.type = 'hidden';
                            actionInput.name = 'action';
                            actionInput.value = 'delete';

                            const reviewIdInput = document.createElement('input');
                            reviewIdInput.type = 'hidden';
                            reviewIdInput.name = 'reviewId';
                            reviewIdInput.value = reviewIdToDelete;

                            form.appendChild(actionInput);
                            form.appendChild(reviewIdInput);
                            document.body.appendChild(form);
                            form.submit();
                        }
                    });
                }

                // Show success/error modals if messages exist
            <c:if test="${not empty successMessage}">
                const successModal = new bootstrap.Modal(document.getElementById('successModal'));
                successModal.show();
            </c:if>

            <c:if test="${not empty errorMessage}">
                const errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
                errorModal.show();
            </c:if>
            });
        </script>
    </body>
</html>
