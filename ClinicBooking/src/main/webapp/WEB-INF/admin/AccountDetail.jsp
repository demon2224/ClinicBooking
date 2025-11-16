<%--
    Document   : AccountDetail
    Created on : Nov 6, 2025, 9:39:54 PM
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account Detail</title>
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
            .section-title {
                margin-top: 30px;
                color: #1B5A90;
                font-weight: bold;
            }
            th {
                width: 220px;
                background-color: #f1f1f1;
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
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                margin-bottom: 30px;
            }

            .card-header {
                background-color: #1B5A90 !important;
                color: white !important;
                font-weight: bold;
            }

            .table-bordered th {
                background-color: #f1f3f5 !important;
                width: 230px;
                font-weight: 600;
            }

            .table-bordered td {
                background-color: #ffffff !important;
            }

            .role-badge {
                padding: 6px 12px;
                font-size: 0.9rem;
                font-weight: 600;
                border-radius: 8px;
            }

        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@include file="../includes/AdminDashboardSidebar.jsp" %>


        <!-- Main Content -->
        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2><i class="fa-solid fa-user me-2"></i>Account Detail</h2>
            </div>
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-id-card me-2"></i>Account Detail
                </div>
                <div class="card-body p-4">
                    <table class="table table-bordered">
                        <tr><th>Username</th><td>${staff.accountName}</td></tr>
                        <tr><th>Full Name</th><td>${staff.fullName}</td></tr>
                        <tr>
                            <th>Role</th>
                            <td>
                                <span class="role-badge badge
                                      <c:choose>
                                          <c:when test="${staff.role eq 'Doctor'}">badge-doctor</c:when>
                                          <c:when test="${staff.role eq 'Pharmacist'}">badge-pharmacist</c:when>
                                          <c:when test="${staff.role eq 'Admin'}">badge-admin</c:when>
                                          <c:when test="${staff.role eq 'Receptionist'}">badge-receptionist</c:when>
                                          <c:otherwise>bg-secondary</c:otherwise>
                                      </c:choose>">
                                    ${staff.role}
                                </span>
                            </td>
                        </tr>
                        <tr><th>Job Status</th><td>${staff.jobStatus}</td></tr>
                        <tr><th>Phone</th><td>${staff.phoneNumber}</td></tr>
                        <tr>
                            <th>Date of birth</th>
                            <td><fmt:formatDate value="${staff.dob}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                        <tr>
                            <th>Gender</th>
                            <td>
                                <c:choose>
                                    <c:when test="${staff.gender}">Male</c:when>
                                    <c:otherwise>Female</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr><th>Address</th><td>${staff.userAddress}</td></tr>
                        <tr>
                            <th>Date Create</th>
                            <td><fmt:formatDate value="${staff.daycreated}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                        <tr>
                            <th>Account Status</th>
                            <td>
                                <span class="badge ${staff.hidden ? 'bg-danger' : 'bg-success'}">
                                    ${staff.hidden ? 'Inactive' : 'Active'}
                                </span>
                            </td>
                        </tr>
                    </table>
                    </table>
                </div>
            </div>
            <c:if test="${staff.role eq 'Doctor'}">
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-user-doctor me-2"></i>Doctor Information
                    </div>
                    <div class="card-body p-4">
                        <table class="table table-bordered">


                            <!-- Specialty -->
                            <tr>
                                <th>Specialty</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty doctor.specialtyID && not empty doctor.specialtyID.specialtyName}">
                                            ${doctor.specialtyID.specialtyName}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fst-italic">No specialty assigned</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>

                            <!-- Years of Experience -->
                            <tr>
                                <th>Years of Experience</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${doctor.yearExperience gt 0}">
                                            ${doctor.yearExperience}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fst-italic">Not specified</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>

                            <!-- Consultation Price -->
                            <tr>
                                <th>Consultation Price</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty doctor.specialtyID && doctor.specialtyID.price gt 0}">
                                            <fmt:formatNumber value="${doctor.specialtyID.price}" type="currency" currencySymbol="$"/>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fst-italic">Not set</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>

                            <!-- Degrees -->
                            <tr>
                                <th>Degrees</th>
                                <td>
                                    <c:if test="${not empty degrees}">
                                        <c:forEach var="deg" items="${degrees}">
                                            ${deg.degreeName}<br/>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty degrees}">
                                        <span class="text-muted fst-italic">No degrees found</span>
                                    </c:if>
                                </td>
                            </tr>

                        </table>
                    </c:if>
                </div>
                </table>
            </div>
        </div>
    </body>
</html>
