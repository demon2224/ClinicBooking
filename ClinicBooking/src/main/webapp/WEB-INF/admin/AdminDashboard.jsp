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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>

        <style>
            body {
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

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
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            }
            .sidebar a {
                display: block;
                color: white;
                text-decoration: none;
                padding: 12px 20px;
                transition: background-color 0.3s ease;
            }
            .sidebar a:hover {
                background-color: #00D0F1;
            }
            .sidebar a i {
                margin-right: 8px;
            }

            .clinic-main-content {
                margin-left: 240px;
                padding-bottom: 50px;
            }

            .clinic-navbar {
                background-color: #ffffff;
                padding: 15px 20px;
                box-shadow: 0px 2px 5px rgba(0,0,0,0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .clinic-navbar-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: #1B5A90;
            }

            .clinic-logout-btn {
                color: #dc3545;
                font-weight: 500;
                text-decoration: none;
            }

            .stats-row {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 22px;
                padding: 25px 30px;
            }

            .stat-card {
                background: #ffffff;
                border-radius: 12px;
                padding: 20px 25px;
                box-shadow: 0px 3px 10px rgba(0,0,0,0.08);
                transition: 0.25s ease;
            }

            .stat-card:hover {
                transform: translateY(-4px);
            }

            .stat-card-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .stat-card-content h6 {
                font-size: 0.9rem;
                margin: 0;
                color: #6c757d;
                font-weight: 500;
            }

            .stat-card-content h3 {
                margin: 5px 0 0;
                font-size: 2rem;
                font-weight: 700;
                color: #1B5A90;
            }

            .stat-icon {
                font-size: 2.5rem;
                color: #1B5A90;
                opacity: 0.9;
            }
        </style>
    </head>
    <body>

        <%@include file="../includes/AdminDashboardSidebar.jsp" %>

        <div class="clinic-main-content">

            <!-- NAVBAR -->
            <div class="clinic-navbar">
                <h3 class="clinic-navbar-title">
                    <i class="fa-solid fa-clipboard me-2"></i>
                    Admin Dashboard
                </h3>
                <a href="${pageContext.request.contextPath}/staff-logout" class="clinic-logout-btn">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
            </div>

            <!-- STATS ROW -->
            <div class="stats-row">

                <!-- Total Staff Accounts -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Total Staff Accounts</h6>
                            <h3>${totalAccounts}</h3>
                        </div>
                        <i class="fa-solid fa-users stat-icon"></i>
                    </div>
                </div>

                <!-- Active Accounts -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Active Accounts</h6>
                            <h3>${activeAccounts}</h3>
                        </div>
                        <i class="fa-solid fa-user-check stat-icon"></i>
                    </div>
                </div>

                <!-- Inactive Accounts -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Inactive Accounts</h6>
                            <h3>${inactiveAccounts}</h3>
                        </div>
                        <i class="fa-solid fa-user-slash stat-icon"></i>
                    </div>
                </div>


            </div>

        </div>

    </body>
</html>
