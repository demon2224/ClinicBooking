<%-- 
    Document   : EditAccount
    Created on : Nov 7, 2025, 2:40:03 AM
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
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/admin-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin-manage-account"><i class="fa-solid fa-calendar-days me-2"></i>Manage Account</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2><i class="fa-solid fa-user-pen me-2"></i>Edit Account</h2>
            </div>

            <form action="${pageContext.request.contextPath}/admin-manage-account" method="post">
                <input type="hidden" name="accountId" value="${staff.staffID}"/>

                <h3 class="section-title">Account Information</h3>
                <table class="table table-bordered">
                    <tr>
                        <th>Username</th>
                        <td><input type="text" name="accountName" class="form-control" value="${staff.accountName}" required/></td>
                    </tr>
                    <tr>
                        <th>Full Name</th>
                        <td>
                            <input type="text" name="fullName" class="form-control" 
                                   value="${staff.firstName} ${staff.lastName}" required/>
                        </td>
                    </tr>
                    <tr>
                        <th>Role</th>
                        <td>
                            <select name="role" class="form-select" required>
                                <option value="Doctor" <c:if test="${staff.role eq 'Doctor'}">selected</c:if>>Doctor</option>
                                <option value="Pharmacist" <c:if test="${staff.role eq 'Pharmacist'}">selected</c:if>>Pharmacist</option>
                                <option value="Receptionist" <c:if test="${staff.role eq 'Receptionist'}">selected</c:if>>Receptionist</option>
                                <option value="Admin" <c:if test="${staff.role eq 'Admin'}">selected</c:if>>Admin</option>
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <th>Phone</th>
                            <td><input type="text" name="phoneNumber" class="form-control" value="${staff.phoneNumber}" required/></td>
                    </tr>
                    <tr>
                        <th>Date of Birth</th>
                        <td><input type="date" name="dob" class="form-control" 
                                   value="<fmt:formatDate value='${staff.dob}' pattern='yyyy-MM-dd'/>" required/></td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td>
                            <select name="gender" class="form-select" required>
                                <option value="true" <c:if test="${staff.gender}">selected</c:if>>Male</option>
                                <option value="false" <c:if test="${!staff.gender}">selected</c:if>>Female</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>Address</th>
                            <td><input type="text" name="userAddress" class="form-control" value="${staff.userAddress}" required/></td>
                    </tr>
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

                <c:if test="${staff.role eq 'Doctor'}">
                    <h3 class="section-title">Doctor Information</h3>
                    <table class="table table-bordered">
                        <tr>
                            <th>Specialty</th>
                            <td>
                                <select name="specialtyID" class="form-select" required>
                                    <c:forEach var="s" items="${specialties}">
                                        <option value="${s[0]}" <c:if test="${doctor.specialtyID.specialtyID eq s[0]}">selected</c:if>>${s[1]}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>Years Experience</th>
                            <td><input type="number" name="yearExperience" class="form-control" value="${doctor.yearExperience}" min="0" required/></td>
                        </tr>
                        <tr>
                            <th>Price</th>
                            <td><input type="number" name="price" class="form-control" value="${doctor.specialtyID.price}" min="0" required/></td>
                        </tr>
                        <tr>
                            <th>Degrees</th>
                            <td>
                                <c:forEach var="deg" items="${degrees}">
                                    <input type="text" name="degreeNames" class="form-control mb-1" value="${deg.degreeName}"/>
                                </c:forEach>
                                <button type="button" class="btn btn-sm btn-primary" id="addDegreeBtn">Add Degree</button>
                            </td>
                        </tr>
                    </table>
                </c:if>

                <div class="mt-3">
                    <button type="submit" class="btn btn-success me-2"><i class="fa-solid fa-floppy-disk me-1"></i>Save Changes</button>
                    <a href="${pageContext.request.contextPath}/admin-manage-account" class="btn btn-secondary"><i class="fa-solid fa-xmark me-1"></i>Cancel</a>
                </div>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $('#addDegreeBtn').click(function () {
                $('<input type="text" name="degreeNames" class="form-control mb-1" placeholder="New Degree"/>')
                        .insertBefore($(this));
            });
        </script>
    </body>
</html>

