<%--
    Document   : AdminDashboard
    Created on : Nov 6, 2025, 7:07:36 PM
    Author     : Ngo Quoc Hung - CE191184
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Manage Account</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #1B5A90;
                color: white;
                position: fixed;
            }
            .sidebar a {
                display: block;
                color: white;
                text-decoration: none;
                padding: 12px 20px;
            }
            .sidebar a:hover {
                background-color: #00D0F1;
            }
            .main-content {
                margin-left: 260px;
                padding: 25px;
            }
            .card {
                border-radius: 10px;
            }
            .table img {
                border-radius: 50%;
                width: 40px;
                height: 40px;
            }
            .status-toggle {
                width: 40px;
                height: 20px;
            }
            .navbar {
                background: white;
                border-bottom: 1px solid #dee2e6;
            }
            #Logout {
                color: red;
                border-color: red;
            }
            #Logout:hover {
                background-color: red;
                color: white;
            }
            /* === Role badge colors === */
            .badge-doctor {
                background-color: #007bff;
            }
            .badge-pharmacist {
                background-color: #20c997;
            }
            .badge-admin {
                background-color: #ffc107;
                color: black;
            }
            .badge-receptionist {
                background-color: #6f42c1;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@include file="../includes/AdminDashboardSidebar.jsp" %>

        <!-- Main content -->
        <div class="main-content">
            <nav class="navbar navbar-light">
                <div class="container-fluid">
                    <form class="d-flex w-50" method="get" action="manage-invoice">
                        <input class="form-control me-2" type="search" name="searchQuery" placeholder="Search here"
                               value="${param.searchQuery}">
                        <button type="submit" class="btn btn-outline-primary" id="searchBtn">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                    <div>
                        <button class="btn btn-submit" id="Logout" type="submit">Logout</button>
                    </div>
                </div>
            </nav>

            <!-- Dashboard statistic cards -->
            <div class="container mt-4">
                <div class="row g-4">
                    <!-- All Staff -->
                    <div class="col-md-4">
                        <div class="card shadow-sm border-0 text-center">
                            <div class="card-body">
                                <i class="fa-solid fa-users fa-2x text-primary mb-2"></i>
                                <h5 class="card-title">All Staff Accounts</h5>
                                <h2 class="fw-bold text-dark">${totalAccounts}</h2>
                                <p class="text-muted mb-0">Total registered staff</p>
                            </div>
                        </div>
                    </div>

                    <!-- Active Accounts -->
                    <div class="col-md-4">
                        <div class="card shadow-sm border-0 text-center">
                            <div class="card-body">
                                <i class="fa-solid fa-user-check fa-2x text-success mb-2"></i>
                                <h5 class="card-title">Active Accounts</h5>
                                <h2 class="fw-bold text-success">${activeAccounts}</h2>
                                <p class="text-muted mb-0">Currently available</p>
                            </div>
                        </div>
                    </div>

                    <!-- Inactive Accounts -->
                    <div class="col-md-4">
                        <div class="card shadow-sm border-0 text-center">
                            <div class="card-body">
                                <i class="fa-solid fa-user-slash fa-2x text-danger mb-2"></i>
                                <h5 class="card-title">Inactive Accounts</h5>
                                <h2 class="fw-bold text-danger">${inactiveAccounts}</h2>
                                <p class="text-muted mb-0">Hidden or disabled</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>


