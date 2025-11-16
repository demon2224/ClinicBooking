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
            </c:if>

            <!-- Error Modal for Password Change -->
            <c:if test="${not empty requestScope.passwordError or not empty requestScope.passwordErrorList}">
                <div id="passwordErrorModal" class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-exclamation-triangle text-error"></i> Error
                            </h3>
                            <button type="button" class="modal-close" onclick="closePasswordErrorModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <c:if test="${not empty requestScope.passwordError}">
                                <p class="error-messages">${requestScope.passwordError}</p>
                            </c:if>
                            <c:if test="${not empty requestScope.passwordErrorList}">
                                <div class="error-messages">
                                    <c:forEach var="error" items="${requestScope.passwordErrorList}">
                                        <p><i class="fas fa-exclamation-circle"></i> ${error}</p>
                                    </c:forEach>
                                </div>
                            </c:if>
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
                                <div class="profile-avatar-large">
                                    <c:choose>
                                        <c:when test="${patient.avatar != null && !empty patient.avatar}">
                                            <img src="${pageContext.request.contextPath}${patient.avatar}"
                                                 alt="Profile Avatar"
                                                 id="profileAvatar"
                                                 class="profile-avatar-large"
                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assests/img/patient1.jpg'">
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

            /* Modal Overlay Styling - Override to ensure display */
            #changePasswordModal {
                display: none !important;
                position: fixed !important;
                top: 0 !important;
                left: 0 !important;
                width: 100% !important;
                height: 100% !important;
                background: rgba(0, 0, 0, 0.5) !important;
                backdrop-filter: blur(4px) !important;
                z-index: 10000 !important;
                align-items: center !important;
                justify-content: center !important;
            }

            #changePasswordModal.active {
                display: flex !important;
                opacity: 1 !important;
                visibility: visible !important;
            }

            #changePasswordModal .modal-content {
                background: white !important;
                border-radius: 0.75rem !important;
                width: 90% !important;
                max-width: 500px !important;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3) !important;
                animation: modalSlideIn 0.3s ease-out !important;
                max-height: 90vh !important;
                overflow-y: auto !important;
                position: relative !important;
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
            document.addEventListener('DOMContentLoaded', function() {
                // Modal Controls
                const modal = document.getElementById('changePasswordModal');
                const openModalBtn = document.getElementById('changePasswordBtn');
                const closeModalBtn = document.getElementById('closeModalBtn');
                const cancelBtn = document.getElementById('cancelBtn');

                // Debug logging
                console.log('Modal element:', modal);
                console.log('Open button:', openModalBtn);
                console.log('Close button:', closeModalBtn);
                console.log('Cancel button:', cancelBtn);

                // Add null checks and bind events
                if (openModalBtn && modal) {
                    console.log('Binding click event to open button');
                    openModalBtn.addEventListener('click', function(e) {
                        e.preventDefault(); // Prevent any default action
                        console.log('=== MODAL DEBUG START ===');
                        console.log('Open button clicked!');
                        console.log('Modal before:', modal.className);
                        
                        modal.classList.add('active');
                        
                        console.log('Modal after:', modal.className);
                        
                        // Check computed styles
                        const styles = window.getComputedStyle(modal);
                        console.log('Display:', styles.display);
                        console.log('Visibility:', styles.visibility);
                        console.log('Opacity:', styles.opacity);
                        console.log('Z-index:', styles.zIndex);
                        console.log('Position:', styles.position);
                        console.log('Width:', styles.width);
                        console.log('Height:', styles.height);
                        
                        // Check if modal is visible in viewport
                        const rect = modal.getBoundingClientRect();
                        console.log('BoundingRect:', rect);
                        console.log('Is visible:', rect.width > 0 && rect.height > 0);
                        
                        console.log('=== MODAL DEBUG END ===');
                        
                        document.body.style.overflow = 'hidden'; // Prevent background scrolling
                    });
                } else {
                    console.error('Cannot bind modal: modal or button not found');
                    if (!openModalBtn) console.error('Button not found!');
                    if (!modal) console.error('Modal not found!');
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

                // Form submission - validation handled by controller
                const form = document.getElementById('changePasswordForm');
                const errorContainer = document.getElementById('errorContainer');

                // Clear error container on form submit
                form.addEventListener('submit', function (e) {
                    errorContainer.classList.add('hidden');
                });

                function resetForm() {
                    form.reset();
                    errorContainer.classList.add('hidden');
                    strengthBarFill.style.width = '0%';
                    strengthText.textContent = '';

                    // Reset requirement colors
                    [reqLength, reqUpper, reqLower, reqSpecial, reqNumber].forEach(el => {
                        el.style.color = '#64748b';
                        el.innerHTML = el.textContent.replace('✓ ', '').replace('✗ ', '');
                    });
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

                // Auto-show modals on page load
                const messageModal = document.getElementById('messageModal');
                if (messageModal) {
                    messageModal.classList.add('active');
                }

                const passwordErrorModal = document.getElementById('passwordErrorModal');
                if (passwordErrorModal) {
                    passwordErrorModal.classList.add('active');
                }
            }); // End DOMContentLoaded

            // Close modals functions - globally accessible
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
        </script>
    </body>
</html>
