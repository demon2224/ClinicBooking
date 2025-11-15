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
                <h1><i class="fas fa-user-edit"></i> Edit Profile</h1>
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
                                    <label for="avatarUpload" class="change-password-btn">
                                        <i class="fas fa-camera"></i> Change Photo
                                    </label>
                                    <input type="file" id="avatarUpload" name="avatar" style="display: none;" accept="image/jpeg,image/png,image/gif">
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
                                        <input type="text" class="profile-value" id="firstName" name="firstName" value="${patient.firstName}" required>
                                    </div>

                                    <div class="profile-field">
                                        <label class="profile-label">Last name:</label>
                                        <input type="text" class="profile-value" id="lastName" name="lastName" value="${patient.lastName}" required>
                                    </div>

                                    <div class="profile-field">
                                        <label class="profile-label">Phone number:</label>
                                        <input type="tel" class="profile-value" id="phoneNumber" name="phoneNumber" value="${patient.phoneNumber}" required>
                                    </div>

                                    <div class="profile-field full-width">
                                        <label class="profile-label">Email:</label>
                                        <input type="email" class="profile-value" id="email" name="email" value="${patient.email}" required>
                                    </div>

                                    <div class="profile-field full-width">
                                        <label class="profile-label">Address:</label>
                                        <input type="text" class="profile-value" id="address" name="address" value="${patient.userAddress}">
                                    </div>

                                    <div class="profile-field">
                                        <label class="profile-label">Date of birth:</label>
                                        <input type="date" class="profile-value" id="dob" name="dob" value="<fmt:formatDate value='${patient.dob}' pattern='yyyy-MM-dd'/>" required>
                                    </div>

                                    <div class="profile-field">
                                        <label class="profile-label">Sex:</label>
                                        <select class="profile-value" id="gender" name="gender" required>
                                            <option value="Male" ${patient.gender ? 'selected' : ''}>Male</option>
                                            <option value="Female" ${!patient.gender ? 'selected' : ''}>Female</option>
                                        </select>
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
            // Avatar upload preview
            document.getElementById('avatarUpload').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file) {
                    // File validation will be handled by backend - show in modal

                    // Preview image
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('profileAvatar').src = e.target.result;
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
            window.addEventListener('DOMContentLoaded', function () {
                const modal = document.getElementById('messageModal');
                if (modal) {
                    modal.style.display = 'flex';
                }
            });
        </script>
    </body>
</html>
