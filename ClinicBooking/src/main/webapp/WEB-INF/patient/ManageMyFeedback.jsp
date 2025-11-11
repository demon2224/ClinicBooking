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
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=${System.currentTimeMillis()}" rel="stylesheet" type="text/css"/>
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

            <!-- New Feedback -->
            <div class="search-filter-section">
                <div class="search-filter-content">
                    <button type="button" class="btn-action btn-primary" onclick="showModal('createFeedbackModal')"
                        <i class="fas fa-plus"></i>
                        New Feedback
                    </button>
                </div>
            </div>

            <!-- Feedbacks Section -->
            <div class="appointments-section">
                <div class="appointments-content">
                    <c:choose>
                        <c:when test="${empty myReviews}">
                            <!-- Empty State -->
                            <div class="appointment-empty-state">
                                <i class="fas fa-comments"></i>
                                <h3>No Feedbacks Found</h3>
                                <p>You haven't written any feedback yet. Share your experience with doctors from your completed appointments.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Display Reviews -->
                            <c:forEach var="review" items="${myReviews}">
                                <div class="appointment-card">
                                    <div class="appointment-header">
                                        <div class="appointment-info">
                                            <div class="appointment-date">
                                                <i class="fas fa-calendar"></i>
                                                <c:choose>
                                                    <c:when test="${review.dateCreate != null}">
                                                        <fmt:formatDate value="${review.dateCreate}" pattern="EEEE, MMMM dd, yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        N/A
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="appointment-doctor">
                                                <i class="fas fa-user-md"></i>
                                                Dr. ${review.doctorID.staffID.firstName} ${review.doctorID.staffID.lastName}
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-star"></i>
                                                Rating: ${review.rateScore}/5
                                                <span class="rating-stars">
                                                    <c:forEach begin="1" end="5" var="star">
                                                        <c:choose>
                                                            <c:when test="${star <= review.rateScore}">
                                                                <i class="fas fa-star star-filled"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="far fa-star star-empty"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </span>
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-comment"></i>
                                                ${review.content}
                                            </div>
                                        </div>
                                        <div class="appointment-status status-completed">
                                            Feedback
                                        </div>
                                    </div>
                                    <div class="appointment-actions">
                                        <a href="${pageContext.request.contextPath}/manage-my-feedback?action=detail&reviewId=${review.doctorReviewID}"
                                           class="btn-action btn-view">
                                            <i class="fas fa-eye"></i> View Details
                                        </a>
                                        <c:if test="${canEditMap[review.doctorReviewID]}">
                                            <button type="button" class="btn-action btn-edit"
                                                    onclick="openEditModal(this)"
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
                                                    title="You can only edit within 24 hours of creating the review">
                                                <i class="fas fa-edit"></i> Edit
                                            </button>
                                        </c:if>
                                        <button class="btn-action btn-cancel"
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
        <div class="modal" id="createFeedbackModal">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createFeedbackModalLabel">
                            <i class="fas fa-plus-circle"></i> Write New Feedback
                        </h5>
                        <button type="button" class="btn-close" onclick="hideModal('createFeedbackModal')" aria-label="Close"></button>
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
                                    <div class="feedback-star-rating">
                                        <input type="radio" name="ratingDisplay" value="5" id="star5">
                                        <label for="star5" class="feedback-star-label">★</label>
                                        <input type="radio" name="ratingDisplay" value="4" id="star4">
                                        <label for="star4" class="feedback-star-label">★</label>
                                        <input type="radio" name="ratingDisplay" value="3" id="star3">
                                        <label for="star3" class="feedback-star-label">★</label>
                                        <input type="radio" name="ratingDisplay" value="2" id="star2">
                                        <label for="star2" class="feedback-star-label">★</label>
                                        <input type="radio" name="ratingDisplay" value="1" id="star1">
                                        <label for="star1" class="feedback-star-label">★</label>
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
                            <button type="button" class="btn btn-secondary" onclick="hideModal('createFeedbackModal')">
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
        <div class="modal" id="editFeedbackModal">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editFeedbackModalLabel">
                            <i class="fas fa-edit"></i> Edit Your Feedback
                        </h5>
                        <button type="button" class="btn-close" onclick="hideModal('editFeedbackModal')" aria-label="Close"></button>
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
                                    <div class="feedback-star-rating">
                                        <input type="radio" name="editRatingDisplay" value="5" id="editStar5">
                                        <label for="editStar5" class="feedback-star-label">★</label>
                                        <input type="radio" name="editRatingDisplay" value="4" id="editStar4">
                                        <label for="editStar4" class="feedback-star-label">★</label>
                                        <input type="radio" name="editRatingDisplay" value="3" id="editStar3">
                                        <label for="editStar3" class="feedback-star-label">★</label>
                                        <input type="radio" name="editRatingDisplay" value="2" id="editStar2">
                                        <label for="editStar2" class="feedback-star-label">★</label>
                                        <input type="radio" name="editRatingDisplay" value="1" id="editStar1">
                                        <label for="editStar1" class="feedback-star-label">★</label>
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
                            <button type="button" class="btn btn-secondary" onclick="hideModal('editFeedbackModal')">
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
        <div class="modal" id="successModal">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content text-center border-0 shadow-lg">
                    <div class="modal-body p-5">
                        <i class="fa-solid fa-circle-check text-success fa-4x mb-3"></i>
                        <h4 class="mb-3 text-success fw-bold">Success!</h4>
                        <p class="text-secondary mb-4" id="successMessage">${successMessage}</p>
                        <button type="button" class="btn btn-success px-4" onclick="hideModal('successModal')">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Error Modal -->
        <div class="modal" id="errorModal">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content text-center border-0 shadow-lg">
                    <div class="modal-body p-5">
                        <i class="fa-solid fa-circle-xmark text-danger fa-4x mb-3"></i>
                        <h4 class="mb-3 text-danger fw-bold">Error!</h4>
                        <p class="text-secondary mb-4" id="errorMessage">${errorMessage}</p>
                        <button type="button" class="btn btn-danger px-4" onclick="hideModal('errorModal')">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal" id="deleteModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirm Delete</h5>
                        <button type="button" class="btn-close" onclick="hideModal('deleteModal')"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this feedback? This action cannot be undone.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="hideModal('deleteModal')">Cancel</button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Custom Modal JS removed Bootstrap dependency -->

        <script>
            // Custom Modal Functions
            function showModal(modalId) {
                const modal = document.getElementById(modalId);
                if (modal) {
                    modal.classList.add('show');
                    document.body.style.overflow = 'hidden';
                }
            }

            function hideModal(modalId) {
                const modal = document.getElementById(modalId);
                if (modal) {
                    modal.classList.remove('show');
                    document.body.style.overflow = 'auto';
                }
            }

            function setupModalEvents() {
                // Close modal when clicking outside or on close button
                document.querySelectorAll('.modal').forEach(modal => {
                    modal.addEventListener('click', function(e) {
                        if (e.target === modal) {
                            hideModal(modal.id);
                        }
                    });
                });

                // Close button events
                document.querySelectorAll('.btn-close').forEach(btn => {
                    btn.addEventListener('click', function() {
                        const modal = this.closest('.modal');
                        if (modal) hideModal(modal.id);
                    });
                });

                // All modal close events are now handled by onclick attributes
            }

            document.addEventListener('DOMContentLoaded', function () {
                setupModalEvents();
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

                // Edit Modal Function
                window.openEditModal = function(button) {
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

                    // Show the modal
                    showModal('editFeedbackModal');
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
                const deleteButtons = document.querySelectorAll('.btn-cancel');
                const deleteModal = document.getElementById('deleteModal');
                const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
                let reviewIdToDelete = null;

                deleteButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        reviewIdToDelete = this.getAttribute('data-review-id');
                        showModal('deleteModal');
                    });
                });

                if (confirmDeleteBtn) {
                    confirmDeleteBtn.addEventListener('click', function () {
                        if (reviewIdToDelete) {
                            // Hide modal first
                            hideModal('deleteModal');
                            
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

            });
        </script>

        <!-- Show modals based on server messages -->
        <c:if test="${not empty successMessage}">
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                showModal('successModal');
            });
        </script>
        </c:if>

        <c:if test="${not empty errorMessage}">
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                showModal('errorModal');
            });
        </script>
        </c:if>
    </body>
</html>
