<%-- 
    Document   : ImportMedicine
    Created on : Oct 20, 2025, 5:44:32 PM
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
                        <h5 class="mb-0">Edit Medicine</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/manage-medicine" method="POST">
                            <input type="hidden" name="action" value="import">
                            <input type="hidden" name="medicineID" value="${requestScope.medicine.medicineID}">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-3 bg-primary">
                                            <label class="form-label text-light p-1 m-0">Medicine Name: </label>
                                        </div>
                                        <div class="col-md-9">
                                            <c:out value="${requestScope.medicine.medicineName}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-3 bg-primary">
                                            <label class="form-label text-light p-1 m-0">Medicine Code: </label>
                                        </div>
                                        <div class="col-md-9">
                                            <c:out value="${requestScope.medicine.medicineCode}"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-3 bg-primary">
                                            <label class="form-label text-light p-1 m-0">Medicine Type: </label>
                                        </div>
                                        <div class="col-md-9">
                                            <c:out value="${requestScope.medicine.medicineType}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-3 bg-primary">
                                            <label class="form-label text-light p-1 m-0">Price ($): </label>
                                        </div>
                                        <div class="col-md-9">
                                            <c:out value="${requestScope.medicine.price}"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="form-label required">Quantity</label>
                                <input type="number" name="quantity" required>
                            </div>

                            <div class="d-flex justify-content-center mt-3">
                                <button type="submit" class="btn btn-success px-5 py-2 fw-bold" style="border-radius: 30px;">
                                    Import
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
