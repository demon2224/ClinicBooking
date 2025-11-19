<%--
    Document   : PrescriptionList
    Created on : Nov 5, 2025, 8:35:37 AM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Pharmacist - Prescription List</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assests/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assests/css/all.min.css"/>

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
            #Logout {
                color: red;
                border-color: red;
            }
            #Logout:hover {
                background-color: red;
                color: white;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
                font-size: 1.1rem;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
            }
            .badge {
                font-size: 0.85rem;
                padding: 6px 10px;
                border-radius: 8px;
            }
            .table th {
                background-color: #f1f3f5;
                font-weight: 600;
            }
        </style>
    </head>
    <body>

        <%@include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="modal fade" id="notificationModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="notificationTitle">Notification</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center fs-5" id="notificationMessage"></div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-primary px-4" data-bs-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="main-content">
            <nav class="navbar navbar-light shadow-sm">
                <h3 class="fw-bold text-primary d-flex align-items-center mb-0">
                    <i class="fa-solid fa-prescription-bottle-medical me-2"></i>
                    Prescription Management
                </h3>

                <form class="d-flex w-50" method="get" action="${pageContext.request.contextPath}/pharmacist-manage-prescription">
                    <input type="hidden" name="action" value="search">
                    <input class="form-control me-2" type="search" name="search" placeholder="Search here..." value="${param.search}">
                    <button class="btn btn-outline-primary" type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/staff-logout" class="btn btn-outline-danger d-flex align-items-center" id="Logout">
                    <i class="fa-solid fa-right-from-bracket me-2"></i> Logout
                </a>
            </nav>

            <div class="card mt-4">
                <div class="card-header">
                    <i class="fa-solid fa-list me-2"></i> Prescription List
                </div>

                <div class="card-body p-4">
                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Doctor</th>
                                <th>Patient</th>
                                <th>Status</th>
                                <th>Date Created</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:if test="${empty prescriptionList}">
                                <tr>
                                    <td colspan="6" class="text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No prescription found.
                                    </td>
                                </tr>
                            </c:if>

                            <c:forEach var="prescription" items="${prescriptionList}" varStatus="item">
                                <tr>
                                    <td><c:out value="${item.count}"/></td>
                                    <td><c:out value="${prescription.appointmentID.doctorID.staffID.fullName}"/></td>
                                    <td><c:out value="${prescription.appointmentID.patientID.fullName}"/></td>

                                    <td>
                                        <span class="badge
                                              <c:choose>
                                                  <c:when test="${prescription.prescriptionStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                                  <c:when test="${prescription.prescriptionStatus eq 'Delivered'}">bg-success text-white</c:when>
                                                  <c:otherwise>bg-danger text-white</c:otherwise>
                                              </c:choose>">
                                            <c:out value="${prescription.prescriptionStatus}"/>
                                        </span>
                                    </td>

                                    <td><c:out value="${prescription.dateCreateFormatDate}"/></td>

                                    <td>
                                        <div class="d-flex justify-content-center align-items-center gap-2">
                                            <a href="${pageContext.request.contextPath}/pharmacist-manage-prescription?action=detail&prescriptionID=${prescription.prescriptionID}"
                                               class="btn btn-info text-white btn-sm action-btn">
                                                <i class="fa-solid fa-eye"></i> View
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="modal fade" id="deliverModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-success">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-truck me-2"></i>Confirm Deliver</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center fs-5">
                        Are you sure you want to <b>Deliver</b> this prescription?
                    </div>
                    <form method="post" action="${pageContext.request.contextPath}/pharmacist-manage-prescription">
                        <input type="hidden" name="action" value="deliver">
                        <input type="hidden" id="deliverID" name="prescriptionID">
                        <div class="modal-footer justify-content-center">
                            <button type="submit" class="btn btn-success px-4">Confirm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="cancelModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-danger">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-ban me-2"></i>Confirm Cancel</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center fs-5">
                        Are you sure you want to <b>Cancel</b> this prescription?
                    </div>
                    <form method="post" action="${pageContext.request.contextPath}/pharmacist-manage-prescription">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" id="cancelID" name="prescriptionID">
                        <div class="modal-footer justify-content-center">
                            <button type="submit" class="btn btn-danger px-4">Confirm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>

        <script>
                                                                function setDeliverID(id) {
                                                                    document.getElementById("deliverID").value = id;
                                                                }
                                                                function setCancelID(id) {
                                                                    document.getElementById("cancelID").value = id;
                                                                }

                                                                function showNotification(type, message) {
                                                                    var titleEl = document.getElementById("notificationTitle");
                                                                    var messageEl = document.getElementById("notificationMessage");
                                                                    var headerEl = document.querySelector('#notificationModal .modal-header');

                                                                    messageEl.innerText = message;
                                                                    if (type === 'success') {
                                                                        titleEl.innerText = 'Success';
                                                                        headerEl.className = 'modal-header bg-success text-white';
                                                                        document.querySelector('#notificationModal .btn').className = 'btn btn-success px-4';
                                                                    } else if (type === 'error') {
                                                                        titleEl.innerText = 'Error';
                                                                        headerEl.className = 'modal-header bg-danger text-white';
                                                                        document.querySelector('#notificationModal .btn').className = 'btn btn-danger px-4';
                                                                    } else {
                                                                        titleEl.innerText = 'Notification';
                                                                        headerEl.className = 'modal-header bg-primary text-white';
                                                                        document.querySelector('#notificationModal .btn').className = 'btn btn-primary px-4';
                                                                    }

                                                                    var modal = new bootstrap.Modal(document.getElementById('notificationModal'));
                                                                    modal.show();
                                                                }

        </script>

        <c:if test="${not empty sessionScope.successMsg}">
            <script>showNotification('success', '${sessionScope.successMsg}');</script>
            <c:remove var="successMsg" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.errorMsg}">
            <script>showNotification('error', '${sessionScope.errorMsg}');</script>
            <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <c:if test="${not empty requestScope.errorMsg}">
            <script>showNotification('error', '${requestScope.errorMsg}');</script>
        </c:if>

    </body>
</html>

