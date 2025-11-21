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

            /* Card style */
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
                margin-bottom: 30px;
            }
            .card-header {
                background-color: #1B5A90 !important;
                color: white !important;
                font-weight: bold;
                padding: 10px 15px;
                border-radius: 10px 10px 0 0;
            }

            table.table-bordered th {
                background-color: #f1f3f5 !important;
                width: 220px;
                font-weight: 600;
            }
            table.table-bordered td {
                background-color: #ffffff !important;
            }
            table.table-bordered th, table.table-bordered td {
                border: 1px solid #dee2e6 !important;
            }

            .role-badge {
                padding: 6px 12px;
                font-size: 0.9rem;
                font-weight: 600;
                border-radius: 8px;
            }
            .badge-doctor {
                background-color: #007bff;
                color: white;
            }
            .badge-pharmacist {
                background-color: #20c997;
                color: white;
            }
            .badge-admin {
                background-color: #ffc107;
                color: black;
            }
            .badge-receptionist {
                background-color: #6f42c1;
                color: white;
            }
            .badge-status {
                padding: 6px 12px;
                font-weight: 600;
                border-radius: 8px;
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <%@ include file="../includes/AdminDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-primary"><i class="fa-solid fa-user me-2"></i>Account Detail</h2>
            </div>

            <!-- Account Information -->
            <div class="card">
                <div class="card-header"><i class="fa-solid fa-id-card me-2"></i>Account Detail</div>
                <div class="card-body p-4">
                    <table class="table table-bordered mb-0">
                        <tr><th>Username</th><td>${staff.accountName}</td></tr>
                        <tr><th>Full Name</th><td>${staff.fullName}</td></tr>
                        <tr>
                            <th>Role</th>
                            <td>
                                <span class="role-badge
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
                        <tr><th>Date of Birth</th><td><fmt:formatDate value="${staff.dob}" pattern="yyyy-MM-dd"/></td></tr>
                        <tr><th>Gender</th>
                            <td><c:choose><c:when test="${staff.gender}">Male</c:when><c:otherwise>Female</c:otherwise></c:choose></td>
                                </tr>
                                    <tr><th>Address</th><td>${staff.userAddress}</td></tr>
                        <tr><th>Date Created</th><td><fmt:formatDate value="${staff.daycreated}" pattern="yyyy-MM-dd"/></td></tr>
                        <tr><th>Account Status</th>
                            <td>
                                <span class="badge-status ${staff.hidden ? 'bg-danger' : 'bg-success'}">
                                    ${staff.hidden ? 'Inactive' : 'Active'}
                                </span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Doctor Information -->
            <c:if test="${staff.role eq 'Doctor'}">
                <div class="card">
                    <div class="card-header"><i class="fa-solid fa-user-doctor me-2"></i>Doctor Information</div>
                    <div class="card-body p-4">
                        <table class="table table-bordered mb-0">
                            <tr><th>Specialty</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty doctor.specialtyID && not empty doctor.specialtyID.specialtyName}">
                                            ${doctor.specialtyID.specialtyName}
                                        </c:when>
                                        <c:otherwise><span class="text-muted fst-italic">No specialty assigned</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><th>Years of Experience</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${doctor.yearExperience gt 0}">${doctor.yearExperience}</c:when>
                                        <c:otherwise><span class="text-muted fst-italic">Not specified</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><th>Consultation Price</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty doctor.specialtyID && doctor.specialtyID.price gt 0}">
                                            <fmt:formatNumber value="${doctor.specialtyID.price}" type="currency" currencySymbol="$"/>
                                        </c:when>
                                        <c:otherwise><span class="text-muted fst-italic">Not set</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><th>Degrees</th>
                                <td>
                                    <c:if test="${not empty degrees}">
                                        <c:forEach var="deg" items="${degrees}">${deg.degreeName}<br/></c:forEach>
                                    </c:if>
                                    <c:if test="${empty degrees}"><span class="text-muted fst-italic">No degrees found</span></c:if>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
            </c:if>

        </div>
    </body>
</html>
