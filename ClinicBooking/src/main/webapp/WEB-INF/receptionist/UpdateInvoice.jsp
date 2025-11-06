<%-- 
    Document   : UpdateInvoice
    Created on : Nov 6, 2025, 5:33:17 PM
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
            input[readonly], input:disabled, select:disabled {
                background-color: #e9ecef !important;
                color: #6c757d !important;
                opacity: 0.7;
                cursor: not-allowed;
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

            <form method="post" action="manage-invoice?action=update-confirm">
                <input type="hidden" name="invoiceId" value="${invoiceDetail.invoiceID}">

                <h3 class="section-title">Invoice Information</h3>
                <table class="table table-bordered">
                    <tr>
                        <th>Status</th>
                        <td>
                            <select name="invoiceStatus" class="form-select">
                                <option value="Pending" ${invoiceDetail.invoiceStatus eq 'Pending' ? 'selected' : ''}>Pending</option>
                                <option value="Paid" ${invoiceDetail.invoiceStatus eq 'Paid' ? 'selected' : ''}>Paid</option>
                                <option value="Canceled" ${invoiceDetail.invoiceStatus eq 'Canceled' ? 'selected' : ''}>Canceled</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>Date Created</th>
                        <td><input type="text" class="form-control" value="<fmt:formatDate value='${invoiceDetail.dateCreate}' pattern='dd/MM/yyyy HH:mm'/>" readonly></td>
                    </tr>
                    <tr>
                        <th>Date Paid</th>
                        <td>
                            <input type="datetime-local" name="datePay" class="form-control"
                                   value="<fmt:formatDate value='${invoiceDetail.datePay}' pattern='yyyy-MM-dd\'T\'HH:mm'/>" readonly>
                        </td>
                    </tr>
                    <tr>
                        <th>Payment Method</th>
                        <td> 
                            <select id="paymentType" name="paymentType" class="form-select">
                                <option value="Cash">Cash</option>
                                <option value="Credit Card">Credit Card</option>
                                <option value="Insurance">Insurance</option>
                                <option value="Online Banking">Online Banking</option>
                                <option value="E-Wallet">E-Wallet</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>Total Fee</th>
                        <td><input type="text" class="form-control" value="<fmt:formatNumber value='${invoiceDetail.totalFee}' type='currency' currencySymbol='$'/>" readonly></td>
                    </tr>
                </table>

                <h3 class="section-title">Patient Information</h3>
                <table class="table table-bordered">
                    <tr>
                        <th>Patient Name</th>
                        <td>
                            <input type="text" class="form-control"
                                   value="${invoiceDetail.medicalRecordID.appointmentID.patientID.firstName} ${invoiceDetail.medicalRecordID.appointmentID.patientID.lastName}" readonly>
                        </td>
                    </tr>
                    <tr><th>Symptoms</th><td><input type="text" class="form-control" value="${invoiceDetail.medicalRecordID.symptoms}" readonly></td></tr>
                    <tr><th>Diagnosis</th><td><input type="text" class="form-control" value="${invoiceDetail.medicalRecordID.diagnosis}" readonly></td></tr>
                    <tr><th>Medical Note</th><td><input type="text" class="form-control" value="${invoiceDetail.medicalRecordID.note}" readonly></td></tr>
                </table>

                <h3 class="section-title">Doctor Information</h3>
                <table class="table table-bordered">
                    <tr>
                        <th>Doctor Name</th>
                        <td>
                            <input type="text" class="form-control"
                                   value="${invoiceDetail.medicalRecordID.appointmentID.doctorID.staffID.firstName} ${invoiceDetail.medicalRecordID.appointmentID.doctorID.staffID.lastName}" readonly>
                        </td>
                    </tr>
                    <tr><th>Specialty</th><td><input type="text" class="form-control" value="${invoiceDetail.specialtyID.specialtyName}" readonly></td></tr>
                    <tr><th>Consultation Fee</th><td><input type="text" class="form-control" value="<fmt:formatNumber value='${invoiceDetail.specialtyID.price}' type='currency' currencySymbol='$'/>" readonly></td></tr>
                </table>

                <h3 class="section-title">Prescription Information</h3>
                <table class="table table-bordered">
                    <tr>
                        <th>Prescription Note</th>
                        <td><input type="text" class="form-control" value="${invoiceDetail.prescriptionID.note}" readonly></td>
                    </tr>
                </table>

                <div class="text-end mt-4">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>

        </div>
    </body>
</html>

