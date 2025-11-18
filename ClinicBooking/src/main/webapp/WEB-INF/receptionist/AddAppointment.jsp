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
            /* Body & General */
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }

            label {
                font-weight: 500;
            }

            .required::after {
                content: " *";
                color: red;
            }

            /* Sidebar */
            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #1B5A90;
                color: white;
                position: fixed;
                overflow-y: auto;
            }

            .sidebar a {
                display: block;
                color: white;
                text-decoration: none;
                padding: 12px 20px;
                transition: background 0.2s;
            }

            .sidebar a:hover {
                background-color: #00D0F1;
            }

            /* Main content */
            .main-content {
                margin-left: 260px;
                padding: 25px;
            }

            /* Cards */
            .card {
                border-radius: 10px;
                box-shadow: 0px 3px 6px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
                border-radius: 10px 10px 0 0;
                padding: 10px 15px;
            }

            /* Patient Suggestions */
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
                transition: background 0.2s;
            }

            #patientSuggestions .list-group-item:last-child {
                border-bottom: none;
            }

            #patientSuggestions .list-group-item:hover {
                background-color: #f8f9fa;
            }

            /* Calendar */
            .calendar-container {
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 10px;
                background: #fff;
                max-width: 100%;
            }

            .calendar-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 5px;
                font-weight: 500;
            }

            .calendar-header .nav-btn {
                background: none;
                border: none;
                cursor: pointer;
                font-size: 1rem;
                color: #1B5A90;
                transition: color 0.2s;
            }

            .calendar-header .nav-btn:hover {
                color: #00D0F1;
            }

            .calendar-weekdays {
                display: flex;
                justify-content: space-between;
                font-weight: 500;
                border-bottom: 1px solid #eee;
                padding-bottom: 3px;
                margin-bottom: 5px;
            }

            .calendar-weekdays div {
                width: 14.28%;
                text-align: center;
            }

            .calendar-days {
                display: flex;
                flex-wrap: wrap;
            }

            .calendar-day {
                width: 14.28%;
                height: 40px;
                text-align: center;
                line-height: 40px;
                margin: 2px 0;
                cursor: pointer;
                border-radius: 4px;
                transition: background 0.2s, color 0.2s;
            }

            .calendar-day:hover:not(.disabled) {
                background-color: #d1ecf1;
            }

            .calendar-day.selected {
                background-color: #0d6efd;
                color: #fff;
            }

            .calendar-day.disabled {
                color: #ccc;
                cursor: not-allowed;
            }

            /* Time Slots */
            .time-slots-container {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .time-period {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .time-slots-grid {
                display: flex;
                flex-wrap: wrap;
                gap: 5px;
            }

            .time-slots-container button {
                padding: 10px 15px;
                font-size: 1.1rem;
                min-width: 80px;
                min-height: 50px;
                border-radius: 6px;
                border: 1px solid #0d6efd;
                cursor: pointer;
                transition: all 0.2s;
                background-color: #fff;
            }


            .time-slots-container button:hover {
                background-color: #e7f1ff;
            }

            .time-slots-container button.active {
                background-color: #0d6efd;
                color: #fff;
                border-color: #0d6efd;
            }

            /* DateTime selector layout */
            .datetime-selector {
                display: flex;
                gap: 20px;
                align-items: flex-start;
                flex-wrap: wrap;
            }

            .date-selection, .time-selection {
                flex: 1;
                min-width: 280px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }
                .main-content {
                    margin-left: 0;
                }
                .datetime-selector {
                    flex-direction: column;
                    gap: 15px;
                }
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
                        <!-- Appointment Date & Time Selector -->
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label required">Appointment time</label>
                            <div class="col-sm-9">
                                <div class="datetime-selector">
                                    <!-- Date Selection -->
                                    <div class="date-selection">
                                        <div class="calendar-container">
                                            <div class="calendar-header">
                                                <button type="button" id="prevMonth" class="nav-btn btn btn-sm btn-light">
                                                    <i class="fas fa-chevron-left"></i>
                                                </button>
                                                <span id="monthYear" class="fw-bold"></span>
                                                <button type="button" id="nextMonth" class="nav-btn btn btn-sm btn-light">
                                                    <i class="fas fa-chevron-right"></i>
                                                </button>
                                            </div>
                                            <div class="calendar-weekdays">
                                                <div>Su</div><div>Mo</div><div>Tu</div><div>We</div><div>Th</div><div>Fr</div><div>Sa</div>
                                            </div>
                                            <div class="calendar-days" id="calendarDays"></div>
                                        </div>
                                    </div>

                                    <!-- Time Selection -->
                                    <div class="time-selection">
                                        <div class="time-slots-container">
                                            <div class="time-period mb-2">
                                                <div class="fw-bold mb-1">Morning</div>
                                                <div class="time-slots-grid d-flex flex-wrap gap-1">
                                                    <c:forEach var="t" begin="7" end="11">
                                                        <button type="button" class="time-slot btn btn-outline-primary btn-sm" data-time="${t}:00">${t}:00</button>
                                                        <button type="button" class="time-slot btn btn-outline-primary btn-sm" data-time="${t}:30">${t}:30</button>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="time-period mb-2">
                                                <div class="fw-bold mb-1">Afternoon</div>
                                                <div class="time-slots-grid d-flex flex-wrap gap-1">
                                                    <c:forEach var="t" begin="12" end="16">
                                                        <button type="button" class="time-slot btn btn-outline-primary btn-sm" data-time="${t}:00">${t}:00</button>
                                                        <button type="button" class="time-slot btn btn-outline-primary btn-sm" data-time="${t}:30">${t}:30</button>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hidden inputs -->
                                <input type="hidden" id="appointmentDateTime" name="appointmentDateTime">
                                <input type="hidden" id="selectedDate" name="selectedDate">
                                <input type="hidden" id="selectedTime" name="selectedTime">
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
                        <!-- Search Existing Patient -->
                        <div class="mb-3 row position-relative">
                            <label class="col-sm-3 col-form-label">Search Existing Patient</label>
                            <div class="col-sm-9 position-relative">
                                <input type="text" class="form-control" id="patientSearch" placeholder="Type patient name...">
                                <input type="hidden" name="existingPatientId" id="existingPatientId">
                                <ul id="patientSuggestions" class="list-group"></ul>
                            </div>
                        </div>

                        <!-- First Name -->
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label required">First Name</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="firstName" id="FirstName"
                                       placeholder="Enter first name"
                                       pattern="[A-Za-z ]+" title="Name must contain only English letters and spaces." required>
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.firstNameErrorMsg}">
                                        <c:out value="${sessionScope.firstNameErrorMsg}"/>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Last Name -->
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label required">Last Name</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="lastName" id="LastName"
                                       placeholder="Enter last name"
                                       pattern="[A-Za-z ]+" title="Name must contain only English letters and spaces." required>
                                <div class="text-danger">
                                    <c:if test="${not empty sessionScope.lastNameErrorMsg}">
                                        <c:out value="${sessionScope.lastNameErrorMsg}"/>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Phone -->
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

                        <!-- Gender -->
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

        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-end">
            <button type="submit" class="btn btn-success me-2">
                <i class="fa-solid fa-check"></i>  Add
            </button>
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
    $(document).ready(function () {
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

<script>
    let currentDate = new Date();
    let selectedDateStr = '';
    let selectedTimeStr = '';

    // Render calendar
    function renderCalendar() {
        const monthYear = document.getElementById('monthYear');
        const calendarDays = document.getElementById('calendarDays');
        const year = currentDate.getFullYear();
        const month = currentDate.getMonth();
        monthYear.textContent = new Intl.DateTimeFormat('en-US', {month: 'long', year: 'numeric'}).format(currentDate);

        calendarDays.innerHTML = '';
        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const today = new Date();
        const minDate = new Date(today.getTime() + 24 * 60 * 60 * 1000); // 24h after now
        const maxDate = new Date(today.getTime() + 30 * 24 * 60 * 60 * 1000); // 30 days ahead

        for (let i = 0; i < firstDay; i++) {
            const emptyDiv = document.createElement('div');
            emptyDiv.className = 'calendar-day empty';
            calendarDays.appendChild(emptyDiv);
        }

        for (let day = 1; day <= daysInMonth; day++) {
            const dayEl = document.createElement('div');
            dayEl.className = 'calendar-day';
            dayEl.textContent = day;
            const dayDate = new Date(year, month, day);
            if (dayDate < minDate || dayDate > maxDate)
                dayEl.classList.add('disabled');
            else
                dayEl.addEventListener('click', () => selectDate(dayDate, dayEl));
            calendarDays.appendChild(dayEl);
        }
    }

    function selectDate(date, element) {
        document.querySelectorAll('.calendar-day.selected').forEach(e => e.classList.remove('selected'));
        element.classList.add('selected');
        selectedDateStr = date.toISOString().split('T')[0];
        document.getElementById('selectedDate').value = selectedDateStr;
        updateDateTime();
    }

    // Setup time slot selection
    function setupTimeSlots() {
        document.querySelectorAll('.time-slot').forEach(slot => {
            slot.addEventListener('click', () => {
                document.querySelectorAll('.time-slot').forEach(s => s.classList.remove('active'));
                slot.classList.add('active');
                selectedTimeStr = slot.dataset.time;
                document.getElementById('selectedTime').value = selectedTimeStr;
                updateDateTime();
            });
        });
    }

    function updateDateTime() {
        if (selectedDateStr && selectedTimeStr) {
            document.getElementById('appointmentDateTime').value = selectedDateStr + 'T' + selectedTimeStr;
        }
    }

    function navigateMonth(direction) {
        currentDate.setMonth(currentDate.getMonth() + direction);
        renderCalendar();
    }

    // Init
    document.addEventListener('DOMContentLoaded', () => {
        renderCalendar();
        setupTimeSlots();
        document.getElementById('prevMonth').addEventListener('click', () => navigateMonth(-1));
        document.getElementById('nextMonth').addEventListener('click', () => navigateMonth(1));
    });
</script>
</body>
</html>


