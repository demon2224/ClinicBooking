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
                background-color: #f8f9fa;
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
                color: white;
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

            /* Main content */
            .clinic-main-content {
                margin-left: 260px;
                padding: 25px;
            }

            /* Navbar đồng bộ */
            .clinic-navbar {
                background: white;
                border-bottom: 1px solid #dee2e6;
                padding: 12px 24px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                border-radius: 0.5rem;
                box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            }

            .clinic-navbar-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: #1B5A90;
                margin: 0;
                display: flex;
                align-items: center;
            }

            .clinic-navbar-title i {
                margin-right: 0.5rem;
            }

            .clinic-logout-btn {
                color: red;
                border: 1px solid red;
                padding: 5px 12px;
                border-radius: 0.35rem;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.2s ease;
            }

            .clinic-logout-btn:hover {
                background-color: red;
                color: white;
            }


            /* Stat cards */
            .stats-row {
                display: flex;
                gap: 1.5rem;
                flex-wrap: wrap;
                margin-bottom: 1.5rem;
            }
            .stat-card {
                flex: 1 1 calc(33.333% - 1rem);
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                transition: transform 0.2s ease, box-shadow 0.2s ease;
                text-align: center;
                padding: 20px;
            }
            .stat-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 14px rgba(0,0,0,0.15);
            }
            .stat-card-content h6 {
                font-weight: 500;
                margin-bottom: 8px;
            }
            .stat-card-content h3 {
                font-weight: 600;
                margin-bottom: 0;
                font-size: 1.8rem;
            }
            .stat-icon {
                font-size: 2.3rem;
                color: #1B5A90;
                margin-top: 12px;
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

        <div class="clinic-main-content">

            <!-- Navbar -->
            <nav class="navbar navbar-light justify-content-between mb-4 px-3 py-2 shadow-sm">
                <h3 class="fw-bold text-primary mb-0">
                   <i class="fa-solid fa-clipboard me-2"></i>Admin Dashboard
                </h3>
                <a href="${pageContext.request.contextPath}/staff-logout" class="clinic-logout-btn">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
            </nav>


            <!-- Stats Row -->
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-card-content">
                        <h6>Total Staff Accounts</h6>
                        <h3>${totalAccounts}</h3>
                        <i class="fa-solid fa-users stat-icon"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-card-content">
                        <h6>Active Accounts</h6>
                        <h3>${activeAccounts}</h3>
                        <i class="fa-solid fa-user-check stat-icon"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-card-content">
                        <h6>Inactive Accounts</h6>
                        <h3>${inactiveAccounts}</h3>
                        <i class="fa-solid fa-user-slash stat-icon"></i>
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

        <c:if test="${not empty sessionScope.loginSuccessMsg}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var modal = new bootstrap.Modal(document.getElementById('loginSuccessModal'));
                    modal.show();
                });
            </script>
            <c:remove var="loginSuccessMsg" scope="session" />
        </c:if>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
