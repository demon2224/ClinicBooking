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

            <!-- Profile Container -->
            <div class="profile-container">
                <div class="profile-layout">
                    <!-- Left Section - Avatar & Actions -->
                    <div class="profile-left">
                        <div class="profile-avatar-section">
                            <img src="${pageContext.request.contextPath}/assests/img/default-avatar.png" 
                                 alt="Profile Avatar" 
                                 class="profile-avatar"
                                 id="profileAvatar">
                            
                            <div class="profile-name">Minh Khang</div>
                            
                            <label for="avatarUpload" class="upload-photo-btn">
                                <i class="fas fa-camera"></i> Upload Photo
                            </label>
                            <input type="file" id="avatarUpload" style="display: none;" accept="image/*">
                            
                            <button type="button" class="change-password-btn">
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
                                <span class="profile-value">patient01</span>
                            </div>

                            <div class="profile-field">
                                <label class="profile-label">Role:</label>
                                <span class="profile-value">Patient</span>
                            </div>

                            <div class="profile-field">
                                <label class="profile-label">First name:</label>
                                <span class="profile-value">Minh</span>
                            </div>

                            <div class="profile-field">
                                <label class="profile-label">Last name:</label>
                                <span class="profile-value">Khang</span>
                            </div>

                            <div class="profile-field">
                                <label class="profile-label">Phone number:</label>
                                <span class="profile-value">0901234567</span>
                            </div>

                            <div class="profile-field">
                                <label class="profile-label">Email:</label>
                                <span class="profile-value">minhkhang@example.com</span>
                            </div>

                            <div class="profile-field full-width">
                                <label class="profile-label">Address:</label>
                                <span class="profile-value">123 Main Street, District 1, Ho Chi Minh City</span>
                            </div>

                            <div class="profile-field">
                                <label class="profile-label">DOB:</label>
                                <span class="profile-value">1999-01-15</span>
                            </div>

                            <div class="profile-field">
                                <label class="profile-label">Sex:</label>
                                <span class="profile-value">Male</span>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="profile-actions">
                            <a href="${pageContext.request.contextPath}/edit-profile" class="btn-edit-profile">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Avatar upload preview
            document.getElementById('avatarUpload').addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('profileAvatar').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });
        </script>
    </body>
</html>
