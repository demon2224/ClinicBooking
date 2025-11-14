<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Account</title>
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
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/admin-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin-manage-account"><i class="fa-solid fa-users me-2"></i>Manage Account</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h2 class="mb-4"><i class="fa-solid fa-user-plus me-2"></i>Add New Account</h2>

            <form action="${pageContext.request.contextPath}/admin-manage-account" method="post">
                <input type="hidden" name="action" value="add"/>

                <h3 class="section-title">Account Information</h3>
                <table class="table table-bordered">

                    <!-- Username -->
                    <tr>
                        <th>Username</th>
                        <td>
                            <input type="text" name="accountName" class="form-control"
                                   value="${param.accountName}" placeholder="Enter username">
                            <div class="text-danger">${sessionScope.usernameErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Password -->
                    <tr>
                        <th>Password</th>
                        <td>
                            <input type="password" name="accountPassword" class="form-control"
                                   placeholder="Enter password">
                            <div class="text-danger">${sessionScope.passwordErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Full Name -->
                    <tr>
                        <th>Full Name</th>
                        <td>
                            <input type="text" name="fullName" class="form-control"
                                   value="${param.fullName}" placeholder="e.g. John Smith">
                            <div class="text-danger">${sessionScope.fullNameErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Role -->
                    <tr>
                        <th>Role</th>
                        <td>
                            <select name="role" id="roleSelect" class="form-select">
                                <option value="">-- Select role --</option>

                                <option value="Doctor"      ${param.role == 'Doctor' ? 'selected' : ''}>Doctor</option>
                                <option value="Pharmacist"  ${param.role == 'Pharmacist' ? 'selected' : ''}>Pharmacist</option>
                                <option value="Receptionist"${param.role == 'Receptionist' ? 'selected' : ''}>Receptionist</option>
                                <option value="Admin"       ${param.role == 'Admin' ? 'selected' : ''}>Admin</option>
                            </select>
                            <div class="text-danger">${sessionScope.roleErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Job Status -->
                    <tr>
                        <th>Job Status</th>
                        <td>
                            <select name="jobStatus" class="form-select">
                                <option value="Available"    ${param.jobStatus == 'Available' ? 'selected' : ''}>Available</option>
                                <option value="Unavailable"  ${param.jobStatus == 'Unavailable' ? 'selected' : ''}>Unavailable</option>
                                <option value="Retired"      ${param.jobStatus == 'Retired' ? 'selected' : ''}>Retired</option>
                            </select>
                        </td>
                    </tr>

                    <!-- Phone -->
                    <tr>
                        <th>Phone</th>
                        <td>
                            <input type="text" name="phoneNumber" class="form-control"
                                   value="${param.phoneNumber}" placeholder="e.g. 0912345678">
                            <div class="text-danger">${sessionScope.phoneErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- DOB -->
                    <tr>
                        <th>Date of Birth</th>
                        <td>
                            <input type="date" name="dob" id="dobInput" class="form-control"
                                   value="${param.dob}">
                            <div class="text-danger">${sessionScope.dobErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Gender -->
                    <tr>
                        <th>Gender</th>
                        <td>
                            <select name="gender" class="form-select">
                                <option value="">-- Select gender --</option>
                                <option value="true"  ${param.gender == 'true' ? 'selected' : ''}>Male</option>
                                <option value="false" ${param.gender == 'false' ? 'selected' : ''}>Female</option>
                            </select>
                        </td>
                    </tr>

                    <!-- Address -->
                    <tr>
                        <th>Address</th>
                        <td>
                            <input type="text" name="userAddress" class="form-control"
                                   value="${param.userAddress}" placeholder="Enter address">
                            <div class="text-danger">${sessionScope.addressErrorMsg}</div>
                        </td>
                    </tr>

                    <!-- Hidden -->
                    <tr>
                        <th>Status</th>
                        <td>
                            <select name="hidden" class="form-select">
                                <option value="0" ${param.hidden == '0' ? 'selected' : ''}>Active</option>
                                <option value="1" ${param.hidden == '1' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </td>
                    </tr>

                </table>

                <!-- Doctor Section -->
                <div id="doctorSection" style="display:none;">
                    <h3 class="section-title">Doctor Information</h3>

                    <table class="table table-bordered">
                        <tr>
                            <th>Specialty</th>
                            <td>
                                <select name="specialtyID" id="specialtySelect" class="form-select">
                                    <option value="">-- Select specialty --</option>

                                    <c:forEach var="s" items="${specialties}">
                                        <option value="${s.specialtyID}"
                                                data-price="${s.price}"
                                                ${param.specialtyID == s.specialtyID ? 'selected' : ''}>
                                            ${s.specialtyName}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="text-danger">${sessionScope.specialtyErrorMsg}</div>
                            </td>
                        </tr>

                        <tr>
                            <th>Years of Experience</th>
                            <td>
                                <input type="number" name="yearExperience"
                                       value="${param.yearExperience}"
                                       class="form-control" min="0">
                                <div class="text-danger">${sessionScope.experienceErrorMsg}</div>
                            </td>
                        </tr>

                        <tr>
                            <th>Consultation Price</th>
                            <td>
                                <input type="number" id="priceField" name="price"
                                       class="form-control"
                                       value="${param.price}" readonly>
                                <div class="text-danger">${sessionScope.priceErrorMsg}</div>
                            </td>
                        </tr>

                        <tr>
                            <th>Degrees</th>
                            <td id="degreesContainer">
                                <c:choose>
                                    <c:when test="${not empty paramValues.degreeNames}">
                                        <c:forEach var="d" items="${paramValues.degreeNames}">
                                            <input type="text" name="degreeNames" class="form-control mb-1"
                                                   value="${d}">
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" name="degreeNames" class="form-control mb-1" placeholder="Enter degree name">
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

                <div class="mt-3">
                    <button type="submit" class="btn btn-success me-2">
                        <i class="fa-solid fa-floppy-disk me-1"></i>Create Account
                    </button>
                </div>

            </form>
        </div>


        <!-- Script -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {

                // Toggle doctor section based on selected role
                function toggleDoctorSection() {
                    const role = $('#roleSelect').val();
                    if (role === 'Doctor')
                        $('#doctorSection').slideDown();
                    else
                        $('#doctorSection').slideUp();
                }
                toggleDoctorSection();
                $('#roleSelect').change(toggleDoctorSection);

                // Add degree input
                $('#addDegreeBtn').click(function () {
                    $('<input type="text" name="degreeNames" class="form-control mb-1" placeholder="Enter degree name">')
                            .insertBefore($(this).closest('div'));
                });

                // Remove degree input
                $('#removeDegreeBtn').click(function () {
                    const inputs = $('#degreesContainer').find('input[name="degreeNames"]');
                    if (inputs.length > 1)
                        inputs.last().remove();
                });

                // DOB range
                const today = new Date();
                const yyyy = today.getFullYear();
                const mm = String(today.getMonth() + 1).padStart(2, '0');
                const dd = String(today.getDate()).padStart(2, '0');
                $('#dobInput').attr('max', (yyyy - 18) + '-' + mm + '-' + dd);
                $('#dobInput').attr('min', (yyyy - 120) + '-' + mm + '-' + dd);
            });
            $('#specialtySelect').change(function () {
                const price = $(this).find(':selected').data('price') || '';
                $('#priceField').val(price);
            });

        </script>

    </body>
</html>
