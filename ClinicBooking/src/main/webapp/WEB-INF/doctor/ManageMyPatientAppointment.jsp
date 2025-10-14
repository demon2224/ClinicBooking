<%-- 
    Document   : ManageMyPatientAppointment
    Created on : 10 Oct. 2025, 7:07:00 pm
    Author     : Le Thien Tri - CE191249
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Patient Appointment</title>
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
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/doctor-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/manage-my-patient-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="#"><i class="fa-solid fa-user-doctor me-2"></i>Manage Medical Record</a>
            <a href="#"><i class="fa-solid fa-user me-2"></i>Manage Prescription</a>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <nav class="navbar navbar-light">
                <div class="container-fluid">
                    <form class="d-flex w-75" action="${pageContext.request.contextPath}/manage-my-patient-appointment" method="get">
                        <input class="form-control me-2" type="text" name="keyword" 
                               placeholder="Search by patient name..." value="${param.keyword}">
                        <button class="btn btn-outline-primary" type="submit">
                            <i class="fa-solid fa-magnifying-glass"></i> Search
                        </button>
                    </form>
                    <div>
                        <button class="btn btn-submit" id="Logout" type="submit">Logout</button>
                    </div>
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
                                    <th>Date</th>
                                    <th>Note</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="appointment" items="${myPatientAppointmentList}">
                                    <tr>
                                        <td>${appointment.patientName}</td>
                                        <td>${appointment.patientEmail}</td>
                                        <td>${appointment.patientPhone}</td>
                                        <td><fmt:formatDate value="${appointment.dateBegin}" pattern="yyyy/MM/dd HH:mm"/></td>
                                <td>${appointment.note}</td>
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
                                <td>
                                    <a href="${pageContext.request.contextPath}/my-patient-appointment-detail?appointmentID=${appointment.appointmentID}"
                                       class="btn btn-sm btn-info text-white text-decoration-none">
                                        <i class="fa-solid fa-eye"></i> View Detail
                                    </a>
                                </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty myPatientAppointmentList}">
                                <tr><td colspan="7" class="text-center text-muted">No appointments found.</td></tr>
                            </c:if>

                            </tbody>
                        </table>
                    </div>
                </div>       



            </div>
        </div>
    </body>
</html>
