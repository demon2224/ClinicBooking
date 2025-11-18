<%--
    Document   : ReceptionistDashboard
    Created on : Oct 11, 2025, 3:59:57 PM
    Author     : Ngo Quoc Hung - CE191184
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Receptionist Dashboard</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">


        <style>
            body {
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

            /* ===== Sidebar (giống 100% Statistics) ===== */
            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #1B5A90;
                color: white;
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1000;
            }

            .sidebar h4 {
                text-align: center;
                margin-top: 1rem;
                margin-bottom: 1.5rem;
                font-size: 1.4rem;
                font-weight: 500;
            }

            .sidebar a {
                display: block;
                color: white;
                text-decoration: none;
                padding: 12px 20px;
                transition: 0.3s ease;
            }

            .sidebar a i {
                margin-right: 8px;
            }

            .sidebar a:hover {
                background-color: #00D0F1;
            }

            
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/receptionist-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/receptionist-manage-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="${pageContext.request.contextPath}/manage-invoice"><i class="fa-solid fa-file-invoice-dollar me-2"></i>Manage Invoice</a>
        </div>

        <!-- Main Content -->
        <div class="clinic-main-content">

            <div class="clinic-navbar">
                <h3 class="clinic-navbar-title">
                    <i class="fa-solid fa-clipboard me-2"></i>
                    Receptionist Dashboard
                </h3>
                <a href="${pageContext.request.contextPath}/staff-logout" class="clinic-logout-btn">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
            </div>

            <!-- ===== STATS CARDS ===== -->
            <div class="stats-row">

                <!-- Today Appointments -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Today Appointments</h6>
                            <h3>${todayAppointments}</h3>
                        </div>
                        <i class="fa-solid fa-calendar-check stat-icon"></i>
                    </div>
                </div>

                <!-- Completed Today -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Completed (Today)</h6>
                            <h3>${completedAppointments}</h3>
                        </div>
                        <i class="fa-solid fa-user-md stat-icon"></i>
                    </div>
                </div>

                <!-- Revenue Today -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Revenue (Today)</h6>
                            <h3>
                                <c:choose>
                                    <c:when test="${todayRevenue != null && todayRevenue > 0}">
                                        <fmt:formatNumber value="${todayRevenue}" type="currency" currencySymbol="$"/>
                                    </c:when>
                                    <c:otherwise>0 $</c:otherwise>
                                </c:choose>
                            </h3>
                        </div>
                        <i class="fa-solid fa-sack-dollar stat-icon"></i>
                    </div>
                </div>

            </div>

            <!-- ===== Row: Top 5 Doctors & Top 5 Specialties (Side by Side) ===== -->
            <div class="row px-3">

                <!-- Left: Top 5 Doctors by Revenue -->
                <div class="col-md-6">
                    <div class="card mb-4 mt-3"
                         style="border:none; border-radius:12px; box-shadow:0 2px 8px rgba(0,0,0,0.08);">
                        <div class="card-header"
                             style="background-color:#1B5A90; color:white; border-top-left-radius:12px; border-top-right-radius:12px;">
                            <i class="fa-solid fa-user-doctor me-2"></i>Top 5 Doctors by Revenue
                        </div>

                        <div class="card-body">
                            <c:if test="${empty topDoctors}">
                                <p class="text-muted text-center mb-0">No revenue data for today.</p>
                            </c:if>

                            <c:if test="${not empty topDoctors}">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th>#</th>
                                            <th>Doctor</th>
                                            <th>Specialty</th>
                                            <th class="text-end">Revenue</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="d" items="${topDoctors}" varStatus="i">
                                            <tr>
                                                <td>${i.index + 1}</td>
                                                <td>${d.doctorName}</td>
                                                <td>${d.specialtyName}</td>
                                                <td class="text-end">
                                                    <fmt:formatNumber value="${d.totalRevenue}" type="currency" currencySymbol="$"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Right: Top 5 Specialties Booked -->
                <div class="col-md-6">
                    <div class="card mb-4 mt-3"
                         style="border:none; border-radius:12px; box-shadow:0 2px 8px rgba(0,0,0,0.08);">
                        <div class="card-header"
                             style="background-color:#1B5A90; color:white; border-top-left-radius:12px; border-top-right-radius:12px;">
                            <i class="fa-solid fa-hospital-user me-2"></i>Top 5 Specialties Booked
                        </div>

                        <div class="card-body">
                            <c:if test="${empty topSpecialties}">
                                <p class="text-muted text-center mb-0">No booking data for today.</p>
                            </c:if>

                            <c:if test="${not empty topSpecialties}">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th>#</th>
                                            <th>Specialty</th>
                                            <th class="text-end">Bookings</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="sp" items="${topSpecialties}" varStatus="i">
                                            <tr>
                                                <td>${i.index + 1}</td>
                                                <td>${sp.specialtyName}</td>
                                                <td class="text-end">${sp.totalBookings}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
