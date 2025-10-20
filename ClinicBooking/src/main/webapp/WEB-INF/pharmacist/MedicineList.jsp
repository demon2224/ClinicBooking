<%-- 
    Document   : medicine
    Created on : Oct 10, 2025, 3:41:23 PM
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
                    <form class="d-flex w-50" action="${pageContext.request.contextPath}/manage-medicine" method="GET">
                        <input type="hidden" name="action" value="search">
                        <input class="form-control me-2" type="search" placeholder="Search here" name="search" value="${param.search}">
                        <button class="btn btn-outline-primary" type="submit">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                    <div>
                        <button class="btn btn-submit" id="Logout" type="submit">Logout</button>
                    </div>
                </div>
            </nav>

            <div class="container-fluid mt-4">
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Medicine List</h5>
                            <div>
                                <a href="${pageContext.request.contextPath}/manage-medicine?action=create" class="btn btn-success">
                                    <i class="fas fa-plus"></i> Add Medicine
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Type</th>
                                    <th>Status</th>
                                    <th>Name</th>
                                    <th>Code</th>
                                    <th>Quantity</th>
                                    <th>Price Per Unit</th>
                                    <th>Last Import</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.medicineList}" var="med" varStatus="item">
                                    <tr>
                                        <td>
                                            <c:out value="${item.count}"/>
                                        </td>
                                        <td>
                                            <c:out value="${med.medicineType}"/>
                                        </td>
                                        <c:choose>
                                            <c:when test="${med.medicineStatus}">
                                                <td>
                                                    <span class="badge bg-success text-white">Available</span>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                    <span class="badge bg-danger text-white">Unavailable</span>
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td>
                                            <c:out value="${med.medicineName}"/>
                                        </td>
                                        <td>
                                            <c:out value="${med.medicineCode}"/>
                                        </td>
                                        <td>
                                            <c:out value="${med.quantity}" />
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${med.price}" type="currency" currencySymbol="$" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty med.lastStockTransactionFormatDate}">
                                                    <c:out value="${med.lastStockTransactionFormatDate}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="None"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <a class="btn btn-submit bg-warning text-white" href="${pageContext.request.contextPath}/manage-medicine?action=detail&medicineId=${med.medicineId}">View Detail</a>
                                                <a class="btn btn-submit bg-primary text-white" href="${pageContext.request.contextPath}/manage-medicine?action=import&medicineId=${med.medicineId}">Import</a>
                                                <a class="btn btn-submit bg-primary text-white" href="${pageContext.request.contextPath}/manage-medicine?action=edit&medicineId=${med.medicineId}">Edit</a>
                                                <form method="post" action="${pageContext.request.contextPath}/manage-medicine">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="medicineId" value="${med.medicineId}">
                                                    <button class="btn btn-submit bg-danger text-white">Delete</button>
                                                </form>
                                            </div>
                                        </td>
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
