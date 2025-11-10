<%--
    Document   : ManageMyMedicalRecord
    Created on : Dec 20, 2024, 12:30:00 AM
    Author     : Le Anh Tuan - CE180905
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
        <title>Manage My Medical Records - CLINIC</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </style>
</head>
<body class="appointment-page">
    <!-- Include Header -->
    <jsp:include page="../includes/header.jsp">
        <jsp:param name="activePage" value="manage-medical-records" />
    </jsp:include>

    <!-- Main Content -->
    <main class="appointment-main-content">
        <!-- Page Header -->
        <div class="appointment-page-header">
            <h1><i class="fas fa-file-medical"></i> Manage My Medical Records</h1>
        </div>

        <!-- Search and Filter Section -->
        <div class="search-filter-section">
            <div class="search-filter-content">
                <form method="GET"
                      action="${pageContext.request.contextPath}/manage-my-medical-records"
                      class="search-form">

                    <div class="search-row">
                        <!-- Search Input -->
                        <div class="search-input-group">
                            <i class="fas fa-search"></i>
                            <input type="text"
                                   name="search"
                                   placeholder="Search by doctor name, specialty, symptoms, or diagnosis..."
                                   value="${searchQuery}"
                                   class="search-input" />
                        </div>

                        <!-- Search Button -->
                        <button type="submit" class="btn-search">
                            <i class="fas fa-search"></i>
                            Search
                        </button>

                        <!-- Clear Button -->
                        <a href="${pageContext.request.contextPath}/manage-my-medical-records"
                           class="btn-clear">
                            <i class="fas fa-times"></i>
                            Clear
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Medical Records Section -->
        <div class="appointments-section">
            <div class="appointments-content">
                <c:choose>
                    <c:when test="${empty medicalRecords}">
                        <!-- Empty State -->
                        <div class="appointment-empty-state">
                            <i class="fas fa-file-medical-alt"></i>
                            <h3>No Medical Records Found</h3>
                            <p>You don't have any medical records yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Display Medical Records -->
                        <c:forEach var="medicalRecord" items="${medicalRecords}">
                            <div class="appointment-card">
                                <div class="appointment-header">
                                    <div class="appointment-info">
                                        <div class="appointment-date">
                                            <i class="fas fa-calendar"></i>
                                            <fmt:formatDate value="${medicalRecord.dateCreate}"
                                                            pattern="EEEE, MMMM dd, yyyy" />
                                        </div>
                                        <div class="appointment-doctor">
                                            <i class="fas fa-user-md"></i>
                                            <c:choose>
                                                <c:when test="${not empty medicalRecord.appointmentID.doctorID.staffID.firstName && not empty medicalRecord.appointmentID.doctorID.staffID.lastName}">
                                                    Dr. ${medicalRecord.appointmentID.doctorID.staffID.firstName} ${medicalRecord.appointmentID.doctorID.staffID.lastName}
                                                </c:when>
                                                <c:otherwise>
                                                    Doctor information not available
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="appointment-specialty">
                                            <i class="fas fa-graduation-cap"></i>
                                            <c:choose>
                                                <c:when test="${not empty medicalRecord.appointmentID.doctorID.specialtyID.specialtyName}">
                                                    ${medicalRecord.appointmentID.doctorID.specialtyID.specialtyName}
                                                </c:when>
                                                <c:otherwise>
                                                    Specialty not available
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="appointment-specialty">
                                            <i class="fas fa-stethoscope"></i>
                                            Symptoms: ${medicalRecord.symptoms != null ? medicalRecord.symptoms : 'No symptoms recorded'}
                                        </div>
                                        <div class="appointment-specialty">
                                            <i class="fas fa-diagnoses"></i>
                                            Diagnosis: ${medicalRecord.diagnosis != null ? medicalRecord.diagnosis : 'No diagnosis'}
                                        </div>
                                    </div>
                                </div>
                                <div class="appointment-actions">
                                    <a href="${pageContext.request.contextPath}/manage-my-medical-records?id=${medicalRecord.medicalRecordID}" class="btn-action btn-view">
                                        <i class="fas fa-eye"></i>
                                        View Details
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <!-- JavaScript for interactivity -->
    <script>
        // Dropdown menu functionality
        document.addEventListener('DOMContentLoaded', function () {
            const dropdowns = document.querySelectorAll('.dropdown');

            dropdowns.forEach(dropdown => {
                const toggle = dropdown.querySelector('.dropdown-toggle');
                const menu = dropdown.querySelector('.dropdown-menu');

                if (toggle && menu) {
                    // Handle click for dropdown
                    toggle.addEventListener('click', function (e) {
                        e.preventDefault();

                        // Close other dropdowns
                        dropdowns.forEach(otherDropdown => {
                            if (otherDropdown !== dropdown) {
                                const otherMenu = otherDropdown.querySelector('.dropdown-menu');
                                if (otherMenu) {
                                    otherMenu.style.opacity = '0';
                                    otherMenu.style.visibility = 'hidden';
                                    otherMenu.style.transform = 'translateY(-10px)';
                                }
                            }
                        });

                        // Toggle current dropdown
                        const isVisible = menu.style.opacity === '1';
                        if (isVisible) {
                            menu.style.opacity = '0';
                            menu.style.visibility = 'hidden';
                            menu.style.transform = 'translateY(-10px)';
                        } else {
                            menu.style.opacity = '1';
                            menu.style.visibility = 'visible';
                            menu.style.transform = 'translateY(0)';
                        }
                    });
                }
            });

            // Close dropdown when clicking outside
            document.addEventListener('click', function (e) {
                if (!e.target.closest('.dropdown')) {
                    dropdowns.forEach(dropdown => {
                        const menu = dropdown.querySelector('.dropdown-menu');
                        if (menu) {
                            menu.style.opacity = '0';
                            menu.style.visibility = 'hidden';
                            menu.style.transform = 'translateY(-10px)';
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>