<%--
    Document   : MyPatientMedicalRecord
    Created on : 11 Oct. 2025, 7:53:46 pm
    Author     : Le Thien Tri - CE191249
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            <nav class="navbar navbar-light justify-content-between px-3 py-2 border-bottom">
                <h3 class="fw-bold text-primary mb-0 d-flex align-items-center">
                    <i class="fa-solid fa-file-medical me-2"></i>
                    Manage My Patient Medical Records
                </h3>
                <form class="d-flex align-items-center"
                      action="${pageContext.request.contextPath}/manage-my-patient-medical-record" method="get">
                    <input class="form-control me-2" type="text" name="keyword"
                           placeholder="Search by patient name..." value="${param.keyword}">
                    <button class="btn btn-outline-primary me-3 d-flex align-items-center" type="submit">
                        <i class="fa-solid fa-magnifying-glass me-2"></i>
                        <span>Search</span>
                    </button>
                    <a href="${pageContext.request.contextPath}/staff-logout"
                       class="btn btn-outline-danger d-flex align-items-center" id="Logout">
                        <i class="fa-solid fa-right-from-bracket me-2"></i>
                        <span>Logout</span>
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
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(record.symptoms) > 20}">
                                                ${fn:substring(record.symptoms, 0, 20)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${record.symptoms}
                                            </c:otherwise>
                                        </c:choose></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(record.diagnosis) > 20}">
                                                ${fn:substring(record.diagnosis, 0, 20)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${record.diagnosis}
                                            </c:otherwise>
                                        </c:choose></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(record.note) > 20}">
                                                ${fn:substring(record.note, 0, 20)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${record.note}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${record.dateCreate}" pattern="yyyy/MM/dd HH:mm"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/manage-my-patient-medical-record?action=detail&medicalRecordID=${record.medicalRecordID}"
                                           class="btn btn-sm btn-info text-white">
                                            <i class="fa-solid fa-eye"></i> View Detail
                                        </a>
                                        <a href="${pageContext.request.contextPath}/manage-my-patient-medical-record?action=edit&medicalRecordID=${record.medicalRecordID}"
                                           class="btn btn-sm btn-warning text-white">
                                            <i class="fa-solid fa-wrench"></i> Edit
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
        <!-- Bootstrap notice Modal -->
        <div class="modal fade" id="success" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-circle-exclamation me-2"></i>Successfully</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ${sessionScope.message}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <c:if test="${not empty sessionScope.message}">
            <script>
                window.onload = function () {
                    var myModal = new bootstrap.Modal(document.getElementById('success'));
                    myModal.show();
                };
            </script>
            <c:remove var="message" scope="session" />
        </c:if>
    </body>
</html>
