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

            /* === MATCH DOCTOR STYLE === */
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
                margin-bottom: 30px;
            }
            .card-header {
                background-color: #1B5A90 !important;
                color: white !important;
                font-weight: bold;
            }

            th {
                background-color: #f1f3f5 !important;
                width: 220px;
                font-weight: 600;
            }
            td {
                background-color: #ffffff !important;
            }
            .table-bordered th, .table-bordered td {
                border: 1px solid #dee2e6 !important;
            }

            .fw-bold {
                font-weight: 700 !important;
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

            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-primary">
                    <i class="fa-solid fa-file-invoice-dollar me-2"></i>Patient Invoice Detail
                </h2>
            </div>

            <!-- Invoice Information -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-receipt me-2"></i>Invoice Information
                </div>
                <div class="card-body p-4">
                    <table class="table table-bordered mb-0">
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
                            <td><fmt:formatDate value="${invoiceDetail.dateCreate}" pattern="dd/MM/yyyy HH:mm"/></td>
                        </tr>

                        <tr>
                            <th>Date Paid</th>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty invoiceDetail.datePay}">
                                        <fmt:formatDate value="${invoiceDetail.datePay}" pattern="dd/MM/yyyy HH:mm"/>
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
                            <th>Total Fee</th>
                            <td><fmt:formatNumber value="${invoiceDetail.totalFee}" type="currency" currencySymbol="$"/></td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Patient Information -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-user me-2"></i>Patient Information
                </div>
                <div class="card-body p-4">
                    <table class="table table-bordered mb-0">
                        <tr>
                            <th>Patient Name</th>
                            <td>${invoiceDetail.medicalRecordID.appointmentID.patientID.firstName}
                                ${invoiceDetail.medicalRecordID.appointmentID.patientID.lastName}</td>
                        </tr>
                        <tr><th>Symptoms</th><td>${invoiceDetail.medicalRecordID.symptoms}</td></tr>
                        <tr><th>Diagnosis</th><td>${invoiceDetail.medicalRecordID.diagnosis}</td></tr>
                        <tr><th>Medical Note</th><td>${invoiceDetail.medicalRecordID.note}</td></tr>
                    </table>
                </div>
            </div>

            <!-- Doctor Information -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-user-doctor me-2"></i>Doctor Information
                </div>
                <div class="card-body p-4">
                    <table class="table table-bordered mb-0">
                        <tr>
                            <th>Doctor Name</th>
                            <td>${invoiceDetail.medicalRecordID.appointmentID.doctorID.staffID.firstName}
                                ${invoiceDetail.medicalRecordID.appointmentID.doctorID.staffID.lastName}</td>
                        </tr>
                        <tr>
                            <th>Specialty</th>
                            <td>${invoiceDetail.specialtyID.specialtyName}</td>
                        </tr>
                        <tr>
                            <th>Consultation Fee</th>
                            <td><fmt:formatNumber value="${invoiceDetail.specialtyID.price}" type="currency" currencySymbol="$"/></td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Prescription Information -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-prescription me-2"></i>Prescription Information
                </div>
                <div class="card-body p-4">
                    <table class="table table-bordered mb-0">
                        <tr>
                            <th>Prescription Note</th>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty invoiceDetail.prescriptionID.note}">
                                        ${invoiceDetail.prescriptionID.note}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">No note available</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>

    </body>
</html>