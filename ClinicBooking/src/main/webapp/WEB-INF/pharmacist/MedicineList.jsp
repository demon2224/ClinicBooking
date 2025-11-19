<%--
    Document   : medicine
    Created on : Oct 10, 2025, 3:41:23 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Pharmacist - Medicine Management</title>
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
                padding: 12px 20px;
                text-decoration: none;
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

            .table th {
                background-color: #f1f3f5;
                font-weight: 600;
            }

            .badge {
                font-size: 0.85rem;
                padding: 6px 10px;
                border-radius: 8px;
            }
        </style>
    </head>

    <body>

        <%@include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="main-content">

            <nav class="navbar navbar-light justify-content-between shadow-sm">
                <h3 class="fw-bold text-primary mb-0 d-flex align-items-center">
                    <i class="fa-solid fa-capsules me-2"></i> Medicine Management
                </h3>

                <form class="d-flex" method="get" action="${pageContext.request.contextPath}/manage-medicine">
                    <input type="hidden" name="action" value="search">
                    <input class="form-control me-2" type="search" name="search" placeholder="Search medicine...">
                    <button class="btn btn-outline-primary" type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/staff-logout"
                   class="btn btn-outline-danger d-flex align-items-center" id="Logout">
                    <i class="fa-solid fa-right-from-bracket me-2"></i> Logout
                </a>
            </nav>

            <div class="card mt-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span><i class="fa-solid fa-list me-2"></i>Medicine List</span>
                    <a href="${pageContext.request.contextPath}/manage-medicine?action=create"
                       class="btn btn-success">
                        <i class="fa-solid fa-plus me-1"></i> Add New
                    </a>
                </div>

                <div class="card-body p-4">
                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Type</th>
                                <th>Status</th>
                                <th>Name</th>
                                <th>Code</th>
                                <th>Quantity</th>
                                <th>Price ($)</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:if test="${empty requestScope.medicineList}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No medicine found.
                                    </td>
                                </tr>
                            </c:if>

                            <c:forEach var="med" items="${requestScope.medicineList}" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>

                                    <td>${med.medicineType}</td>

                                    <td>
                                        <span class="badge
                                              ${(med.medicineStatus and med.quantity gt 0) ? 'bg-success' : 'bg-danger'}">
                                            ${(med.medicineStatus and med.quantity gt 0) ? 'Available' : 'Unavailable'}
                                        </span>
                                    </td>

                                    <td>${med.medicineName}</td>
                                    <td>${med.medicineCode}</td>
                                    <td>${med.quantity}</td>

                                    <td><fmt:formatNumber value="${med.price}" type="currency" currencySymbol="$"/></td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${med.isHidden}">
                                                <div class="d-flex flex-wrap justify-content-center gap-2">

                                                    <!-- 3 nút mờ -->
                                                    <button class="btn btn-sm btn-secondary" disabled style="opacity:0.5; min-width:90px;">
                                                        <i class="fa-solid fa-eye"></i> View
                                                    </button>

                                                    <button class="btn btn-sm btn-secondary" disabled style="opacity:0.5; min-width:90px;">
                                                        <i class="fa-solid fa-truck-ramp-box"></i> Import
                                                    </button>

                                                    <button class="btn btn-sm btn-secondary" disabled style="opacity:0.5; min-width:90px;">
                                                        <i class="fa-solid fa-pen-to-square"></i> Edit
                                                    </button>

                                                    <!-- Nút Restore -->
                                                    <button type="button" class="btn btn-sm btn-success fw-bold" style="min-width:90px;"
                                                            data-bs-toggle="modal" data-bs-target="#restoreModal${med.medicineID}">
                                                        <i class="fa-solid fa-rotate-left"></i> Restore
                                                    </button>

                                                    <!-- Modal confirm Restore -->
                                                    <div class="modal fade" id="restoreModal${med.medicineID}" tabindex="-1">
                                                        <div class="modal-dialog modal-dialog-centered">
                                                            <div class="modal-content border-success">
                                                                <div class="modal-header bg-success text-white">
                                                                    <h5 class="modal-title">
                                                                        <i class="fa-solid fa-rotate-left me-2"></i>Confirm Restore
                                                                    </h5>
                                                                    <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                                </div>
                                                                <div class="modal-body text-center">
                                                                    Are you sure you want to restore this medicine?
                                                                </div>
                                                                <div class="modal-footer justify-content-center">
                                                                    <form method="post" action="${pageContext.request.contextPath}/manage-medicine">
                                                                        <input type="hidden" name="action" value="restore">
                                                                        <input type="hidden" name="medicineID" value="${med.medicineID}">
                                                                        <button type="submit" class="btn btn-success px-4">
                                                                            <i class="fa-solid fa-rotate-left me-1"></i> Restore
                                                                        </button>
                                                                    </form>
                                                                    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                                                                        Cancel
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </c:when>

                                            <c:otherwise>
                                                <div class="d-flex flex-wrap justify-content-center gap-2">

                                                    <a class="btn btn-sm btn-info text-white" href="${pageContext.request.contextPath}/manage-medicine?action=detail&medicineID=${med.medicineID}" style="min-width:90px;">
                                                        <i class="fa-solid fa-eye"></i> View
                                                    </a>

                                                    <a class="btn btn-sm btn-warning text-white" href="${pageContext.request.contextPath}/manage-medicine?action=import&medicineID=${med.medicineID}" style="min-width:90px;">
                                                        <i class="fa-solid fa-truck-ramp-box"></i> Import
                                                    </a>

                                                    <a class="btn btn-sm btn-primary text-white" href="${pageContext.request.contextPath}/manage-medicine?action=edit&medicineID=${med.medicineID}" style="min-width:90px;">
                                                        <i class="fa-solid fa-pen-to-square"></i> Edit
                                                    </a>

                                                    <!-- Nút Delete -->
                                                    <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal${med.medicineID}" style="min-width:90px;">
                                                        <i class="fa-solid fa-trash"></i> Delete
                                                    </button>

                                                    <!-- Modal confirm Delete -->
                                                    <div class="modal fade" id="deleteModal${med.medicineID}" tabindex="-1">
                                                        <div class="modal-dialog modal-dialog-centered">
                                                            <div class="modal-content border-danger">
                                                                <div class="modal-header bg-danger text-white">
                                                                    <h5 class="modal-title">
                                                                        <i class="fa-solid fa-triangle-exclamation me-2"></i>Confirm Delete
                                                                    </h5>
                                                                    <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                                </div>
                                                                <div class="modal-body text-center">
                                                                    Are you sure you want to delete this medicine?
                                                                </div>
                                                                <div class="modal-footer justify-content-center">
                                                                    <form method="post" action="${pageContext.request.contextPath}/manage-medicine">
                                                                        <input type="hidden" name="action" value="delete">
                                                                        <input type="hidden" name="medicineID" value="${med.medicineID}">
                                                                        <button type="submit" class="btn btn-danger px-4">
                                                                            <i class="fa-solid fa-trash me-1"></i> Delete
                                                                        </button>
                                                                    </form>
                                                                    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                                                                        Cancel
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="modal fade" id="successModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow">

                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Success</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body fs-5 text-center">
                        <c:choose>
                            <c:when test="${not empty sessionScope.medicineEditSuccessMsg}">
                                ${sessionScope.medicineEditSuccessMsg}
                            </c:when>

                            <c:when test="${not empty sessionScope.medicineImportSuccessMsg}">
                                ${sessionScope.medicineImportSuccessMsg}
                            </c:when>

                            <c:when test="${not empty sessionScope.medicineDeleteSuccessMsg}">
                                ${sessionScope.medicineDeleteSuccessMsg}
                            </c:when>

                            <c:when test="${not empty sessionScope.medicineRestoreSuccessMsg}">
                                ${sessionScope.medicineRestoreSuccessMsg}
                            </c:when>
                        </c:choose>
                    </div>

                    <div class="modal-footer justify-content-center">
                        <button class="btn btn-outline-success px-4" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${not empty sessionScope.medicineEditSuccessMsg
                      or not empty sessionScope.medicineImportSuccessMsg
                      or not empty sessionScope.medicineDeleteSuccessMsg
                      or not empty sessionScope.medicineRestoreSuccessMsg}">
              <script>
                  window.onload = function () {
                      var modal = new bootstrap.Modal(document.getElementById('successModal'));
                      modal.show();
                  }
              </script>

              <c:remove var="medicineEditSuccessMsg" scope="session" />
              <c:remove var="medicineImportSuccessMsg" scope="session" />
              <c:remove var="medicineDeleteSuccessMsg" scope="session" />
              <c:remove var="medicineRestoreSuccessMsg" scope="session" />
        </c:if>


        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
