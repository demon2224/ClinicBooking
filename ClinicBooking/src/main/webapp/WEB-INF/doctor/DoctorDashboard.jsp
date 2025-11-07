<%-- 
    Document   : DoctorDashboard
    Created on : 7 Oct. 2025, 2:18:25 pm
    Author     : Le Thien Tri - CE191249
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Doctor Dashboard</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/logo.png">
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
            .badge {
                font-size: 0.85rem;
                padding: 6px 10px;
                border-radius: 8px;
            }
            .table th {
                color: #1B5A90;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.08);
            }
        </style>
    </head>
    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">

            <!-- Navbar -->
            <nav class="navbar navbar-light justify-content-between mb-4">
                <h3 class="fw-bold text-primary mb-0">
                    <i class="fa-solid fa-user-doctor me-2"></i>Doctor Dashboard
                </h3>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger" id="Logout">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
            </nav>
                    <span style="display: flex; align-content: center; justify-content: center; font-size: 100px;">Place Holder...</span>
        </div>

    </body>
</html>