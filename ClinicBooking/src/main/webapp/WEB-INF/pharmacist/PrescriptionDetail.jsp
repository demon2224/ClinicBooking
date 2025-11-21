<%--
    Document   : PrescriptionDetail
    Created on : Nov 5, 2025, 10:11:23 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Prescription Detail</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <style>
            body {
                background-color: #f8f9fa;
            }
            .main-content {
                margin-left: 260px;
                padding: 25px;
            }

            .card {
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
                margin-bottom: 30px;
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
            }
            th {
                background-color: #f1f3f5;
                width: 220px;
                font-weight: 600;
            }
            td {
                background-color: #fff;
            }
            .badge {
                font-size: 0.9rem;
                padding: 6px 10px;
                border-radius: 8px;
            }
        </style>
    </head>

    <body>

        <%@ include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="main-content">
            <c:set var="rate" value="25000" />
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-primary">
                    <i class="fa-solid fa-prescription-bottle-medical me-2"></i>Prescription Detail
                </h2>
            </div>

            <c:choose>

                <c:when test="${empty prescription}">
                    <div class="card">
                        <div class="card-header">
                            <i class="fa-solid fa-file-prescription me-2"></i>Prescription Information
                        </div>
                        <div class="card-body text-center py-5">
                            <i class="fa-solid fa-circle-info text-muted fs-1"></i>
                            <p class="mt-3 fs-5 text-muted">No prescription found.</p>
                        </div>
                    </div>
                </c:when>

                <c:otherwise>

                    <div class="card">
                        <div class="card-header">
                            <i class="fa-solid fa-file-prescription me-2"></i>Prescription Information
                        </div>

                        <div class="card-body p-4">
                            <table class="table table-bordered mb-0">

                                <tr>
                                    <th>Status</th>
                                    <td>
                                        <span class="badge
                                              <c:choose>
                                                  <c:when test="${prescription.prescriptionStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                                  <c:when test="${prescription.prescriptionStatus eq 'Delivered'}">bg-success</c:when>
                                                  <c:otherwise>bg-danger</c:otherwise>
                                              </c:choose>">
                                            <c:out value="${prescription.prescriptionStatus}"/>
                                        </span>
                                    </td>

                                    <th>Created Date</th>
                                    <td>
                                        <fmt:formatDate value="${prescription.dateCreate}" pattern="yyyy/MM/dd HH:mm"/>
                                    </td>
                                </tr>

                                <tr>
                                    <th>Doctor</th>
                                    <td>
                                        <strong><c:out value="${prescription.appointmentID.doctorID.staffID.fullName}"/></strong><br>
                                    </td>

                                    <th>Patient</th>
                                    <td>
                                        <strong>
                                            <c:out value="${prescription.appointmentID.patientID.firstName}"/>
                                            <c:out value="${prescription.appointmentID.patientID.lastName}"/>
                                        </strong>
                                    </td>
                                </tr>

                                <tr>
                                    <th>Note</th>
                                    <td>
                                        <c:out value="${empty prescription.note ? '(No note)' : prescription.note}"/>
                                    </td>
                                </tr>

                            </table>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">
                            <i class="fa-solid fa-pills me-2"></i>Medicine Information
                        </div>

                        <div class="card-body p-4">

                            <table class="table table-striped table-bordered text-center align-middle">

                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Medicine</th>
                                        <th>Code</th>
                                        <th>Type</th>
                                        <th>Price</th>
                                        <th>Dosage</th>
                                        <th>Instruction</th>
                                        <th>Subtotal</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="item" items="${prescription.prescriptionItemList}" varStatus="no">
                                        <tr>
                                            <td><c:out value="${no.count}"/></td>
                                            <td><c:out value="${item.medicineID.medicineName}"/></td>
                                            <td><c:out value="${item.medicineID.medicineCode}"/></td>
                                            <td><c:out value="${item.medicineID.medicineType}"/></td>

                                            <td class="text-end">
                                                <fmt:formatNumber value="${item.medicineID.price}"/>
                                            </td>

                                            <td><c:out value="${item.dosage}"/></td>
                                            <td><c:out value="${item.instruction}"/></td>

                                            <td class="text-end">
                                                <fmt:formatNumber value="${item.subTotal * rate}" type="number"
                                                                  groupingUsed="true" maxFractionDigits="0" />
                                                đ
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty prescription.prescriptionItemList}">
                                        <tr>
                                            <td colspan="8" class="text-center text-muted py-4">
                                                <i class="fa-solid fa-circle-info me-2"></i>No medicines in this prescription.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>

                                <tfoot>
                                    <tr>
                                        <th colspan="7" class="text-end">Total:</th>
                                        <th class="text-end">
                                            <fmt:formatNumber value="${prescription.totalValue * rate}" type="number"
                                                              groupingUsed="true" maxFractionDigits="0" />
                                            đ
                                        </th>
                                    </tr>
                                </tfoot>

                            </table>

                        </div>
                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </body>
</html>