<%--
    Document   : Profile
    Created on : Nov 6, 2025
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
        <title>My Profile - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">


        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=${System.currentTimeMillis()}" rel="stylesheet" type="text/css"/>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="../includes/header.jsp">
            <jsp:param name="activePage" value="profile" />
        </jsp:include>

        <!-- Main Content -->
        <main class="appointment-main-content">
            <!-- Page Header -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-user-circle"></i> Profile</h1>
            </div>

            <!-- Success Modal -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div id="messageModal" class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-check-circle text-success"></i> Success
                            </h3>
                            <button type="button" class="modal-close" onclick="closeMessageModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>${sessionScope.successMessage}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" onclick="closeMessageModal()">OK</button>
                        </div>
                    </div>
                </div>
                <%-- Remove message after displaying --%>
                <c:remove var="successMessage" scope="session"/>
            </c:if>

            <!-- Error Modal for General Errors -->
            <c:if test="${not empty sessionScope.errorMessage}">
                <div id="errorMessageModal" class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-exclamation-triangle text-error"></i> Error
                            </h3>
                            <button type="button" class="modal-close" onclick="closeErrorMessageModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>${sessionScope.errorMessage}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" onclick="closeErrorMessageModal()">Close</button>
                        </div>
                    </div>
                </div>
                <%-- Remove message after displaying --%>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>


            <!-- Profile Container -->
            <div class="appointments-section">
                <div class="appointments-content">
                    <div class="profile-layout">
                        <!-- Left Section - Avatar & Actions -->
                        <div class="profile-left">
                            <div class="profile-avatar-section">
                                <div class="profile-avatar-large">
                                    <c:choose>
                                        <c:when test="${patient.avatar != null && !empty patient.avatar}">
                                            <img src="${pageContext.request.contextPath}/${patient.avatar}"
                                                 alt="Profile Avatar"
                                                 id="profileAvatar"
                                                 class="profile-avatar-large"
                                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assests/img/0.png'">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/assests/img/0.png"
                                                 alt="Profile Avatar"
                                                 id="profileAvatar"
                                                 class="profile-avatar-large"
                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'">
                                            <div class="avatar-placeholder avatar-placeholder-large" style="display: none;">
                                                <i class="fas fa-user"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="profile-name">${patient.firstName} ${patient.lastName}</div>
                                <button type="button" class="change-password-btn" id="changePasswordBtn">
                                    <i class="fas fa-key"></i> Change Password
                                </button>
                            </div>
                        </div>

                        <!-- Right Section - Profile Information -->
                        <div class="profile-right">
                            <h2 class="profile-section-title">Profile Information:</h2>

                            <div class="profile-info-grid">
                                <div class="profile-field">
                                    <label class="profile-label">Username:</label>
                                    <span class="profile-value">${patient.accountName}</span>
                                </div>
                                <div class="profile-field">
                                    <label class="profile-label">First name:</label>
                                    <span class="profile-value">${patient.firstName}</span>
                                </div>

                                <div class="profile-field">
                                    <label class="profile-label">Last name:</label>
                                    <span class="profile-value">${patient.lastName}</span>
                                </div>

                                <div class="profile-field">
                                    <label class="profile-label">Phone number:</label>
                                    <span class="profile-value">${patient.phoneNumber}</span>
                                </div>

                                <div class="profile-field full-width">
                                    <label class="profile-label">Email:</label>
                                    <span class="profile-value">${patient.email}</span>
                                </div>

                                <div class="profile-field full-width">
                                    <label class="profile-label">Address:</label>
                                    <span class="profile-value">${patient.userAddress}</span>
                                </div>

                                <div class="profile-field">
                                    <label class="profile-label">Date of birth:</label>
                                    <span class="profile-value"><fmt:formatDate value="${patient.dob}" pattern="yyyy-MM-dd"/></span>
                                </div>

                                <div class="profile-field">
                                    <label class="profile-label">Sex:</label>
                                    <span class="profile-value">${patient.gender ? 'Male' : 'Female'}</span>
                                </div>
                            </div>

                            <!-- Actions -->
                            <div class="profile-actions">
                                <a href="${pageContext.request.contextPath}/profile?action=edit" class="btn-edit-profile">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
        </main>

        <!-- Change Password Modal -->
        <div id="changePasswordModal" class="modal-overlay">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">
                        <i class="fas fa-key"></i> Change Password
                    </h3>
                    <button type="button" class="modal-close" id="closeModalBtn">
                        <i class="fas fa-times"></i>
                    </button>
                </div>

                <form id="changePasswordForm" action="${pageContext.request.contextPath}/profile" method="POST">
                    <input type="hidden" name="action" value="changePassword">

                    <div class="modal-body">
                        <!-- Error Messages -->
                        <div id="errorContainer" class="error-messages hidden"></div>

                        <!-- Current Password -->
                        <div class="form-group">
                            <label for="currentPassword" class="form-label required">Current Password</label>
                            <input type="password"
                                   id="currentPassword"
                                   name="currentPassword"
                                   class="form-input"
                                   required
                                   autocomplete="current-password">
                            <c:if test="${not empty requestScope.currentPasswordErrorMsg}">
                                <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                    <i class="fa-solid fa-circle-exclamation me-1"></i>${requestScope.currentPasswordErrorMsg}
                                </div>
                            </c:if>
                        </div>

                        <!-- New Password -->
                        <div class="form-group">
                            <label for="newPassword" class="form-label required">New Password</label>
                            <input type="password"
                                   id="newPassword"
                                   name="newPassword"
                                   class="form-input"
                                   required
                                   autocomplete="new-password">
                            <c:if test="${not empty requestScope.newPasswordErrorMsg}">
                                <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                    <i class="fa-solid fa-circle-exclamation me-1"></i>${requestScope.newPasswordErrorMsg}
                                </div>
                            </c:if>
                            <c:if test="${not empty requestScope.passwordDifferentErrorMsg}">
                                <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                    <i class="fa-solid fa-circle-exclamation me-1"></i>${requestScope.passwordDifferentErrorMsg}
                                </div>
                            </c:if>
                        </div>

                        <!-- Confirm Password -->
                        <div class="form-group">
                            <label for="confirmPassword" class="form-label required">Confirm New Password</label>
                            <input type="password"
                                   id="confirmPassword"
                                   name="confirmPassword"
                                   class="form-input"
                                   required
                                   autocomplete="new-password">
                            <c:if test="${not empty requestScope.confirmPasswordErrorMsg}">
                                <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                    <i class="fa-solid fa-circle-exclamation me-1"></i>${requestScope.confirmPasswordErrorMsg}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-modal btn-cancel" id="cancelBtn">Cancel</button>
                        <button type="submit" class="btn-modal btn-submit" id="submitBtn">Change Password</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Custom Modal JS - no Bootstrap dependency -->
        <jsp:include page="../includes/footer.jsp" />

        <style>
            /* Change Password Button Styling */
            .change-password-btn {
                width: 100%;
                padding: 0.875rem 1.5rem;
                background: linear-gradient(120deg, #175CDD, #1450C4);
                color: white;
                border: none;
                border-radius: 0.5rem;
                font-weight: 600;
                font-size: 0.95rem;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                box-shadow: 0 2px 4px rgba(23, 92, 221, 0.2);
                margin-top: 1rem;
            }

            .change-password-btn:hover {
                background: linear-gradient(135deg, #1450C4, #0f46b8);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(23, 92, 221, 0.3);
            }

            .change-password-btn:active {
                transform: translateY(0);
                box-shadow: 0 2px 4px rgba(23, 92, 221, 0.2);
            }

            .change-password-btn i {
                font-size: 1rem;
            }

            /* Modal Overlay Styling - Common styles for all modals */
            .modal-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(4px);
                z-index: 10000;
                align-items: center;
                justify-content: center;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .modal-overlay.active {
                display: flex !important;
                opacity: 1 !important;
                visibility: visible !important;
            }

            .modal-overlay .modal-content {
                background: white;
                border-radius: 0.75rem;
                width: 90%;
                max-width: 500px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                animation: modalSlideIn 0.3s ease-out;
                max-height: 90vh;
                overflow-y: auto;
                position: relative;
            }

            @keyframes modalSlideIn {
                from {
                    transform: translateY(-50px) scale(0.95);
                    opacity: 0;
                }
                to {
                    transform: translateY(0) scale(1);
                    opacity: 1;
                }
            }
        </style>

        <script>
            // Wait for DOM to be fully loaded
            document.addEventListener('DOMContentLoaded', function () {
                // Modal Controls
                const modal = document.getElementById('changePasswordModal');
                const openModalBtn = document.getElementById('changePasswordBtn');
                const closeModalBtn = document.getElementById('closeModalBtn');
                const cancelBtn = document.getElementById('cancelBtn');

                // Add null checks and bind events
                if (openModalBtn && modal) {
                    openModalBtn.addEventListener('click', function (e) {
                        e.preventDefault();
                        modal.classList.add('active');
                        document.body.style.overflow = 'hidden'; // Prevent background scrolling
                    });
                }

                if (closeModalBtn && modal) {
                    closeModalBtn.addEventListener('click', () => {
                        modal.classList.remove('active');
                        document.body.style.overflow = ''; // Restore scrolling
                        resetForm();
                    });
                }

                if (cancelBtn && modal) {
                    cancelBtn.addEventListener('click', () => {
                        modal.classList.remove('active');
                        document.body.style.overflow = ''; // Restore scrolling
                        resetForm();
                    });
                }

                // Close modal when clicking outside
                if (modal) {
                    modal.addEventListener('click', (e) => {
                        if (e.target === modal) {
                            modal.classList.remove('active');
                            document.body.style.overflow = ''; // Restore scrolling
                            resetForm();
                        }
                    });
                }

                // Form submission with client-side validation
                const form = document.getElementById('changePasswordForm');
                const errorContainer = document.getElementById('errorContainer');
                const currentPasswordInput = document.getElementById('currentPassword');
                const confirmPasswordInput = document.getElementById('confirmPassword');

                // Password validation regex (same as server-side)
                const PASSWORD_REGEX = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=!])(?=\S+$).{8,}$/;

                // Validate password format
                function isValidPasswordFormat(password) {
                    return password && password.trim() !== '' && PASSWORD_REGEX.test(password);
                }

                // Validate form before submission - no error messages, just prevent submit if invalid
                form.addEventListener('submit', function (e) {
                    const currentPassword = currentPasswordInput.value;
                    const newPassword = newPasswordInput.value;
                    const confirmPassword = confirmPasswordInput.value;
                    
                    let hasErrors = false;

                    // Validate current password
                    if (!currentPassword || currentPassword.trim() === '') {
                        hasErrors = true;
                    }

                    // Validate new password format
                    if (!isValidPasswordFormat(newPassword)) {
                        hasErrors = true;
                    }

                    // Validate password match
                    if (!confirmPassword || confirmPassword.trim() === '') {
                        hasErrors = true;
                    } else if (newPassword !== confirmPassword) {
                        hasErrors = true;
                    }

                    // Validate password different
                    if (currentPassword && newPassword && currentPassword === newPassword) {
                        hasErrors = true;
                    }

                    // If there are errors, prevent submission (no error messages shown)
                    if (hasErrors) {
                        e.preventDefault();
                        return false;
                    }

                    // If no errors, allow form submission
                });

                function resetForm() {
                    form.reset();
                    errorContainer.classList.add('hidden');
                }

                // Avatar upload preview (only if avatarUpload element exists)
                const avatarUploadElement = document.getElementById('avatarUpload');
                if (avatarUploadElement) {
                    avatarUploadElement.addEventListener('change', function (e) {
                        const file = e.target.files[0];
                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                document.getElementById('profileAvatar').src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                        }
                    });
                }

                // Auto-show change password modal if there are validation errors
                <c:if test="${not empty requestScope.currentPasswordErrorMsg or not empty requestScope.newPasswordErrorMsg or not empty requestScope.confirmPasswordErrorMsg or not empty requestScope.passwordDifferentErrorMsg}">
                if (modal) {
                    modal.classList.add('active');
                    document.body.style.overflow = 'hidden';
                }
                </c:if>

                // Auto-show modals on page load
                const messageModal = document.getElementById('messageModal');
                if (messageModal) {
                    messageModal.classList.add('active');
                    // Close on backdrop click
                    messageModal.addEventListener('click', function(e) {
                        if (e.target === messageModal) {
                            closeMessageModal();
                        }
                    });
                }

                const errorMessageModal = document.getElementById('errorMessageModal');
                if (errorMessageModal) {
                    errorMessageModal.classList.add('active');
                    // Close on backdrop click
                    errorMessageModal.addEventListener('click', function(e) {
                        if (e.target === errorMessageModal) {
                            closeErrorMessageModal();
                        }
                    });
                }

            }); // End DOMContentLoaded

            // Close modals functions - globally accessible
            function closeMessageModal() {
                const modal = document.getElementById('messageModal');
                if (modal) {
                    modal.classList.remove('active');
                }
            }

            function closeErrorMessageModal() {
                const modal = document.getElementById('errorMessageModal');
                if (modal) {
                    modal.classList.remove('active');
                }
            }
        </script>
    </body>
</html>
