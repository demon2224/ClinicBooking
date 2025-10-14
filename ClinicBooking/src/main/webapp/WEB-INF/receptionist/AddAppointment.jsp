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
        <title>Doctor Dashboard</title>
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
            .required::after {
                content: " *";
                color: red;
            }
            .card {
                border-radius: 10px;
            }
            .table img {
                border-radius: 50%;
                width: 40px;
                height: 40px;
            }
            .status-toggle {
                width: 40px;
                height: 20px;
            }
            .navbar {
                background: white;
                border-bottom: 1px solid #dee2e6;
            }
            #Logout {
                color: red;
                border-color: red;
            }
            #Logout:hover {
                background-color: red;
                color: white;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/receptionist-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/receptionist-manage-appointment?action"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="#"><i class="fa-solid fa-user-doctor me-2"></i>Manage Invoice</a>
        </div>

        <!-- Main Container -->
        <div class="container">
            <h3 class="section-title">Add Appointment</h3>

            <form action="${pageContext.request.contextPath}/receptionist-manage-appointment" method="post">
                <input type="hidden" name="action" value="addAppointment">

                <!-- Appointment Info -->
                <h5>Appointment Information</h5>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label required">Specialty</label>
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
                    <label class="col-sm-3 col-form-label required">Doctor</label>
                    <div class="col-sm-9">
                        <select class="form-select" id="doctorSelect" name="doctorId" required>
                            <option value="">-- Select Doctor --</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label required">Date Begin</label>
                    <div class="col-sm-9">
                        <input 
                            type="datetime-local"
                            class="form-control"
                            name="dateBegin"
                            value="<%=defaultDateBegin%>"
                            min="<%=defaultDateBegin%>"
                            required>
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
                    <label class="col-sm-3 col-form-label required">Select Existing Patient</label>
                    <div class="col-sm-9">
                        <select class="form-select" name="existingPatientId">
                            <option value="">-- New Patient --</option>
                            <c:forEach var="p" items="${patients}">
                                <option value="${p.userId}">${p.fullName} - ${p.phone}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label required">Full Name</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="patientName" id="patientName"
                               placeholder="Required if new patient"
                               pattern="[A-Za-z\s]+" title="Full Name cannot contain special characters or numbers"
                               required>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label required">Phone</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="phone" id="phone"
                               placeholder="Required if new patient"
                               pattern="0\d{9}" title="Phone must start with 0 and have 10 digits">
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label required">Gender</label>
                    <div class="col-sm-9">
                        <select class="form-select" name="gender" id="genderSelect">
                            <option value="true">Male</option>
                            <option value="false">Female</option>
                        </select>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-success me-2">Confirm Add Appointment</button>
                    <a href="${pageContext.request.contextPath}/receptionist-manage-appointment" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $('#specialtySelect').change(function () {
                var specialtyName = $(this).val();
                if (specialtyName) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/receptionist-manage-appointment',
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

            function togglePatientFields() {
                var existingPatient = $('select[name="existingPatientId"]').val();
                if (existingPatient) {
                    $('#patientName, #phone, #genderSelect').prop('disabled', true);
                } else {
                    $('#patientName, #phone, #genderSelect').prop('disabled', false);
                }
            }

            togglePatientFields();
            $('select[name="existingPatientId"]').change(function () {
                togglePatientFields();
            });
        </script>
        <script>
            const dateInput = document.querySelector('input[name="dateBegin"]');
            dateInput.addEventListener('keydown', e => e.preventDefault());

            const dateInput = document.querySelector('input[name="dateBegin"]');

            function setMinDateTime() {
                const now = new Date();
                now.setMinutes(now.getMinutes() - now.getTimezoneOffset()); // adjust timezone
                dateInput.min = now.toISOString().slice(0, 16);
            }

            // Prevent selecting a past date or time
            dateInput.addEventListener("change", function () {
                const selected = new Date(this.value);
                const now = new Date();
                if (selected < now) {
                    alert("You cannot select a past date or time!");
                    this.value = "";
                }
            });

            // Set minimum date and time when the page loads
            setMinDateTime();
        </script>
    </body>
</html>
