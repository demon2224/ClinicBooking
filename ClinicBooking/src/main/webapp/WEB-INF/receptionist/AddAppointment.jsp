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
            #patientSuggestions {
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                z-index: 2000;
                background: #fff;
                border: 1px solid #ccc;
                border-top: none;
                border-radius: 0 0 8px 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                max-height: 200px;
                overflow-y: auto;
                display: none;
            }

            #patientSuggestions .list-group-item {
                border: none;
                border-bottom: 1px solid #eee;
                padding: 10px 12px;
                cursor: pointer;
            }

            #patientSuggestions .list-group-item:last-child {
                border-bottom: none;
            }

            #patientSuggestions .list-group-item:hover {
                background-color: #f8f9fa;
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
                                <select class="form-select" id="specialtySelect" name="specialtyID" required>
                                    <option value="">-- Select Specialty --</option>
                                    <c:forEach var="s" items="${specialties}">
                                        <option value="${s[0]}">${s[1]}</option>
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
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.doctorErrorMsg}">
                                        <c:out value="${sessionScope.doctorErrorMsg}"/>
                                    </c:if>
                                </div>
                            </div>
                        </div>


                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label required">Date Begin</label>
                            <div class="col-sm-9">
                                <input type="datetime-local" class="form-control" name="dateBegin"
                                       value="<%=defaultDateBegin%>" min="<%=defaultDateBegin%>" required>
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.dateErrorMsg}">
                                        <c:out value="${sessionScope.dateErrorMsg}"/>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">Note</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" name="note" rows="2" placeholder="Additional notes..."></textarea>
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.noteErrorMsg}">
                                        <c:out value="${sessionScope.noteErrorMsg}"/>
                                    </c:if>
                                </div>
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
                        <div class="mb-3 row position-relative">
                            <label class="col-sm-3 col-form-label">Search Existing Patient</label>
                            <div class="col-sm-9 position-relative">
                                <input type="text" class="form-control" id="patientSearch" placeholder="Type patient name...">
                                <input type="hidden" name="existingPatientId" id="existingPatientId">
                                <ul id="patientSuggestions" class="list-group"></ul>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label required">Full Name</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="patientName" id="patientName"
                                       placeholder="Enter full name"
                                       pattern="[A-Za-z ]+" title="Full name must contain only English letters and spaces." required>
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.patientNameErrorMsg}">
                                        <c:out value="${sessionScope.patientNameErrorMsg}"/>
                                    </c:if>
                                </div>
                            </div>
                        </div>


                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label required">Phone</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="phone" id="phone"
                                       placeholder="e.g. 0901234567"
                                       pattern="0\\d{9,10}" title="Phone must start with 0 and contain 10–11 digits" required>
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.phoneErrorMsg}">
                                        <c:out value="${sessionScope.phoneErrorMsg}"/>
                                    </c:if>
                                </div>
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
                        <i class="fa-solid fa-check"></i>  Add
                    </button>
<!--                    <a href="${pageContext.request.contextPath}/receptionist-manage-appointment" class="btn btn-secondary">
                        <i class="fa-solid fa-xmark"></i> Cancel
                    </a>-->
                </div>
            </form>
        </div>
        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $('#specialtySelect').change(function () {
                var specialtyId = $(this).val();
                if (specialtyId) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/receptionist-manage-appointment',
                        type: 'get',
                        data: {action: 'getDoctorsBySpecialty', specialtyID: specialtyId},
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

            dateInput.addEventListener("change", function () {
                const selected = new Date(this.value);
                const now = new Date();
                if (selected < now) {
                    alert("You cannot select a past date or time!");
                    this.value = "";
                }
            });


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
        <script>
            $(document).ready(function () {
                // Khi người dùng gõ tên bệnh nhân
                $('#patientSearch').on('input', function () {
                    let query = $(this).val().trim();
                    if (query.length < 2) {
                        $('#patientSuggestions').hide();
                        return;
                    }

                    $.ajax({
                        url: '${pageContext.request.contextPath}/receptionist-manage-appointment',
                        type: 'get',
                        data: {action: 'searchPatients', query: query},
                        success: function (data) {
                            let list = $('#patientSuggestions');
                            list.empty();

                            if (data.length === 0) {
                                list.hide();
                                return;
                            }

                            $.each(data, function (i, p) {
                                list.append('<li class="list-group-item list-group-item-action" data-id="' + p.id + '">'
                                        + p.name + '</li>');
                            });

                            list.show();
                        },
                        error: function () {
                            console.error('Error fetching patients');
                        }
                    });
                });

                // Khi chọn 1 gợi ý
                $(document).on('click', '#patientSuggestions li', function () {
                    const name = $(this).text();
                    const id = $(this).data('id');
                    $('#patientSearch').val(name);
                    $('#existingPatientId').val(id);
                    $('#patientSuggestions').hide();

                    // Disable nhập mới nếu đã chọn bệnh nhân cũ
                    $('#patientName, #phone, #genderSelect').prop('disabled', true);
                });

                // Khi xóa text => bật lại input
                $('#patientSearch').on('input', function () {
                    if ($(this).val().trim() === '') {
                        $('#existingPatientId').val('');
                        $('#patientName, #phone, #genderSelect').prop('disabled', false);
                    }
                });
            });
        </script>

    </body>
</html>


