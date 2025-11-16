<%--
    Document   : EditProfile
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
        <title>Edit Profile - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">


        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=${System.currentTimeMillis()}" rel="stylesheet" type="text/css"/>
        
        <style>
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
                <h1><i class="fas fa-user-edit"></i> Edit Profile</h1>
            </div>

            <!-- General Error Message (for non-field errors) -->
            <c:if test="${not empty generalErrorMsg}">
                <div class="alert alert-danger" style="margin: 1rem 0; padding: 0.75rem 1rem; border-radius: 0.5rem;">
                    <i class="fas fa-exclamation-triangle me-2"></i>${generalErrorMsg}
                </div>
            </c:if>

            <!-- Success Modal -->
            <c:if test="${not empty successMessage}">
                <div id="successModal" class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-check-circle text-success"></i> Success
                            </h3>
                            <button type="button" class="modal-close" onclick="closeSuccessModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>${successMessage}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" onclick="closeSuccessModal()">OK</button>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Profile Container -->
            <div class="appointments-section">
                <div class="appointments-content">
                    <form method="post" action="${pageContext.request.contextPath}/profile" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="update">

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
                                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assests/img/0.png'">
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
                                    <label for="avatarUpload" class="change-password-btn">
                                        <i class="fas fa-camera"></i> Change Photo
                                    </label>
                                    <input type="file" id="avatarUpload" name="avatar" style="display: none;" accept="image/jpeg,image/png,image/gif">
                                    <c:if test="${not empty avatarErrorMsg}">
                                        <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.5rem; text-align: center;">
                                            <i class="fa-solid fa-circle-exclamation me-1"></i>${avatarErrorMsg}
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Right Section - Profile Information -->
                            <div class="profile-right">
                                <h2 class="profile-section-title">Profile Information:</h2>

                                <div class="profile-info-grid">
                                    <div class="profile-field">
                                        <label class="profile-label">Username:</label>
                                        <input type="text" class="profile-value" value="${patient.accountName}" readonly disabled>
                                    </div>

                                    <div class="profile-field">
                                        <label class="profile-label">First name:</label>
                                        <input type="text" class="profile-value" id="firstName" name="firstName" value="${patient.firstName}">
                                        <c:if test="${not empty firstNameErrorMsg}">
                                            <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                                <i class="fa-solid fa-circle-exclamation me-1"></i>${firstNameErrorMsg}
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="profile-field">
                                        <label class="profile-label">Last name:</label>
                                        <input type="text" class="profile-value" id="lastName" name="lastName" value="${patient.lastName}">
                                        <c:if test="${not empty lastNameErrorMsg}">
                                            <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                                <i class="fa-solid fa-circle-exclamation me-1"></i>${lastNameErrorMsg}
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="profile-field">
                                        <label class="profile-label">Phone number:</label>
                                        <input type="tel" class="profile-value" id="phoneNumber" name="phoneNumber" value="${patient.phoneNumber}">
                                        <c:if test="${not empty phoneNumberErrorMsg}">
                                            <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                                <i class="fa-solid fa-circle-exclamation me-1"></i>${phoneNumberErrorMsg}
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="profile-field full-width">
                                        <label class="profile-label">Email:</label>
                                        <input type="text" class="profile-value" id="email" name="email" value="${patient.email}">
                                        <c:if test="${not empty emailErrorMsg}">
                                            <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                                <i class="fa-solid fa-circle-exclamation me-1"></i>${emailErrorMsg}
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="profile-field full-width">
                                        <label class="profile-label">Address:</label>
                                        <input type="text" class="profile-value" id="address" name="address" value="${patient.userAddress}">
                                        <c:if test="${not empty addressErrorMsg}">
                                            <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                                <i class="fa-solid fa-circle-exclamation me-1"></i>${addressErrorMsg}
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="profile-field">
                                        <label class="profile-label">Date of birth:</label>
                                        <input type="date" class="profile-value" id="dob" name="dob" value="<fmt:formatDate value='${patient.dob}' pattern='yyyy-MM-dd'/>">
                                        <c:if test="${not empty dobErrorMsg}">
                                            <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                                <i class="fa-solid fa-circle-exclamation me-1"></i>${dobErrorMsg}
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="profile-field">
                                        <label class="profile-label">Sex:</label>
                                        <select class="profile-value" id="gender" name="gender">
                                            <option value="Male" ${patient.gender ? 'selected' : ''}>Male</option>
                                            <option value="Female" ${!patient.gender ? 'selected' : ''}>Female</option>
                                        </select>
                                        <c:if test="${not empty genderErrorMsg}">
                                            <div class="text-danger small mt-1" style="font-size: 0.875rem; margin-top: 0.25rem;">
                                                <i class="fa-solid fa-circle-exclamation me-1"></i>${genderErrorMsg}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Actions -->
                                <div class="profile-actions">
                                    <a href="${pageContext.request.contextPath}/profile" class="btn-cancel-profile">
                                        <i class="fas fa-times"></i> Cancel
                                    </a>
                                    <button type="submit" class="btn-save-profile">
                                        <i class="fas fa-save"></i> Save Changes
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </main>
        <jsp:include page="../includes/footer.jsp" />

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Avatar upload preview - show immediately when file is selected
                const avatarUploadElement = document.getElementById('avatarUpload');
                if (avatarUploadElement) {
                    avatarUploadElement.addEventListener('change', function (e) {
                        const file = e.target.files[0];
                        if (file) {
                            // Validate file type
                            const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                            if (!validTypes.includes(file.type)) {
                                alert('Please select a valid image file (JPG, PNG, or GIF)');
                                e.target.value = ''; // Clear the input
                                return;
                            }
                            
                            // Validate file size (max 10MB)
                            const maxSize = 10 * 1024 * 1024; // 10MB in bytes
                            if (file.size > maxSize) {
                                alert('File size must be less than 10MB');
                                e.target.value = ''; // Clear the input
                                return;
                            }
                            
                            // Preview image immediately
                            const reader = new FileReader();
                            reader.onload = function (event) {
                                const profileAvatar = document.getElementById('profileAvatar');
                                if (profileAvatar) {
                                    profileAvatar.src = event.target.result;
                                    // Hide placeholder if exists
                                    const placeholder = profileAvatar.nextElementSibling;
                                    if (placeholder && placeholder.classList.contains('avatar-placeholder')) {
                                        placeholder.style.display = 'none';
                                    }
                                    profileAvatar.style.display = 'block';
                                }
                            };
                            reader.onerror = function() {
                                alert('Error reading file. Please try again.');
                            };
                            reader.readAsDataURL(file);
                        }
                    });
                }

                // Auto-show success modal on page load
                const successModal = document.getElementById('successModal');
                if (successModal) {
                    successModal.classList.add('active');
                    // Close on backdrop click
                    successModal.addEventListener('click', function(e) {
                        if (e.target === successModal) {
                            closeSuccessModal();
                        }
                    });
                }
            });

            // Close success modal function - globally accessible
            function closeSuccessModal() {
                const modal = document.getElementById('successModal');
                if (modal) {
                    modal.classList.remove('active');
                }
            }
        </script>
    </body>
</html>
