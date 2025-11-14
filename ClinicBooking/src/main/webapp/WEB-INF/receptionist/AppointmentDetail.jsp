<%-- 
    Document   : AppointmentDetail
    Created on : Oct 11, 2025
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Appointment Detail</title>
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
            border: 1px solid #dee2e6 !important; /* Màu border nhẹ giống doctor */
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
                <i class="fa-solid fa-calendar-check me-2"></i>Appointment Detail
            </h2>
        </div>

        <!-- Appointment Information -->
        <div class="card">
            <div class="card-header">
                <i class="fa-solid fa-info-circle me-2"></i>Appointment Information
            </div>
            <div class="card-body p-4">
                <table class="table table-bordered mb-0">
                    <tr>
                        <th>Date Created</th>
                        <td><fmt:formatDate value="${appointment.dateCreate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    </tr>
                    <tr>
                        <th>Date Begin</th>
                        <td><fmt:formatDate value="${appointment.dateBegin}" pattern="dd/MM/yyyy HH:mm" /></td>
                    </tr>
                    <tr>
                        <th>Date End</th>
                        <td>
                            <c:choose>
                                <c:when test="${appointment.statusName == 'Completed'}">
                                    <fmt:formatDate value="${appointment.dateEnd}" pattern="dd/MM/yyyy HH:mm"/>
                                </c:when>
                                <c:otherwise>None</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Status</th>
                        <td>
                            <span class="badge
                                  <c:choose>
                                      <c:when test="${appointment.statusName eq 'Pending'}">bg-warning text-dark</c:when>
                                      <c:when test="${appointment.statusName eq 'Approved'}">bg-primary</c:when>
                                      <c:when test="${appointment.statusName eq 'Completed'}">bg-success</c:when>
                                      <c:when test="${appointment.statusName eq 'Canceled'}">bg-danger</c:when>
                                      <c:otherwise>bg-secondary</c:otherwise>
                                  </c:choose>">
                                ${appointment.statusName}
                            </span>
                        </td>
                    </tr>
                    <tr><th>Appointment Note</th><td>${appointment.note}</td></tr>
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
                    <tr><th>Patient Name</th><td>${appointment.patientID.firstName} ${appointment.patientID.lastName}</td></tr>
                    <tr><th>Email</th><td>${appointment.patientID.email}</td></tr>
                    <tr><th>Phone</th><td>${appointment.patientID.phoneNumber}</td></tr>
                    <tr>
                        <th>Gender</th>
                        <td>
                            <c:choose>
                                <c:when test="${appointment.patientID.gender}">Male</c:when>
                                <c:otherwise>Female</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr><th>Date of Birth</th><td><fmt:formatDate value="${appointment.patientID.dob}" pattern="dd/MM/yyyy" /></td></tr>
                    <tr><th>Address</th><td>${appointment.patientID.userAddress}</td></tr>
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
                        <td>${appointment.doctorID.staffID.firstName} ${appointment.doctorID.staffID.lastName}</td>
                    </tr>
                    <tr><th>Specialty</th><td>${appointment.doctorID.specialtyID.specialtyName}</td></tr>
                    <tr><th>Email</th><td>${appointment.doctorID.staffID.email}</td></tr>
                    <tr><th>Phone</th><td>${appointment.doctorID.staffID.phoneNumber}</td></tr>
                    <tr><th>Year Experience</th><td>${appointment.doctorID.yearExperience}</td></tr>
                </table>
            </div>
        </div>

    </div>

</body>
</html>
