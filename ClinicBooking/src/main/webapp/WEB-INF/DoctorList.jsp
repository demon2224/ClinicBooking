<%-- Document : DoctorList Created on : Oct 7, 2025, 9:48:47 AM Author : Nguyen Minh Khang - CE190728 --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DOCCURE - Medical Clinic</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css" />

        <style>
            body {
                margin: 0;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                padding-top: 80px;
                /* Space for fixed header */
                background-color: #f8f9fa;
            }

            .main-content {
                padding: 2rem;
                text-align: center;
            }

            /* Doctor List Title */
            h1 {
                color: #2c3e50;
                font-weight: 600;
                margin: 2rem 0;
                text-align: center;
                font-size: 2rem;
            }

            /* Doctor Grid Container */
            .doctor-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 1rem;
            }

            .doctor-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-top: 2rem;
                justify-items: center;
            }

            /* Doctor Card - Updated Design */
            .doctor-card {
                background-color: white;
                border: 1px solid #e8ecf0;
                border-radius: 16px;
                padding: 2rem 1.5rem 1.5rem 1.5rem;
                text-align: center;
                transition: all 0.3s ease;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
                position: relative;
                max-width: 300px;
                margin: 0 auto;
            }

            .doctor-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
                border-color: #d0d7de;
            }

            /* Doctor Avatar */
            .doctor-avatar {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
                margin: 0 auto 1.5rem;
                border: 4px solid #f6f8fa;
                background-color: #f6f8fa;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            /* Doctor Name */
            .doctor-name {
                font-size: 1.25rem;
                font-weight: 700;
                color: #24292f;
                margin: 0 0 0.25rem 0;
                line-height: 1.3;
            }

            /* Doctor Specialty */
            .doctor-specialty {
                font-size: 0.95rem;
                color: #175cdd;
                margin: 0 0 0.5rem 0;
                font-weight: 500;
            }

            /* Years Experience */
            .doctor-experience {
                font-size: 0.9rem;
                color: #656d76;
                margin: 0 0 1rem 0;
                font-weight: 500;
            }

            /* Status Badge */
            .status-badge {
                display: inline-block;
                padding: 0.4rem 0.8rem;
                border-radius: 6px;
                font-size: 0.75rem;
                font-weight: 600;
                margin-bottom: 1.5rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-available {
                background-color: #dcfce7;
                color: #166534;
                border: 1px solid #bbf7d0;
            }

            .status-unavailable {
                background-color: #fef3c7;
                color: #92400e;
                border: 1px solid #fde68a;
            }

            .status-retired {
                background-color: #fee2e2;
                color: #991b1b;
                border: 1px solid #fecaca;
            }

            /* Button Group */
            .doctor-actions {
                display: flex;
                gap: 0.75rem;
                justify-content: center;
            }

            /* Button Styling - Updated */
            .btn-view {
                flex: 1;
                padding: 0.6rem 1rem;
                border: 2px solid #d0d7de;
                background-color: white;
                color: #24292f;
                text-decoration: none;
                border-radius: 8px;
                font-size: 0.9rem;
                font-weight: 600;
                transition: all 0.2s ease;
                cursor: pointer;
                display: inline-block;
            }

            .btn-view:hover {
                background-color: #f6f8fa;
                border-color: #8c959f;
                color: #24292f;
                text-decoration: none;
            }

            .btn-book {
                flex: 1;
                padding: 0.6rem 1rem;
                border: 2px solid #175cdd;
                background-color: #175cdd;
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-size: 0.9rem;
                font-weight: 600;
                transition: all 0.2s ease;
                cursor: pointer;
                display: inline-block;
            }

            .btn-book:hover {
                background-color: #135bb8;
                border-color: #135bb8;
                color: white;
                text-decoration: none;
            }

            .btn-disabled {
                opacity: 0.5;
                cursor: not-allowed;
                pointer-events: none;
            }

            /* Error Message */
            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                padding: 1rem;
                border-radius: 8px;
                margin: 1rem auto;
                max-width: 800px;
                text-align: center;
            }

            /* No Doctors Message */
            .no-doctors {
                text-align: center;
                color: #6c757d;
                font-size: 1.1rem;
                padding: 3rem;
            }

            /* Footer Styling */
            footer {
                background-color: white;
                padding: 2rem;
                text-align: center;
                margin-top: 3rem;
                border-top: 1px solid #e9ecef;
                box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
            }

            footer p {
                margin: 0;
                color: #6c757d;
                font-size: 0.9rem;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .doctor-grid {
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                    gap: 1rem;
                }

                .doctor-container {
                    padding: 0 0.5rem;
                }

                h1 {
                    font-size: 1.5rem;
                }

                .doctor-card {
                    padding: 1.5rem 1rem;
                    max-width: 100%;
                }

                .doctor-avatar {
                    width: 90px;
                    height: 90px;
                }
            }

            @media (max-width: 480px) {
                .doctor-grid {
                    grid-template-columns: 1fr;
                    gap: 1rem;
                }

                .doctor-actions {
                    flex-direction: column;
                }

                .btn-view,
                .btn-book {
                    flex: none;
                    width: 100%;
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
                            <a href="${pageContext.request.contextPath}/doctor-list" class="active">Doctors</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle">Portal</a>
                            <ul class="dropdown-menu">
                                <li><a href="${pageContext.request.contextPath}/manage-my-appointments">Manage
                                        My
                                        Appointments</a></li>
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

        <h1>Doctor List</h1>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                ${errorMessage}
            </div>
        </c:if>

        <!-- Doctor Grid -->
        <div class="doctor-container">
            <c:choose>
                <c:when test="${empty doctors}">
                    <div class="no-doctors">
                        <p>No doctors available at the moment.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="doctor-grid">
                        <c:forEach var="doctor" items="${doctors}">
                            <div class="doctor-card">
                                <!-- Doctor Avatar -->
                                <c:choose>
                                    <c:when test="${not empty doctor.avatar}">
                                        <img src="${pageContext.request.contextPath}/${doctor.avatar}"
                                             alt="${doctor.fullName}" class="doctor-avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="#"
                                             alt="${doctor.fullName}" class="doctor-avatar">
                                    </c:otherwise>
                                </c:choose>

                                <!-- Doctor Name -->
                                <h3 class="doctor-name">${doctor.fullName}</h3>

                                <!-- Doctor Specialty -->
                                <p class="doctor-specialty">${doctor.specialtyName}</p>

                                <!-- Years Experience -->
                                <p class="doctor-experience">+${doctor.yearExperience} years exp</p>

                                <!-- Status Badge -->
                                <c:choose>
                                    <c:when test="${doctor.jobStatusID == 1}">
                                        <span class="status-badge status-available">Available</span>
                                    </c:when>
                                    <c:when test="${doctor.jobStatusID == 2}">
                                        <span class="status-badge status-unavailable">Unavailable</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-retired">Retired</span>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Action Buttons -->
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-detail?id=${doctor.doctorID}"
                                       class="btn-view">View Detail</a>
                                    <a href="${pageContext.request.contextPath}/book-appointment?doctorId=${doctor.doctorID}"
                                       class="btn-book ${doctor.jobStatusID != 1 ? 'btn-disabled' : ''}">Book</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <footer>
            <p>Clinic Booking System © 2025</p>
        </footer>