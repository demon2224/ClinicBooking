<%--
    Document   : MyAppointmentDetail
    Created on : Oct 8, 2025, 3:46:33 PM
    Author     : Le Anh Tuan - CE180905
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Appointment Details - CLINIC</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="manage-appointments" />
        </jsp:include>

        <main class="appointment-main-content">


            <div class="appointment-detail-card">
                <div class="appointment-page-header">
                    <h1><i class="fas fa-calendar-check"></i> Appointment Details</h1>
                </div>
                <!-- Content Sections -->
                <div class="appointment-content">
                    <c:choose>
                        <c:when test="${not empty appointment}">
                            <!-- Appointment Information -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-calendar-alt"></i>
                                    Appointment Information
                                </h3>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-calendar"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Appointment Date</h4>
                                            <p>
                                                <fmt:formatDate value="${appointment.dateBegin}"
                                                                pattern="EEEE, MMMM dd, yyyy"/>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-clock"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Time</h4>
                                            <p>
                                                <fmt:formatDate value="${appointment.dateBegin}" pattern="hh:mm a"/> -
                                                <fmt:formatDate value="${appointment.dateEnd}" pattern="hh:mm a"/>
                                            </p>
                                        </div>
                                    </div>

                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-plus-circle"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Created On</h4>
                                            <p>
                                                <fmt:formatDate value="${appointment.dateCreate}"
                                                                pattern="MMM dd, yyyy 'at' hh:mm a"/>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-info-circle"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Status</h4>
                                            <p>
                                                <span class="appointment-status
                                                      <c:choose>
                                                          <c:when test="${appointment.appointmentStatusID == 2}">status-confirmed</c:when>
                                                          <c:when test="${appointment.appointmentStatusID == 1}">status-pending</c:when>
                                                          <c:when test="${appointment.appointmentStatusID == 4}">status-cancelled</c:when>
                                                          <c:when test="${appointment.appointmentStatusID == 3}">status-completed</c:when>
                                                          <c:otherwise>status-pending</c:otherwise>
                                                      </c:choose>">
                                                    ${appointment.statusName != null ? appointment.statusName : 'Unknown'}
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Doctor Information -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-user-md"></i>
                                    Doctor Information
                                </h3>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-user-md"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Doctor Name</h4>
                                            <p>Dr. ${appointment.doctorName != null ? appointment.doctorName : 'Unknown Doctor'}</p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-stethoscope"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Specialty</h4>
                                            <p>${appointment.specialtyName != null ? appointment.specialtyName : 'General Medicine'}</p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Rating</h4>
                                            <p>
                                                <span class="stars">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </span>
                                                5.0
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-graduation-cap"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Experience</h4>
                                            <p>8+ years</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Additional Notes -->
                            <c:choose>
                                <c:when test="${not empty appointment.note}">
                                    <div class="info-section">
                                        <h3 class="section-title">
                                            <i class="fas fa-sticky-note"></i>
                                            Appointment Notes
                                        </h3>
                                        <div class="info-grid">
                                            <div class="info-item">
                                                <div class="info-icon">
                                                    <i class="fas fa-comment-alt"></i>
                                                </div>
                                                <div class="info-content">
                                                    <h4>Notes</h4>
                                                    <p>${appointment.note}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <!-- Error Message -->
                            <div class="appointment-empty-state">
                                <div class="appointment-alert appointment-alert-error">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    <h3>Appointment Not Found</h3>
                                    <p>The requested appointment could not be found or you don't have permission to view it.</p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </body>
</html>
