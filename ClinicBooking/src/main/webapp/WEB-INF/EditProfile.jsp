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

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>

        <style>
            body.edit-profile-page {
                margin: 0 !important;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                padding-top: 80px !important;
                background-color: #f8fafc !important;
                overflow-x: hidden !important;
            }

            .edit-profile-main-content {
                padding: 2rem !important;
                max-width: 1200px !important;
                margin: 0 auto !important;
                min-height: calc(100vh - 80px) !important;
            }

            .edit-profile-page-header {
                background: #175CDD !important;
                padding: 1.5rem 2rem !important;
                border-radius: 0.5rem !important;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
                margin-bottom: 2rem !important;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .edit-profile-page-header h1 {
                color: white !important;
                margin: 0;
                font-size: 1.75rem;
                font-weight: 600;
            }

            .edit-profile-container {
                background: white;
                border-radius: 0.5rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 2rem;
            }

            .edit-profile-layout {
                display: grid;
                grid-template-columns: 300px 1fr;
                gap: 3rem;
            }

            .edit-profile-left {
                text-align: center;
            }

            .edit-profile-avatar-section {
                background: #f8fafc;
                border-radius: 0.5rem;
                padding: 2rem 1.5rem;
                border: 2px solid #e2e8f0;
            }

            .edit-profile-avatar {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #175CDD;
                margin-bottom: 1rem;
            }

            .edit-profile-name {
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

            .edit-profile-right {
                padding-left: 1rem;
            }

            .edit-profile-section-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #1e293b;
                margin-bottom: 1.5rem;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #e2e8f0;
            }

            .edit-profile-form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            .form-group.full-width {
                grid-column: span 2;
            }

            .form-label {
                display: block;
                font-weight: 500;
                color: #374151;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
            }

            .form-control, .form-select {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid #e2e8f0;
                border-radius: 0.375rem;
                font-size: 0.95rem;
                transition: all 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                outline: none;
                border-color: #175CDD;
                box-shadow: 0 0 0 3px rgba(23, 92, 221, 0.1);
            }

            .form-control:disabled, .form-select:disabled {
                background-color: #f8fafc;
                cursor: not-allowed;
            }

            .edit-profile-actions {
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 2px solid #e2e8f0;
                display: flex;
                justify-content: flex-end;
                gap: 1rem;
            }

            .btn-cancel {
                padding: 0.75rem 2rem;
                background: #f1f5f9;
                color: #64748b;
                border: 1px solid #e2e8f0;
                border-radius: 0.375rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
            }

            .btn-cancel:hover {
                background: #e2e8f0;
                color: #475569;
            }

            .btn-save {
                padding: 0.75rem 2rem;
                background: #175CDD;
                color: white;
                border: none;
                border-radius: 0.375rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-save:hover {
                background: #1e40af;
            }

            .alert {
                padding: 1rem;
                margin-bottom: 1.5rem;
                border-radius: 0.375rem;
                border: 1px solid transparent;
            }

            .alert-danger {
                background-color: #fef2f2;
                border-color: #fecaca;
                color: #dc2626;
            }

            .alert-success {
                background-color: #f0fdf4;
                border-color: #bbf7d0;
                color: #16a34a;
            }

            .alert ul {
                margin-left: 1.5rem;
                margin-bottom: 0;
            }

            .text-muted {
                font-size: 0.75rem;
                color: #64748b;
                margin-top: 0.25rem;
                display: block;
            }

            /* Inline validation removed - using backend modal only */

            @media (max-width: 992px) {
                .edit-profile-layout {
                    grid-template-columns: 1fr;
                    gap: 2rem;
                }

                .edit-profile-right {
                    padding-left: 0;
                }
            }

            @media (max-width: 768px) {
                .edit-profile-form-grid {
                    grid-template-columns: 1fr;
                }

                .form-group.full-width {
                    grid-column: span 1;
                }

                .edit-profile-actions {
                    flex-direction: column;
                }

                .btn-cancel, .btn-save {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body class="edit-profile-page">
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="profile" />
        </jsp:include>

        <!-- Main Content -->
        <main class="edit-profile-main-content">
            <!-- Page Header -->
            <div class="edit-profile-page-header">
                <i class="fas fa-user-edit fa-lg"></i>
                <h1>Edit Profile</h1>
            </div>

            <!-- Error Modal -->
            <c:if test="${not empty errors}">
                <div id="messageModal" class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-exclamation-triangle text-error"></i> Error
                            </h3>
                            <button type="button" class="modal-close" onclick="closeModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <ul style="margin: 0; padding-left: 1.5rem; color: #374151;">
                                <c:forEach var="error" items="${errors}">
                                    <li>${error}</li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" onclick="closeModal()">Close</button>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Success Modal -->
            <c:if test="${not empty successMessage}">
                <div id="messageModal" class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <i class="fas fa-check-circle text-success"></i> Success
                            </h3>
                            <button type="button" class="modal-close" onclick="closeModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>${successMessage}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" onclick="closeModal()">OK</button>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Edit Profile Container -->
            <div class="edit-profile-container">
                <form method="post" action="${pageContext.request.contextPath}/profile" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="update">
                    
                    <div class="edit-profile-layout">
                        <!-- Left Section - Avatar -->
                        <div class="edit-profile-left">
                            <div class="edit-profile-avatar-section">
                                <c:choose>
                                    <c:when test="${not empty patient.avatar}">
                                        <img src="${pageContext.request.contextPath}/${patient.avatar}"
                                             alt="Profile Avatar"
                                             class="edit-profile-avatar"
                                             id="editProfileAvatar"
                                             onerror="this.src='${pageContext.request.contextPath}/assests/img/0.png'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assests/img/0.png"
                                             alt="Profile Avatar"
                                             class="edit-profile-avatar"
                                             id="editProfileAvatar">
                                    </c:otherwise>
                                </c:choose>

                                <div class="edit-profile-name">${patient.firstName} ${patient.lastName}</div>

                                <label for="editAvatarUpload" class="upload-photo-btn">
                                    <i class="fas fa-camera"></i> Change Photo
                                </label>
                                <input type="file" id="editAvatarUpload" name="avatar" style="display: none;" accept="image/jpeg,image/png,image/gif">
                                <div style="font-size: 0.75rem; color: #64748b; margin-top: 0.5rem;">
                                    Max 10MB (.jpg, .png, .gif)
                                </div>
                            </div>
                        </div>

                        <!-- Right Section - Edit Form -->
                        <div class="edit-profile-right">
                            <h2 class="edit-profile-section-title">Profile Information:</h2>

                            <div class="edit-profile-form-grid">
                                <div class="form-group">
                                    <label for="username" class="form-label">Username:</label>
                                    <input type="text" class="form-control" id="username" value="${patient.accountName}" readonly disabled>
                                    <small class="text-muted">Username cannot be changed</small>
                                </div>

                                <div class="form-group">
                                    <label for="role" class="form-label">Role:</label>
                                    <input type="text" class="form-control" id="role" value="Patient" readonly disabled>
                                </div>

                                <div class="form-group">
                                    <label for="firstName" class="form-label">First name: <span style="color: red;">*</span></label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" value="${patient.firstName}" required>
                                </div>

                                <div class="form-group">
                                    <label for="lastName" class="form-label">Last name: <span style="color: red;">*</span></label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" value="${patient.lastName}" required>
                                </div>

                                <div class="form-group">
                                    <label for="phoneNumber" class="form-label">Phone number: <span style="color: red;">*</span></label>
                                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="${patient.phoneNumber}" required>
                                    <small class="text-muted">Format: 0xxxxxxxxx (10 digits)</small>
                                </div>

                                <div class="form-group">
                                    <label for="email" class="form-label">Email: <span style="color: red;">*</span></label>
                                    <input type="email" class="form-control" id="email" name="email" value="${patient.email}" required>
                                    <small class="text-muted">Must be unique</small>
                                </div>

                                <div class="form-group full-width">
                                    <label for="address" class="form-label">Address:</label>
                                    <input type="text" class="form-control" id="address" name="address" value="${patient.userAddress}">
                                </div>

                                <div class="form-group">
                                    <label for="dob" class="form-label">Date of Birth: <span style="color: red;">*</span></label>
                                    <input type="date" class="form-control" id="dob" name="dob" value="<fmt:formatDate value='${patient.dob}' pattern='yyyy-MM-dd'/>" required>
                                    <small class="text-muted">Must be 18+ years old</small>
                                </div>

                                <div class="form-group">
                                    <label for="gender" class="form-label">Gender: <span style="color: red;">*</span></label>
                                    <select class="form-select" id="gender" name="gender" required>
                                        <option value="Male" ${patient.gender ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${!patient.gender ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Actions -->
                            <div class="edit-profile-actions">
                                <a href="${pageContext.request.contextPath}/profile" class="btn-cancel">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn-save">
                                    <i class="fas fa-save"></i> Save Changes
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </main>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Avatar upload preview
            document.getElementById('editAvatarUpload').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file) {
                    // File validation will be handled by backend - show in modal

                    // Preview image
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('editProfileAvatar').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });

            // Avatar upload preview (keep simple, no validation popups)

            // Form validation removed - let backend handle all validation via modal

            // Close modal function
            function closeModal() {
                const modal = document.getElementById('messageModal');
                if (modal) {
                    modal.style.display = 'none';
                }
            }

            // Auto-show modal on page load
            window.addEventListener('DOMContentLoaded', function() {
                const modal = document.getElementById('messageModal');
                if (modal) {
                    modal.style.display = 'flex';
                }
            });
        </script>
    </body>
</html>
