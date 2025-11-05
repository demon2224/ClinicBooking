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
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <!-- Main content -->
        <div class="main-content">
            <nav class="navbar navbar-light">
                <div class="container-fluid justify-content-end">
                    <button class="btn btn-submit" id="Logout" type="submit">Logout</button>
                </div>
            </nav>

            <div class="container-fluid mt-4">
                <!-- Doctors List -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Patient Appointment List</h5>
                    </div>
                    <div class="card-body">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Note</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="myPatientAppointment" items="${myPatientAppointmentList}">
                                    <tr>
                                        <td>${myPatientAppointment.patientName}</td>
                                        <td>${myPatientAppointment.patientEmail}</td>
                                        <td>${myPatientAppointment.patientPhone}</td>
                                        <td>${myPatientAppointment.note}</td>
                                        <td>
                                            <fmt:formatDate value="${myPatientAppointment.dateBegin}" pattern="yyyy/MM/dd HH:mm" />
                                        </td>
                                        <td>
                                            <span class="badge
                                                  <c:choose>
                                                      <c:when test="${myPatientAppointment.statusName eq 'Pending'}">bg-warning text-dark</c:when>
                                                      <c:when test="${myPatientAppointment.statusName eq 'Approved'}">bg-primary</c:when>
                                                      <c:when test="${myPatientAppointment.statusName eq 'Completed'}">bg-success</c:when>
                                                      <c:when test="${myPatientAppointment.statusName eq 'Canceled'}">bg-danger</c:when>
                                                      <c:otherwise>bg-secondary</c:otherwise>
                                                  </c:choose>">
                                                ${myPatientAppointment.statusName}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Patients List -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Patient Medical Record List</h5>
                    </div>
                    <div class="card-body">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Diagnosis</th>
                                    <th>Appointment Date</th>
                                    <th>Record Create Date</th>   
                                    <th>Prescription Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="myPatientMedicalRecord" items="${myPatientMedicalRecordList}">
                                    <tr>
                                        <td>${myPatientMedicalRecord.patientName}</td>
                                        <td>${myPatientMedicalRecord.diagnosis}</td>
                                        <td>
                                            <fmt:formatDate value="${myPatientMedicalRecord.appointmentDateBegin}" pattern="yyyy/MM/dd HH:mm" />
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${myPatientMedicalRecord.medicalRecordDateCreate}" pattern="yyyy/MM/dd HH:mm" />
                                        </td>
                                        <td>
                                            <span class="badge
                                                  <c:choose>
                                                      <c:when test="${myPatientMedicalRecord.prescriptionStatusName eq 'Pending'}">bg-warning text-dark</c:when>
                                                      <c:when test="${myPatientMedicalRecord.prescriptionStatusName eq 'Delivered'}">bg-success</c:when>
                                                      <c:when test="${myPatientMedicalRecord.prescriptionStatusName eq 'Canceled'}">bg-danger</c:when>
                                                      <c:otherwise>bg-secondary</c:otherwise>
                                                  </c:choose>">
                                                ${myPatientMedicalRecord.prescriptionStatusName}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Appointment List -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Patient Prescription List</h5>
                    </div>
                    <div class="card-body">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Prescription Note</th> 
                                    <th>Appointment Date</th>                                                       
                                    <th>Prescription Date</th>
                                    <th>Prescription Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="myPatientPrescription" items="${myPatientPrescriptionList}">
                                    <tr>
                                        <td>${myPatientPrescription.patientName}</td>
                                        <td>${myPatientPrescription.note}</td>
                                        <td>
                                            <fmt:formatDate value="${myPatientPrescription.appointmentDateBegin}" pattern="yyyy/MM/dd HH:mm" />
                                        </td>                                   
                                        <td>
                                            <fmt:formatDate value="${myPatientPrescription.dateCreate}" pattern="yyyy/MM/dd HH:mm" />
                                        </td>
                                        <td>
                                            <span class="badge
                                                  <c:choose>
                                                      <c:when test="${myPatientPrescription.prescriptionStatusName eq 'Pending'}">bg-warning text-dark</c:when>
                                                      <c:when test="${myPatientPrescription.prescriptionStatusName eq 'Delivered'}">bg-success</c:when>
                                                      <c:when test="${myPatientPrescription.prescriptionStatusName eq 'Canceled'}">bg-danger</c:when>
                                                      <c:otherwise>bg-secondary</c:otherwise>
                                                  </c:choose>">
                                                ${myPatientPrescription.prescriptionStatusName}
                                            </span>
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
