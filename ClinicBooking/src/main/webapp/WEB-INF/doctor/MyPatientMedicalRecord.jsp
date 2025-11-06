<%-- 
    Document   : MyPatientMedicalRecord
    Created on : 11 Oct. 2025, 7:53:46 pm
    Author     : Le Thien Tri - CE191249
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage My Patient Medical Records</title>
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
                padding: 12px 24px;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
            }
            .table th {
                background-color: #f1f3f5;
                font-weight: 600;
                vertical-align: middle;
            }
            .table td {
                vertical-align: middle;
            }
            #Logout {
                color: red;
                border-color: red;
                transition: all 0.3s ease;
            }
            #Logout:hover {
                background-color: red;
                color: white;
            }
        </style>
    </head>

    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <nav class="navbar navbar-light justify-content-between">
                <h3 class="fw-bold text-primary mb-0">
                    <i class="fa-solid fa-file-medical me-2"></i>Manage My Patient Medical Records
                </h3>
                <form class="d-flex" action="${pageContext.request.contextPath}/manage-my-patient-medical-record" method="get">
                    <input class="form-control me-2" type="text" name="keyword" 
                           placeholder="Search by patient name..." value="${param.keyword}">
                    <button class="btn btn-outline-primary me-3" type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i> Search
                    </button>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger" id="Logout">
                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                    </a>
                </form>
            </nav>

            <!-- Record List -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fa-solid fa-list me-2"></i>Patient Medical Record List
                </div>
                <div class="card-body p-4">
                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Patient Name</th>
                                <th>Symptoms</th>
                                <th>Diagnosis</th>
                                <th>Note</th>
                                <th>Date Created</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="record" items="${myPatientMedicalRecordList}" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>
                                    <td>${record.appointmentID.patientID.firstName} ${record.appointmentID.patientID.lastName}</td>
                                    <td>${record.symptoms}</td>
                                    <td>${record.diagnosis}</td>
                                    <td>${record.note}</td>
                                    <td><fmt:formatDate value="${record.dateCreate}" pattern="yyyy/MM/dd HH:mm"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/manage-my-patient-medical-record?action=detail&medicalRecordID=${record.medicalRecordID}"
                                           class="btn btn-sm btn-info text-white">
                                            <i class="fa-solid fa-eye"></i> View Detail
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty myPatientMedicalRecordList}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No medical records found.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
