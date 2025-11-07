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
        <%@include file="../includes/PharmacistDashboardSidebar.jsp" %>

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
                                    <div class="text-danger">
                                        <c:if test="${not empty sessionScope.medicineNameErrorMsg}">                   
                                            <c:out value="${sessionScope.medicineNameErrorMsg}"/>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Medicine Code</label>
                                    <input type="text" class="form-control" name="medicineCode" required>
                                    <div class="text-danger">
                                        <c:if test="${not empty sessionScope.medicineCodeErrorMsg}">                   
                                            <c:out value="${sessionScope.medicineCodeErrorMsg}"/>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label required">Medicine Type</label>
                                    <select class="form-select" name="medicineType" required>
                                        <c:forEach items="${requestScope.medicineTypeList}" var="type">
                                            <option value="${type}">
                                                <c:out value="${type}"/>
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="text-danger">
                                        <c:if test="${not empty sessionScope.medicineTypeErrorsMsg}">                   
                                            <c:out value="${sessionScope.medicineTypeErrorsMsg}"/>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Price ($)</label>
                                    <input type="number" class="form-control" name="price" min="0" step="0.01" required>
                                    <div class="text-danger">
                                        <c:if test="${not empty sessionScope.medicinePriceErrorsMsg}">                   
                                            <c:out value="${sessionScope.medicinePriceErrorsMsg}"/>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label required">Status</label>
                                    <select class="form-select" name="medicineStatus">
                                        <option value="1">Available</option>
                                        <option value="0">Unavailable</option>
                                    </select>
                                    <div class="text-danger">
                                        <c:if test="${not empty sessionScope.medicineStatusErrorsMsg}">                   
                                            <c:out value="${sessionScope.medicineStatusErrorsMsg}"/>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-center mt-3">
                                <button type="submit" class="btn btn-success px-5 py-2 fw-bold" style="border-radius: 30px;">
                                    Create
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
