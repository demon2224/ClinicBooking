<%--
    Document   : MyPrescriptionList
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
        <title>My Prescriptions - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">


        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="../includes/header.jsp">
            <jsp:param name="activePage" value="manage-prescriptions" />
        </jsp:include>

        <!-- Main Content -->
        <main class="appointment-main-content">
            <!-- Page Header -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-prescription-bottle-alt"></i> My Prescriptions</h1>
            </div>

            <!-- Search and Filter Section -->
            <div class="search-filter-section">
                <div class="search-filter-content">
                    <form method="GET"
                          action="${pageContext.request.contextPath}/manage-my-prescriptions"
                          class="search-form">

                        <div class="search-row">
                            <!-- Search Input -->
                            <div class="search-input-group">
                                <i class="fas fa-search"></i>
                                <input type="text"
                                       name="search"
                                       placeholder="Search by doctor name or specialty..."
                                       value="${searchQuery}"
                                       class="search-input" />
                            </div>

                            <!-- Search Button -->
                            <button type="submit" class="btn-search">
                                <i class="fas fa-search"></i>
                                Search
                            </button>

                            <!-- Clear Button -->
                            <a href="${pageContext.request.contextPath}/manage-my-prescriptions"
                               class="btn-clear">
                                <i class="fas fa-times"></i>
                                Clear
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Prescriptions Section -->
            <div class="appointments-section">
                <div class="appointments-content">
                    <c:choose>
                        <c:when test="${empty prescriptions}">
                            <!-- Empty State -->
                            <div class="appointment-empty-state">
                                <i class="fas fa-prescription-bottle-alt"></i>
                                <h3>No Prescriptions Found</h3>
                                <p>You don't have any prescriptions yet.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Display Prescriptions -->
                            <c:forEach var="prescription" items="${prescriptions}">
                                <div class="appointment-card">
                                    <div class="appointment-header">
                                        <div class="appointment-info">
                                            <div class="appointment-date">
                                                <i class="fas fa-calendar"></i>
                                                Delivered Date: <fmt:formatDate value="${prescription.dateCreate}"
                                                                pattern="EEEE, MMMM dd, yyyy" />
                                            </div>
                                            <div class="appointment-doctor">
                                                <i class="fas fa-user-md"></i>
                                                <c:choose>
                                                    <c:when test="${not empty prescription.appointmentID.doctorID.staffID.firstName && not empty prescription.appointmentID.doctorID.staffID.lastName}">
                                                        Dr. ${prescription.appointmentID.doctorID.staffID.firstName} ${prescription.appointmentID.doctorID.staffID.lastName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Doctor information not available
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-graduation-cap"></i>
                                                <c:choose>
                                                    <c:when test="${not empty prescription.appointmentID.doctorID.specialtyID.specialtyName}">
                                                        ${prescription.appointmentID.doctorID.specialtyID.specialtyName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Specialty not available
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="appointment-status
                                             <c:choose>
                                                 <c:when test="${prescription.prescriptionStatus == 'Delivered'}">status-completed</c:when>
                                                 <c:when test="${prescription.prescriptionStatus == 'Pending'}">status-pending</c:when>
                                                 <c:when test="${prescription.prescriptionStatus == 'Canceled'}">status-cancelled</c:when>
                                                 <c:otherwise>status-pending</c:otherwise>
                                             </c:choose>
                                             ">
                                            ${prescription.prescriptionStatus != null ? prescription.prescriptionStatus : 'Pending'}
                                        </div>
                                    </div>
                                    <div class="appointment-actions">
                                        <a href="${pageContext.request.contextPath}/manage-my-prescriptions?id=${prescription.prescriptionID}" class="btn-action btn-view">
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
        <jsp:include page="../includes/footer.jsp" />

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
