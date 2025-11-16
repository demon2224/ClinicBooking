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
        <title>Medicine Detail</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
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
                padding: 12px 20px;
                text-decoration: none;
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
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
                margin-bottom: 30px;
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
            }
            th {
                background-color: #f1f3f5;
                width: 250px;
                font-weight: 600;
            }
            td {
                background-color: white;
            }
        </style>
    </head>

    <body>

        <%@include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="main-content">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-primary">
                    <i class="fa-solid fa-capsules me-2"></i>Medicine Detail
                </h2>
            </div>

            <c:if test="${requestScope.medicine.isHidden}">
                <div class="alert alert-danger text-center fs-4 py-3">
                    <i class="fa-solid fa-circle-exclamation me-2"></i>Medicine Not Found
                </div>
            </c:if>

            <c:if test="${not requestScope.medicine.isHidden}">
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-info-circle me-2"></i>Information
                    </div>

                    <div class="card-body p-4">
                        <table class="table table-bordered mb-0">

                            <tr>
                                <th>Name</th>
                                <td>${medicine.medicineName}</td>
                            </tr>

                            <tr>
                                <th>Code</th>
                                <td>${medicine.medicineCode}</td>
                            </tr>

                            <tr>
                                <th>Status</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${medicine.medicineStatus}">
                                            <span class="badge bg-success">Available</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Unavailable</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>

                            <tr>
                                <th>Type</th>
                                <td>${medicine.medicineType}</td>
                            </tr>

                            <tr>
                                <th>Quantity</th>
                                <td>${medicine.quantity}</td>
                            </tr>

                            <tr>
                                <th>Price per Unit</th>
                                <td>$<fmt:formatNumber value="${medicine.price}" pattern="#,##0.00"/></td>
                            </tr>

                            <tr>
                                <th>Date Created</th>
                                <td>${medicine.dateCreateFormatDate}</td>
                            </tr>

                        </table>
                    </div>
                </div>
            </c:if>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
