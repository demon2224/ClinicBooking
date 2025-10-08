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

            .main-content {
                padding: 2rem;
                max-width: 1000px;
                margin: 0 auto;
            }

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
                font-size: 1.8rem;
                font-weight: 600;
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
            }

            .back-btn:hover {
                background: #cbd5e1;
            }

            .appointment-detail-card {
                background: white;
                border-radius: 0.5rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                margin-bottom: 2rem;
            }

            .card-header {
                background: #175CDD;
                color: white;
                padding: 1.5rem 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .card-header h2 {
                margin: 0;
                font-size: 1.25rem;
                font-weight: 600;
            }

            .status-badge {
                padding: 0.5rem 1rem;
                border-radius: 1rem;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .status-confirmed {
                background: #dcfce7;
                color: #166534;
            }
            .status-pending {
                background: #fef3c7;
                color: #92400e;
            }
            .status-cancelled {
                background: #fee2e2;
                color: #dc2626;
            }
            .status-completed {
                background: #dbeafe;
                color: #1e40af;
            }

            .card-content {
                padding: 2rem;
            }

            .detail-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 2rem;
                margin-bottom: 2rem;
            }

            .detail-section {
                border: 1px solid #e2e8f0;
                border-radius: 0.375rem;
                padding: 1.5rem;
            }

            .detail-section h3 {
                color: #1e293b;
                margin: 0 0 1rem 0;
                font-size: 1.1rem;
                font-weight: 600;
                border-bottom: 2px solid #e2e8f0;
                padding-bottom: 0.5rem;
            }

            .detail-item {
                display: flex;
                margin-bottom: 0.75rem;
            }

            .detail-label {
                font-weight: 500;
                color: #475569;
                min-width: 120px;
            }

            .detail-value {
                color: #1e293b;
                flex: 1;
            }

            .action-buttons {
                display: flex;
                gap: 1rem;
                justify-content: center;
                padding-top: 1.5rem;
                border-top: 1px solid #e2e8f0;
            }

            .btn {
                padding: 0.75rem 1.5rem;
                border: none;
                border-radius: 0.375rem;
                font-weight: 500;
                text-decoration: none;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-cancel {
                background: #fee2e2;
                color: #dc2626;
            }

            .btn-cancel:hover {
                background: #fecaca;
            }

            .btn-reschedule {
                background: #f3e8ff;
                color: #7c3aed;
            }

            .btn-reschedule:hover {
                background: #e9d5ff;
            }

            .alert {
                padding: 1rem 1.5rem;
                border-radius: 0.375rem;
                margin-bottom: 1.5rem;
            }

            .alert-error {
                background: #fee2e2;
                color: #dc2626;
                border: 1px solid #fecaca;
            }
        </style>
    </head>
    <body>
        <header class="header">
            <div class="container">
                <!-- Logo -->
                <a href="${pageContext.request.contextPath}/home" class="logo">
                    <i class="fas fa-stethoscope"></i>
                    CLINIC
                </a>

                <!-- Navigation Menu -->
                <nav>
                    <ul class="nav-menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/home">Home</a>
                        </li>
                        <li>
                            <a href="#">About</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/doctor-list">Doctors</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle active">Portal</a>
                            <ul class="dropdown-menu">
                                <li><a href="${pageContext.request.contextPath}/manage-my-appointments" class="active">Manage My Appointments</a></li>
                                <li><a href="#">Manage My Medical Records</a></li>
                                <li><a href="#">Manage My Prescriptions</a></li>
                                <li><a href="#">Manage My Invoices</a></li>
                                <li><a href="#">My Feedbacks</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">Contact</a>
                        </li>
                    </ul>
                </nav>

                <!-- User Actions -->
                <div class="user-actions">
                    <!-- Register Button -->
                    <a href="#" class="btn btn-register">
                        <i class="fas fa-user-plus"></i>
                        Register
                    </a>

                    <!-- Login Button -->
                    <a href="#" class="btn btn-login">
                        <i class="fas fa-sign-in-alt"></i>
                        Login
                    </a>
                </div>
            </div>
        </header>
        <main class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1><i class="fas fa-calendar-check"></i> Appointment Details</h1>
                <a href="${pageContext.request.contextPath}/manage-my-appointments" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Back to Appointments
                </a>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                </div>
            </c:if>

            <!-- Appointment Details -->
            <c:if test="${not empty appointment}">
                <div class="appointment-detail-card">
                    <div class="card-header">
                        <h2>Appointment #${appointment.appointmentID}</h2>
                        <div class="status-badge
                             <c:choose>
                                 <c:when test="${appointment.appointmentStatusID == 2}">status-confirmed</c:when>
                                 <c:when test="${appointment.appointmentStatusID == 1}">status-pending</c:when>
                                 <c:when test="${appointment.appointmentStatusID == 4}">status-cancelled</c:when>
                                 <c:when test="${appointment.appointmentStatusID == 3}">status-completed</c:when>
                                 <c:otherwise>status-pending</c:otherwise>
                             </c:choose>">
                            ${appointment.statusName != null ? appointment.statusName : 'Unknown'}
                        </div>
                    </div>

                    <div class="card-content">
                        <div class="detail-grid">
                            <!-- Appointment Information -->
                            <div class="detail-section">
                                <h3><i class="fas fa-calendar"></i> Appointment Information</h3>
                                <div class="detail-item">
                                    <span class="detail-label">Date & Time:</span>
                                    <span class="detail-value">
                                        <fmt:formatDate value="${appointment.dateBegin}"
                                                        pattern="EEEE, MMMM dd, yyyy 'at' hh:mm a"/>
                                    </span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Duration:</span>
                                    <span class="detail-value">
                                        <fmt:formatDate value="${appointment.dateBegin}" pattern="hh:mm a"/> -
                                        <fmt:formatDate value="${appointment.dateEnd}" pattern="hh:mm a"/>
                                    </span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Created:</span>
                                    <span class="detail-value">
                                        <fmt:formatDate value="${appointment.dateCreate}"
                                                        pattern="MMM dd, yyyy 'at' hh:mm a"/>
                                    </span>
                                </div>
                                <c:if test="${not empty appointment.note}">
                                    <div class="detail-item">
                                        <span class="detail-label">Note:</span>
                                        <span class="detail-value">${appointment.note}</span>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Doctor Information -->
                            <div class="detail-section">
                                <h3><i class="fas fa-user-md"></i> Doctor Information</h3>
                                <div class="detail-item">
                                    <span class="detail-label">Name:</span>
                                    <span class="detail-value">
                                        Dr. ${appointment.doctorName != null ? appointment.doctorName : 'Unknown Doctor'}
                                    </span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Specialty:</span>
                                    <span class="detail-value">
                                        ${appointment.specialtyName != null ? appointment.specialtyName : 'General'}
                                    </span>
                                </div>
                                <c:if test="${not empty doctor}">
                                    <c:if test="${not empty doctor.email}">
                                        <div class="detail-item">
                                            <span class="detail-label">Email:</span>
                                            <span class="detail-value">${doctor.email}</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty doctor.phoneNumber}">
                                        <div class="detail-item">
                                            <span class="detail-label">Phone:</span>
                                            <span class="detail-value">${doctor.phoneNumber}</span>
                                        </div>
                                    </c:if>
                                </c:if>
                            </div>

                            <!-- Patient Information -->
                            <c:if test="${not empty patient}">
                                <div class="detail-section">
                                    <h3><i class="fas fa-user"></i> Patient Information</h3>
                                    <div class="detail-item">
                                        <span class="detail-label">Name:</span>
                                        <span class="detail-value">${patient.fullName}</span>
                                    </div>
                                    <c:if test="${not empty patient.email}">
                                        <div class="detail-item">
                                            <span class="detail-label">Email:</span>
                                            <span class="detail-value">${patient.email}</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty patient.phoneNumber}">
                                        <div class="detail-item">
                                            <span class="detail-label">Phone:</span>
                                            <span class="detail-value">${patient.phoneNumber}</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty patient.userAddress}">
                                        <div class="detail-item">
                                            <span class="detail-label">Address:</span>
                                            <span class="detail-value">${patient.userAddress}</span>
                                        </div>
                                    </c:if>
                                </div>
                            </c:if>
                        </div>

                        <!-- Action Buttons -->
                        <c:if test="${appointment.appointmentStatusID != 4 && appointment.appointmentStatusID != 3}">
                            <div class="action-buttons">
                                <button class="btn btn-reschedule" onclick="rescheduleAppointment()">
                                    <i class="fas fa-edit"></i> Reschedule
                                </button>
                                <button class="btn btn-cancel" onclick="confirmCancel()">
                                    <i class="fas fa-times"></i> Cancel Appointment
                                </button>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </main>

        <!-- JavaScript -->
        <script>
            function confirmCancel() {
                if (confirm('Are you sure you want to cancel this appointment? This action cannot be undone.')) {
                    // Create form to submit cancellation
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/my-appointment-detail';

                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'cancel';

                    const idInput = document.createElement('input');
                    idInput.type = 'hidden';
                    idInput.name = 'appointmentId';
                    idInput.value = '${appointment.appointmentID}';

                    form.appendChild(actionInput);
                    form.appendChild(idInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            }

            function rescheduleAppointment() {
                alert('Reschedule functionality will be implemented soon!');
            }
        </script>
    </body>
</html>
