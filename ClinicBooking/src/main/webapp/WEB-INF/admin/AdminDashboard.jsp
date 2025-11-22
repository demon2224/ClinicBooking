<%--
    Document   : AdminDashboard
    Created on : Nov 6, 2025
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
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
                border-radius: 0.5rem;
                box-shadow: 0 2px 6px rgba(0,0,0,0.05);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .navbar h3 {
                font-weight: 600;
                color: #1B5A90;
                margin: 0;
            }
            .logout-btn {
                color: red;
                border: 1px solid red;
                padding: 5px 12px;
                border-radius: 0.35rem;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.2s ease;
            }
            .logout-btn:hover {
                background-color: red;
                color: white;
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
                font-weight: 500;
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

            /* Table Styling */
            .admin-table {
                border-collapse: separate;
                border-spacing: 0 8px;
            }
            .admin-table th {
                background-color: #1B5A90;
                color: white;
                border: none;
                border-radius: 12px 12px 0 0;
                font-weight: 500;
            }
            .admin-table td {
                background-color: white;
                border: none;
            }
            .admin-table tbody tr:hover td {
                background-color: #e9f5fb;
            }

            /* Badges by Role */
            .badge-doctor {
                background-color: #0dcaf0;
            }
            .badge-pharmacist {
                background-color: #ffc107;
                color: #212529;
            }
            .badge-admin {
                background-color: #0d6efd;
            }
            .badge-receptionist {
                background-color: #198754;
            }
            .badge-inactive {
                background-color: #dc3545;
            }
            .badge-active {
                background-color: #198754;
            }

            /* Modal */
            .modal-dialog.modal-dialog-centered {
                display: flex;
                align-items: center;
                min-height: calc(100vh - 1rem);
            }
        </style>
    </head>
    <body>

        <%@include file="../includes/AdminDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">

            <!-- Navbar -->
            <nav class="navbar mb-4">
                <h3><i class="fa-solid fa-clipboard me-2"></i>Admin Dashboard</h3>
                <a href="${pageContext.request.contextPath}/staff-logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket me-1"></i>Logout</a>
            </nav>

            <!-- Welcome Section -->
            <div class="alert alert-primary shadow-sm mb-4" role="alert">
                <i class="fa-solid fa-stethoscope me-2"></i>
                Welcome back, <strong>${sessionScope.staff.fullName}</strong>! Here’s an overview of your clinic activities.
            </div>

            <!-- Stats Row -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-users stat-icon mb-2"></i>
                        <div class="stat-value">${totalAccounts}</div>
                        <p class="mb-0 text-muted">Total Staff Accounts</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-user-check stat-icon mb-2"></i>
                        <div class="stat-value">${activeAccounts}</div>
                        <p class="mb-0 text-muted">Active Accounts</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-user-slash stat-icon mb-2"></i>
                        <div class="stat-value">${inactiveAccounts}</div>
                        <p class="mb-0 text-muted">Inactive Accounts</p>
                    </div>
                </div>
            </div>

            <!-- Recent Staff Table -->
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fa-solid fa-users me-2"></i>Recent Staff Accounts
                    <a href="${pageContext.request.contextPath}/admin-manage-account" class="btn btn-light btn-sm float-end fw-bold">
                        <i class="fa-solid fa-eye me-1"></i>View All
                    </a>
                </div>
                <div class="card-body p-0">
                    <c:if test="${empty recentStaffList}">
                        <p class="text-muted text-center py-4 mb-0">
                            <i class="fa-solid fa-circle-info me-2"></i>No accounts found.
                        </p>
                    </c:if>
                    <c:if test="${not empty recentStaffList}">
                        <table class="table table-hover align-middle text-center">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Username</th>
                                    <th>Full Name</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="s" items="${recentStaffList}" varStatus="loop">
                                    <tr>
                                        <td>${loop.count}</td>
                                        <td>${s.accountName}</td>
                                        <td>${s.firstName} ${s.lastName}</td>
                                        <td>
                                            <span class="badge
                                                  <c:choose>
                                                      <c:when test="${s.role eq 'Doctor'}">badge-doctor</c:when>
                                                      <c:when test="${s.role eq 'Pharmacist'}">badge-pharmacist</c:when>
                                                      <c:when test="${s.role eq 'Admin'}">badge-admin</c:when>
                                                      <c:when test="${s.role eq 'Receptionist'}">badge-receptionist</c:when>
                                                      <c:otherwise>bg-secondary</c:otherwise>
                                                  </c:choose>">
                                                ${s.role}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge ${s.hidden ? 'badge-inactive' : 'badge-active'}">
                                                ${s.hidden ? 'Inactive' : 'Active'}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
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
