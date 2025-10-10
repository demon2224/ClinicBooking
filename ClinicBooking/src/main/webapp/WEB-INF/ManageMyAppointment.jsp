<%--
    Document   : ManageMyAppointment
    Created on : Oct 7, 2025, 12:30:00 AM
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
        <title>Manage My Appointments - CLINIC</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>

        <style>
            body {
                margin: 0;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                padding-top: 80px; /* Space for fixed header */
                background-color: #f8fafc;
            }

            .main-content {
                padding: 2rem;
                max-width: 1200px;
                margin: 0 auto;
            }

            .page-header {
                background: white;
                padding: 2rem;
                border-radius: 0.5rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-bottom: 2rem;
            }

            .page-header h1 {
                color: #175CDD;
                margin: 0 0 0.5rem 0;
                font-size: 2rem;
                font-weight: 600;
            }

            .page-header p {
                color: #64748b;
                margin: 0;
                font-size: 1.1rem;
            }

            .appointments-section {
                background: white;
                border-radius: 0.5rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .section-header {
                background: #175CDD;
                color: white;
                padding: 1.5rem 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .section-header h2 {
                margin: 0;
                font-size: 1.25rem;
                font-weight: 600;
            }

            .appointments-content {
                padding: 2rem;
            }

            .appointment-card {
                border: 1px solid #e2e8f0;
                border-radius: 0.5rem;
                padding: 1.5rem;
                margin-bottom: 1rem;
                transition: all 0.3s ease;
            }

            .appointment-card:hover {
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                border-color: #175CDD;
            }

            .appointment-header {
                display: flex;
                justify-content: between;
                align-items: flex-start;
                margin-bottom: 1rem;
            }

            .appointment-info {
                flex: 1;
            }

            .appointment-date {
                color: #175CDD;
                font-weight: 600;
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }

            .appointment-doctor {
                color: #1e293b;
                font-weight: 500;
                margin-bottom: 0.25rem;
            }

            .appointment-specialty {
                color: #64748b;
                font-size: 0.9rem;
            }

            .appointment-status {
                padding: 0.25rem 0.75rem;
                border-radius: 1rem;
                font-size: 0.875rem;
                font-weight: 500;
                text-align: center;
                min-width: 80px;
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
                color: #1d4ed8;
            }

            .appointment-patient {
                color: #475569;
                font-size: 0.9rem;
                margin-bottom: 0.25rem;
            }

            .alert {
                padding: 1rem;
                margin-bottom: 1rem;
                border-radius: 0.375rem;
                font-weight: 500;
            }

            .alert-success {
                background: #dcfce7;
                color: #166534;
                border: 1px solid #bbf7d0;
            }

            .alert-error {
                background: #fee2e2;
                color: #dc2626;
                border: 1px solid #fecaca;
            }

            .text-muted {
                color: #64748b;
                font-size: 0.9rem;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 2rem;
                color: #64748b;
            }

            .empty-state i {
                font-size: 3rem;
                margin-bottom: 1rem;
                color: #cbd5e1;
            }

            .empty-state h3 {
                margin: 0 0 0.5rem 0;
                color: #1e293b;
            }

            .alert {
                padding: 1rem;
                margin-bottom: 1rem;
                border-radius: 0.375rem;
                font-weight: 500;
            }

            .alert-success {
                background: #dcfce7;
                color: #166534;
                border: 1px solid #bbf7d0;
            }

            .alert-error {
                background: #fee2e2;
                color: #dc2626;
                border: 1px solid #fecaca;
            }

            .appointment-actions {
                display: flex;
                gap: 0.5rem;
                margin-top: 1rem;
            }

            .btn-action {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
            }

            .btn-view {
                background: #e0f2fe;
                color: #0891b2;
            }

            .btn-view:hover {
                background: #bae6fd;
            }

            .btn-reschedule {
                background: #f3e8ff;
                color: #7c3aed;
            }

            .btn-reschedule:hover {
                background: #e9d5ff;
            }

            .btn-cancel {
                background: #fee2e2;
                color: #dc2626;
            }

            .btn-cancel:hover {
                background: #fecaca;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 2rem;
                color: #64748b;
            }

            .empty-state i {
                font-size: 3rem;
                color: #cbd5e1;
                margin-bottom: 1rem;
            }

            /* Search and Filter Styles */
            .search-filter-section {
                background: white;
                border-radius: 0.5rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-bottom: 2rem;
                overflow: hidden;
            }

            .search-filter-content {
                padding: 1.5rem 2rem;
            }

            .search-form {
                width: 100%;
            }

            .search-row {
                display: flex;
                gap: 1rem;
                align-items: center;
                flex-wrap: nowrap;
            }

            .search-input-group {
                position: relative;
                flex: 2;
                min-width: 300px;
            }

            .search-input-group i {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: #9ca3af;
            }

            .search-input {
                width: 100%;
                padding: 0.75rem 1rem 0.75rem 2.5rem;
                border: 1px solid #d1d5db;
                border-radius: 0.375rem;
                font-size: 0.9rem;
                transition: all 0.3s ease;
            }

            .search-input:focus {
                outline: none;
                border-color: #175CDD;
                box-shadow: 0 0 0 3px rgba(23, 92, 221, 0.1);
            }

            .filter-group {
                min-width: 180px;
            }

            .filter-select {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid #d1d5db;
                border-radius: 0.375rem;
                font-size: 0.9rem;
                background: white;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .filter-select:focus {
                outline: none;
                border-color: #175CDD;
                box-shadow: 0 0 0 3px rgba(23, 92, 221, 0.1);
            }

            .btn-search, .btn-clear {
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
                font-size: 0.9rem;
                white-space: nowrap;
            }

            .btn-search {
                background: #175CDD;
                color: white;
            }

            .btn-search:hover {
                background: #1e40af;
            }

            .btn-clear {
                background: #f1f5f9;
                color: #475569;
            }

            .btn-clear:hover {
                background: #e2e8f0;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .search-row {
                    flex-direction: column;
                    gap: 1rem;
                }

                .search-input-group {
                    min-width: unset;
                    width: 100%;
                }

                .filter-group {
                    min-width: unset;
                    width: 100%;
                }

                .btn-search, .btn-clear {
                    width: 100%;
                    justify-content: center;
                }
            }

            /* Alert Styles */
            .alert {
                padding: 1rem 1.5rem;
                border-radius: 0.5rem;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .alert-success {
                background: #dcfce7;
                color: #166534;
                border: 1px solid #bbf7d0;
            }

            .alert-error {
                background: #fee2e2;
                color: #dc2626;
                border: 1px solid #fecaca;
            }

            /* Status Colors */
            .status-approved {
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

            @media (max-width: 768px) {
                .main-content {
                    padding: 1rem;
                }

                .page-header {
                    padding: 1.5rem;
                }

                .section-header {
                    flex-direction: column;
                    gap: 1rem;
                    align-items: stretch;
                }

                .appointment-header {
                    flex-direction: column;
                    gap: 1rem;
                }

                .appointment-actions {
                    flex-wrap: wrap;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
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

        <!-- Main Content -->
        <main class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1><i class="fas fa-calendar-check"></i> Manage My Appointments</h1>
                <p>View and manage your appointments</p>
                <c:if test="${not empty userName}">
                    <p class="text-muted">Welcome, ${user.fullName}</p>
                </c:if>
                <c:if test="${not empty appointments}">
                    <p class="text-muted">You have ${appointments.size()} appointments</p>
                </c:if>
            </div>

            <!-- Message Display -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                </div>
                <c:remove var="successMessage" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                </div>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>

            <!-- Search and Filter Section -->
            <div class="search-filter-section">
                <div class="search-filter-content">
                    <form method="GET" action="${pageContext.request.contextPath}/manage-my-appointments" class="search-form">
                        <div class="search-row">
                            <!-- Search Input -->
                            <div class="search-input-group">
                                <i class="fas fa-search"></i>
                                <input type="text" name="search" placeholder="Search for Doctors by name..."
                                       value="${searchQuery}" class="search-input">
                            </div>
                            <!-- Search Button -->
                            <button type="submit" class="btn-search">
                                <i class="fas fa-search"></i> Search
                            </button>

                            <!-- Clear Button -->
                            <a href="${pageContext.request.contextPath}/manage-my-appointments" class="btn-clear">
                                <i class="fas fa-times"></i> Clear
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Appointments Section -->
            <div class="appointments-section">
                <div class="section-header">
                    <h2>My Appointments</h2>
                </div>

                <div class="appointments-content">
                    <c:choose>
                        <c:when test="${empty appointments}">
                            <!-- Empty State -->
                            <div class="empty-state">
                                <i class="fas fa-calendar-times"></i>
                                <h3>No Appointments Found</h3>
                                <p>You don't have any appointments scheduled yet.</p>
                                <a href="#" class="btn-new-appointment" style="margin-top: 1rem;">
                                    <i class="fas fa-plus"></i>
                                    Book Your First Appointment
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Display Appointments -->
                            <c:forEach var="appointment" items="${appointments}">
                                <div class="appointment-card">
                                    <div class="appointment-header">
                                        <div class="appointment-info">
                                            <div class="appointment-date">
                                                <i class="fas fa-calendar"></i>
                                                <fmt:formatDate value="${appointment.dateBegin}"
                                                                pattern="EEEE, MMMM dd, yyyy 'at' hh:mm a" />
                                            </div>
                                            <div class="appointment-doctor">
                                                <i class="fas fa-user-md"></i>
                                                Dr. ${appointment.doctorName != null ? appointment.doctorName : 'Unknown Doctor'}
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-stethoscope"></i>
                                                ${appointment.specialtyName != null ? appointment.specialtyName : 'General'}
                                                <c:if test="${not empty appointment.note}"> - ${appointment.note}</c:if>
                                                </div>
                                            </div>
                                            <div class="appointment-status
                                            <c:choose>
                                                <c:when test="${appointment.appointmentStatusID == 2}">status-approved</c:when>
                                                <c:when test="${appointment.appointmentStatusID == 1}">status-pending</c:when>
                                                <c:when test="${appointment.appointmentStatusID == 4}">status-cancelled</c:when>
                                                <c:when test="${appointment.appointmentStatusID == 3}">status-completed</c:when>
                                                <c:otherwise>status-pending</c:otherwise>
                                            </c:choose>">
                                            ${appointment.statusName != null ? appointment.statusName : 'Unknown'}
                                        </div>
                                    </div>
                                    <div class="appointment-actions">
                                        <a href="${pageContext.request.contextPath}/my-appointment-detail?id=${appointment.appointmentID}" class="btn-action btn-view">
                                            <i class="fas fa-eye"></i>
                                            View Details
                                        </a>

                                        <!-- Only show cancel button for pending appointments -->
                                        <c:if test="${appointment.appointmentStatusID == 1}">
                                            <button class="btn-action btn-cancel"
                                                    data-appointment-id="${appointment.appointmentID}">
                                                <i class="fas fa-times"></i>
                                                Cancel
                                            </button>
                                        </c:if>
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
            // Cancel appointment function
            function cancelAppointment(appointmentId) {
                if (confirm('Are you sure you want to cancel this appointment?')) {
                    // Send request to cancel appointment
                    window.location.href = '${pageContext.request.contextPath}/manage-my-appointments?action=cancel&appointmentId=' + appointmentId;
                }
            }

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

            // Appointment actions
            document.addEventListener('DOMContentLoaded', function () {
                // Cancel appointment confirmation
                document.querySelectorAll('.btn-cancel').forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault();
                        const appointmentId = this.getAttribute('data-appointment-id');
                        if (confirm('Are you sure you want to cancel this appointment? This action cannot be undone.')) {
                            // Create form to submit cancellation
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/manage-my-appointments';

                            const actionInput = document.createElement('input');
                            actionInput.type = 'hidden';
                            actionInput.name = 'action';
                            actionInput.value = 'cancel';

                            const idInput = document.createElement('input');
                            idInput.type = 'hidden';
                            idInput.name = 'appointmentId';
                            idInput.value = appointmentId;

                            form.appendChild(actionInput);
                            form.appendChild(idInput);
                            document.body.appendChild(form);
                            form.submit();
                        }
                    });
                });
            });
        </script>
    </body>
</html>