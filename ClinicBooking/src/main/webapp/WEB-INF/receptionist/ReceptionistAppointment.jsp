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
        <title>Receptionist Dashboard</title>
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
            #Logout {
                color: red;
                border-color: red;
            }
            #Logout:hover {
                background-color: red;
                color: white;
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

        <!-- Main content -->
        <div class="main-content">
            <nav class="navbar navbar-light">
                <div class="container-fluid">
                    <form class="d-flex w-50" method="get" action="${pageContext.request.contextPath}/receptionist-manage-appointment">
                        <input class="form-control me-2" type="search" name="searchQuery" placeholder="Search here" value="${param.searchQuery}">
                        <button class="btn btn-outline-primary" type="submit">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                    <div>
                        <button class="btn btn-submit" id="Logout" type="submit">Logout</button>
                    </div>
                </div>
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


            <div class="container-fluid mt-4">
                <!-- Appointment List -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Appointment List</h5>
                        <!-- Add Appointment button -->
                        <a href="${pageContext.request.contextPath}/receptionist-manage-appointment?action=add" class="btn btn-primary">
                            <i class="fa-solid fa-plus me-1"></i> Add
                        </a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle text-center">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Doctor Name</th>
                                    <th>Specialty</th>
                                    <th>Patient Name</th>
                                    <th>Appointment Time</th>
                                    <th>Symptom</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="a" items="${appointmentList}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${a.doctorName}</td>
                                        <td>${a.specialtyName}</td>
                                        <td>${a.patientName}</td>
                                        <td>
                                            <fmt:formatDate value="${a.dateBegin}" pattern="yyyy-MM-dd"/><br/>
                                            <fmt:formatDate value="${a.dateBegin}" pattern="HH:mm:ss"/>
                                        </td>
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

                                        <td class="text-center">
                                            <div class="d-flex justify-content-center gap-2">

                                                <!-- View button -->    
                                                <a href="${pageContext.request.contextPath}/receptionist-manage-appointment?action=viewDetail&id=${a.appointmentID}"
                                                   class="btn btn-sm btn-info text-white">
                                                    <i class="fa-solid fa-eye"></i> View Detail
                                                </a>

                                                <!-- Update button -->
                                                <button type="button"
                                                        class="btn btn-sm btn-success btn-approve"
                                                        data-id="${a.appointmentID}"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#confirmModal"
                                                        style="<c:if test='${a.statusName ne "Pending" and a.statusName ne "Approved"}'>visibility:hidden;</c:if>">
                                                            <i class="fa-solid fa-check"></i> Update
                                                        </button>

                                                        <!-- Cancel button -->
                                                        <button type="button"
                                                                class="btn btn-sm btn-danger btn-cancel"
                                                                data-id="${a.appointmentID}"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#confirmModal"
                                                        style="<c:if test='${!(a.statusName eq "Pending" || a.statusName eq "Approved")}'>visibility:hidden;</c:if>">
                                                            <i class="fa-solid fa-xmark"></i> Cancel
                                                        </button>
                                                </div>
                                            </td>
                                        </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>          
            </div>
        </div>

        <!-- Confirmation Modal -->
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirm Action</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to proceed?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" id="confirmActionBtn">Yes</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                    document.addEventListener('DOMContentLoaded', () => {
                        const contextPath = '${pageContext.request.contextPath}';
                        let actionType = '';
                        let appointmentId = '';

                        // Approve button
                        document.querySelectorAll('.btn-approve').forEach(btn => {
                            btn.addEventListener('click', function () {
                                actionType = 'approve';
                                appointmentId = this.getAttribute('data-id');
                                document.querySelector('#confirmModal .modal-body').innerText = 'Approve this appointment?';
                            });
                        });

                        // Cancel button
                        document.querySelectorAll('.btn-cancel').forEach(btn => {
                            btn.addEventListener('click', function () {
                                actionType = 'cancel';
                                appointmentId = this.getAttribute('data-id');
                                document.querySelector('#confirmModal .modal-body').innerText = 'Cancel this appointment?';
                            });
                        });

                        // Confirm modal Yes button
                        document.getElementById('confirmActionBtn').addEventListener('click', function () {
                            if (!actionType || !appointmentId)
                                return;

                            // Close modal
                            const modalEl = document.getElementById('confirmModal');
                            const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                            modal.hide();

                            // Create dynamic POST form
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

