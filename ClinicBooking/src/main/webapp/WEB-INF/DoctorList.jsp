<%-- Document : DoctorList Created on : Oct 7, 2025, 9:48:47 AM Author : Nguyen Minh Khang - CE190728 --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Doctor List - CLINIC</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css" />

    </style>
</head>
<body class="appointment-page">
    <!-- Include Header -->
    <jsp:include page="includes/header.jsp">
        <jsp:param name="activePage" value="doctors" />
    </jsp:include>

    <!-- Main Content -->
    <main class="appointment-main-content">
        <!-- Page Header -->
        <div class="appointment-page-header">
            <div>
                <h1><i class="fas fa-user-md"></i> Doctor List</h1>
            </div>
        </div>

        <!-- Search and Filter Section -->
        <div class="search-filter-section">
            <div class="search-filter-content">
                <form method="POST" action="${pageContext.request.contextPath}/doctor" class="search-form">
                    <input type="hidden" name="action" value="search">
                    <div class="search-row">
                        <!-- Search Input -->
                        <div class="search-input-group">
                            <i class="fas fa-search"></i>
                            <input type="text" name="search" class="search-input"
                                   placeholder="Search by doctor name or specialty..."
                                   value="${search != null ? search : ''}">
                        </div>

                        <!-- Search Button -->
                        <button type="submit" class="btn-search">
                            <i class="fas fa-search"></i> Search
                        </button>

                        <!-- Clear Filters Button -->
                        <a href="${pageContext.request.contextPath}/doctor" class="btn-clear">
                            <i class="fas fa-times"></i> Clear
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="appointment-alert appointment-alert-error">
                <i class="fas fa-exclamation-triangle"></i>
                ${errorMessage}
            </div>
        </c:if>

        <!-- Doctor Grid -->
        <div class="appointments-section">
            <div class="appointments-content">
                <c:choose>
                    <c:when test="${empty doctors}">
                        <div class="doctors-empty-state">
                            <i class="fas fa-user-md-times"></i>
                            <h3>No doctors available</h3>
                            <p>No doctors found matching your criteria. Try adjusting your search.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="doctors-grid">
                            <c:forEach var="doctor" items="${doctors}">
                                <div class="doctor-profile-card">
                                    <!-- Doctor Avatar -->
                                    <img src="${pageContext.request.contextPath}${doctor.staffID.avatar}"
                                         alt="Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}"
                                         class="doctor-profile-avatar"
                                         onerror="this.src='${pageContext.request.contextPath}/assests/img/0.png'">

                                    <!-- Doctor Name -->
                                    <h3 class="doctor-profile-name">
                                        Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}
                                    </h3>

                                    <!-- Doctor Specialty -->
                                    <p class="doctor-profile-specialty">
                                        <i class="fas fa-stethoscope"></i> ${doctor.specialtyID.specialtyName}
                                    </p>

                                    <!-- Years Experience -->
                                    <p class="doctor-profile-experience">
                                        <i class="fas fa-award"></i> +${doctor.yearExperience} years experience
                                    </p>

                                    <!-- Status Badge -->
                                    <span class="status-badge status-approved">
                                        <i class="fas fa-check-circle"></i> Available
                                    </span>

                                    <!-- Action Buttons -->
                                    <div class="doctor-profile-actions">
                                        <a href="${pageContext.request.contextPath}/doctor?action=detail&id=${doctor.doctorID}"
                                           class="btn-action btn-view">
                                            <i class="fas fa-eye"></i> View Detail
                                        </a>
                                        <a href="${pageContext.request.contextPath}/manage-my-appointments?action=bookAppointment&doctorId=${doctor.doctorID}"
                                           class="btn-action btn-book">
                                            <i class="fas fa-calendar-plus"></i> Book
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

