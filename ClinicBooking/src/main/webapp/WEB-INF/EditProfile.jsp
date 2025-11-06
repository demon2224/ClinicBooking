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

            <!-- Edit Profile Container -->
            <div class="edit-profile-container">
                <form method="post" action="${pageContext.request.contextPath}/edit-profile" enctype="multipart/form-data">
                    <div class="edit-profile-layout">
                        <!-- Left Section - Avatar -->
                        <div class="edit-profile-left">
                            <div class="edit-profile-avatar-section">
                                <img src="${pageContext.request.contextPath}/assests/img/default-avatar.png" 
                                     alt="Profile Avatar" 
                                     class="edit-profile-avatar"
                                     id="editProfileAvatar">
                                
                                <div class="edit-profile-name">Minh Khang</div>
                                
                                <label for="editAvatarUpload" class="upload-photo-btn">
                                    <i class="fas fa-camera"></i> Upload Photo
                                </label>
                                <input type="file" id="editAvatarUpload" name="avatar" style="display: none;" accept="image/*">
                            </div>
                        </div>

                        <!-- Right Section - Edit Form -->
                        <div class="edit-profile-right">
                            <h2 class="edit-profile-section-title">Profile Information:</h2>
                            
                            <div class="edit-profile-form-grid">
                                <div class="form-group">
                                    <label for="username" class="form-label">Username:</label>
                                    <input type="text" class="form-control" id="username" name="username" value="patient01" readonly disabled>
                                </div>

                                <div class="form-group">
                                    <label for="role" class="form-label">Role:</label>
                                    <input type="text" class="form-control" id="role" name="role" value="Patient" readonly disabled>
                                </div>

                                <div class="form-group">
                                    <label for="firstName" class="form-label">First name:</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" value="Minh" required>
                                </div>

                                <div class="form-group">
                                    <label for="lastName" class="form-label">Last name:</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" value="Khang" required>
                                </div>

                                <div class="form-group">
                                    <label for="phoneNumber" class="form-label">Phone number:</label>
                                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="0901234567" required>
                                </div>

                                <div class="form-group">
                                    <label for="email" class="form-label">Email:</label>
                                    <input type="email" class="form-control" id="email" name="email" value="minhkhang@example.com" required>
                                </div>

                                <div class="form-group full-width">
                                    <label for="address" class="form-label">Address:</label>
                                    <input type="text" class="form-control" id="address" name="address" value="123 Main Street, District 1, Ho Chi Minh City">
                                </div>

                                <div class="form-group">
                                    <label for="dob" class="form-label">DOB:</label>
                                    <input type="date" class="form-control" id="dob" name="dob" value="1999-01-15">
                                </div>

                                <div class="form-group">
                                    <label for="sex" class="form-label">Sex:</label>
                                    <select class="form-select" id="sex" name="sex">
                                        <option value="Male" selected>Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Actions -->
                            <div class="edit-profile-actions">
                                <a href="${pageContext.request.contextPath}/profile" class="btn-cancel">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn-save">
                                    <i class="fas fa-save"></i> Save
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
            document.getElementById('editAvatarUpload').addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('editProfileAvatar').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });

            // Form validation
            document.querySelector('form').addEventListener('submit', function(e) {
                const firstName = document.getElementById('firstName').value.trim();
                const lastName = document.getElementById('lastName').value.trim();
                const phoneNumber = document.getElementById('phoneNumber').value.trim();
                const email = document.getElementById('email').value.trim();

                if (!firstName || !lastName || !phoneNumber || !email) {
                    e.preventDefault();
                    alert('Please fill in all required fields');
                    return false;
                }

                // Phone validation
                const phonePattern = /^[0-9]{10}$/;
                if (!phonePattern.test(phoneNumber)) {
                    e.preventDefault();
                    alert('Please enter a valid 10-digit phone number');
                    return false;
                }

                // Email validation
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailPattern.test(email)) {
                    e.preventDefault();
                    alert('Please enter a valid email address');
                    return false;
                }
            });
        </script>
    </body>
</html>
