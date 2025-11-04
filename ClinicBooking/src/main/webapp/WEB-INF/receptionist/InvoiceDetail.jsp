<%-- 
    Document   : InvoiceDetail
    Created on : Oct 20, 2025, 6:50:33 PM
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Invoice Detail</title>
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
            .section-title {
                margin-top: 30px;
                color: #1B5A90;
                font-weight: bold;
            }
            th {
                width: 220px;
                background-color: #f1f1f1;
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

        <!-- Main Content -->
        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2><i class="fa-solid fa-file-invoice-dollar me-2"></i>Patient Invoice Detail</h2>
            </div>

            <!-- Invoice Information -->
            <h3 class="section-title">Invoice Information</h3>
            <table class="table table-bordered">
                <tr>
                    <th>Status</th>
                    <td>
                        <c:choose>
                            <c:when test="${invoiceDetail.invoiceStatus eq 'Paid'}">
                                <span class="badge bg-success">Paid</span>
                            </c:when>
                            <c:when test="${invoiceDetail.invoiceStatus eq 'Pending'}">
                                <span class="badge bg-warning text-dark">Pending</span>
                            </c:when>
                            <c:when test="${invoiceDetail.invoiceStatus eq 'Canceled'}">
                                <span class="badge bg-danger">Canceled</span>
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>Date Created</th>
                    <td><fmt:formatDate value="${invoiceDetail.dateCreate}" pattern="dd/MM/yyyy HH:mm" /></td>
                </tr>
                <tr>
                    <th>Date Paid</th>
                    <td>
                        <c:choose>
                            <c:when test="${not empty invoiceDetail.datePay}">
                                <fmt:formatDate value="${invoiceDetail.datePay}" pattern="dd/MM/yyyy HH:mm" />
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">Not yet paid</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>Payment Method</th>
                    <td>${invoiceDetail.paymentType}</td>
                </tr>
                <tr>
                    <th>Consultation Fee</th>
                    <td><fmt:formatNumber value="${invoiceDetail.fee}" type="currency" currencySymbol="$"/></td>
                </tr>
            </table>

            <!-- Patient Information -->
            <h3 class="section-title">Patient Information</h3>
            <table class="table table-bordered">
                <tr><th>Patient Name</th><td>${invoiceDetail.patientName}</td></tr>
                <tr><th>Symptoms</th><td>${invoiceDetail.symptoms}</td></tr>
                <tr><th>Diagnosis</th><td>${invoiceDetail.diagnosis}</td></tr>
                <tr><th>Medical Note</th><td>${invoiceDetail.medicalNote}</td></tr>
            </table>

            <!-- Doctor Information -->
            <h3 class="section-title">Doctor Information</h3>
            <table class="table table-bordered">
                <tr><th>Doctor Name</th><td>${invoiceDetail.doctorName}</td></tr>
                <tr><th>Specialty</th><td>${invoiceDetail.specialty}</td></tr>
            </table>

            <!-- Prescription Information -->
            <h3 class="section-title">Prescription Information</h3>
            <table class="table table-bordered">
                <tr>
                    <th>Prescription Note</th>
                    <td>
                        <c:choose>
                            <c:when test="${not empty invoiceDetail.prescriptionNote}">
                                ${invoiceDetail.prescriptionNote}
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">No note available</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>
