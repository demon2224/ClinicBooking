<%--
    Document   : PrescriptionList
    Created on : Nov 5, 2025, 8:35:37 AM
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
        <%@include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <!-- Main content -->
        <div class="main-content">
            <nav class="navbar navbar-light">
                <div class="container-fluid">
                    <form class="d-flex w-50" method="get" action="${pageContext.request.contextPath}/pharmacist-manage-prescription">
                        <input type="hidden" name="action" value="search">
                        <input class="form-control me-2" type="search" name="search" placeholder="Search here" value="${param.search}">
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
                <!-- Appointment List -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Prescription List</h5>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle text-center">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Doctor</th>
                                    <th>Patient</th>
                                    <th>Status</th>
                                    <th>Day Create</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="prescription" items="${requestScope.prescriptionList}" varStatus="item">
                                    <tr>
                                        <td>
                                            <c:out value="${item.count}"/>
                                        </td>
                                        <td>
                                            <c:out value="${prescription.appointmentID.doctorID.staffID.fullName}"/>
                                        </td>
                                        <td>
                                            <c:out value="${prescription.appointmentID.patientID.fullName}"/>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${prescription.prescriptionStatus == 'Pending'}">
                                                    <span class="badge bg-warning text-dark">Pending</span>
                                                </c:when>
                                                <c:when test="${prescription.prescriptionStatus == 'Delivered'}">
                                                    <span class="badge bg-success text-white">Delivered</span>
                                                </c:when>
                                                <c:when test="${prescription.prescriptionStatus == 'Canceled'}">
                                                    <span class="badge bg-danger text-white">Canceled</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:out value="${prescription.dateCreateFormatDate}"/>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex justify-content-center align-items-center gap-2">

                                                <!-- Nút Detail (luôn có) -->
                                                <a href="${pageContext.request.contextPath}/pharmacist-manage-prescription?action=detail&prescriptionID=${prescription.prescriptionID}"
                                                   class="btn btn-primary">Detail</a>

                                                <!-- Nút Deliver -->
                                                <c:choose>
                                                    <c:when test="${prescription.prescriptionStatus == 'Pending'}">
                                                        <form method="post" action="${pageContext.request.contextPath}/pharmacist-manage-prescription">
                                                            <input type="hidden" name="action" value="deliver">
                                                            <input type="hidden" name="prescriptionID" value="${prescription.prescriptionID}">
                                                            <button type="submit" class="btn btn-success">Deliver</button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-success invisible">Deliver</button>
                                                    </c:otherwise>
                                                </c:choose>

                                                <!-- Nút Cancel -->
                                                <c:choose>
                                                    <c:when test="${prescription.prescriptionStatus == 'Pending'}">
                                                        <form method="post" action="${pageContext.request.contextPath}/pharmacist-manage-prescription">
                                                            <input type="hidden" name="action" value="cancel">
                                                            <input type="hidden" name="prescriptionID" value="${prescription.prescriptionID}">
                                                            <button type="submit" class="btn btn-danger">Cancel</button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-danger invisible">Cancel</button>
                                                    </c:otherwise>
                                                </c:choose>
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
