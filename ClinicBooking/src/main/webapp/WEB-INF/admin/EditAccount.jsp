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
            .text-danger {
                font-size: 0.9rem;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@include file="../includes/AdminDashboardSidebar.jsp" %>
        <!-- Main Content -->
        <div class="main-content">
            <h2 class="mb-4"><i class="fa-solid fa-user-pen me-2"></i>Edit Account</h2>

            <form action="${pageContext.request.contextPath}/admin-manage-account" method="post">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="staffID" value="${staff.staffID}"/>

                <h3 class="section-title">Account Information</h3>
                <table class="table table-bordered">
                    <!-- Username -->
                    <tr>
                        <th>Username</th>
                        <td>
                            <input type="text" name="accountName" class="form-control"
                                   value="${staff.accountName}" required/>
                            <div class="text-danger">
                                <c:if test="${not empty sessionScope.usernameErrorMsg}">
                                    <c:out value="${sessionScope.usernameErrorMsg}"/>
                                    <c:remove var="usernameErrorMsg" scope="session"/>
                                </c:if>
                            </div>
                        </td>
                    </tr>

                    <!-- Full name -->
                    <tr>
                        <th>Full Name</th>
                        <td>
                            <input type="text" name="fullName" class="form-control"
                                   value="${staff.fullName}" required/>
                            <div class="text-danger">
                                <c:if test="${not empty sessionScope.fullNameErrorMsg}">
                                    <c:out value="${sessionScope.fullNameErrorMsg}"/>
                                    <c:remove var="fullNameErrorMsg" scope="session"/>
                                </c:if>
                            </div>
                        </td>
                    </tr>

                    <!-- Role -->
                    <tr>
                        <th>Role</th>
                        <td>
                            <select name="role" class="form-select" required>
                                <option value="Doctor" <c:if test="${staff.role eq 'Doctor'}">selected</c:if>>Doctor</option>
                                <option value="Pharmacist" <c:if test="${staff.role eq 'Pharmacist'}">selected</c:if>>Pharmacist</option>
                                <option value="Receptionist" <c:if test="${staff.role eq 'Receptionist'}">selected</c:if>>Receptionist</option>
                                <option value="Admin" <c:if test="${staff.role eq 'Admin'}">selected</c:if>>Admin</option>
                                </select>
                                <div class="text-danger">
                                <c:if test="${not empty sessionScope.roleErrorMsg}">
                                    <c:out value="${sessionScope.roleErrorMsg}"/>
                                    <c:remove var="roleErrorMsg" scope="session"/>
                                </c:if>
                            </div>
                        </td>
                    </tr>

                    <!-- Job status -->
                    <tr>
                        <th>Job Status</th>
                        <td>
                            <select name="jobStatus" class="form-select">
                                <option value="Available" <c:if test="${staff.jobStatus eq 'Available'}">selected</c:if>>Available</option>
                                <option value="Unavailable" <c:if test="${staff.jobStatus eq 'Unavailable'}">selected</c:if>>Unavailable</option>
                                <option value="Retired" <c:if test="${staff.jobStatus eq 'Retired'}">selected</c:if>>Retired</option>
                                </select>
                            </td>
                        </tr>

                        <!-- Phone -->
                        <tr>
                            <th>Phone</th>
                            <td>
                                <input type="text" name="phoneNumber" class="form-control"
                                       value="${staff.phoneNumber}" required/>
                            <div class="text-danger">
                                <c:if test="${not empty sessionScope.phoneErrorMsg}">
                                    <c:out value="${sessionScope.phoneErrorMsg}"/>
                                    <c:remove var="phoneErrorMsg" scope="session"/>
                                </c:if>
                            </div>
                        </td>
                    </tr>

                    <!-- Date of Birth -->
                    <tr>
                        <th>Date of Birth</th>
                        <td>
                            <fmt:formatDate value="${staff.dob}" pattern="yyyy-MM-dd" var="formattedDob"/>
                            <input type="date" name="dob" class="form-control" value="${formattedDob}" required/>
                            <div class="text-danger">
                                <c:if test="${not empty sessionScope.dobErrorMsg}">
                                    <c:out value="${sessionScope.dobErrorMsg}"/>
                                    <c:remove var="dobErrorMsg" scope="session"/>
                                </c:if>
                            </div>
                        </td>
                    </tr>

                    <!-- Gender -->
                    <tr>
                        <th>Gender</th>
                        <td>
                            <select name="gender" class="form-select" required>
                                <option value="true" <c:if test="${staff.gender}">selected</c:if>>Male</option>
                                <option value="false" <c:if test="${!staff.gender}">selected</c:if>>Female</option>
                                </select>
                            </td>
                        </tr>

                        <!-- Address -->
                        <tr>
                            <th>Address</th>
                            <td>
                                <input type="text" name="userAddress" class="form-control"
                                       value="${staff.userAddress}" required/>
                            <div class="text-danger">
                                <c:if test="${not empty sessionScope.addressErrorMsg}">
                                    <c:out value="${sessionScope.addressErrorMsg}"/>
                                    <c:remove var="addressErrorMsg" scope="session"/>
                                </c:if>
                            </div>
                        </td>
                    </tr>

                    <!-- Status -->
                    <tr>
                        <th>Status</th>
                        <td>
                            <select name="hidden" class="form-select">
                                <option value="0" <c:if test="${!staff.hidden}">selected</c:if>>Active</option>
                                <option value="1" <c:if test="${staff.hidden}">selected</c:if>>Inactive</option>
                                </select>
                            </td>
                        </tr>
                    </table>

                    <!-- Doctor Section -->
                <c:if test="${staff.role eq 'Doctor'}">
                    <h3 class="section-title">Doctor Information</h3>
                    <table class="table table-bordered">
                        <tr>
                            <th>Specialty</th>
                            <td>
                                <select name="specialtyID" class="form-select" required>
                                    <c:forEach var="s" items="${specialties}">
                                        <option value="${s.specialtyID}"
                                                <c:if test="${doctor != null && doctor.specialtyID != null
                                                              && doctor.specialtyID.specialtyID eq s.specialtyID}">
                                                      selected
                                                </c:if>>
                                            ${s.specialtyName}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.specialtyErrorMsg}">
                                        <c:out value="${sessionScope.specialtyErrorMsg}"/>
                                        <c:remove var="specialtyErrorMsg" scope="session"/>
                                    </c:if>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <th>Years Experience</th>
                            <td>
                                <input type="number" name="yearExperience" class="form-control"
                                       value="${doctor.yearExperience}" min="0" required/>
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.experienceErrorMsg}">
                                        <c:out value="${sessionScope.experienceErrorMsg}"/>
                                        <c:remove var="experienceErrorMsg" scope="session"/>
                                    </c:if>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <th>Price</th>
                            <td>
                                <input type="number" name="price" class="form-control"
                                       value="${doctor.specialtyID.price}" min="0" required/>
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.priceErrorMsg}">
                                        <c:out value="${sessionScope.priceErrorMsg}"/>
                                        <c:remove var="priceErrorMsg" scope="session"/>
                                    </c:if>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <th>Degrees</th>
                            <td id="degreeContainer">
                                <c:forEach var="deg" items="${degrees}">
                                    <input type="text" name="degreeNames"
                                           class="form-control mb-1" value="${deg.degreeName}"/>
                                </c:forEach>
                                <button type="button" class="btn btn-sm btn-primary" id="addDegreeBtn">
                                    <i class="fa-solid fa-plus me-1"></i> Add Degree
                                </button>
                            </td>
                        </tr>
                    </table>
                </c:if>

                <!-- Buttons -->
                <div class="mt-3">
                    <button type="submit" class="btn btn-success me-2">
                        <i class="fa-solid fa-floppy-disk me-1"></i>Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/admin-manage-account"
                       class="btn btn-secondary">
                        <i class="fa-solid fa-xmark me-1"></i>Cancel
                    </a>
                </div>
            </form>
        </div>

        <!-- JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $('#addDegreeBtn').click(function () {
                $('<input type="text" name="degreeNames" class="form-control mb-1" placeholder="New Degree"/>')
                        .insertBefore('#addDegreeBtn');
            });
        </script>
    </body>
</html>
