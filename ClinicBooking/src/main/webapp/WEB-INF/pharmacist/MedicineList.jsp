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
        <title>Pharmacist - Medicine Management</title>
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
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="main-content">

            <nav class="navbar navbar-light">
                <div class="container-fluid">
                    <form class="d-flex w-50" method="get" action="${pageContext.request.contextPath}/manage-medicine">
                        <input class="form-control me-2" type="search" name="action" placeholder="Search medicine..." value="search">
                        <button class="btn btn-outline-primary" type="submit">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                    <div>
                        <form action="${pageContext.request.contextPath}/staff-logout">
                            <button  id="Logout" class="btn btn-submit" type="submit">Logout</button>
                        </form>
                    </div>
                </div>
            </nav>

            <div class="container-fluid mt-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <h5 class="mb-0">Medicine List</h5>
                        <a href="${pageContext.request.contextPath}/manage-medicine?action=create" class="btn btn-success">
                            <i class="fa-solid fa-plus me-1"></i> Add New
                        </a>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle text-center mb-0">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Type</th>
                                    <th>Status</th>
                                    <th>Name</th>
                                    <th>Code</th>
                                    <th>Quantity</th>
                                    <th>Price Per Unit</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="med" items="${requestScope.medicineList}" varStatus="item">
                                    <tr style="<c:if test='${med.isHidden}'>opacity: 0.5;</c:if>">
                                        <td>${item.count}</td>
                                        <td>${med.medicineType}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${med.medicineStatus}">
                                                    <span class="badge bg-success">Available</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Unavailable</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${med.medicineName}</td>
                                        <td>${med.medicineCode}</td>
                                        <td>${med.quantity}</td>
                                        <td><fmt:formatNumber value="${med.price}" type="currency" currencySymbol="$" /></td>

                                        <td>
                                            <div class="d-flex flex-wrap justify-content-center gap-2">
                                                <a class="btn btn-primary btn-sm text-white fw-semibold" 
                                                   href="${pageContext.request.contextPath}/manage-medicine?action=detail&medicineID=${med.medicineID}">
                                                    <i class="fa-solid fa-eye me-1"></i> View Detail
                                                </a>

                                                <a class="btn btn-warning btn-sm text-white fw-semibold" 
                                                   href="${pageContext.request.contextPath}/manage-medicine?action=import&medicineID=${med.medicineID}">
                                                    <i class="fa-solid fa-truck-ramp-box me-1"></i> Import
                                                </a>

                                                <a class="btn btn-info btn-sm text-white fw-semibold" 
                                                   href="${pageContext.request.contextPath}/manage-medicine?action=edit&medicineID=${med.medicineID}">
                                                    <i class="fa-solid fa-pen-to-square me-1"></i> Edit
                                                </a>

                                                <button type="button" class="btn btn-danger btn-sm fw-semibold"
                                                        data-bs-toggle="modal" data-bs-target="#deleteModal${med.medicineID}">
                                                    <i class="fa-solid fa-trash me-1"></i> Delete
                                                </button>
                                            </div>

                                            <div class="modal fade" id="deleteModal${med.medicineID}" tabindex="-1" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Confirm Delete</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Are you sure you want to proceed?
                                                        </div>
                                                        <div class="modal-footer d-flex justify-content-end">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                            <form method="post" action="${pageContext.request.contextPath}/manage-medicine" class="d-inline">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="medicineID" value="${med.medicineID}">
                                                                <button type="submit" class="btn btn-danger">Yes</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
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

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
