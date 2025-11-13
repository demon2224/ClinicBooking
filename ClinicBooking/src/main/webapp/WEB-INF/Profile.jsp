<%--
    Document   : Profile
    Created on : Nov 6, 2025
    Author     : Nguyen Minh Khang - CE190728
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<%-- Get and remove success message from session --%>
<c:if test="${not empty sessionScope.successMessage}">
    <c:set var="successMessage" value="${sessionScope.successMessage}"/>
    <c:remove var="successMessage" scope="session"/>
</c:if>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Profile - CLINIC</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=${System.currentTimeMillis()}" rel="stylesheet" type="text/css"/>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="profile" />
        </jsp:include>

        <!-- Main Content -->
        <main class="appointment-main-content">
            <!-- Page Header -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-user-circle"></i> Profile</h1>
            </div>

            <!-- Success Modal -->
            <c:if test= "true">
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
            </c:if>

            <!-- Error Modal for Password Change -->
            <c:if test="${not empty requestScope.passwordError}">
                <div id="passwordErrorModal" class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-exclamation-triangle text-error"></i> Error
                            </h3>
                            <button type="button" class="modal-close" onclick="closePasswordErrorModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p class="error-messages"> ${requestScope.passwordError}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" onclick="closePasswordErrorModal()">Close</button>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Profile Container -->
            <div class="appointments-section">
                <div class="appointments-content">
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
                            <div class="password-requirements">
                                <div>Password must contain:</div>
                                <ul class="password-requirements-list">
                                    <li id="req-length">At least 8 characters</li>
                                    <li id="req-upper">At least 1 uppercase letter</li>
                                    <li id="req-lower">At least 1 lowercase letter</li>
                                    <li id="req-number">At least 1 number</li>
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

        <!-- Custom Modal JS - no Bootstrap dependency -->

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
            const reqNumber = document.getElementById('req-number');
            const reqSpecial = document.getElementById('req-special');

            newPasswordInput.addEventListener('input', function () {
                const password = this.value;
                let strength = 0;

                // Check requirements
                const hasLength = password.length >= 8;
                const hasUpper = /[A-Z]/.test(password);
                const hasLower = /[a-z]/.test(password);
                const hasNumber = /[0-9]/.test(password);
                const hasSpecial = /[@#$%^&+=!]/.test(password);

                // Update requirement indicators
                updateRequirement(reqLength, hasLength);
                updateRequirement(reqUpper, hasUpper);
                updateRequirement(reqLower, hasLower);
                updateRequirement(reqNumber, hasNumber);
                updateRequirement(reqSpecial, hasSpecial);

                // Calculate strength
                if (hasLength)
                    strength++;
                if (hasUpper)
                    strength++;
                if (hasLower)
                    strength++;
                if (hasNumber)
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
                } else if (strength === 3 || strength === 4) {
                    strengthBarFill.classList.add('medium');
                    strengthText.classList.add('medium');
                    strengthText.textContent = 'Medium password';
                } else if (strength === 5) {
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
                if (newPassword.length < 8) {
                    errors.push('Password must be at least 8 characters');
                }
                if (!/[A-Z]/.test(newPassword)) {
                    errors.push('Password must contain at least 1 uppercase letter');
                }
                if (!/[a-z]/.test(newPassword)) {
                    errors.push('Password must contain at least 1 lowercase letter');
                }
                if (!/[0-9]/.test(newPassword)) {
                    errors.push('Password must contain at least 1 number');
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
                    errorContainer.classList.add('hidden');
                }
            });

            function displayErrors(errors) {
                errorContainer.innerHTML = errors.map(error =>
                        `<div class="error-message"><i class="fas fa-exclamation-circle"></i> ${error}</div>`
                ).join('');
                errorContainer.classList.remove('hidden');
            }

            function resetForm() {
                form.reset();
                errorContainer.classList.add('hidden');
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
                    modal.classList.remove('active');
                }
            }

            function closePasswordErrorModal() {
                const modal = document.getElementById('passwordErrorModal');
                if (modal) {
                    modal.classList.remove('active');
                }
                // Open change password modal after closing error
                document.getElementById('changePasswordModal').classList.add('active');
            }

            // Auto-show modals on page load
            window.addEventListener('DOMContentLoaded', function () {
                const messageModal = document.getElementById('messageModal');
                if (messageModal) {
                    messageModal.classList.add('active');
                }

                const passwordErrorModal = document.getElementById('passwordErrorModal');
                if (passwordErrorModal) {
                    passwordErrorModal.classList.add('active');
                }
            });
        </script>
    </body>
</html>
