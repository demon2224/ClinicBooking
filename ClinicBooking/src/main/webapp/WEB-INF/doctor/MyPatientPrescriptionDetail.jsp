<%--
    Document   : MyPatientPrescriptionDetail
    Created on : 6 Nov. 2025, 5:19:58 pm
    Author     : Le Thien Tri - CE191249
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
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
            .btn-back {
                background-color: #1B5A90;
                color: white;
                font-weight: 600;
                border-radius: 30px;
                padding: 10px 25px;
                transition: all 0.3s ease;
            }
            .btn-back:hover {
                background-color: #00D0F1;
                color: #fff;
                transform: translateY(-2px);
            }
        </style>
    </head>

    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>
        <c:if test="${not empty prescription}">
            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold text-primary">
                        <i class="fa-solid fa-prescription-bottle-medical me-2"></i>Prescription Detail
                    </h2>
                </div>

                <!-- Prescription Information -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-file-prescription me-2"></i>Prescription Information
                    </div>
                    <div class="card-body p-4">
                        <table class="table table-bordered mb-0">
                            <tr>
                                <th>Date Created</th>
                                <td><fmt:formatDate value="${prescription.dateCreate}" pattern="yyyy/MM/dd HH:mm" /></td>
                            </tr>
                            <tr>
                                <th>Status</th>
                                <td>
                                    <span class="badge
                                          <c:choose>
                                              <c:when test="${prescription.prescriptionStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                              <c:otherwise>bg-success</c:otherwise>
                                          </c:choose>">
                                        ${prescription.prescriptionStatus}
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>Prescription Note</th>
                                <td>${prescription.note}</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <!-- Patient Information -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-user me-2"></i>Patient Information
                    </div>
                    <div class="card-body p-4">
                        <table class="table table-bordered mb-0">
                            <tr>
                                <th>Patient Name</th>
                                <td>${prescription.appointmentID.patientID.firstName} ${prescription.appointmentID.patientID.lastName}</td>
                            </tr>
                            <tr><th>Email</th><td>${prescription.appointmentID.patientID.email}</td></tr>
                            <tr><th>Phone</th><td>${prescription.appointmentID.patientID.phoneNumber}</td></tr>
                            <tr>
                                <th>Gender</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${prescription.appointmentID.patientID.gender}">Male</c:when>
                                        <c:otherwise>Female</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th>Date of Birth</th>
                                <td><fmt:formatDate value="${prescription.appointmentID.patientID.dob}" pattern="yyyy/MM/dd"/></td>
                            </tr>
                            <tr><th>Address</th><td>${prescription.appointmentID.patientID.userAddress}</td></tr>
                        </table>
                    </div>
                </div>



                <!-- Medicine List -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-pills me-2"></i>Medicine Information
                    </div>
                    <div class="card-body p-4">
                        <table class="table table-striped table-bordered text-center align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Medicine Name</th>
                                    <th>Code</th>
                                    <th>Type</th>
                                    <th>Price (₫)</th>
                                    <th>Dosage</th>
                                    <th>Instruction</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${requestScope.prescription.prescriptionItemList}" varStatus="no">
                                    <tr>
                                        <td class="text-center"><c:out value="${no.count}"/></td>
                                        <td><c:out value="${item.medicineID.medicineName}"/></td>
                                        <td class="text-center"><c:out value="${item.medicineID.medicineCode}"/></td>
                                        <td class="text-center"><c:out value="${item.medicineID.medicineType}"/></td>
                                        <td class="text-end"><fmt:formatNumber value="${item.medicineID.price}" /></td>
                                        <td class="text-center"><c:out value="${item.dosage}"/></td>
                                        <td><c:out value="${item.instruction}"/></td>
                                        <td class="text-end"><c:out value="${item.subTotal}"/></td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty requestScope.prescription.prescriptionItemList}">
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">
                                            <i class="fa-solid fa-circle-info me-2"></i>No medicines found in this prescription.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="7" class="text-end">Total:</th>
                                    <th class="text-end">
                                        <c:out value="${prescription.totalValue}"/>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>


            </div>
        </c:if>
        <c:if test="${empty prescription}">
            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold text-primary">
                        <i class="fa-solid fa-prescription-bottle-medical me-2"></i>Prescription Detail
                    </h2>
                </div>

                <!-- Prescription Information -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-file-prescription me-2"></i>Prescription Information
                    </div>
                    <div class="card-body p-4">
                        <table class="table table-bordered mb-0">
                            <tr><i class="fa-solid fa-circle-info me-2"></i>No prescription.</tr>
                        </table>
                    </div>
                </div>

                <!-- Patient Information -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-user me-2"></i>Patient Information
                    </div>
                    <div class="card-body p-4">
                        <table class="table table-bordered mb-0">
                            <tr><i class="fa-solid fa-circle-info me-2"></i>No patient.</tr>
                        </table>
                    </div>
                </div>



                <!-- Medicine List -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-pills me-2"></i>Medicine Information
                    </div>
                    <div class="card-body p-4">
                        <table class="table table-striped table-bordered text-center align-middle">
                            <tr><i class="fa-solid fa-circle-info me-2"></i>No medicines.</tr>
                        </table>
                    </div>
                </div>


            </div>
        </c:if>
    </body>
</html>
