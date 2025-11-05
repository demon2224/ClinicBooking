<%-- 
    Document   : MyPatientAppointmentDetail
    Created on : 10 Oct. 2025, 9:56:23 pm
    Author     : Le Thien Tri - CE191249
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Appointment Detail</title>
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
                .section-title {
                    margin-top: 30px;
                    color: #1B5A90;
                    font-weight: bold;
                }
                th {
                    width: 220px;
                    background-color: #f1f1f1;
                }
                .btn-create-record {
                    display: inline-block;
                    background: #28a745;
                    color: white;
                    padding: 10px 24px;
                    border-radius: 30px;
                    font-weight: 600;
                    text-decoration: none;
                    transition: all 0.3s ease;
                }

                .btn-create-record:hover {
                    background: #00e6b8;
                    transform: translateY(-2px);
                    color: #fff;
                    text-decoration: none;
                }

                .btn-create-record:active {
                    transform: translateY(0);
                }
        </style>
    </head>
    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>
            <!-- Main Content -->
            <div class="main-content">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2><i class="fa-solid fa-calendar-days me-2"></i>Appointment Detail</h2>
                </div>

                <!-- Appointment Information -->
                <h3 class="section-title">Appointment Information</h3>
                <table class="table table-bordered">
                    <tr><th>Date Begin</th><td><fmt:formatDate value="${detail.dateBegin}" pattern="yyyy/MM/dd HH:mm" /></td></tr>
                    <tr>
                        <th>Date End</th>
                        <td>
                            <c:choose>
                                <c:when test="${detail.appointmentStatus == 'Completed'}">
                                    <fmt:formatDate value="${detail.dateEnd}" pattern="yyyy/MM/dd HH:mm"/>
                                </c:when>
                                <c:otherwise>
                                    None
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Status</th>
                        <td>
                            <span class="badge
                                  <c:choose>
                                      <c:when test="${detail.appointmentStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                      <c:when test="${detail.appointmentStatus eq 'Approved'}">bg-primary</c:when>
                                      <c:when test="${detail.appointmentStatus eq 'Completed'}">bg-success</c:when>
                                      <c:when test="${detail.appointmentStatus eq 'Canceled'}">bg-danger</c:when>
                                      <c:otherwise>bg-secondary</c:otherwise>
                                  </c:choose>">
                                ${detail.appointmentStatus}
                            </span>
                        </td>
                    </tr>
                    <tr><th>Appointment Note</th><td>${detail.note}</td></tr>
                </table>

                <!-- Patient Information -->
                <h3 class="section-title">Patient Information</h3>
                <table class="table table-bordered">
                    <tr><th>Patient Name</th><td>${detail.patientID.firstName} ${detail.patientID.lastName}</td></tr>
                    <tr><th>Email</th><td>${detail.patientID.email}</td></tr>
                    <tr><th>Phone</th><td>${detail.patientID.phoneNumber}</td></tr>
                    <tr><th>Gender</th>
                        <td>
                            <c:choose>
                                <c:when test="${detail.patientID.gender}">Male</c:when>
                                <c:otherwise>Female</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr><th>Date of Birth</th><td><fmt:formatDate value="${detail.patientID.dob}" pattern="yyyy/MM/dd" /></td></tr>
                    <tr><th>Address</th><td>${detail.patientID.userAddress}</td></tr>
                </table>
                <c:if test="${not requestScope.isExist}">
                    <div class="text-center mt-4">
                        <a href="${pageContext.request.contextPath}/manage-my-patient-medical-record?action=create&appointmentID=${detail.appointmentID}"
                           class="btn-create-record"> Create Medical Record
                        </a>
                    </div>
                </c:if>
            </div>
        </body>
</html>
