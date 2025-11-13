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
            <nav class="navbar navbar-light justify-content-between px-3 py-2 border-bottom shadow-sm">
                <h3 class="fw-bold text-primary mb-0 d-flex align-items-center">
                    <i class="fa-solid fa-prescription-bottle-medical me-2"></i>
                    Manage My Patient Prescriptions
                </h3>
                <form class="d-flex align-items-center"
                      action="${pageContext.request.contextPath}/manage-my-patient-prescription" method="get">
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
                                        <c:choose>
                                            <c:when test="${prescription.prescriptionStatus eq 'Pending' and prescription.hidden eq false}">
                                                <a href="${pageContext.request.contextPath}/manage-my-patient-prescription?action=edit&prescriptionID=${prescription.prescriptionID}"
                                                   class="btn btn-sm btn-warning text-white">
                                                    <i class="fa-solid fa-wrench"></i> Edit
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn btn-sm btn-secondary text-white disabled" tabindex="-1" aria-disabled="true">
                                                    <i class="fa-solid fa-wrench"></i> Edit
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${prescription.prescriptionStatus eq 'Pending'}">
                                            <c:choose>
                                                <c:when test="${prescription.hidden eq false}">
                                                    <button type="button"
                                                            class="btn btn-sm btn-danger text-white user-select-none"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#confirmDeleteModal"
                                                            data-href="${pageContext.request.contextPath}/manage-my-patient-prescription?action=delete&prescriptionID=${prescription.prescriptionID}">
                                                        <i class="fa-solid fa-trash"></i> Delete
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button"
                                                            class="btn btn-sm btn-success text-white user-select-none"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#confirmRestoreModal"
                                                            data-href="${pageContext.request.contextPath}/manage-my-patient-prescription?action=delete&prescriptionID=${prescription.prescriptionID}">
                                                        <i class="fa-solid fa-rotate-left"></i> Restore
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                        <c:if test="${prescription.prescriptionStatus eq 'Delivered'}">
                                            <button type="button" class="btn btn-sm btn-secondary text-white disabled" tabindex="-1" aria-disabled="true">
                                                <i class="fa-solid fa-trash"></i> Delete
                                            </button>
                                        </c:if>
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
        <!-- Bootstrap Success Modal -->
        <div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-circle-check me-2"></i>Success</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ${sessionScope.message}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
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
                        ${sessionScope.error}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Bootstrap Confirm Delete Modal -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-danger">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title"><i class="fa-solid fa-triangle-exclamation me-2"></i>Confirm Deletion</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <p class="mb-3 fs-5">Are you sure you want to delete this prescription?</p>
                    <p class="text-muted"><i class="fa-solid fa-circle-info me-2"></i>This action cannot be undone.</p>
                </div>
                <div class="modal-footer justify-content-center">
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger px-4">
                        <i class="fa-solid fa-trash me-1"></i> Delete
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Bootstrap Confirm Restore Modal -->
    <div class="modal fade" id="confirmRestoreModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-warning">
                <div class="modal-header bg-warning text-white">
                    <h5 class="modal-title"><i class="fa-solid fa-triangle-exclamation me-2"></i>Confirm Restore</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <p class="mb-3 fs-5">Are you sure you want to restore this prescription?</p>
                </div>
                <div class="modal-footer justify-content-center">
                    <a href="#" id="confirmRestoreBtn" class="btn btn-danger px-4">
                        <i class="fa-solid fa-trash me-1"></i> Restore
                    </a>
                </div>
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
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var confirmModal = document.getElementById('confirmDeleteModal');
            var confirmButton = document.getElementById('confirmDeleteBtn');

            confirmModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var href = button.getAttribute('data-href');
                confirmButton.setAttribute('href', href);
            });
        });
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var confirmModal = document.getElementById('confirmRestoreModal');
            var confirmButton = document.getElementById('confirmRestoreBtn');

            confirmModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var href = button.getAttribute('data-href');
                confirmButton.setAttribute('href', href);
            });
        });
    </script>
    <c:if test="${not empty sessionScope.message}">
        <script>
            window.onload = function () {
                var myModal = new bootstrap.Modal(document.getElementById('successModal'));
                successModal.show();
            };
        </script>
        <c:remove var="message" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <script>
            window.onload = function () {
                var myModal = new bootstrap.Modal(document.getElementById('errorModal'));
                myModal.show();
            };
        </script>
        <c:remove var="error" scope="session" />
    </c:if>
</body>
</html>
