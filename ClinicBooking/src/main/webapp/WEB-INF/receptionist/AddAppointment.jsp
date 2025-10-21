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
            .card {
                border-radius: 10px;
                box-shadow: 0px 3px 6px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
            }
            .required::after {
                content: " *";
                color: red;
            }
            label {
                font-weight: 500;
            }
        </style>
    </head>

    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/receptionist-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/receptionist-manage-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="${pageContext.request.contextPath}/manage-invoice"><i class="fa-solid fa-file-invoice-dollar me-2"></i>Manage Invoice</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fa-solid fa-calendar-plus me-2"></i>Add Appointment</h2>
            </div>

            <form action="${pageContext.request.contextPath}/receptionist-manage-appointment" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="action" value="addAppointment">

                <!-- Appointment Info -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-info-circle me-2"></i>Appointment Information
                    </div>
                    <div class="card-body">
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
                                <input type="datetime-local" class="form-control" name="dateBegin"
                                       value="<%=defaultDateBegin%>" min="<%=defaultDateBegin%>" required>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">Note</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" name="note" rows="2" placeholder="Additional notes..."></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Patient Info -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-user me-2"></i>Patient Information
                    </div>
                    <div class="card-body">
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">Select Existing Patient</label>
                            <div class="col-sm-9">
                                <select class="form-select" name="existingPatientId" id="existingPatientSelect">
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
                                       placeholder="Enter full name"
                                       pattern="[A-Za-z\\s]+" title="Full Name cannot contain numbers or symbols" required>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label required">Phone</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="phone" id="phone"
                                       placeholder="e.g. 0901234567"
                                       pattern="0\\d{9}" title="Phone must start with 0 and have 10 digits" required>
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
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-success me-2">
                        <i class="fa-solid fa-check"></i> Confirm Add Appointment
                    </button>
                    <a href="${pageContext.request.contextPath}/receptionist-manage-appointment" class="btn btn-secondary">
                        <i class="fa-solid fa-xmark"></i> Cancel
                    </a>
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


