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

            body {
                margin: 0 !important;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                padding-top: 80px !important; /* Space for fixed header */
                background-color: #f8fafc !important;
                overflow-x: hidden !important;
            }

            .main-content {
                padding: 2rem !important;
                max-width: 1200px !important;
                margin: 0 auto !important;
                min-height: calc(100vh - 80px) !important;
                position: relative !important;
                z-index: 1 !important;
                display: flex !important;
                flex-direction: column !important;
            }

            .page-header {
                background: white !important;
                padding: 2rem !important;
                border-radius: 0.5rem !important;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
                margin-bottom: 0 !important;
                position: relative !important;
                z-index: 5 !important;
                order: 1 !important;
            }

            .page-header h1 {
                color: #175CDD;
                margin: 0 0 0.5rem 0;
                font-size: 2rem;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .page-header p {
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
                .main-content {
                    padding: 1rem !important;
                }

                .feedback-card {
                    padding: 1rem !important;
                }

                .feedback-header {
                    flex-direction: column !important;
                    align-items: flex-start !important;
                }

                .feedback-meta {
                    align-items: flex-start !important;
                    width: 100% !important;
                }

                .feedback-actions {
                    flex-direction: column !important;
                }

                .btn-action {
                    width: 100% !important;
                    justify-content: center !important;
                }
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp" />

        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1>
                    <i class="fas fa-star"></i>
                    Feedback Detail
                </h1>
                <p>View your review details</p>
            </div>

            <!-- Feedback Section -->
            <div class="feedback-section">
                <div class="feedback-content">
                    <!-- Feedback Card - Same format as list view -->
                    <div class="feedback-card">
                        <div class="feedback-header">
                            <div class="feedback-doctor">
                                <div class="doctor-name">
                                    <i class="fas fa-user-md"></i>
                                    ${reviewDetail.doctorName}
                                </div>
                            </div>
                            <div class="feedback-meta">
                                <div class="feedback-date">
                                    <i class="fas fa-calendar"></i>
                                    <c:choose>
                                        <c:when test="${reviewDetail.dateCreate != null}">
                                            ${reviewDetail.dateCreate.toLocalDate()} at ${reviewDetail.dateCreate.toLocalTime().withNano(0)}
                                        </c:when>
                                        <c:otherwise>
                                            N/A
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="feedback-rating">
                                    <div class="rating-stars">
                                        <c:forEach begin="1" end="5" var="star">
                                            <i class="fas fa-star ${star <= reviewDetail.rateScore ? '' : 'text-muted'}"></i>
                                        </c:forEach>
                                    </div>
                                    <span class="rating-score">${reviewDetail.rateScore}/5</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="feedback-content-text">
                            ${reviewDetail.content}
                        </div>

                        <div class="feedback-actions">
                            <a href="${pageContext.request.contextPath}/manage-my-feedback?action=edit&reviewId=${reviewDetail.doctorReviewID}" 
                               class="btn-action btn-edit">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <button class="btn-action btn-delete" 
                                    data-review-id="${reviewDetail.doctorReviewID}">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div id="deleteModal" class="modal" style="display: none;">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Delete Review</h3>
                    <span class="close">&times;</span>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete this review? This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-action btn-edit" onclick="closeDeleteModal()">Cancel</button>
                    <button type="button" class="btn-action btn-delete" id="confirmDelete">Delete</button>
                </div>
            </div>
        </div>

        <script>
            // Delete functionality
            document.addEventListener('DOMContentLoaded', function() {
                const deleteButtons = document.querySelectorAll('.btn-delete[data-review-id]');
                const deleteModal = document.getElementById('deleteModal');
                const confirmDeleteBtn = document.getElementById('confirmDelete');
                let reviewIdToDelete = null;

                deleteButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        reviewIdToDelete = this.getAttribute('data-review-id');
                        deleteModal.style.display = 'flex';
                    });
                });

                confirmDeleteBtn.addEventListener('click', function() {
                    if (reviewIdToDelete) {
                        window.location.href = '${pageContext.request.contextPath}/manage-my-feedback?action=delete&reviewId=' + reviewIdToDelete;
                    }
                });

                // Close modal functionality
                document.querySelector('.close').addEventListener('click', closeDeleteModal);
                deleteModal.addEventListener('click', function(e) {
                    if (e.target === deleteModal) {
                        closeDeleteModal();
                    }
                });
            });

            function closeDeleteModal() {
                document.getElementById('deleteModal').style.display = 'none';
            }
        </script>
    </body>
</html>
