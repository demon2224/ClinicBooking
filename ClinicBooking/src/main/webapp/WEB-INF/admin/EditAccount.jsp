<%--
    Document   : EditAccount
    Created on : Nov 7, 2025
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Account</title>
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
            th {
                width: 220px;
                background-color: #f1f1f1;
            }
            .text-danger {
                font-size: 0.9rem;
            }
            .section-title {
                margin-top: 30px;
                color: #1B5A90;
                font-weight: bold;
            }
        </style>
    </head>

    <body>

        <!-- Sidebar -->
        <%@include file="../includes/AdminDashboardSidebar.jsp" %>

        <div class="main-content">
            <h2 class="mb-4"><i class="fa-solid fa-user-pen me-2"></i>Edit Account</h2>

            <form action="${pageContext.request.contextPath}/admin-manage-account" method="post">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="staffID" value="${staff.staffID}"/>

                <!-- ACCOUNT INFORMATION -->
                <h3 class="section-title">Account Information</h3>

                <table class="table table-bordered">

                    <!-- Username -->
                    <tr>
                        <th>Username</th>
                        <td>
                            <input type="text" name="accountName" class="form-control"
                                   value="${param.accountName != null ? param.accountName : staff.accountName}">
                            <div class="text-danger">${sessionScope.usernameErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Full Name -->
                    <tr>
                        <th>Full Name</th>
                        <td>
                            <input type="text" name="fullName" class="form-control"
                                   value="${param.fullName != null ? param.fullName : staff.fullName}">
                            <div class="text-danger">${sessionScope.fullNameErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Role (READONLY) -->
                    <tr>
                        <th>Role</th>
                        <td>
                            <input type="text" class="form-control" value="${staff.role}" readonly />
                            <input type="hidden" name="role" value="${staff.role}"/>

                            <div class="text-danger">
                                <c:if test="${not empty sessionScope.roleErrorMsg}">
                                    <c:out value="${sessionScope.roleErrorMsg}"/>
                                    <c:remove var="roleErrorMsg" scope="session"/>
                                </c:if>
                            </div>
                        </td>
                    </tr>


                    <!-- Job Status -->
                    <tr>
                        <th>Job Status</th>
                        <td>
                            <select name="jobStatus" class="form-select">
                                <option value="Available"    ${param.jobStatus == 'Available' ? 'selected' : (staff.jobStatus=='Available'?'selected':'')}>Available</option>
                                <option value="Unavailable"  ${param.jobStatus == 'Unavailable' ? 'selected' : (staff.jobStatus=='Unavailable'?'selected':'')}>Unavailable</option>
                                <option value="Retired"      ${param.jobStatus == 'Retired' ? 'selected' : (staff.jobStatus=='Retired'?'selected':'')}>Retired</option>
                            </select>
                        </td>
                    </tr>

                    <!-- Phone -->
                    <tr>
                        <th>Phone</th>
                        <td>
                            <input type="text" name="phoneNumber" class="form-control"
                                   value="${param.phoneNumber != null ? param.phoneNumber : staff.phoneNumber}">
                            <div class="text-danger">${sessionScope.phoneErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- DOB -->
                    <tr>
                        <th>Date of Birth</th>
                        <td>
                            <fmt:formatDate value="${staff.dob}" pattern="yyyy-MM-dd" var="dobFormatted"/>
                            <input type="date" name="dob" class="form-control"
                                   value="${param.dob != null ? param.dob : dobFormatted}">
                            <div class="text-danger">${sessionScope.dobErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Gender -->
                    <tr>
                        <th>Gender</th>
                        <td>
                            <select name="gender" class="form-select">
                                <option value="true"  ${(param.gender=='true')  or (staff.gender==true  and param.gender==null) ? 'selected' : ''}>Male</option>
                                <option value="false" ${(param.gender=='false') or (staff.gender==false and param.gender==null) ? 'selected' : ''}>Female</option>
                            </select>
                        </td>
                    </tr>

                    <!-- Address -->
                    <tr>
                        <th>Address</th>
                        <td>
                            <input type="text" name="userAddress" class="form-control"
                                   value="${param.userAddress != null ? param.userAddress : staff.userAddress}">
                            <div class="text-danger">${sessionScope.addressErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Hidden -->
                    <tr>
                        <th>Status</th>
                        <td>
                            <select name="hidden" class="form-select">
                                <option value="0" ${(param.hidden=='0') or (!staff.hidden and param.hidden==null) ? 'selected':''}>Active</option>
                                <option value="1" ${(param.hidden=='1') or ( staff.hidden and param.hidden==null) ? 'selected':''}>Inactive</option>
                            </select>
                        </td>
                    </tr>

                </table>

                <!-- DOCTOR SECTION -->
                <c:if test="${staff.role eq 'Doctor'}">
                    <h3 class="section-title">Doctor Information</h3>

                    <table class="table table-bordered">

                        <!-- Specialty -->
                        <tr>
                            <th>Specialty</th>
                            <td>
                                <select name="specialtyID" class="form-select">

                                    <c:forEach var="s" items="${specialties}">
                                        <option value="${s.specialtyID}"
                                                ${param.specialtyID != null 
                                                  ? (param.specialtyID == s.specialtyID ? 'selected' : '')
                                                  : (doctor.specialtyID.specialtyID == s.specialtyID ? 'selected' : '')}>
                                                    ${s.specialtyName}
                                                </option>
                                        </c:forEach>

                                    </select>
                                    <div class="text-danger">${sessionScope.specialtyErrorMsg}</div>
                                </td>
                            </tr>

                            <!-- Experience -->
                            <tr>
                                <th>Years Experience</th>
                                <td>
                                    <input type="number" name="yearExperience" class="form-control" min="0"
                                           value="${param.yearExperience != null ? param.yearExperience : doctor.yearExperience}">
                                    <div class="text-danger">${sessionScope.experienceErrorMsg}</div>
                                </td>
                            </tr>

                            <!-- Price -->
                            <tr>
                                <th>Price</th>
                                <td>
                                    <input type="number" name="price" class="form-control" min="0"
                                           value="${param.price != null ? param.price : doctor.specialtyID.price}">
                                    <div class="text-danger">${sessionScope.priceErrorMsg}</div>
                                </td>
                            </tr>

                            <!-- Degrees -->
                            <tr>
                                <th>Degrees</th>
                                <td id="degreeContainer">

                                    <c:choose>
                                        <c:when test="${not empty paramValues.degreeNames}">
                                            <c:forEach var="d" items="${paramValues.degreeNames}">
                                                <input type="text" name="degreeNames" class="form-control mb-1" value="${d}"/>
                                            </c:forEach>
                                        </c:when>

                                        <c:otherwise>
                                            <c:forEach var="deg" items="${degrees}">
                                                <input type="text" name="degreeNames" class="form-control mb-1" value="${deg.degreeName}"/>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>

                                    <button type="button" class="btn btn-sm btn-primary mt-2" id="addDegreeBtn">
                                        <i class="fa-solid fa-plus me-1"></i> Add Degree
                                    </button>
                                </td>
                            </tr>

                        </table>
                    </c:if>

                    <div class="mt-3">
                        <button type="submit" class="btn btn-success me-2">
                            <i class="fa-solid fa-floppy-disk me-1"></i>Save Changes
                        </button>

<!--                        <a href="${pageContext.request.contextPath}/admin-manage-account"
                           class="btn btn-secondary">
                            <i class="fa-solid fa-xmark me-1"></i>Cancel
                        </a>-->
                    </div>
                </form>
            </div>

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                $('#addDegreeBtn').click(function () {
                    $('<input type="text" name="degreeNames" class="form-control mb-1" placeholder="New Degree"/>')
                            .insertBefore(this);
                });
            </script>

        </body>
    </html>
