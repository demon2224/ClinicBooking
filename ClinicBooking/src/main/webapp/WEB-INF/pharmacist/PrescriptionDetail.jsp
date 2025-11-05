<%-- 
    Document   : PrescriptionDetail
    Created on : Nov 5, 2025, 10:11:23 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Doctor Dashboard</title>
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

            #Logout{
                color: red;
                border-color: red;

            }
            #Logout:hover{
                background-color: red;
                color: white;
            }
        </style>
    </head>
    <body>
        <%@ include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="container-fluid">
            <div class="row">
                <div class="col-12 offset-md-2 col-md-10 pt-4">

                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="mb-0">Prescription Detail</h3>
                    </div>

                    <div class="card mb-4">
                        <div class="card-body">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <h6 class="text-muted">Status</h6>
                                    <p class="mb-0">
                                        <c:choose>
                                            <c:when test="${requestScope.prescription.prescriptionStatus == 'Pending'}">
                                                <span class="badge bg-warning text-dark">Pending</span>
                                            </c:when>
                                            <c:when test="${requestScope.prescription.prescriptionStatus == 'Delivered'}">
                                                <span class="badge bg-success">Delivered</span>
                                            </c:when>
                                            <c:when test="${requestScope.prescription.prescriptionStatus == 'Canceled'}">
                                                <span class="badge bg-danger">Canceled</span>
                                            </c:when>
                                        </c:choose>
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-muted">Created Date</h6>
                                    <p class="mb-0">
                                        <c:out value="${requestScope.prescription.dateCreate}"/>
                                    </p>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <h6 class="text-muted">Doctor</h6>
                                    <p class="fw-bold mb-0">
                                        <c:out value="${requestScope.prescription.appointmentID.doctorID.staffID.fullName}" />
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-muted">Patient</h6>
                                    <p class="fw-bold mb-0">
                                        <c:out value="${requestScope.prescription.appointmentID.patientID.fullName}" />
                                    </p>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <h6 class="text-muted">Note</h6>
                                    <p class="mb-0">
                                        <c:out value="${requestScope.prescription.note}" default="(No note)" />
                                    </p>
                                </div>
                            </div>

                            <div class="table-responsive mb-3">
                                <table class="table table-striped table-bordered align-middle">
                                    <thead class="table-light text-center">
                                        <tr>
                                            <th style="width:5%;">#</th>
                                            <th>Medicine</th>
                                            <th>Code</th>
                                            <th>Type</th>
                                            <th class="text-end">Price</th>
                                            <th class="text-center">Dosage</th>
                                            <th>Instruction</th>
                                            <th class="text-end">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${requestScope.prescription.prescriptionItemList}" varStatus="no">
                                            <tr>
                                                <td class="text-center">
                                                    <c:out value="${no.count}"/>
                                                </td>
                                                <td>
                                                    <c:out value="${item.medicineIID.medicineName}"/>
                                                </td>
                                                <td class="text-center">
                                                    <c:out value="${item.medicineIID.medicineCode}"/>
                                                </td>
                                                <td class="text-center">
                                                    <c:out value="${item.medicineIID.medicineType}"/>
                                                </td>
                                                <td class="text-end">
                                                    <c:out value="${item.medicineIID.price}"/>
                                                </td>
                                                <td class="text-center">
                                                    <c:out value="${item.dosage}"/>
                                                </td>
                                                <td>
                                                    <c:out value="${item.instruction}"/>
                                                </td>
                                                <td class="text-end">
                                                    <c:out value="${item.subTotal}"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="7" class="text-end">Total</th>
                                            <th class="text-end">
                                                <strong><c:out value="${requestScope.prescription.totalValue}"/></strong>
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>
    </body>
</html>