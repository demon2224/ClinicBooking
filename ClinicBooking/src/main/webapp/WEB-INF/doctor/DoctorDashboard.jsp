<%--
    Document   : DoctorDashboard
    Created on : 7 Oct. 2025, 2:18:25 pm
    Author     : Le Thien Tri - CE191249
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Doctor Dashboard</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                background-color: #f4f7fb;
                font-family: "Poppins", sans-serif;
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
                background-color: #00BFE7;
            }
            .main-content {
                margin-left: 260px;
                padding: 25px;
            }
            .card {
                border: none;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
            }
            .dashboard-card {
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }
            .dashboard-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 14px rgba(0,0,0,0.15);
            }
            .stat-icon {
                font-size: 2.3rem;
                color: #1B5A90;
            }
            .stat-value {
                font-size: 1.8rem;
                font-weight: 600;
            }
            .logout-btn {
                color: red;
                border-color: red;
            }
            .logout-btn:hover {
                background-color: red;
                color: white;
            }
            .navbar {
                background: white;
                border-bottom: 1px solid #dee2e6;
                padding: 12px 24px;
            }
        </style>
    </head>
    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <div class="main-content">
            <!-- Navbar -->
            <nav class="navbar navbar-light justify-content-between mb-4 px-3 py-2 border-bottom shadow-sm">
                <h3 class="fw-bold text-primary mb-0">
                    <i class="fa-solid fa-user-doctor me-2"></i>Doctor Dashboard
                </h3>
                <a href="${pageContext.request.contextPath}/staff-logout" class="btn btn-outline-danger logout-btn">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
            </nav>

            <!-- Welcome Section -->
            <div class="alert alert-primary shadow-sm mb-4" role="alert">
                <i class="fa-solid fa-stethoscope me-2"></i>
                Welcome back, <strong>${sessionScope.staff.fullName}</strong>!
                Here’s an overview of your current medical activities.
            </div>

            <!-- Summary Statistics -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-calendar-check stat-icon mb-2"></i>
                        <div class="stat-value">${todayAppointments}</div>
                        <p class="mb-0 text-muted">Appointments</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-prescription-bottle-medical stat-icon mb-2"></i>
                        <div class="stat-value">${pendingPrescriptions}</div>
                        <p class="mb-0 text-muted">Prescriptions</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-file-medical stat-icon mb-2"></i>
                        <div class="stat-value">${totalMedicalRecords}</div>
                        <p class="mb-0 text-muted">Medical Records</p>
                    </div>
                </div>
            </div>

            <!-- Upcoming Appointments Table -->
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fa-solid fa-calendar-days me-2"></i>Appointments
                </div>
                <div class="card-body">
                    <c:if test="${empty upcomingAppointments}">
                        <p class="text-muted text-center mb-0">No upcoming appointments.</p>
                    </c:if>
                    <c:if test="${not empty upcomingAppointments}">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Patient</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="app" items="${upcomingAppointments}">
                                    <tr>
                                        <td>${app.patientName}</td>
                                        <td><fmt:formatDate value="${app.dateBegin}" pattern="dd MMM yyyy"/></td>
                                        <td><fmt:formatDate value="${app.dateBegin}" pattern="HH:mm"/></td>
                                        <td>
                                            <span class="badge
                                                  <c:choose>
                                                      <c:when test="${app.appointmentStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                                      <c:when test="${app.appointmentStatus eq 'Approved'}">bg-primary</c:when>
                                                      <c:when test="${app.appointmentStatus eq 'Completed'}">bg-success</c:when>
                                                      <c:when test="${app.appointmentStatus eq 'Canceled'}">bg-danger</c:when>
                                                      <c:otherwise>bg-secondary</c:otherwise>
                                                  </c:choose>">
                                                ${app.appointmentStatus}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/manage-my-patient-appointment?action=detail&appointmentID=${app.appointmentID}"
                                               class="btn btn-sm btn-info text-white">
                                                <i class="fa-solid fa-eye"></i> View Detail
                                            </a>
                                            <c:choose>
                                                <c:when test="${app.appointmentStatus eq 'Approved' and app.hasRecord}">
                                                    <a href="${pageContext.request.contextPath}/manage-my-patient-appointment?action=completed&appointmentID=${app.appointmentID}"
                                                       class="btn btn-sm btn-success text-white">
                                                        <i class="fa-solid fa-check"></i> Completed
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-sm btn-secondary" disabled>
                                                        <i class="fa-solid fa-check"></i> Completed
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>

            <!-- Recent Prescriptions -->
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fa-solid fa-prescription me-2"></i>Prescriptions
                </div>
                <div class="card-body">
                    <c:if test="${empty recentPrescriptions}">
                        <p class="text-muted text-center mb-0">No prescriptions.</p>
                    </c:if>
                    <c:if test="${not empty recentPrescriptions}">
                        <table class="table table-striped align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Patient</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pres" items="${recentPrescriptions}" varStatus="i">
                                    <tr>
                                        <td>${i.count}</td>
                                        <td>${pres.appointmentID.patientID.firstName} ${pres.appointmentID.patientID.lastName}</td>
                                        <td><fmt:formatDate value="${pres.dateCreate}" pattern="dd MMM yyyy"/></td>
                                        <td>
                                            <span class="badge
                                                  <c:choose>
                                                      <c:when test="${pres.prescriptionStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                                      <c:otherwise>bg-success</c:otherwise>
                                                  </c:choose>">
                                                <c:choose>
                                                    <c:when test="${pres.prescriptionStatus eq 'Pending'}">${pres.prescriptionStatus}</c:when>
                                                    <c:otherwise>Paid</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/manage-my-patient-prescription?action=detail&prescriptionID=${pres.prescriptionID}"
                                               class="btn btn-sm btn-info text-white">
                                                <i class="fa-solid fa-eye"></i> View Detail
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>
            <!-- Recent Medical Records -->
            <div class="card mb-4 mt-3">
                <div class="card-header">
                    <i class="fa-solid fa-notes-medical me-2"></i>Recent Medical Records
                </div>
                <div class="card-body">
                    <c:if test="${empty recentRecords}">
                        <p class="text-muted text-center mb-0">No medical records.</p>
                    </c:if>
                    <c:if test="${not empty recentRecords}">
                        <table class="table table-striped align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Patient</th>
                                    <th>Diagnosis</th>
                                    <th>Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="record" items="${recentRecords}" varStatus="i">
                                    <tr>
                                        <td>${i.count}</td>
                                        <td>${record.appointmentID.patientID.firstName} ${record.appointmentID.patientID.lastName}</td>
                                        <td>${record.diagnosis}</td>
                                        <td><fmt:formatDate value="${record.dateCreate}" pattern="dd MMM yyyy"/></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/manage-my-patient-medical-record?action=detail&medicalRecordID=${record.medicalRecordID}"
                                               class="btn btn-sm btn-info text-white">
                                                <i class="fa-solid fa-eye"></i> View Detail
                                            </a>                                            
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
