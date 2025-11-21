<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Receptionist Dashboard</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <style>
            body {
                background-color: #f4f7fb;
                font-family: "Poppins", sans-serif;
                margin: 0;
                padding: 0;
            }

            /* Sidebar */
            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #1B5A90;
                color: white;
                position: fixed;
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
            .sidebar a:hover {
                background-color: #00BFE7;
            }

            /* Main Content */
            .main-content {
                margin-left: 260px;
                padding: 25px;
            }

            /* Navbar */
            .navbar {
                background: white;
                border-bottom: 1px solid #dee2e6;
                padding: 12px 24px;
            }

            /* Cards */
            .card {
                border: none;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
            }
            .dashboard-card {
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }
            .dashboard-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 14px rgba(0,0,0,0.15);
            }
            .stat-icon {
                font-size: 2.3rem;
                color: #1B5A90;
            }
            .stat-value {
                font-size: 1.8rem;
                font-weight: 600;
            }
            .logout-btn {
                color: red;
                border-color: red;
            }
            .logout-btn:hover {
                background-color: red;
                color: white;
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <h4>CLINIC</h4>
            <a href="${pageContext.request.contextPath}/receptionist-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/receptionist-manage-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="${pageContext.request.contextPath}/manage-invoice"><i class="fa-solid fa-file-invoice-dollar me-2"></i>Manage Invoice</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">

            <!-- Navbar -->
            <nav class="navbar navbar-light justify-content-between mb-4 px-3 py-2 shadow-sm">
                <h3 class="fw-bold text-primary mb-0"><i class="fa-solid fa-clipboard me-2"></i>Receptionist Dashboard</h3>
                <a href="${pageContext.request.contextPath}/staff-logout" class="btn btn-outline-danger logout-btn">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
            </nav>

            <!-- Summary Stats -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-calendar-check stat-icon mb-2"></i>
                        <div class="stat-value">${todayAppointments}</div>
                        <p class="mb-0 text-muted">Today Appointments</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-user-md stat-icon mb-2"></i>
                        <div class="stat-value">${completedAppointments}</div>
                        <p class="mb-0 text-muted">Completed Today</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-sack-dollar stat-icon mb-2"></i>
                        <div class="stat-value">
                            <c:choose>
                                <c:when test="${todayRevenue != null && todayRevenue > 0}">
                                    <fmt:formatNumber value="${todayRevenue}" type="currency" currencySymbol="$"/>
                                </c:when>
                                <c:otherwise>0 $</c:otherwise>
                            </c:choose>
                        </div>
                        <p class="mb-0 text-muted">Revenue Today</p>
                    </div>
                </div>
            </div>

            <!-- Top 5 Doctors & Specialties -->
            <div class="row g-4">

                <!-- Top Doctors -->
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header">
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

                <!-- Top Specialties -->
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header">
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

            <!-- Modal Login Success -->
            <div class="modal fade" id="loginSuccessModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title">Login Successful</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body text-center">
                            <c:out value="${sessionScope.loginSuccessMsg}" />
                        </div>
                        <div class="modal-footer justify-content-center">
                            <button type="button" class="btn btn-success" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Show Modal if Login Success -->
            <c:if test="${not empty sessionScope.loginSuccessMsg}">
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        var modalEl = document.getElementById('loginSuccessModal');
                        var modal = new bootstrap.Modal(modalEl, {backdrop: 'static', keyboard: false});
                        modal.show();
                    });
                </script>
                <c:remove var="loginSuccessMsg" scope="session"/>
            </c:if>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
