<%-- 
    Document   : CreateMyPatientMedicalRecord
    Created on : Nov 6, 2025
    Author     : Le Thien Tri - CE191249
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Medical Record</title>
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
                box-shadow: 0px 3px 6px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
            }
            .required::after {
                content: " *";
                color: red;
            }
            label {
                font-weight: 500;
            }
        </style>
    </head>

    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fa-solid fa-file-medical me-2"></i>Create Medical Record</h2>
            </div>

            <form action="${pageContext.request.contextPath}/manage-my-patient-medical-record?action=create&appointmentID=${appointment.appointmentID}" 
                  method="post" class="needs-validation" novalidate>

                <!-- Appointment Information -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-calendar-check me-2"></i>Appointment Information
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered mb-0">
                            <tr>
                                <th width="25%">Date Begin</th>
                                <td><fmt:formatDate value="${appointment.dateBegin}" pattern="yyyy/MM/dd HH:mm"/></td>
                            </tr>
                            <tr>
                                <th>Status</th>
                                <td>${appointment.appointmentStatus}</td>
                            </tr>
                            <tr>
                                <th>Appointment Note</th>
                                <td>${appointment.note}</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <!-- Patient Information -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-user me-2"></i>Patient Information
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered mb-0">
                            <tr><th width="25%">Name</th><td>${appointment.patientID.firstName} ${appointment.patientID.lastName}</td></tr>
                            <tr><th>Email</th><td>${appointment.patientID.email}</td></tr>
                            <tr><th>Phone</th><td>${appointment.patientID.phoneNumber}</td></tr>
                            <tr>
                                <th>Gender</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${appointment.patientID.gender}">Male</c:when>
                                        <c:otherwise>Female</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><th>Date of Birth</th><td><fmt:formatDate value="${appointment.patientID.dob}" pattern="yyyy/MM/dd"/></td></tr>
                            <tr><th>Address</th><td>${appointment.patientID.userAddress}</td></tr>
                        </table>
                    </div>
                </div>

                <!-- Medical Record Form -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-stethoscope me-2"></i>Medical Record Details
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label required">Symptoms</label>
                            <textarea name="symptoms" class="form-control" rows="3"
                                      placeholder="Enter symptoms..." required></textarea>
                            <div class="invalid-feedback">Please enter the symptoms.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label required">Diagnosis</label>
                            <textarea name="diagnosis" class="form-control" rows="3"
                                      placeholder="Enter diagnosis..." required></textarea>
                            <div class="invalid-feedback">Please enter the diagnosis.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label required">Doctor's Note</label>
                            <textarea name="note" class="form-control" rows="3"
                                      placeholder="Enter doctor's notes..." required></textarea>
                            <div class="invalid-feedback">Please enter the doctor’s note.</div>
                        </div>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-success me-2">
                        <i class="fa-solid fa-check"></i> Save Medical Record
                    </button>
                </div>

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
    </body>
</html>
