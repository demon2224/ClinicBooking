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

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>

        <style>
            body.profile-page {
                margin: 0 !important;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                padding-top: 80px !important;
                background-color: #f8fafc !important;
                overflow-x: hidden !important;
            }

            .profile-main-content {
                padding: 2rem !important;
                max-width: 1200px !important;
                margin: 0 auto !important;
                min-height: calc(100vh - 80px) !important;
            }

            .profile-page-header {
                background: #175CDD !important;
                padding: 1.5rem 2rem !important;
                border-radius: 0.5rem !important;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
                margin-bottom: 2rem !important;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .profile-page-header h1 {
                color: white !important;
                margin: 0;
                font-size: 1.75rem;
                font-weight: 600;
            }

            .profile-container {
                background: white;
                border-radius: 0.5rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 2rem;
            }

            .profile-layout {
                display: grid;
                grid-template-columns: 300px 1fr;
                gap: 3rem;
            }

            .profile-left {
                text-align: center;
            }

            .profile-avatar-section {
                background: #f8fafc;
                border-radius: 0.5rem;
                padding: 2rem 1.5rem;
                border: 2px solid #e2e8f0;
            }

            .profile-avatar {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #175CDD;
                margin-bottom: 1rem;
            }

            .profile-name {
                font-size: 1.25rem;
                font-weight: 600;
                color: #1e293b;
                margin-bottom: 0.5rem;
            }

            .upload-photo-btn {
                display: inline-block;
                margin-top: 1rem;
                padding: 0.5rem 1rem;
                background: #e0f2fe;
                color: #0891b2;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                cursor: pointer;
                transition: all 0.3s ease;
                border: 1px solid #bae6fd;
            }

            .upload-photo-btn:hover {
                background: #bae6fd;
            }

            .change-password-btn {
                width: 100%;
                margin-top: 1rem;
                padding: 0.75rem;
                background: #175CDD;
                color: white;
                border: none;
                border-radius: 0.375rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .change-password-btn:hover {
                background: #1e40af;
            }

            .profile-right {
                padding-left: 1rem;
            }

            .profile-section-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #1e293b;
                margin-bottom: 1.5rem;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #e2e8f0;
            }

            .profile-info-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
            }

            .profile-field {
                margin-bottom: 1rem;
            }

            .profile-field.full-width {
                grid-column: span 2;
            }

            .profile-label {
                display: block;
                font-weight: 500;
                color: #374151;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
            }

            .profile-value {
                display: block;
                padding: 0.75rem 1rem;
                background: #f8fafc;
                border: 1px solid #e2e8f0;
                border-radius: 0.375rem;
                color: #1e293b;
                font-size: 0.95rem;
            }

            .profile-actions {
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 2px solid #e2e8f0;
                text-align: right;
            }

            .btn-edit-profile {
                padding: 0.75rem 2rem;
                background: #175CDD;
                color: white;
                border: none;
                border-radius: 0.375rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
            }

            .btn-edit-profile:hover {
                background: #1e40af;
                color: white;
            }

            /* Change Password Modal Styles */
            .modal-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 9999;
                align-items: center;
                justify-content: center;
            }

            .modal-overlay.active {
                display: flex;
            }

            .modal-content {
                background: white;
                border-radius: 0.5rem;
                width: 90%;
                max-width: 500px;
                padding: 2rem;
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
                animation: modalSlideIn 0.3s ease-out;
            }

            @keyframes modalSlideIn {
                from {
                    transform: translateY(-50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #e2e8f0;
            }

            .modal-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #1e293b;
            }

            .modal-close {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: #64748b;
                cursor: pointer;
                padding: 0;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 0.25rem;
                transition: all 0.2s;
            }

            .modal-close:hover {
                background: #f1f5f9;
                color: #1e293b;
            }

            .modal-body {
                margin-bottom: 1.5rem;
            }

            .form-group {
                margin-bottom: 1.25rem;
            }

            .form-label {
                display: block;
                font-weight: 500;
                color: #374151;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
            }

            .form-label.required::after {
                content: " *";
                color: #ef4444;
            }

            .form-input {
                width: 100%;
                padding: 0.75rem;
                border: 1px solid #d1d5db;
                border-radius: 0.375rem;
                font-size: 0.95rem;
                transition: all 0.2s;
            }

            .form-input:focus {
                outline: none;
                border-color: #175CDD;
                box-shadow: 0 0 0 3px rgba(23, 92, 221, 0.1);
            }

            .form-input.error {
                border-color: #ef4444;
            }

            .password-strength {
                margin-top: 0.5rem;
                font-size: 0.75rem;
            }

            .strength-bar {
                height: 4px;
                background: #e2e8f0;
                border-radius: 2px;
                margin-top: 0.25rem;
                overflow: hidden;
            }

            .strength-bar-fill {
                height: 100%;
                width: 0%;
                transition: all 0.3s;
                border-radius: 2px;
            }

            .strength-bar-fill.weak {
                width: 33%;
                background: #ef4444;
            }

            .strength-bar-fill.medium {
                width: 66%;
                background: #f59e0b;
            }

            .strength-bar-fill.strong {
                width: 100%;
                background: #10b981;
            }

            .strength-text {
                margin-top: 0.25rem;
                font-size: 0.75rem;
            }

            .strength-text.weak {
                color: #ef4444;
            }

            .strength-text.medium {
                color: #f59e0b;
            }

            .strength-text.strong {
                color: #10b981;
            }

            .error-messages {
                background: #fef2f2;
                border: 1px solid #fecaca;
                border-radius: 0.375rem;
                padding: 0.75rem;
                margin-bottom: 1rem;
            }

            .error-message {
                color: #dc2626;
                font-size: 0.875rem;
                margin: 0.25rem 0;
            }

            .error-message i {
                margin-right: 0.25rem;
            }

            .success-message {
                background: #f0fdf4;
                border: 1px solid #bbf7d0;
                color: #16a34a;
                border-radius: 0.375rem;
                padding: 0.75rem;
                margin-bottom: 1rem;
                font-size: 0.875rem;
            }

            .modal-footer {
                display: flex;
                gap: 1rem;
                justify-content: flex-end;
                padding-top: 1rem;
                border-top: 1px solid #e2e8f0;
            }

            .btn-modal {
                padding: 0.625rem 1.5rem;
                border-radius: 0.375rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s;
                border: none;
                font-size: 0.95rem;
            }

            .btn-cancel {
                background: #f1f5f9;
                color: #475569;
            }

            .btn-cancel:hover {
                background: #e2e8f0;
            }

            .btn-submit {
                background: #175CDD;
                color: white;
            }

            .btn-submit:hover {
                background: #1e40af;
            }

            .btn-submit:disabled {
                background: #94a3b8;
                cursor: not-allowed;
            }

            @media (max-width: 992px) {
                .profile-layout {
                    grid-template-columns: 1fr;
                    gap: 2rem;
                }

                .profile-right {
                    padding-left: 0;
                }
            }

            @media (max-width: 768px) {
                .profile-info-grid {
                    grid-template-columns: 1fr;
                }

                .profile-field.full-width {
                    grid-column: span 1;
                }
            }
        </style>
    </head>
    <body class="profile-page">
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="profile" />
        </jsp:include>

        <!-- Main Content -->
        <main class="profile-main-content">
            <!-- Page Header -->
            <div class="profile-page-header">
                <i class="fas fa-user-circle fa-lg"></i>
                <h1>Profile</h1>
            </div>

            <!-- Success Modal -->
            <c:if test="${not empty successMessage}">
                <div id="messageModal" class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-check-circle text-success"></i> Success
                            </h3>
                            <button type="button" class="modal-close" onclick="closeMessageModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>${successMessage}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" onclick="closeMessageModal()">OK</button>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Error Modal for Password Change -->
            <c:if test="${not empty passwordError}">
                <div id="passwordErrorModal" class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-exclamation-triangle text-error"></i> Error
                            </h3>
                            <button type="button" class="modal-close" onclick="closePasswordErrorModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>${passwordError}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" onclick="closePasswordErrorModal()">Close</button>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Profile Container -->
            <div class="profile-container">
                <div class="profile-layout">
                    <!-- Left Section - Avatar & Actions -->
                    <div class="profile-left">
                        <div class="profile-avatar-section">
                            <c:choose>
                                <c:when test="${not empty patient.avatar}">
                                    <img src="${pageContext.request.contextPath}/${patient.avatar}"
                                         alt="Profile Avatar"
                                         class="profile-avatar"
                                         id="profileAvatar"
                                         onerror="this.src='${pageContext.request.contextPath}/assests/img/0.png'">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assests/img/0.png"
                                         alt="Profile Avatar"
                                         class="profile-avatar"
                                         id="profileAvatar">
                                </c:otherwise>
                            </c:choose>

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

                            <div class="profile-field">
                                <label class="profile-label">Email:</label>
                                <span class="profile-value">${patient.email}</span>
                            </div>

                            <div class="profile-field full-width">
                                <label class="profile-label">Address:</label>
                                <span class="profile-value">${patient.userAddress}</span>
                            </div>

                            <div class="profile-field">
                                <label class="profile-label">DOB:</label>
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
                        <div id="errorContainer" class="error-messages" style="display: none;"></div>

                        <!-- Current Password -->
                        <div class="form-group">
                            <label for="currentPassword" class="form-label required">Current Password</label>
                            <input type="password"
                                   id="currentPassword"
                                   name="currentPassword"
                                   class="form-input"
                                   required
                                   autocomplete="current-password">
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

                            <!-- Password Strength Indicator -->
                            <div class="password-strength">
                                <div class="strength-bar">
                                    <div id="strengthBarFill" class="strength-bar-fill"></div>
                                </div>
                                <div id="strengthText" class="strength-text"></div>
                            </div>

                            <!-- Password Requirements -->
                            <div style="margin-top: 0.75rem; font-size: 0.75rem; color: #64748b;">
                                <div>Password must contain:</div>
                                <ul style="margin: 0.25rem 0 0 1.25rem; padding: 0;">
                                    <li id="req-length">At least 6 characters</li>
                                    <li id="req-upper">At least 1 uppercase letter</li>
                                    <li id="req-lower">At least 1 lowercase letter</li>
                                    <li id="req-special">At least 1 special character (@#$%^&+=!)</li>
                                </ul>
                            </div>
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
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-modal btn-cancel" id="cancelBtn">Cancel</button>
                        <button type="submit" class="btn-modal btn-submit" id="submitBtn">Change Password</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                // Modal Controls
                                const modal = document.getElementById('changePasswordModal');
                                const openModalBtn = document.getElementById('changePasswordBtn');
                                const closeModalBtn = document.getElementById('closeModalBtn');
                                const cancelBtn = document.getElementById('cancelBtn');

                                openModalBtn.addEventListener('click', () => {
                                    modal.classList.add('active');
                                });

                                closeModalBtn.addEventListener('click', () => {
                                    modal.classList.remove('active');
                                    resetForm();
                                });

                                cancelBtn.addEventListener('click', () => {
                                    modal.classList.remove('active');
                                    resetForm();
                                });

                                // Close modal when clicking outside
                                modal.addEventListener('click', (e) => {
                                    if (e.target === modal) {
                                        modal.classList.remove('active');
                                        resetForm();
                                    }
                                });

                                // Password Strength Checker
                                const newPasswordInput = document.getElementById('newPassword');
                                const strengthBarFill = document.getElementById('strengthBarFill');
                                const strengthText = document.getElementById('strengthText');
                                const reqLength = document.getElementById('req-length');
                                const reqUpper = document.getElementById('req-upper');
                                const reqLower = document.getElementById('req-lower');
                                const reqSpecial = document.getElementById('req-special');

                                newPasswordInput.addEventListener('input', function () {
                                    const password = this.value;
                                    let strength = 0;

                                    // Check requirements
                                    const hasLength = password.length >= 6;
                                    const hasUpper = /[A-Z]/.test(password);
                                    const hasLower = /[a-z]/.test(password);
                                    const hasSpecial = /[@#$%^&+=!]/.test(password);

                                    // Update requirement indicators
                                    updateRequirement(reqLength, hasLength);
                                    updateRequirement(reqUpper, hasUpper);
                                    updateRequirement(reqLower, hasLower);
                                    updateRequirement(reqSpecial, hasSpecial);

                                    // Calculate strength
                                    if (hasLength)
                                        strength++;
                                    if (hasUpper)
                                        strength++;
                                    if (hasLower)
                                        strength++;
                                    if (hasSpecial)
                                        strength++;

                                    // Update strength bar
                                    strengthBarFill.className = 'strength-bar-fill';
                                    strengthText.className = 'strength-text';

                                    if (password.length === 0) {
                                        strengthBarFill.style.width = '0%';
                                        strengthText.textContent = '';
                                    } else if (strength <= 2) {
                                        strengthBarFill.classList.add('weak');
                                        strengthText.classList.add('weak');
                                        strengthText.textContent = 'Weak password';
                                    } else if (strength === 3) {
                                        strengthBarFill.classList.add('medium');
                                        strengthText.classList.add('medium');
                                        strengthText.textContent = 'Medium password';
                                    } else {
                                        strengthBarFill.classList.add('strong');
                                        strengthText.classList.add('strong');
                                        strengthText.textContent = 'Strong password';
                                    }
                                });

                                function updateRequirement(element, isMet) {
                                    if (isMet) {
                                        element.style.color = '#10b981';
                                        element.innerHTML = '<i class="fas fa-check"></i> ' + element.textContent.replace('✓ ', '').replace('✗ ', '');
                                    } else {
                                        element.style.color = '#ef4444';
                                        element.innerHTML = '<i class="fas fa-times"></i> ' + element.textContent.replace('✓ ', '').replace('✗ ', '');
                                    }
                                }

                                // Form Validation
                                const form = document.getElementById('changePasswordForm');
                                const errorContainer = document.getElementById('errorContainer');
                                const confirmPasswordInput = document.getElementById('confirmPassword');
                                const submitBtn = document.getElementById('submitBtn');

                                form.addEventListener('submit', function (e) {
                                    const errors = [];
                                    const currentPassword = document.getElementById('currentPassword').value;
                                    const newPassword = newPasswordInput.value;
                                    const confirmPassword = confirmPasswordInput.value;

                                    // Validate current password
                                    if (!currentPassword) {
                                        errors.push('Current password is required');
                                    }

                                    // Validate new password strength
                                    if (newPassword.length < 6) {
                                        errors.push('Password must be at least 6 characters');
                                    }
                                    if (!/[A-Z]/.test(newPassword)) {
                                        errors.push('Password must contain at least 1 uppercase letter');
                                    }
                                    if (!/[a-z]/.test(newPassword)) {
                                        errors.push('Password must contain at least 1 lowercase letter');
                                    }
                                    if (!/[@#$%^&+=!]/.test(newPassword)) {
                                        errors.push('Password must contain at least 1 special character (@#$%^&+=!)');
                                    }
                                    if (/\s/.test(newPassword)) {
                                        errors.push('Password must not contain spaces');
                                    }

                                    // Validate password match
                                    if (newPassword !== confirmPassword) {
                                        errors.push('New password and confirmation do not match');
                                    }

                                    // Validate new password different from current
                                    if (currentPassword === newPassword) {
                                        errors.push('New password must be different from current password');
                                    }

                                    if (errors.length > 0) {
                                        e.preventDefault();
                                        displayErrors(errors);
                                    } else {
                                        errorContainer.style.display = 'none';
                                    }
                                });

                                function displayErrors(errors) {
                                    errorContainer.innerHTML = errors.map(error =>
                                            `<div class="error-message"><i class="fas fa-exclamation-circle"></i> ${error}</div>`
                                    ).join('');
                                    errorContainer.style.display = 'block';
                                }

                                function resetForm() {
                                    form.reset();
                                    errorContainer.style.display = 'none';
                                    strengthBarFill.style.width = '0%';
                                    strengthText.textContent = '';

                                    // Reset requirement colors
                                    [reqLength, reqUpper, reqLower, reqSpecial].forEach(el => {
                                        el.style.color = '#64748b';
                                        el.innerHTML = el.textContent.replace('✓ ', '').replace('✗ ', '');
                                    });
                                }

                                // Avatar upload preview
                                document.getElementById('avatarUpload').addEventListener('change', function (e) {
                                    const file = e.target.files[0];
                                    if (file) {
                                        const reader = new FileReader();
                                        reader.onload = function (e) {
                                            document.getElementById('profileAvatar').src = e.target.result;
                                        };
                                        reader.readAsDataURL(file);
                                    }
                                });

                                // Close modals
                                function closeMessageModal() {
                                    const modal = document.getElementById('messageModal');
                                    if (modal) {
                                        modal.style.display = 'none';
                                    }
                                }

                                function closePasswordErrorModal() {
                                    const modal = document.getElementById('passwordErrorModal');
                                    if (modal) {
                                        modal.style.display = 'none';
                                    }
                                    // Open change password modal after closing error
                                    document.getElementById('changePasswordModal').classList.add('active');
                                }

                                // Auto-show modals on page load
                                window.addEventListener('DOMContentLoaded', function () {
                                    const messageModal = document.getElementById('messageModal');
                                    if (messageModal) {
                                        messageModal.style.display = 'flex';
                                    }

                                    const passwordErrorModal = document.getElementById('passwordErrorModal');
                                    if (passwordErrorModal) {
                                        passwordErrorModal.style.display = 'flex';
                                    }
                                });
        </script>
    </body>
</html>
