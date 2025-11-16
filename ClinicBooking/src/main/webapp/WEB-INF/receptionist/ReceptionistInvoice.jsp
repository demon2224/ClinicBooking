<%--
    Document   : ReceptionistInvoice
    Created on : Oct 18, 2025, 2:27:30 PM
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Invoice</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
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
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/receptionist-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/receptionist-manage-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="${pageContext.request.contextPath}/manage-invoice"><i class="fa-solid fa-file-invoice-dollar me-2"></i>Manage Invoice</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <nav class="navbar navbar-light justify-content-between px-3 py-2 border-bottom shadow-sm">
                <h3 class="fw-bold text-primary mb-0 d-flex align-items-center">
                    <i class="fa-solid fa-file-invoice-dollar me-2"></i>
                    Manage Invoice
                </h3>
                <form class="d-flex align-items-center" method="get" action="manage-invoice">
                    <input class="form-control me-2" type="search" name="searchQuery"
                           placeholder="Search by patient or doctor name..." value="${param.searchQuery}">
                    <button class="btn btn-outline-primary me-3 d-flex align-items-center" type="submit">
                        <i class="fa-solid fa-magnifying-glass me-2"></i>
                        <span>Search</span>
                    </button>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="btn btn-outline-danger d-flex align-items-center" id="Logout">
                        <i class="fa-solid fa-right-from-bracket me-2"></i>
                        <span>Logout</span>
                    </a>
                </form>
            </nav>

            <!-- Invoice List -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fa-solid fa-list me-2"></i>Invoice List
                </div>
                <div class="card-body p-4">
                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Patient Name</th>
                                <th>Doctor Name</th>
                                <th>Specialty</th>
                                <th>Date Created</th>
                                <th>Fee</th>
                                <th>Payment Method</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="inv" items="${invoices}" varStatus="loop">
                                <tr>
                                    <td>${loop.count}</td>
                                    <td>${inv.medicalRecordID.appointmentID.patientID.firstName} ${inv.medicalRecordID.appointmentID.patientID.lastName}</td>
                                    <td>${inv.medicalRecordID.appointmentID.doctorID.staffID.firstName} ${inv.medicalRecordID.appointmentID.doctorID.staffID.lastName}</td>
                                    <td>${inv.specialtyID.specialtyName}</td>
                                    <td><fmt:formatDate value="${inv.dateCreate}" pattern="yyyy/MM/dd HH:mm"/></td>
                                    <td><fmt:formatNumber value="${inv.specialtyID.price}" type="currency" currencySymbol="$"/></td>
                                    <td>${inv.paymentType}</td>
                                    <td>
                                        <span class="badge
                                              <c:choose>
                                                  <c:when test="${inv.invoiceStatus eq 'Paid'}">bg-success</c:when>
                                                  <c:when test="${inv.invoiceStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                                  <c:when test="${inv.invoiceStatus eq 'Canceled'}">bg-danger</c:when>
                                                  <c:otherwise>bg-secondary</c:otherwise>
                                              </c:choose>">
                                            ${inv.invoiceStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="manage-invoice?action=viewDetail&id=${inv.invoiceID}"
                                               class="btn btn-sm btn-info text-white">
                                                <i class="fa-solid fa-eye"></i> View
                                            </a>

                                            <c:choose>
                                                <c:when test="${inv.invoiceStatus eq 'Pending'}">
                                                    <a href="manage-invoice?action=update&id=${inv.invoiceID}"
                                                       class="btn btn-sm btn-success text-white">
                                                        <i class="fa-solid fa-check"></i> Update
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-sm btn-success invisible">
                                                        <i class="fa-solid fa-check"></i> Update
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>

                                            <c:choose>
                                                <c:when test="${inv.invoiceStatus eq 'Pending'}">
                                                    <!-- Open confirm modal; pass invoice id in data attribute -->
                                                    <button type="button"
                                                            class="btn btn-sm btn-danger text-white btn-open-cancel"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#confirmCancelModal"
                                                            data-invoiceid="${inv.invoiceID}">
                                                        <i class="fa-solid fa-xmark"></i> Cancel
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-sm btn-danger invisible">
                                                        <i class="fa-solid fa-xmark"></i> Cancel
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty invoices}">
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No invoices found.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Confirm Cancel Modal (uses POST form) -->
        <div class="modal fade" id="confirmCancelModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-danger">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>Confirm Cancel
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body text-center">
                        <p class="fs-5 mb-2">Are you sure you want to cancel this invoice?</p>
                        <p class="text-muted">
                            <i class="fa-solid fa-circle-info me-1"></i> This action cannot be undone.
                        </p>
                    </div>

                    <div class="modal-footer justify-content-center">
                        <!-- form posts to servlet; controller expects POST with action=cancel and invoiceId -->
                        <form id="cancelForm" action="${pageContext.request.contextPath}/manage-invoice" method="post" class="d-inline">
                            <input type="hidden" name="action" value="cancel"/>
                            <input type="hidden" name="invoiceId" id="cancelInvoiceId" value=""/>
                            <button type="submit" class="btn btn-danger px-4">
                                <i class="fa-solid fa-xmark me-1"></i> Cancel
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Success Modal -->
        <div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-success">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">
                            <i class="fa-solid fa-circle-check me-2"></i>Success
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-center fs-5">
                        ${sessionScope.successMessage}
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-success px-4" data-bs-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- JS (single block, no duplicates) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // When confirmCancelModal opens, read invoice id from opener button and set hidden input
                var confirmCancelModal = document.getElementById('confirmCancelModal');
                confirmCancelModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget; // Button that triggered the modal
                    var invoiceId = button.getAttribute('data-invoiceid');
                    document.getElementById('cancelInvoiceId').value = invoiceId || '';
                });

                // If server placed successMessage in session, show success modal once (then session removed on server side)
            <%-- Use JSTL to render script that triggers modal if message exists --%>
            });
        </script>

        <c:if test="${not empty sessionScope.successMessage}">
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var modal = new bootstrap.Modal(document.getElementById('successModal'));
                    modal.show();
                });
            </script>
            <!-- remove session attribute from server side view handling was in servlet (redirect), but if you need also to remove here: -->
            <c:remove var="successMessage" scope="session"/>
        </c:if>

    </body>
</html>