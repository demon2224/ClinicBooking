<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Account</title>
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

            .card {
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                margin-bottom: 30px;
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
            }
            th {
                width: 220px;
                background-color: #f1f3f5;
                font-weight: 600;
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
        <%@ include file="../includes/AdminDashboardSidebar.jsp" %>

        <div class="main-content">
            <h2 class="mb-4"><i class="fa-solid fa-user-pen me-2"></i>Edit Account</h2>

            <form action="${pageContext.request.contextPath}/admin-manage-account" method="post">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="staffID" value="${staff.staffID}"/>

                <!-- Account Information -->
                <div class="card">
                    <div class="card-header">Account Information</div>
                    <div class="card-body p-4">
                        <table class="table table-bordered">

                            <tr>
                                <th>Username</th>
                                <td>
                                    <input type="text" name="accountName" class="form-control"
                                           value="${param.accountName != null ? param.accountName : staff.accountName}">
                                    <div class="text-danger">${sessionScope.usernameErrorMsg}</div>
                                </td>
                            </tr>

                            <tr>
                                <th>Full Name</th>
                                <td>
                                    <input type="text" name="fullName" class="form-control"
                                           value="${param.fullName != null ? param.fullName : staff.fullName}">
                                    <div class="text-danger">${sessionScope.fullNameErrorMsg}</div>
                                </td>
                            </tr>

                            <tr>
                                <th>Role</th>
                                <td>
                                    <input type="text" class="form-control" value="${staff.role}" readonly />
                                    <input type="hidden" name="role" value="${staff.role}"/>
                                </td>
                            </tr>

                            <tr>
                                <th>Job Status</th>
                                <td>
                                    <select name="jobStatus" class="form-select">
                                        <option value="Available" ${param.jobStatus=='Available' || (param.jobStatus==null && staff.jobStatus=='Available')?'selected':''}>Available</option>
                                        <option value="Unavailable" ${param.jobStatus=='Unavailable' || (param.jobStatus==null && staff.jobStatus=='Unavailable')?'selected':''}>Unavailable</option>
                                        <option value="Retired" ${param.jobStatus=='Retired' || (param.jobStatus==null && staff.jobStatus=='Retired')?'selected':''}>Retired</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th>Phone</th>
                                <td>
                                    <input type="text" name="phoneNumber" class="form-control"
                                           value="${param.phoneNumber != null ? param.phoneNumber : staff.phoneNumber}">
                                    <div class="text-danger">${sessionScope.phoneErrorMsg}</div>
                                </td>
                            </tr>

                            <tr>
                                <th>Date of Birth</th>
                                <td>
                                    <fmt:formatDate value="${staff.dob}" pattern="yyyy-MM-dd" var="dobFormatted"/>
                                    <input type="date" name="dob" class="form-control"
                                           value="${param.dob != null ? param.dob : dobFormatted}">
                                    <div class="text-danger">${sessionScope.dobErrorMsg}</div>
                                </td>
                            </tr>

                            <tr>
                                <th>Gender</th>
                                <td>
                                    <select name="gender" class="form-select">
                                        <option value="true" ${param.gender=='true' || (param.gender==null && staff.gender)?'selected':''}>Male</option>
                                        <option value="false" ${param.gender=='false' || (param.gender==null && !staff.gender)?'selected':''}>Female</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th>Address</th>
                                <td>
                                    <input type="text" name="userAddress" class="form-control"
                                           value="${param.userAddress != null ? param.userAddress : staff.userAddress}">
                                    <div class="text-danger">${sessionScope.addressErrorMsg}</div>
                                </td>
                            </tr>

                            <tr>
                                <th>Status</th>
                                <td>
                                    <select name="hidden" class="form-select">
                                        <option value="0" ${(param.hidden=='0') or (!staff.hidden and param.hidden==null)?'selected':''}>Active</option>
                                        <option value="1" ${(param.hidden=='1') or (staff.hidden and param.hidden==null)?'selected':''}>Inactive</option>
                                    </select>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>

                <!-- Doctor Section -->
                <c:if test="${staff.role eq 'Doctor'}">
                    <div class="card">
                        <div class="card-header">Doctor Information</div>
                        <div class="card-body p-4">
                            <table class="table table-bordered">
                                <tr>
                                    <th>Specialty</th>
                                    <td>
                                        <select name="specialtyID" id="specialtySelect" class="form-select">
                                            <option value="">-- Select specialty --</option>
                                            <c:forEach var="s" items="${specialties}">
                                                <option value="${s.specialtyID}"
                                                        data-price="${s.price}" 
                                                        ${param.specialtyID != null 
                                                          ? (param.specialtyID == s.specialtyID ? 'selected' : '') 
                                                          : (doctor.specialtyID.specialtyID == s.specialtyID ? 'selected' : '')}>
                                                            ${s.specialtyName}
                                                        </option>
                                                </c:forEach>
                                            </select>
                                            <div class="text-danger">${sessionScope.specialtyErrorMsg}</div>
                                            <input type="hidden" name="price" id="specialtyPrice" value="${doctor.specialtyID != null ? doctor.specialtyID.price : 0}">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Years of Experience</th>
                                        <td>
                                            <input type="number" name="yearExperience" class="form-control" min="0"
                                                   value="${param.yearExperience != null ? param.yearExperience : doctor.yearExperience}">
                                            <div class="text-danger">${sessionScope.experienceErrorMsg}</div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>Degrees</th>
                                        <td id="degreesContainer">
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
                                            <div class="mt-2">
                                                <button type="button" class="btn btn-sm btn-primary" id="addDegreeBtn">
                                                    <i class="fa-solid fa-plus me-1"></i>Add
                                                </button>
                                                <button type="button" class="btn btn-sm btn-danger" id="removeDegreeBtn">
                                                    <i class="fa-solid fa-minus me-1"></i>Remove
                                                </button>
                                            </div>
                                        </td>
                                    </tr>

                                </table>
                            </div>
                        </div>
                    </c:if>

                    <!-- Submit Button -->
                    <div class="mt-3">
                        <button type="submit" class="btn btn-success me-2">
                            <i class="fa-solid fa-floppy-disk me-1"></i>Save Changes
                        </button>
                    </div>

                </form>
            </div>

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                $(document).ready(function () {

                    $('#addDegreeBtn').click(function () {
                        $('<input type="text" name="degreeNames" class="form-control mb-1" placeholder="Enter degree name">')
                                .insertBefore($(this).closest('div'));
                    });

                    $('#removeDegreeBtn').click(function () {
                        const inputs = $('#degreesContainer').find('input[name="degreeNames"]');
                        if (inputs.length > 1)
                            inputs.last().remove();
                    });

                });
            </script>
            <script>
                $(document).ready(function () {

                    $('#specialtySelect').change(function () {
                        const selectedOption = $(this).find('option:selected');
                        const price = selectedOption.data('price') || 0;
                        $('#specialtyPrice').val(price);
                    });

                    $('#addDegreeBtn').click(function () {
                        $('<input type="text" name="degreeNames" class="form-control mb-1" placeholder="Enter degree name">')
                                .insertBefore($(this).closest('div'));
                    });

                    $('#removeDegreeBtn').click(function () {
                        const inputs = $('#degreesContainer').find('input[name="degreeNames"]');
                        if (inputs.length > 1)
                            inputs.last().remove();
                    });
                });
            </script>


        </body>
    </html>
