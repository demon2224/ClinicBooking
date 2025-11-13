<%-- 
    Document   : ReceptionistAppointment
    Created on : Oct 11, 2025, 3:58:21 PM
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Appointment</title>
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
                    <i class="fa-solid fa-calendar-days me-2"></i>
                    Manage Appointment
                </h3>
                <form class="d-flex align-items-center" method="get" action="${pageContext.request.contextPath}/receptionist-manage-appointment">
                    <input class="form-control me-2" type="search" name="searchQuery"
                           placeholder="Search by patient or doctor..." value="${param.searchQuery}">
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

            <!-- Success Modal -->
            <div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content text-center border-0 shadow-lg">
                        <div class="modal-body p-5">
                            <i class="fa-solid fa-circle-check text-success fa-4x mb-3"></i>
                            <h4 class="mb-3 text-success fw-bold">Success!</h4>
                            <p class="text-secondary mb-4">${sessionScope.successMessage}</p>
                            <button type="button" class="btn btn-success px-4" data-bs-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${not empty sessionScope.successMessage}">
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const modal = new bootstrap.Modal(document.getElementById("successModal"));
                        modal.show();
                    });
                </script>
                <c:remove var="successMessage" scope="session"/>
            </c:if>

            <!-- Appointment List -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fa-solid fa-list me-2"></i>Appointment List
                    <a href="${pageContext.request.contextPath}/receptionist-manage-appointment?action=add"
                       class="btn btn-light btn-sm float-end text-primary fw-bold">
                        <i class="fa-solid fa-plus me-1"></i> Add
                    </a>
                </div>
                <div class="card-body p-4">
                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Doctor Name</th>
                                <th>Specialty</th>
                                <th>Patient Name</th>
                                <th>Created Date</th>
                                <th>Appointment Time</th>
                                <th>Symptom</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${appointmentList}" varStatus="loop">
                                <tr>
                                    <td>${loop.count}</td>
                                    <td>${a.doctorName}</td>
                                    <td>${a.specialtyName}</td>
                                    <td>${a.patientName}</td>
                                    <td><fmt:formatDate value="${a.dateCreate}" pattern="yyyy/MM/dd HH:mm"/></td>
                                    <td><fmt:formatDate value="${a.dateBegin}" pattern="yyyy/MM/dd HH:mm"/></td>
                                    <td>${a.note}</td>
                                    <td>
                                        <span class="badge
                                              <c:choose>
                                                  <c:when test="${a.statusName eq 'Pending'}">bg-warning text-dark</c:when>
                                                  <c:when test="${a.statusName eq 'Approved'}">bg-primary</c:when>
                                                  <c:when test="${a.statusName eq 'Completed'}">bg-success</c:when>
                                                  <c:when test="${a.statusName eq 'Canceled'}">bg-danger</c:when>
                                                  <c:otherwise>bg-secondary</c:otherwise>
                                              </c:choose>">
                                            ${a.statusName}
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex justify-content-center align-items-center gap-2">

                                            <a href="${pageContext.request.contextPath}/receptionist-manage-appointment?action=viewDetail&id=${a.appointmentID}"
                                               class="btn btn-sm btn-info text-white">
                                                <i class="fa-solid fa-eye"></i> View Detail
                                            </a>

  
                                            <c:choose>
                                                <c:when test="${a.statusName eq 'Pending' or a.statusName eq 'Approved'}">
                                                    <button type="button" class="btn btn-sm btn-success btn-approve"
                                                            data-id="${a.appointmentID}" data-bs-toggle="modal"
                                                            data-bs-target="#confirmModal">
                                                        <i class="fa-solid fa-check"></i> Update
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-sm btn-success invisible">
                                                        <i class="fa-solid fa-check"></i> Update
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>


                                            <c:choose>
                                                <c:when test="${a.statusName eq 'Pending' or a.statusName eq 'Approved'}">
                                                    <button type="button" class="btn btn-sm btn-danger btn-cancel"
                                                            data-id="${a.appointmentID}" data-bs-toggle="modal"
                                                            data-bs-target="#confirmModal">
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

                            <c:if test="${empty appointmentList}">
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No appointments found.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Confirm Modal -->
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-primary">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-triangle-exclamation me-2"></i>Confirm Action</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-center fs-5">
                        Are you sure you want to proceed with this action?
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary px-4" id="confirmActionBtn">Confirm</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                    document.addEventListener('DOMContentLoaded', () => {
                        const contextPath = '${pageContext.request.contextPath}';
                        let actionType = '', appointmentId = '';

                        document.querySelectorAll('.btn-approve').forEach(btn => {
                            btn.addEventListener('click', function () {
                                actionType = 'approve';
                                appointmentId = this.getAttribute('data-id');
                                document.querySelector('#confirmModal .modal-body').innerText = 'Approve this appointment?';
                            });
                        });

                        document.querySelectorAll('.btn-cancel').forEach(btn => {
                            btn.addEventListener('click', function () {
                                actionType = 'cancel';
                                appointmentId = this.getAttribute('data-id');
                                document.querySelector('#confirmModal .modal-body').innerText = 'Cancel this appointment?';
                            });
                        });

                        document.getElementById('confirmActionBtn').addEventListener('click', function () {
                            if (!actionType || !appointmentId)
                                return;

                            const form = document.createElement('form');
                            form.method = 'post';
                            form.action = contextPath + '/receptionist-manage-appointment';
                            form.style.display = 'none';

                            const inputAction = document.createElement('input');
                            inputAction.type = 'hidden';
                            inputAction.name = 'action';
                            inputAction.value = actionType;
                            form.appendChild(inputAction);

                            const inputId = document.createElement('input');
                            inputId.type = 'hidden';
                            inputId.name = 'appointmentId';
                            inputId.value = appointmentId;
                            form.appendChild(inputId);

                            document.body.appendChild(form);
                            form.submit();
                        });
                    });
        </script>
    </body>
</html>
