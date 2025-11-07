<%-- 
    Document   : MyPatientAppointmentDetail
    Created on : 10 Oct. 2025, 9:56:23 pm
    Author     : Le Thien Tri - CE191249
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
                width: 220px;
                font-weight: 600;
            }
            td {
                background-color: #fff;
            }
            .btn-create-record {
                background-color: #28a745;
                color: white;
                font-weight: 600;
                border-radius: 10px;
                padding: 10px 25px;
                transition: all 0.3s ease;
            }
            .btn-create-record:hover {
                background-color: #00c18a;
                color: #fff;
                transform: translateY(-2px);
            }
        </style>
    </head>

    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-primary">
                    <i class="fa-solid fa-calendar-check me-2"></i>Appointment Detail
                </h2>
                 <!-- Create Medical Record Button -->
            <c:if test="${not requestScope.isExist}">
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/manage-my-patient-medical-record?action=create&appointmentID=${detail.appointmentID}"
                       class="btn btn-create-record">
                        <i class="fa-solid fa-notes-medical me-2"></i>Create Medical Record
                    </a>
                </div>
            </c:if>
            </div>

            <!-- Appointment Information -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-info-circle me-2"></i>Appointment Information
                </div>
                <div class="card-body p-4">
                    <table class="table table-bordered mb-0">
                        <tr>
                            <th>Date Begin</th>
                            <td><fmt:formatDate value="${detail.dateBegin}" pattern="yyyy/MM/dd HH:mm" /></td>
                        </tr>
                        <tr>
                            <th>Date End</th>
                            <td>
                                <c:choose>
                                    <c:when test="${detail.appointmentStatus == 'Completed'}">
                                        <fmt:formatDate value="${detail.dateEnd}" pattern="yyyy/MM/dd HH:mm"/>
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
                                          <c:when test="${detail.appointmentStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                          <c:when test="${detail.appointmentStatus eq 'Approved'}">bg-primary</c:when>
                                          <c:when test="${detail.appointmentStatus eq 'Completed'}">bg-success</c:when>
                                          <c:when test="${detail.appointmentStatus eq 'Canceled'}">bg-danger</c:when>
                                          <c:otherwise>bg-secondary</c:otherwise>
                                      </c:choose>">
                                    ${detail.appointmentStatus}
                                </span>
                            </td>
                        </tr>
                        <tr><th>Appointment Note</th><td>${detail.note}</td></tr>
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
                        <tr><th>Patient Name</th><td>${detail.patientID.firstName} ${detail.patientID.lastName}</td></tr>
                        <tr><th>Email</th><td>${detail.patientID.email}</td></tr>
                        <tr><th>Phone</th><td>${detail.patientID.phoneNumber}</td></tr>
                        <tr>
                            <th>Gender</th>
                            <td>
                                <c:choose>
                                    <c:when test="${detail.patientID.gender}">Male</c:when>
                                    <c:otherwise>Female</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr><th>Date of Birth</th><td><fmt:formatDate value="${detail.patientID.dob}" pattern="yyyy/MM/dd" /></td></tr>
                        <tr><th>Address</th><td>${detail.patientID.userAddress}</td></tr>
                    </table>
                </div>
            </div>         
        </div>
    </body>
</html>
