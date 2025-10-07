<%--
    Document   : ManageMyAppointment
    Created on : Oct 7, 2025, 12:30:00 AM
    Author     : Le Anh Tuan - CE180905
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

            .btn-new-appointment {
                background: white;
                color: #175CDD;
                padding: 0.75rem 1.5rem;
                border: none;
                border-radius: 0.375rem;
                font-weight: 600;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                transition: all 0.3s ease;
            }

            .btn-new-appointment:hover {
                background: #f1f5f9;
                transform: translateY(-1px);
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
                <p>View, schedule, and manage all your medical appointments</p>
            </div>

            <!-- Appointments Section -->
            <div class="appointments-section">
                <div class="section-header">
                    <h2>My Appointments</h2>
                    <a href="#" class="btn-new-appointment">
                        <i class="fas fa-plus"></i>
                        Book New Appointment
                    </a>
                </div>

                <div class="appointments-content">
                    <!-- Sample Appointment Cards -->
                    <div class="appointment-card">
                        <div class="appointment-header">
                            <div class="appointment-info">
                                <div class="appointment-date">
                                    <i class="fas fa-calendar"></i>
                                    Monday, October 15, 2025 at 10:30 AM
                                </div>
                                <div class="appointment-doctor">
                                    <i class="fas fa-user-md"></i>
                                    Dr. Sarah Johnson
                                </div>
                                <div class="appointment-specialty">
                                    <i class="fas fa-stethoscope"></i>
                                    Cardiology - Regular Checkup
                                </div>
                            </div>
                            <div class="appointment-status status-confirmed">
                                Confirmed
                            </div>
                        </div>
                        <div class="appointment-actions">
                            <a href="#" class="btn-action btn-view">
                                <i class="fas fa-eye"></i>
                                View Details
                            </a>
                            <a href="#" class="btn-action btn-reschedule">
                                <i class="fas fa-edit"></i>
                                Reschedule
                            </a>
                            <a href="#" class="btn-action btn-cancel">
                                <i class="fas fa-times"></i>
                                Cancel
                            </a>
                        </div>
                    </div>

                    <div class="appointment-card">
                        <div class="appointment-header">
                            <div class="appointment-info">
                                <div class="appointment-date">
                                    <i class="fas fa-calendar"></i>
                                    Wednesday, October 20, 2025 at 2:00 PM
                                </div>
                                <div class="appointment-doctor">
                                    <i class="fas fa-user-md"></i>
                                    Dr. Michael Chen
                                </div>
                                <div class="appointment-specialty">
                                    <i class="fas fa-eye"></i>
                                    Ophthalmology - Eye Examination
                                </div>
                            </div>
                            <div class="appointment-status status-pending">
                                Pending
                            </div>
                        </div>
                        <div class="appointment-actions">
                            <a href="#" class="btn-action btn-view">
                                <i class="fas fa-eye"></i>
                                View Details
                            </a>
                            <a href="#" class="btn-action btn-reschedule">
                                <i class="fas fa-edit"></i>
                                Reschedule
                            </a>
                            <a href="#" class="btn-action btn-cancel">
                                <i class="fas fa-times"></i>
                                Cancel
                            </a>
                        </div>
                    </div>

                    <div class="appointment-card">
                        <div class="appointment-header">
                            <div class="appointment-info">
                                <div class="appointment-date">
                                    <i class="fas fa-calendar"></i>
                                    Friday, October 8, 2025 at 9:15 AM
                                </div>
                                <div class="appointment-doctor">
                                    <i class="fas fa-user-md"></i>
                                    Dr. Emily Davis
                                </div>
                                <div class="appointment-specialty">
                                    <i class="fas fa-tooth"></i>
                                    Dentistry - Routine Cleaning
                                </div>
                            </div>
                            <div class="appointment-status status-cancelled">
                                Cancelled
                            </div>
                        </div>
                        <div class="appointment-actions">
                            <a href="#" class="btn-action btn-view">
                                <i class="fas fa-eye"></i>
                                View Details
                            </a>
                        </div>
                    </div>

                    <!-- Empty State (uncomment to show when no appointments) -->
                    <!--
                    <div class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <h3>No Appointments Found</h3>
                        <p>You don't have any appointments scheduled yet.</p>
                        <a href="#" class="btn-new-appointment" style="margin-top: 1rem;">
                            <i class="fas fa-plus"></i>
                            Book Your First Appointment
                        </a>
                    </div>
                    -->
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

            // Appointment actions
            document.addEventListener('DOMContentLoaded', function () {
                // Cancel appointment confirmation
                document.querySelectorAll('.btn-cancel').forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault();
                        if (confirm('Are you sure you want to cancel this appointment?')) {
                            // Handle cancellation logic here
                            alert('Appointment cancelled successfully!');
                        }
                    });
                });

                // Reschedule appointment
                document.querySelectorAll('.btn-reschedule').forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault();
                        alert('Reschedule functionality will be implemented soon!');
                    });
                });

                // View appointment details
                document.querySelectorAll('.btn-view').forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault();
                        alert('View details functionality will be implemented soon!');
                    });
                });

                // Book new appointment
                document.querySelectorAll('.btn-new-appointment').forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault();
                        alert('Book new appointment functionality will be implemented soon!');
                    });
                });
            });
        </script>
    </body>
</html>