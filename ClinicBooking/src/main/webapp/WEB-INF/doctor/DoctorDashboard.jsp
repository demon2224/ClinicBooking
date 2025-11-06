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
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/logo.png">
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
            .badge {
                font-size: 0.85rem;
                padding: 6px 10px;
                border-radius: 8px;
            }
            .table th {
                color: #1B5A90;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.08);
            }
        </style>
    </head>
    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">

            <!-- Navbar -->
            <nav class="navbar navbar-light justify-content-between mb-4">
                <h3 class="fw-bold text-primary mb-0">
                    <i class="fa-solid fa-user-doctor me-2"></i>Doctor Dashboard
                </h3>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger" id="Logout">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
            </nav>

            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card text-center p-3 border-0 shadow-sm">
                        <div class="card-body">
                            <i class="fa-solid fa-calendar-check fa-2x text-primary mb-2"></i>
                            <h5 class="fw-bold">${todayAppointmentCount}</h5>
                            <p class="text-muted mb-0">Today's Appointments</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center p-3 border-0 shadow-sm">
                        <div class="card-body">
                            <i class="fa-solid fa-notes-medical fa-2x text-success mb-2"></i>
                            <h5 class="fw-bold">${totalMedicalRecordCount}</h5>
                            <p class="text-muted mb-0">Total Medical Records</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center p-3 border-0 shadow-sm">
                        <div class="card-body">
                            <i class="fa-solid fa-prescription-bottle-medical fa-2x text-info mb-2"></i>
                            <h5 class="fw-bold">${totalPrescriptionCount}</h5>
                            <p class="text-muted mb-0">Total Prescriptions</p>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Appointment List -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fa-solid fa-calendar-days text-primary me-2"></i>My Patient Appointments</h5>
                </div>
                <div class="card-body">
                    <table class="table align-middle table-hover">
                        <thead>
                            <tr>
                                <th>Patient Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Note</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${myPatientAppointmentList}">
                                <tr>
                                    <td>${a.patientID.firstName} ${a.patientID.lastName}</td>
                                    <td>${a.patientID.email}</td>
                                    <td>${a.patientID.phoneNumber}</td>
                                    <td>${a.note}</td>
                                    <td><fmt:formatDate value="${a.dateBegin}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>
                                        <span class="badge
                                              <c:choose>
                                                  <c:when test="${a.appointmentStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                                  <c:when test="${a.appointmentStatus eq 'Approved'}">bg-primary</c:when>
                                                  <c:when test="${a.appointmentStatus eq 'Completed'}">bg-success</c:when>
                                                  <c:when test="${a.appointmentStatus eq 'Canceled'}">bg-danger</c:when>
                                                  <c:otherwise>bg-secondary</c:otherwise>
                                              </c:choose>">
                                            ${a.appointmentStatus}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty myPatientAppointmentList}">
                                <tr><td colspan="6" class="text-center text-muted">No appointments found.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Medical Record List -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fa-solid fa-notes-medical text-success me-2"></i>My Patient Medical Records</h5>
                </div>
                <div class="card-body">
                    <table class="table align-middle table-hover">
                        <thead>
                            <tr>
                                <th>Patient Name</th>
                                <th>Diagnosis</th>
                                <th>Symptoms</th>
                                <th>Date Created</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${myPatientMedicalRecordList}">
                                <tr>
                                    <td>${r.appointmentID.patientID.firstName} ${r.appointmentID.patientID.lastName}</td>
                                    <td>${r.diagnosis}</td>
                                    <td>${r.symptoms}</td>
                                    <td><fmt:formatDate value="${r.dateCreate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty myPatientMedicalRecordList}">
                                <tr><td colspan="4" class="text-center text-muted">No medical records found.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Prescription List -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fa-solid fa-prescription-bottle-medical text-info me-2"></i>My Patient Prescriptions</h5>
                </div>
                <div class="card-body">
                    <table class="table align-middle table-hover">
                        <thead>
                            <tr>
                                <th>Patient Name</th>
                                <th>Note</th>
                                <th>Date Created</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${myPatientPrescriptionList}">
                                <tr>
                                    <td>${p.patientName}</td>
                                    <td>${p.note}</td>
                                    <td><fmt:formatDate value="${p.dateCreate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>
                                        <span class="badge
                                              <c:choose>
                                                  <c:when test="${p.prescriptionStatusName eq 'Pending'}">bg-warning text-dark</c:when>
                                                  <c:when test="${p.prescriptionStatusName eq 'Delivered'}">bg-success</c:when>
                                                  <c:when test="${p.prescriptionStatusName eq 'Canceled'}">bg-danger</c:when>
                                                  <c:otherwise>bg-secondary</c:otherwise>
                                              </c:choose>">
                                            ${p.prescriptionStatusName}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty myPatientPrescriptionList}">
                                <tr><td colspan="4" class="text-center text-muted">No prescriptions found.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </body>
</html>