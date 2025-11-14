<%--
    Document   : AdminManageAccountList
    Created on : Nov 6, 2025, 7:07:00 PM
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Manage Account</title>
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
            .badge-role {
                font-size: 0.85rem;
                padding: 6px 10px;
                border-radius: 8px;
            }
            .badge-doctor {
                background-color: #007bff;
            }
            .badge-pharmacist {
                background-color: #20c997;
            }
            .badge-admin {
                background-color: #ffc107;
                color: black;
            }
            .badge-receptionist {
                background-color: #6f42c1;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@include file="../includes/AdminDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">
            <nav class="navbar navbar-light justify-content-between px-3 py-2 border-bottom shadow-sm">
                <h3 class="fw-bold text-primary mb-0 d-flex align-items-center">
                    <i class="fa-solid fa-users me-2"></i>
                    Manage Accounts
                </h3>
                <form class="d-flex align-items-center" method="get" action="${pageContext.request.contextPath}/admin-manage-account">
                    <input class="form-control me-2" type="text" name="searchQuery" placeholder="Search by username or name..." value="${param.searchQuery}">
                    <button class="btn btn-outline-primary me-3 d-flex align-items-center" type="submit">
                        <i class="fa-solid fa-magnifying-glass me-2"></i>Search
                    </button>
                    <a href="${pageContext.request.contextPath}/staff-logout"
                       class="btn btn-outline-danger d-flex align-items-center" id="Logout">
                        <i class="fa-solid fa-right-from-bracket me-2"></i>Logout
                    </a>
                </form>
            </nav>

            <!-- Account List -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fa-solid fa-list me-2"></i>Account List
                    <a href="${pageContext.request.contextPath}/admin-manage-account?action=add"
                       class="btn btn-success btn-sm float-end fw-bold text-white">
                        <i class="fa-solid fa-plus me-1"></i> Add
                    </a>
                </div>

                <div class="card-body p-4">
                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Role</th>
                                <th>Phone</th>
                                <th>Date Created</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${staffList}" varStatus="loop">
                                <tr>
                                    <td>${loop.count}</td>
                                    <td>${s.accountName}</td>
                                    <td>${s.firstName} ${s.lastName}</td>
                                    <td>
                                        <span class="badge
                                              <c:choose>
                                                  <c:when test="${s.role eq 'Doctor'}">badge-doctor</c:when>
                                                  <c:when test="${s.role eq 'Pharmacist'}">badge-pharmacist</c:when>
                                                  <c:when test="${s.role eq 'Admin'}">badge-admin</c:when>
                                                  <c:when test="${s.role eq 'Receptionist'}">badge-receptionist</c:when>
                                                  <c:otherwise>bg-secondary</c:otherwise>
                                              </c:choose>">
                                            ${s.role}
                                        </span>
                                    </td>

                                    <td>${s.phoneNumber}</td>
                                    <td><fmt:formatDate value="${s.daycreated}" pattern="yyyy/MM/dd"/></td>
                                    <td>
                                        <span class="badge ${s.hidden ? 'bg-danger' : 'bg-success'}">
                                            ${s.hidden ? 'Inactive' : 'Active'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="admin-manage-account?action=view&id=${s.staffID}" class="btn btn-sm btn-info text-white">
                                                <i class="fa-solid fa-eye"></i> View Detai
                                            </a>
                                            <a href="admin-manage-account?action=edit&id=${s.staffID}" class="btn btn-sm btn-warning text-white">
                                                <i class="fa-solid fa-pen"></i> Edit
                                            </a>
                                            <button type="button" class="btn btn-sm btn-danger text-white"
                                                    data-bs-toggle="modal" data-bs-target="#confirmDeleteModal"
                                                    data-id="${s.staffID}">
                                                <i class="fa-solid fa-trash"></i> Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty staffList}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No accounts found.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Confirm Delete Modal -->
        <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-danger">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>Confirm Delete
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body text-center">
                        <p class="fs-5 mb-2">Are you sure you want to delete this account?</p>
                        <p class="text-muted">
                            <i class="fa-solid fa-circle-info me-1"></i> This action cannot be undone.
                        </p>
                    </div>

                    <div class="modal-footer justify-content-center">
                        <form id="deleteForm" action="${pageContext.request.contextPath}/admin-manage-account" method="post" class="d-inline">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="staffID" id="deleteStaffID"/>
                            <button type="submit" class="btn btn-danger px-4">
                                <i class="fa-solid fa-trash me-1"></i> Delete
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


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // When Delete Modal opens – set staffID
                var deleteModal = document.getElementById('confirmDeleteModal');
                deleteModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;
                    var staffID = button.getAttribute('data-id');
                    document.getElementById('deleteStaffID').value = staffID || '';
                });
            });
        </script>
        <c:if test="${not empty sessionScope.successMessage}">
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var modal = new bootstrap.Modal(document.getElementById('successModal'));
                    modal.show();
                });
            </script>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

    </body>
</html>



