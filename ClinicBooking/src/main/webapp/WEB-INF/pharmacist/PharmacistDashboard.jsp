<%--
    Document   : PharmacistDashboard
    Created on : Oct 10, 2025, 1:47:38 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Pharmacist Dashboard</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assests/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assests/css/all.min.css" />

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
                padding: 12px 20px;
                color: white;
                text-decoration: none;
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
            }

            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
                font-size: 1.1rem;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
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

        <%@ include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="main-content">

            <nav class="navbar navbar-light shadow-sm mb-4 d-flex justify-content-between">
                <h3 class="fw-bold text-primary d-flex align-items-center mb-0">
                    <i class="fa-solid fa-gauge me-2"></i>Pharmacist Dashboard
                </h3>

                <a href="${pageContext.request.contextPath}/staff-logout"
                   class="btn btn-outline-danger d-flex align-items-center" id="Logout">
                    <i class="fa-solid fa-right-from-bracket me-2"></i>Logout
                </a>
            </nav>

            <div class="row g-4 mb-4">

                <div class="col-md-3">
                    <div class="card text-center py-4">
                        <div class="text-primary fs-1"><i class="fa-solid fa-capsules"></i></div>
                        <h3 class="fw-bold text-primary mb-0"><c:out value="${totalMedicine}"/></h3>
                        <div class="text-muted">Total Medicines</div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-center py-4">
                        <div class="text-warning fs-1"><i class="fa-solid fa-triangle-exclamation"></i></div>
                        <h3 class="fw-bold text-warning mb-0"><c:out value="${lowStock}"/></h3>
                        <div class="text-muted">Low Stock</div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-center py-4">
                        <div class="text-danger fs-1"><i class="fa-solid fa-prescription-bottle-medical"></i></div>
                        <h3 class="fw-bold text-danger mb-0"><c:out value="${numberPendingPrecription}"/></h3>
                        <div class="text-muted">Pending Prescriptions</div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-center py-4">
                        <div class="text-success fs-1"><i class="fa-solid fa-circle-check"></i></div>
                        <h3 class="fw-bold text-success mb-0"><c:out value="${numberDeliverPrecriptionToday}"/></h3>
                        <div class="text-muted">Delivered Today</div>
                    </div>
                </div>

            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>Low Stock Medicines
                </div>

                <div class="card-body p-4">

                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Type</th>
                                <th>Name</th>
                                <th>Code</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:if test="${empty lowStockMedicneList}">
                                <tr>
                                    <td colspan="5" class="text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No low-stock medicines.
                                    </td>
                                </tr>
                            </c:if>

                            <c:forEach var="m" items="${lowStockMedicneList}" varStatus="i">
                                <tr>
                                    <td><c:out value="${i.count}"/></td>
                                    <td><c:out value="${m.medicineType}"/></td>
                                    <td><c:out value="${m.medicineName}"/></td>
                                    <td><c:out value="${m.medicineCode}"/></td>
                                    <td><c:out value="${m.quantity}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <i class="fa-solid fa-prescription-bottle-medical me-2"></i>Pending Prescriptions
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

                            <c:if test="${empty pendingPrecriptionList}">
                                <tr>
                                    <td colspan="6" class="text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No pending prescriptions.
                                    </td>
                                </tr>
                            </c:if>

                            <c:forEach var="p" items="${pendingPrecriptionList}" varStatus="i">

                                <tr>
                                    <td><c:out value="${i.count}"/></td>

                                    <td><c:out value="${p.appointmentID.doctorID.staffID.fullName}"/></td>
                                    <td><c:out value="${p.appointmentID.patientID.fullName}"/></td>

                                    <td>
                                        <span class="badge bg-warning text-dark">Pending</span>
                                    </td>

                                    <td><c:out value="${p.dateCreateFormatDate}"/></td>

                                    <td>
                                        <div class="d-flex justify-content-center gap-2">

                                            <a href="${pageContext.request.contextPath}/pharmacist-manage-prescription?action=detail&prescriptionID=${p.prescriptionID}"
                                               class="btn btn-info btn-sm text-white">
                                                <i class="fa-solid fa-eye"></i> View
                                            </a>

                                            <button class="btn btn-success btn-sm"
                                                    data-bs-toggle="modal" data-bs-target="#deliverModal"
                                                    onclick="setDeliverID('${p.prescriptionID}')">
                                                <i class="fa-solid fa-truck"></i> Deliver
                                            </button>

                                            <button class="btn btn-danger btn-sm"
                                                    data-bs-toggle="modal" data-bs-target="#cancelModal"
                                                    onclick="setCancelID('${p.prescriptionID}')">
                                                <i class="fa-solid fa-ban"></i> Cancel
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

        <div class="modal fade" id="deliverModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-success">

                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-truck me-2"></i>Confirm Deliver</h5>
                        <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body text-center fs-5">
                        Are you sure you want to <b>Deliver</b> this prescription?
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/pharmacist-manage-prescription">
                        <input type="hidden" name="action" value="deliver">
                        <input type="hidden" name="prescriptionID" id="deliverID">

                        <div class="modal-footer justify-content-center">
                            <button class="btn btn-success px-4">Confirm</button>
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
                        <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body text-center fs-5">
                        Are you sure you want to <b>Cancel</b> this prescription?
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/pharmacist-manage-prescription">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="prescriptionID" id="cancelID">

                        <div class="modal-footer justify-content-center">
                            <button class="btn btn-danger px-4">Confirm</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <div class="modal fade" id="loginSuccessModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Login Successful</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body text-center">
                        <c:out value="${sessionScope.loginSuccessMsg}" />
                    </div>

                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-success" data-bs-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>


        <c:if test="${not empty sessionScope.loginSuccessMsg}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var modal = new bootstrap.Modal(document.getElementById('loginSuccessModal'));
                    modal.show();
                });
            </script>

            <c:remove var="loginSuccessMsg" scope="session" />
        </c:if>


        <script>
            function setDeliverID(id) {
                document.getElementById("deliverID").value = id;
            }
            function setCancelID(id) {
                document.getElementById("cancelID").value = id;
            }
        </script>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>

    </body>
</html>

