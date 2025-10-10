<%-- 
    Document   : AddAppointment
    Created on : Oct 11, 2025
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%
    LocalDateTime now = LocalDateTime.now();
    String defaultDateBegin = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Appointment</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
            }
            body {
                background-color: #f8f9fa;
                font-family: "Segoe UI", sans-serif;
            }
            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #1B5A90;
                color: white;
                position: fixed;
                top: 0;
                left: 0;
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
            .container {
                margin-left: 260px;
                margin-top: 40px;
                background: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                max-width: 900px;
            }
            h3.section-title {
                color: #0d6efd;
                font-weight: 600;
                border-bottom: 2px solid #0d6efd;
                padding-bottom: 6px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/doctor-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/manage-my-patient-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="#"><i class="fa-solid fa-user-doctor me-2"></i>Manage Medical Record</a>
            <a href="#"><i class="fa-solid fa-user me-2"></i>Manage Prescription</a>
        </div>

        <div class="container">
            <h3 class="section-title">Add New Appointment</h3>

            <form action="${pageContext.request.contextPath}/receptionist-dashboard" method="post">
                <input type="hidden" name="action" value="addAppointment">

                <!-- Appointment Info -->
                <h5>Appointment Information</h5>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Specialty</label>
                    <div class="col-sm-9">
                        <select class="form-select" id="specialtySelect" name="specialtyName" required>
                            <option value="">-- Select Specialty --</option>
                            <c:forEach var="s" items="${specialties}">
                                <option value="${s[1]}">${s[1]}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Doctor</label>
                    <div class="col-sm-9">
                        <select class="form-select" id="doctorSelect" name="doctorId" required>
                            <option value="">-- Select Doctor --</option>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Date Begin</label>
                    <div class="col-sm-9">
                        <input type="datetime-local" class="form-control" name="dateBegin" value="<%=defaultDateBegin%>" readonly>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Date End</label>
                    <div class="col-sm-9">
                        <input type="datetime-local" class="form-control" name="dateEnd">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Note</label>
                    <div class="col-sm-9">
                        <textarea class="form-control" name="note"></textarea>
                    </div>
                </div>

                <!-- Patient Info -->
                <h5>Patient Information</h5>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Full Name</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="patientName" required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Email</label>
                    <div class="col-sm-9">
                        <input type="email" class="form-control" name="email">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Phone</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="phone">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Gender</label>
                    <div class="col-sm-9">
                        <select class="form-select" name="gender">
                            <option value="">-- Select Gender --</option>
                            <option value="1">Male</option>
                            <option value="0">Female</option>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Date of Birth</label>
                    <div class="col-sm-9">
                        <input type="date" class="form-control" name="dob">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Address</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="address">
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-success me-2">Confirm Add Appointment</button>
                    <a href="${pageContext.request.contextPath}/receptionist-dashboard" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $('#specialtySelect').change(function () {
                var specialtyName = $(this).val();
                if (specialtyName) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/receptionist-dashboard',
                        type: 'get',
                        data: {action: 'getDoctorsBySpecialty', specialtyName: specialtyName},
                        success: function (data) {
                            var doctorSelect = $('#doctorSelect');
                            doctorSelect.empty();
                            doctorSelect.append('<option value="">-- Select Doctor --</option>');
                            $.each(data, function (index, doc) {
                                doctorSelect.append('<option value="' + doc.doctorID + '">' + doc.doctorName + '</option>');
                            });
                        },
                        error: function () {
                            alert('Cannot load doctors for this specialty.');
                        }
                    });
                } else {
                    $('#doctorSelect').empty().append('<option value="">-- Select Doctor --</option>');
                }
            });
        </script>
    </body>
</html>
