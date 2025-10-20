<%-- 
    Document   : MedicineDetail
    Created on : Oct 10, 2025, 11:08:33 PM
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
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Medicine Detail</h5>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-4">
                                Name: 
                                <c:out value="${requestScope.medicine.medicineName}"/>
                            </div>
                            <div class="col-4">
                                Code: 
                                <c:out value="${requestScope.medicine.medicineCode}"/>
                            </div>
                            <div class="col-4">
                                Status: 
                                <c:choose>
                                    <c:when test="${requestScope.medicine.medicineStatus}">
                                        <span class="badge bg-success text-white">Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger text-white">Unavailable</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-4">
                                Type: 
                                <c:out value="${requestScope.medicine.medicineType}"/>
                            </div>
                            <div class="col-4">
                                Quantity: 
                                <c:out value="${requestScope.medicine.quantity}"/>
                            </div>
                            <div class="col-4">
                                Price per unit: 
                                <fmt:formatNumber value="${requestScope.medicine.price}" type="currency" currencySymbol="$" />
                            </div>
                            <div class="col-4">
                                Day create: 
                                <c:out value="${requestScope.medicine.dateCreateFormatDate}"/>
                            </div>
                            <div class="col-4">
                                Last import: 
                                <c:choose>
                                    <c:when test="${not empty requestScope.medicine.lastStockTransactionFormatDate}">
                                        <c:out value="${requestScope.medicine.lastStockTransactionFormatDate}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value="None"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Medicine Transaction History</h5>
                    </div>
                    <div class="card-body">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>Code</th>
                                    <th>Quantity</th>
                                    <th>Total Value</th>
                                    <th>Day Import</th>
                                    <th>Day Expire</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.medicineStockTransactionList}" var="transaction" varStatus="item">
                                    <tr>
                                        <td>${item.count}</td>
                                        <td>${transaction.medicine.medicineName}</td>
                                        <td>${transaction.medicine.medicineCode}</td>
                                        <td>${transaction.quantity}</td>
                                        <td>${transaction.totalValue}</td>
                                        <td>${transaction.dateImportFormatDate}</td>
                                        <td>${transaction.dateExpireFormatDate}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
