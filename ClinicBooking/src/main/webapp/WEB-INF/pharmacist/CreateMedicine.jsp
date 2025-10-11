<%-- 
    Document   : CreateMedicine
    Created on : Oct 11, 2025, 2:00:09 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Doctor Dashboard</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assests/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assests/css/all.min.css" />
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

            #Logout{
                color: red;
                border-color: red;

            }
            #Logout:hover{
                background-color: red;
                color: white;
            }
            .required::after {
                content: " *";
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@include file="PharmacistDashboardSidebar.jsp" %>

        <!-- Main content -->
        <div class="main-content">
            <nav class="navbar navbar-light">
                <div class="container-fluid">
                    <div class="container-fluid d-flex justify-content-end">
                        <button class="btn btn-submit" id="Logout" type="submit">Logout</button>
                    </div>
                </div>
            </nav>

            <div class="container-fluid mt-4">
                <div class="card">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Create New Medicine</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/manage-medicine" method="POST">
                            <input type="hidden" name="action" value="create">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label required">Medicine Name</label>
                                    <input type="text" class="form-control" name="medicineName" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Medicine Code</label>
                                    <input type="text" class="form-control" name="medicineCode" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label class="form-label required">Medicine Type</label>
                                    <select class="form-select" name="medicineTypeId" required>
                                        <c:forEach items="${requestScope.medicineTypeList}" var="type">
                                            <option value="${type.medicineType}">${type.medicineType}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label required">Quantity</label>
                                    <input type="number" class="form-control" name="quantity" min="0" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label required">Price ($)</label>
                                    <input type="number" class="form-control" name="price" min="0" step="0.01" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label required">Date Expire</label>
                                    <input type="date" class="form-control" name="dateExpire" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Status</label>
                                    <select class="form-select" name="medicineStatus">
                                        <option value="1">Available</option>
                                        <option value="0">Unavailable</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
