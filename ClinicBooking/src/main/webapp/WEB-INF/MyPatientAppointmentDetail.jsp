<%-- 
    Document   : MyPatientAppointmentDetail
    Created on : 10 Oct. 2025, 9:56:23 pm
    Author     : Le Thien Tri - CE191249
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Patient Appointment Detail (Demo)</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
            }

            body {
                background-color: #f8f9fa;
                font-family: "Segoe UI", sans-serif;
            }

            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #1B5A90;
                color: white;
                position: fixed;
                top: 0;
                left: 0;
            }
            .container {
                margin-top: 40px;
                background: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                max-width: 900px;
            }
            h3.section-title {
                color: #0d6efd;
                font-weight: 600;
                border-bottom: 2px solid #0d6efd;
                padding-bottom: 6px;
                margin-bottom: 20px;
            }
            .info-table th {
                width: 200px;
                background-color: #f1f1f1;
            }
            .back-btn {
                text-decoration: none;
                padding: 8px 18px;
                background-color: #0d6efd;
                color: white;
                border-radius: 6px;
                transition: 0.3s;
            }
            .back-btn:hover {
                background-color: #084298;
            }
            .status-badge {
                padding: 4px 10px;
                border-radius: 8px;
                font-size: 13px;
                color: white;
            }
            .status-Approved {
                background-color: #0d6efd;
            }
            .status-Completed {
                background-color: #28a745;
            }
            .status-Pending {
                background-color: #ffc107;
                color: #333;
            }
            .status-Canceled {
                background-color: #dc3545;
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
        </style>
    </head>
    <body>
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/doctor-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/manage-my-patient-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="#"><i class="fa-solid fa-user-doctor me-2"></i>Manage Medical Record</a>
            <a href="#"><i class="fa-solid fa-user me-2"></i>Manage Prescription</a>
        </div>
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Patient Appointment Detail</h2>
            </div>

            <!-- Appointment Info -->
            <h3 class="section-title">Appointment Information</h3>
            <table class="table table-bordered info-table">
                <tr><th>Appointment ID</th>
                    <td>${detailAppointment.appointmentID}</td>
                </tr>
                <tr>
                    <th>Date Begin</th><td>${detailAppointment.dateBegin}</td>
                </tr>
                <tr>
                    <th>Date End</th>
                    <td>
                        ${detailAppointment.statusName == 'Completed' 
                          ? detailAppointment.dateEnd 
                          : 'None'}
                    </td>
                </tr>

                <tr>
                    <th>Status</th>
                    <td>
                        <span class="badge
                              <c:choose>
                                  <c:when test="${detailAppointment.statusName eq 'Pending'}">bg-warning text-dark</c:when>
                                  <c:when test="${detailAppointment.statusName eq 'Approved'}">bg-primary</c:when>
                                  <c:when test="${detailAppointment.statusName eq 'Completed'}">bg-success</c:when>
                                  <c:when test="${detailAppointment.statusName eq 'Canceled'}">bg-danger</c:when>
                                  <c:otherwise>bg-secondary</c:otherwise>
                              </c:choose>">
                            ${detailAppointment.statusName}
                        </span>
                    </td>
                </tr>
                <tr><th>Appointment Note</th>
                    <td>${detailAppointment.note}</td></tr>
            </table>

            <!-- Patient Info -->
            <h3 class="section-title">Patient Information</h3>
            <table class="table table-striped">
                <tr><th>Name</th><td>${detailAppointment.patientName}</td></tr>
                <tr><th>Email</th><td>${detailAppointment.patientEmail}</td></tr>
                <tr><th>Phone</th><td>${detailAppointment.patientPhone}</td></tr>
                <tr><th>Gender</th><td>${detailAppointment.gender}</td></tr>
                <tr><th>Date of Birth</th><td>${detailAppointment.doB}</td></tr>
                <tr><th>Address</th><td>${detailAppointment.address}</td></tr>
            </table>
        </div>

    </body>
</html>
