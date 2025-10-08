<%-- Document : DoctorList Created on : Oct 7, 2025, 9:48:47 AM Author : Nguyen Minh Khang - CE190728 --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="en">

            <head @media (max-width: 480px) { .doctor-grid { grid-template-columns: 1fr; gap: 1rem; } .doctor-actions {
                flex-direction: column; gap: 0.5rem; } .btn-view, .btn-book { flex: none; width: 100%; min-height: 44px;
                padding: 0.8rem 0.5rem; font-size: 0.9rem; } } charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Medical Clinic</title>

                <!-- Font Awesome Icons -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

                <!-- Custom CSS -->
                <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css" />

                <style>
                    body {
                        margin: 0;
                        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                        padding-top: 80px;
                        background-color: #f8f9fa;
                    }

                    .main-content {
                        padding: 2rem;
                        text-align: center;
                    }

                    h1 {
                        color: #2c3e50;
                        font-weight: 600;
                        margin: 2rem 0 1rem 0;
                        text-align: center;
                        font-size: 2rem;
                    }

                    .search-filter-form {
                        background: white;
                        padding: 1.5rem;
                        border-radius: 12px;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                        margin-bottom: 1.5rem;
                    }

                    .search-bar-wrapper {
                        display: flex;
                        gap: 0.75rem;
                        align-items: center;
                        flex-wrap: nowrap;
                    }

                    .search-input-group {
                        flex: 1;
                        position: relative;
                        min-width: 200px;
                        max-width: 400px;
                    }

                    .search-icon {
                        position: absolute;
                        left: 1rem;
                        top: 50%;
                        transform: translateY(-50%);
                        color: #6c757d;
                        font-size: 1rem;
                    }

                    .search-input {
                        width: 300px;
                        padding: 0.75rem 1rem 0.75rem 2.5rem;
                        border: 1px solid #d0d7de;
                        border-radius: 8px;
                        font-size: 0.95rem;
                        transition: all 0.2s ease;
                    }

                    .search-input:focus {
                        outline: none;
                        border-color: #175cdd;
                        box-shadow: 0 0 0 3px rgba(23, 92, 221, 0.1);
                    }

                    .filter-group {
                        display: flex;
                        gap: 0.75rem;
                        flex-wrap: nowrap;
                        flex-shrink: 0;
                        position: relative;
                        left: 200px;
                    }

                    .filter-select {
                        padding: 0.75rem 1rem;
                        border: 1px solid #d0d7de;
                        border-radius: 8px;
                        font-size: 0.9rem;
                        background-color: white;
                        cursor: pointer;
                        transition: all 0.2s ease;
                        min-width: 140px;
                        white-space: nowrap;
                    }

                    .filter-select:focus {
                        outline: none;
                        border-color: #175cdd;
                        box-shadow: 0 0 0 3px rgba(23, 92, 221, 0.1);
                    }

                    .search-button {
                        padding: 0.80rem 1.5rem;
                        background-color: #175cdd;
                        color: white;
                        border: none;
                        border-radius: 8px;
                        font-size: 0.9rem;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.2s ease;
                        white-space: nowrap;
                        flex-shrink: 0;
                        position: relative;
                        left: 200px;
                    }

                    .search-button:hover {
                        background-color: #135bb8;
                    }

                    .clear-button {
                        padding: 0.70rem 1.2rem;
                        background-color: white;
                        color: #24292f;
                        border: 1px solid #d0d7de;
                        border-radius: 8px;
                        font-size: 0.9rem;
                        font-weight: 600;
                        text-decoration: none;
                        cursor: pointer;
                        transition: all 0.2s ease;
                        white-space: nowrap;
                        display: inline-block;
                        flex-shrink: 0;
                        position: relative;
                        left: 205px;
                    }

                    .clear-button:hover {
                        background-color: #f6f8fa;
                        border-color: #8c959f;
                        text-decoration: none;
                        color: #24292f;
                    }

                    .results-count {
                        color: #656d76;
                        font-size: 0.95rem;
                        margin-top: 1rem;
                        text-align: center;
                    }

                    .doctor-container {
                        max-width: 1200px;
                        margin: 2rem auto;
                        padding: 0 1rem;
                    }

                    .doctor-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                        gap: 3.5rem;
                        margin-top: 2rem;
                        justify-items: center;
                    }

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

                    .doctor-avatar {
                        width: 200px;
                        height: 200px;                     
                        object-fit: cover;
                        margin: 0 auto 1.5rem;
                        border: 4px solid #f6f8fa;
                        background-color: #f6f8fa;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                    }

                    .doctor-name {
                        font-size: 1.25rem;
                        font-weight: 700;
                        color: #24292f;
                        margin: 0 0 0.25rem 0;
                        line-height: 1.3;
                    }

                    .doctor-specialty {
                        font-size: 0.95rem;
                        color: #175cdd;
                        margin: 0 0 0.5rem 0;
                        font-weight: 500;
                    }

                    .doctor-experience {
                        font-size: 0.9rem;
                        color: #656d76;
                        margin: 0 0 1rem 0;
                        font-weight: 500;
                    }

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

                    .doctor-actions {
                        display: flex;
                        gap: 0.75rem;
                        justify-content: center;
                        height: 50px;
                    }

                    .btn-view {
                        flex: 1;
                        padding: 0.05rem 0.8rem;
                        border: 1px solid #d0d7de;
                        background-color: white;
                        color: #24292f;
                        text-decoration: none;
                        border-radius: 8px;
                        font-size: 0.85rem;
                        font-weight: 600;
                        transition: all 0.2s ease;
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        text-align: center;
                        min-height: 40px;
                        line-height: 1.2;
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                    }

                    .btn-view:hover {
                        background-color: #f6f8fa;
                        border-color: #8c959f;
                        color: #24292f;
                        text-decoration: none;
                    }

                    .btn-book {
                        flex: 1;
                        padding: 0.05rem 0.8rem;
                        border: 2px solid #175cdd;
                        background-color: #175cdd;
                        color: white;
                        text-decoration: none;
                        border-radius: 8px;
                        font-size: 0.85rem;
                        font-weight: 600;
                        transition: all 0.2s ease;
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        text-align: center;
                        min-height: 40px;
                        line-height: 1.2;
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
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

                    .error-message {
                        background-color: #f8d7da;
                        color: #721c24;
                        padding: 1rem;
                        border-radius: 8px;
                        margin: 1rem auto;
                        max-width: 800px;
                        text-align: center;
                    }

                    .no-doctors {
                        text-align: center;
                        color: #6c757d;
                        font-size: 1.1rem;
                        padding: 3rem;
                    }

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

                    @media (max-width: 1024px) {
                        .search-bar-wrapper {
                            flex-wrap: wrap;
                        }

                        .search-input-group {
                            flex: 1 1 100%;
                            max-width: 100%;
                        }

                        .filter-group {
                            flex: 1 1 100%;
                            width: 100%;
                        }
                    }

                    @media (max-width: 768px) {
                        .search-bar-wrapper {
                            flex-direction: column;
                            gap: 0.75rem;
                        }

                        .search-input-group {
                            width: 100%;
                            min-width: 100%;
                            max-width: 100%;
                        }

                        .filter-group {
                            width: 100%;
                            flex-direction: column;
                        }

                        .filter-select {
                            width: 100%;
                            min-width: 100%;
                        }

                        .search-button,
                        .clear-button {
                            width: 100%;
                        }

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
                            grid-template-columns: 2fr;
                            gap: 1rem;
                        }

                        .doctor-actions {
                            flex-direction: column;
                        }

                        .btn-view,
                        .btn-book {
                            flex: none;
                            width: 90%;
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

                <!-- Search and Filter Section -->
                <div class="doctor-container">
                    <form method="GET" action="${pageContext.request.contextPath}/doctor-list"
                        class="search-filter-form">
                        <div class="search-bar-wrapper">
                            <!-- Search Input -->
                            <div class="search-input-group">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" name="searchName" class="search-input"
                                    placeholder="Search for Doctors by name..."
                                    value="${searchName != null ? searchName : ''}">
                            </div>

                            <!-- Filter Dropdowns -->
                            <div class="filter-group">
                                <!-- Specialty Filter -->
                                <select name="specialty" class="filter-select">
                                    <option value="">All Specialties</option>
                                    <c:forEach var="spec" items="${specialties}">
                                        <option value="${spec[0]}" ${selectedSpecialty eq spec[0] ? 'selected' : '' }>
                                            ${spec[1]}
                                        </option>
                                    </c:forEach>
                                </select>

                                <!-- Experience Filter -->
                                <select name="minExperience" class="filter-select">
                                    <option value="">All Experience</option>
                                    <option value="5" ${minExperience eq '5' ? 'selected' : '' }>5+ years</option>
                                    <option value="10" ${minExperience eq '10' ? 'selected' : '' }>10+ years</option>
                                    <option value="15" ${minExperience eq '15' ? 'selected' : '' }>15+ years</option>
                                </select>
                            </div>

                            <!-- Search Button -->
                            <button type="submit" class="search-button">
                                <i class="fas fa-search"></i> Search
                            </button>

                            <!-- Clear Filters Button -->
                            <a href="${pageContext.request.contextPath}/doctor-list" class="clear-button">
                                <i class="fas fa-times"></i> Clear
                            </a>
                        </div>
                    </form>

                    <!-- Results Count -->
                    <c:if test="${not empty doctors}">
                        <p class="results-count">Showing ${totalDoctors} doctor(s)</p>
                    </c:if>
                </div>

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
                                        <img src="${pageContext.request.contextPath}/${doctor.avatar}"
                                            alt="Dr. ${doctor.firstName} ${doctor.lastName}" class="doctor-avatar"
                                            onerror="this.src='${pageContext.request.contextPath}/assests/img/0.png'">

                                        <!-- Doctor Name -->
                                        <h3 class="doctor-name">${doctor.fullName}</h3>

                                        <!-- Doctor Specialty -->
                                        <p class="doctor-specialty">${doctor.specialtyName}</p>

                                        <!-- Years Experience -->
                                        <p class="doctor-experience">+${doctor.yearExperience} years exp</p>

                                        <!-- Status Badge -->
                                        <span class="status-badge status-available">Available</span>

                                        <!-- Action Buttons -->
                                        <div class="doctor-actions">
                                            <a href="${pageContext.request.contextPath}/doctor-detail?id=${doctor.doctorID}"
                                                class="btn-view">View Detail</a>
                                            <a href="${pageContext.request.contextPath}/book-appointment?doctorId=${doctor.doctorID}"
                                                class="btn-book">Book</a>
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