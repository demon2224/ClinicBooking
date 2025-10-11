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

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>

        <style>
            body {
                margin: 0;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                padding-top: 80px;
                background-color: #f8fafc;
            }

            /* Force header to be at top */
            .header {
                position: fixed !important;
                top: 0 !important;
                left: 0 !important;
                right: 0 !important;
                z-index: 9999 !important;
                background-color: #ffffff !important;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
            }

            .main-content {
                padding: 2rem;
                max-width: 1200px;
                margin: 0 auto;
                min-height: calc(100vh - 80px);
                position: relative;
                z-index: 1;
            }

            /* Page Header - Simple style like manage appointments */
            .page-header {
                background: white;
                padding: 2rem;
                border-radius: 0.5rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-bottom: 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .page-header h1 {
                color: #175CDD;
                margin: 0;
                font-size: 2rem;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .page-header h1 i {
                color: #175CDD;
                font-size: 1.8rem;
            }

            .page-header p {
                color: #64748b;
                margin: 0.5rem 0 0 0;
                font-size: 1.1rem;
            }

            .back-btn {
                background: #e2e8f0;
                color: #475569;
                padding: 0.75rem 1.5rem;
                border: none;
                border-radius: 0.375rem;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .back-btn:hover {
                background: #cbd5e1;
                color: #334155;
            }

            /* Appointment Detail Card */
            .appointment-detail-card {
                background: white;
                border-radius: 0.75rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                overflow: hidden;
                margin-bottom: 2rem;
            }

            /* Header Section - Simplified */
            .appointment-header {
                background: #175CDD;
                color: white;
                padding: 1.5rem 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .appointment-header h2 {
                margin: 0;
                font-size: 1.5rem;
                font-weight: 600;
                color: white;
            }

            /* Status Badge in Header */
            .status-badge {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-pending {
                background: rgba(255, 193, 7, 0.2);
                color: #856404;
                border: 1px solid rgba(255, 193, 7, 0.5);
            }

            .status-confirmed {
                background: rgba(40, 167, 69, 0.2);
                color: #155724;
                border: 1px solid rgba(40, 167, 69, 0.5);
            }

            .status-cancelled {
                background: rgba(220, 53, 69, 0.2);
                color: #721c24;
                border: 1px solid rgba(220, 53, 69, 0.5);
            }

            .status-completed {
                background: rgba(23, 162, 184, 0.2);
                color: #0c5460;
                border: 1px solid rgba(23, 162, 184, 0.5);
            }

            /* Content Sections */
            .appointment-content {
                padding: 0;
            }

            .info-section {
                padding: 2rem;
                border-bottom: 1px solid #e2e8f0;
            }

            .info-section:last-child {
                border-bottom: none;
            }

            .section-title {
                color: #175CDD;
                font-size: 1.25rem;
                font-weight: 600;
                margin: 0 0 1.5rem 0;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .section-title i {
                color: #175CDD;
            }

            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 2rem;
            }

            .info-item {
                display: flex;
                align-items: flex-start;
                gap: 1rem;
            }

            .info-icon {
                width: 40px;
                height: 40px;
                background: #f1f5f9;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #175CDD;
                font-size: 1.1rem;
                flex-shrink: 0;
            }

            .info-content h4 {
                margin: 0 0 0.25rem 0;
                color: #1e293b;
                font-weight: 600;
                font-size: 1rem;
            }

            .info-content p {
                margin: 0;
                color: #64748b;
                font-size: 0.95rem;
                line-height: 1.4;
            }

            /* Action Buttons */
            .action-buttons {
                padding: 2rem;
                background: #f8fafc;
                display: flex;
                gap: 1rem;
                justify-content: flex-end;
            }

            .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 600;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                border: 2px solid transparent;
                transition: all 0.2s ease;
                cursor: pointer;
                font-size: 0.95rem;
            }

            .btn-primary {
                background: #175CDD;
                color: white;
            }

            .btn-primary:hover {
                background: #1e40af;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(23, 92, 221, 0.3);
            }

            .btn-outline {
                background: white;
                color: #175CDD;
                border-color: #175CDD;
            }

            .btn-outline:hover {
                background: #175CDD;
                color: white;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(23, 92, 221, 0.2);
            }

            .btn-danger {
                background: #dc3545;
                color: white;
            }

            .btn-danger:hover {
                background: #c82333;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .main-content {
                    padding: 1rem;
                }

                .appointment-info {
                    flex-direction: column;
                    text-align: center;
                    gap: 1rem;
                }

                .appointment-title h1 {
                    font-size: 2rem;
                }

                .status-actions {
                    position: relative;
                    top: auto;
                    right: auto;
                    justify-content: center;
                    margin-top: 1rem;
                }

                .info-grid {
                    grid-template-columns: 1fr;
                    gap: 1.5rem;
                }

                .action-buttons {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="manage-appointments" />
        </jsp:include>

        <main class="main-content">
            <div class="appointment-detail-card">
                <div class="page-header">
                    <div>
                        <h1><i class="fas fa-calendar-check"></i> Appointment Details</h1>
                        <p>View and manage your appointment information</p>
                    </div>
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
                            <div class="info-section">
                                <div class="error-message">
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
