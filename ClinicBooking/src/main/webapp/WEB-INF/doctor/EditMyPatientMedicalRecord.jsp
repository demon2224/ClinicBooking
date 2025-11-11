<%-- 
    Document   : EditMyPatientMedicalRecord
    Created on : 12 Nov. 2025, 4:07:46 am
    Author     : Le Thien Tri - CE191249
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Medical Record Detail</title>
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
            .wrap-text {
                width: 300px;
                word-wrap: break-word;
                overflow-wrap: break-word;
                white-space: normal !important;
                line-break: anywhere;
            }
        </style>
    </head>

    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-primary">
                    <i class="fa-solid fa-file-medical me-2"></i>Medical Record Detail
                </h2>
            </div>

            <!-- Appointment Information -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-calendar-check me-2"></i>Appointment Information
                </div>
                <div class="card-body p-4">
                    <table class="table table-bordered mb-0">
                        <tr>
                            <th>Date Begin</th>
                            <td><fmt:formatDate value="${detail.appointmentID.dateBegin}" pattern="yyyy/MM/dd HH:mm" /></td>
                        </tr>
                        <tr>
                            <th>Date End</th>
                            <td>
                                <c:choose>
                                    <c:when test="${detail.appointmentID.appointmentStatus == 'Completed'}">
                                        <fmt:formatDate value="${detail.appointmentID.dateEnd}" pattern="yyyy/MM/dd HH:mm"/>
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
                                          <c:when test="${detail.appointmentID.appointmentStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                          <c:when test="${detail.appointmentID.appointmentStatus eq 'Approved'}">bg-primary</c:when>
                                          <c:when test="${detail.appointmentID.appointmentStatus eq 'Completed'}">bg-success</c:when>
                                          <c:when test="${detail.appointmentID.appointmentStatus eq 'Canceled'}">bg-danger</c:when>
                                          <c:otherwise>bg-secondary</c:otherwise>
                                      </c:choose>">
                                    ${detail.appointmentID.appointmentStatus}
                                </span>
                            </td>
                        </tr>
                        <tr><th>Appointment Note</th><td>${detail.appointmentID.note}</td></tr>
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
                        <tr><th>Patient Name</th><td>${detail.appointmentID.patientID.firstName} ${detail.appointmentID.patientID.lastName}</td></tr>
                        <tr><th>Email</th><td>${detail.appointmentID.patientID.email}</td></tr>
                        <tr><th>Phone</th><td>${detail.appointmentID.patientID.phoneNumber}</td></tr>
                        <tr>
                            <th>Gender</th>
                            <td>
                                <c:choose>
                                    <c:when test="${detail.appointmentID.patientID.gender}">Male</c:when>
                                    <c:otherwise>Female</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr><th>Date of Birth</th><td><fmt:formatDate value="${detail.appointmentID.patientID.dob}" pattern="yyyy/MM/dd" /></td></tr>
                        <tr><th>Address</th><td>${detail.appointmentID.patientID.userAddress}</td></tr>
                    </table>
                </div>
            </div>

            <!-- Medical Record Information -->
            <form action="${pageContext.request.contextPath}/manage-my-patient-medical-record?action=edit&medicalRecordID=${detail.medicalRecordID}" 
                  method="post" class="needs-validation" novalidate>

                <!-- Medical Record edit Form -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-stethoscope me-2"></i>Medical Record
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label required">Symptoms</label>
                            <textarea name="symptoms" class="form-control" rows="3"
                                      placeholder="Enter symptoms..." required>${detail.symptoms}</textarea>                         

                        </div>

                        <div class="mb-3">
                            <label class="form-label required">Diagnosis</label>
                            <textarea name="diagnosis" class="form-control" rows="3"
                                      placeholder="Enter diagnosis..." required>${detail.diagnosis}</textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label required">Doctor's Note</label>
                            <textarea name="note" class="form-control" rows="3"
                                      placeholder="Enter doctor's notes..." required>${detail.note}</textarea>
                        </div>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-success me-2">
                        <i class="fa-solid fa-check"></i> Save
                    </button>
                </div>
            </form>
            <!-- Bootstrap Error Modal -->
            <div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title"><i class="fa-solid fa-circle-exclamation me-2"></i>Error</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            ${error}
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <c:if test="${not empty error}">
            <script>
                window.onload = function () {
                    var myModal = new bootstrap.Modal(document.getElementById('errorModal'));
                    myModal.show();
                };
            </script>
        </c:if>
    </div>
</body>
</html>
