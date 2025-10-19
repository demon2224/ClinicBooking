<%--
    Document   : ManageMyAppointment
    Created on : Oct 7, 2025, 12:30:00 AM
    Author     : Le Anh Tuan - CE180905
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage My Appointments - CLINIC</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </style>
</head>
<body class="appointment-page">
    <!-- Include Header -->
    <jsp:include page="includes/header.jsp">
        <jsp:param name="activePage" value="manage-appointments" />
    </jsp:include>

    <!-- Main Content -->
    <main class="appointment-main-content">
        <!-- Page Header -->
        <div class="appointment-page-header">
            <h1><i class="fas fa-calendar-check"></i> Manage My Appointments</h1>
        </div>
        <!-- Message Display -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="appointment-alert appointment-alert-success">
                <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="appointment-alert appointment-alert-error">
                <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <!-- Search and Filter Section -->
        <div class="search-filter-section">
            <div class="search-filter-content">
                <form method="GET"
                      action="${pageContext.request.contextPath}/manage-my-appointments"
                      class="search-form">

                    <div class="search-row">
                        <!-- Search Input -->
                        <div class="search-input-group">
                            <i class="fas fa-search"></i>
                            <input type="text"
                                   name="search"
                                   placeholder="Search for doctors by name..."
                                   value="${searchQuery}"
                                   class="search-input" />
                        </div>

                        <!-- Search Button -->
                        <button type="submit" class="btn-search">
                            <i class="fas fa-search"></i>
                            Search
                        </button>

                        <!-- Clear Button -->
                        <a href="${pageContext.request.contextPath}/manage-my-appointments"
                           class="btn-clear">
                            <i class="fas fa-times"></i>
                            Clear
                        </a>
                    </div>
                </form>
            </div>
        </div>


        <!-- Appointments Section -->
        <div class="appointments-section">
            <div class="appointments-content">
                <c:choose>
                    <c:when test="${empty appointments}">
                        <!-- Empty State -->
                        <div class="appointment-empty-state">
                            <i class="fas fa-calendar-times"></i>
                            <h3>No Appointments Found</h3>
                            <p>You don't have any appointments scheduled yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Display Appointments -->
                        <c:forEach var="appointment" items="${appointments}">
                            <div class="appointment-card">
                                <div class="appointment-header">
                                    <div class="appointment-info">
                                        <div class="appointment-date">
                                            <i class="fas fa-calendar"></i>
                                            <fmt:formatDate value="${appointment.dateBegin}"
                                                            pattern="EEEE, MMMM dd, yyyy 'at' hh:mm a" />
                                        </div>
                                        <div class="appointment-doctor">
                                            <i class="fas fa-user-md"></i>
                                            Dr. ${appointment.doctorName != null ? appointment.doctorName : 'Unknown Doctor'}
                                        </div>
                                        <div class="appointment-specialty">
                                            <i class="fas fa-stethoscope"></i>
                                            ${appointment.specialtyName != null ? appointment.specialtyName : 'General'}
                                            <c:if test="${not empty appointment.note}"> - ${appointment.note}</c:if>
                                            </div>
                                        </div>
                                        <div class="appointment-status
                                        <c:choose>
                                            <c:when test="${appointment.appointmentStatusID == 2}">status-approved</c:when>
                                            <c:when test="${appointment.appointmentStatusID == 1}">status-pending</c:when>
                                            <c:when test="${appointment.appointmentStatusID == 4}">status-cancelled</c:when>
                                            <c:when test="${appointment.appointmentStatusID == 3}">status-completed</c:when>
                                            <c:otherwise>status-pending</c:otherwise>
                                        </c:choose>">
                                        ${appointment.statusName != null ? appointment.statusName : 'Unknown'}
                                    </div>
                                </div>
                                <div class="appointment-actions">
                                    <a href="${pageContext.request.contextPath}/manage-my-appointments?id=${appointment.appointmentID}" class="btn-action btn-view">
                                        <i class="fas fa-eye"></i>
                                        View Details
                                    </a>

                                    <!-- Only show cancel button for pending appointments -->
                                    <c:if test="${appointment.appointmentStatusID == 1}">
                                        <button class="btn-action btn-cancel"
                                                data-appointment-id="${appointment.appointmentID}">
                                            <i class="fas fa-times"></i>
                                            Cancel
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <!-- JavaScript for interactivity -->
    <script>
        // Cancel appointment function
        function cancelAppointment(appointmentId) {
            if (confirm('Are you sure you want to cancel this appointment?')) {
                // Send request to cancel appointment
                window.location.href = '${pageContext.request.contextPath}/manage-my-appointments?action=cancel&appointmentId=' + appointmentId;
            }
        }

        // Dropdown menu functionality
        document.addEventListener('DOMContentLoaded', function () {
            const dropdowns = document.querySelectorAll('.dropdown');

            dropdowns.forEach(dropdown => {
                const toggle = dropdown.querySelector('.dropdown-toggle');
                const menu = dropdown.querySelector('.dropdown-menu');

                if (toggle && menu) {
                    // Handle click for dropdown
                    toggle.addEventListener('click', function (e) {
                        e.preventDefault();

                        // Close other dropdowns
                        dropdowns.forEach(otherDropdown => {
                            if (otherDropdown !== dropdown) {
                                const otherMenu = otherDropdown.querySelector('.dropdown-menu');
                                if (otherMenu) {
                                    otherMenu.style.opacity = '0';
                                    otherMenu.style.visibility = 'hidden';
                                    otherMenu.style.transform = 'translateY(-10px)';
                                }
                            }
                        });

                        // Toggle current dropdown
                        const isVisible = menu.style.opacity === '1';
                        if (isVisible) {
                            menu.style.opacity = '0';
                            menu.style.visibility = 'hidden';
                            menu.style.transform = 'translateY(-10px)';
                        } else {
                            menu.style.opacity = '1';
                            menu.style.visibility = 'visible';
                            menu.style.transform = 'translateY(0)';
                        }
                    });
                }
            });

            // Close dropdown when clicking outside
            document.addEventListener('click', function (e) {
                if (!e.target.closest('.dropdown')) {
                    dropdowns.forEach(dropdown => {
                        const menu = dropdown.querySelector('.dropdown-menu');
                        if (menu) {
                            menu.style.opacity = '0';
                            menu.style.visibility = 'hidden';
                            menu.style.transform = 'translateY(-10px)';
                        }
                    });
                }
            });
        });

        // Appointment actions
        document.addEventListener('DOMContentLoaded', function () {
            // Cancel appointment confirmation
            document.querySelectorAll('.btn-cancel').forEach(button => {
                button.addEventListener('click', function (e) {
                    e.preventDefault();
                    const appointmentId = this.getAttribute('data-appointment-id');
                    if (confirm('Are you sure you want to cancel this appointment? This action cannot be undone.')) {
                        // Create form to submit cancellation
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '${pageContext.request.contextPath}/manage-my-appointments';

                        const actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        actionInput.value = 'cancel';

                        const idInput = document.createElement('input');
                        idInput.type = 'hidden';
                        idInput.name = 'appointmentId';
                        idInput.value = appointmentId;

                        form.appendChild(actionInput);
                        form.appendChild(idInput);
                        document.body.appendChild(form);
                        form.submit();
                    }
                });
            });
        });
    </script>
</body>
</html>