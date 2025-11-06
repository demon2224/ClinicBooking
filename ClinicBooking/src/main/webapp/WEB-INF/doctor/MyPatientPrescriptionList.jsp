<%-- 
    Document   : MyPatientPrescriptionList
    Created on : 6 Nov. 2025, 5:19:35 pm
    Author     : Le Thien Tri - CE191249
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage My Patient Prescriptions</title>
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
            .badge {
                font-size: 0.85rem;
                padding: 6px 10px;
                border-radius: 8px;
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
                    <i class="fa-solid fa-prescription-bottle-medical me-2"></i>Manage My Patient Prescriptions
                </h3>
                <form class="d-flex" action="${pageContext.request.contextPath}/manage-my-patient-prescription" method="get">
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

            <!-- Prescription List -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fa-solid fa-list me-2"></i>Patient Prescription List
                </div>
                <div class="card-body p-4">
                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Patient Name</th>
                                <th>Date Created</th>
                                <th>Prescription Note</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prescription" items="${myPatientPrescriptionList}" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>
                                    <td>${prescription.appointmentID.patientID.firstName} ${prescription.appointmentID.patientID.lastName}</td>
                                    <td><fmt:formatDate value="${prescription.dateCreate}" pattern="yyyy/MM/dd HH:mm"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(prescription.note) > 20}">
                                                ${fn:substring(prescription.note, 0, 20)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${prescription.note}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="badge
                                              <c:choose>
                                                  <c:when test="${prescription.prescriptionStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                                  <c:otherwise>bg-success</c:otherwise>
                                              </c:choose>">
                                            ${prescription.prescriptionStatus}
                                        </span>
                                    </td>

                                    <td>
                                        <a href="${pageContext.request.contextPath}/manage-my-patient-prescription?action=detail&prescriptionID=${prescription.prescriptionID}"
                                           class="btn btn-sm btn-info text-white">
                                            <i class="fa-solid fa-eye"></i> View Detail
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty myPatientPrescriptionList}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No prescriptions found.
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
