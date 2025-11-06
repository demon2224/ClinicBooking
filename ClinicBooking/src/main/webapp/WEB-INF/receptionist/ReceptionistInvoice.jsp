<%-- 
    Document   : ReceptionistInvoice
    Created on : Oct 18, 2025, 2:27:30 PM
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Doctor Dashboard</title>
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
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/receptionist-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/receptionist-manage-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="${pageContext.request.contextPath}/manage-invoice"><i class="fa-solid fa-file-invoice-dollar me-2"></i>Manage Invoice</a>
        </div>

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
            <c:if test="${not empty sessionScope.successMessage}">
                <div id="successAlert" class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session"/>
                <script>
                    // auto hide after 2 seccond
                    setTimeout(function () {
                        var alertEl = document.getElementById('successAlert');
                        if (alertEl) {
                            var bsAlert = bootstrap.Alert.getOrCreateInstance(alertEl);
                            bsAlert.close();
                        }
                    }, 2000);
                </script>
            </c:if>


            <div class="container-fluid mt-4">
                <!-- Appointment List -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Invoice List</h5>                      
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle text-center">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Patient Name</th>
                                    <th>Doctor Name</th>
                                    <th>Specialty</th>
                                    <th>Fee</th>
                                    <th>Payment Method</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="inv" items="${invoices}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>
                                            ${inv.medicalRecordID.appointmentID.patientID.firstName}
                                            ${inv.medicalRecordID.appointmentID.patientID.lastName}
                                        </td>
                                        <td>
                                            ${inv.medicalRecordID.appointmentID.doctorID.staffID.firstName}
                                            ${inv.medicalRecordID.appointmentID.doctorID.staffID.lastName}
                                        </td>
                                        <td>${inv.specialtyID.specialtyName}</td>
                                        <td>
                                            <fmt:formatNumber value="${inv.specialtyID.price}" type="currency" currencySymbol="$"/>
                                        </td>
                                        <td>${inv.paymentType}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${inv.invoiceStatus eq 'Paid'}">
                                                    <span class="badge bg-success">${inv.invoiceStatus}</span>
                                                </c:when>
                                                <c:when test="${inv.invoiceStatus eq 'Pending'}">
                                                    <span class="badge bg-warning text-dark">${inv.invoiceStatus}</span>
                                                </c:when>
                                                <c:when test="${inv.invoiceStatus eq 'Canceled'}">
                                                    <span class="badge bg-danger">${inv.invoiceStatus}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${inv.invoiceStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <!-- Action -->
                                        <td class="text-center">
                                            <div class="d-flex justify-content-center gap-2">
                                                <a href="manage-invoice?action=viewDetail&id=${inv.invoiceID}"
                                                   class="btn btn-sm btn-info text-white">
                                                    <i class="fa-solid fa-eye"></i> View Detail
                                                </a>

                                                <a href="manage-invoice?action=update&id=${inv.invoiceID}" 
                                                   class="btn btn-success btn-sm"
                                                   style="visibility:${inv.invoiceStatus eq 'Pending' ? 'visible' : 'hidden'};">
                                                    <i class="fa-solid fa-check"></i> Update
                                                </a>


                                                <form action="manage-invoice" method="post" style="display:inline;">
                                                    <input type="hidden" name="invoiceId" value="${inv.invoiceID}">
                                                    <input type="hidden" name="action" value="cancel">
                                                    <button type="submit" class="btn btn-danger btn-sm"
                                                            style="visibility:${inv.invoiceStatus eq 'Pending' ? 'visible' : 'hidden'};">
                                                        <i class="fa-solid fa-xmark"></i> Cancel
                                                    </button>
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


