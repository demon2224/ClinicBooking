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
        <style>
            .container {
                margin-top: 40px;
                max-width: 800px;
            }
            h3.section-title {
                color: #0d6efd;
                border-bottom: 2px solid #0d6efd;
                padding-bottom: 6px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
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
                    <label class="col-sm-3 col-form-label">Note</label>
                    <div class="col-sm-9">
                        <textarea class="form-control" name="note"></textarea>
                    </div>
                </div>

                <!-- Patient Info -->
                <h5>Patient Information</h5>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Select Existing Patient</label>
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
                    <label class="col-sm-3 col-form-label">Full Name</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="patientName" placeholder="Required if new patient">
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Phone</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="phone" placeholder="Required if new patient">
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label">Gender</label>
                    <div class="col-sm-9">
                        <select class="form-select" name="gender">
                            <option value="true">Male</option>
                            <option value="false">Female</option>
                        </select>
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
