<%--
    Document   : ManageMyPatientAppointment
    Created on : 10 Oct. 2025, 7:07:00 pm
    Author     : Le Thien Tri - CE191249
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage My Patient Appointments</title>
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
            .navbar {
                background: white;
                border-bottom: 1px solid #dee2e6;
                padding: 12px 24px;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
            }
            .table th {
                background-color: #f1f3f5;
                font-weight: 600;
            }
            .table td, .table th {
                vertical-align: middle;
            }
            #Logout {
                color: red;
                border-color: red;
                transition: all 0.3s;
            }
            #Logout:hover {
                background-color: red;
                color: white;
            }
        </style>
    </head>

    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">
            <nav class="navbar navbar-light justify-content-between px-3 py-2 border-bottom shadow-sm">
                <h3 class="fw-bold text-primary mb-0 d-flex align-items-center">
                    <i class="fa-solid fa-calendar-days me-2"></i>
                    Manage My Patient Appointments
                </h3>
                <form class="d-flex align-items-center"
                      action="${pageContext.request.contextPath}/manage-my-patient-appointment" method="get">
                    <input class="form-control me-2" type="text" name="keyword"
                           placeholder="Search by patient name..." value="${param.keyword}">
                    <button class="btn btn-outline-primary me-3 d-flex align-items-center" type="submit">
                        <i class="fa-solid fa-magnifying-glass me-2"></i>
                        <span>Search</span>
                    </button>
                    <a href="${pageContext.request.contextPath}/staff-logout"
                       class="btn btn-outline-danger d-flex align-items-center" id="Logout">
                        <i class="fa-solid fa-right-from-bracket me-2"></i>
                        <span>Logout</span>
                    </a>
                </form>
            </nav>


            <!-- Appointment List -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fa-solid fa-list me-2"></i>Appointment List
                </div>
                <div class="card-body p-4">
                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Patient Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Date Begin</th>
                                <th>Note</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="list" items="${list}" varStatus="item">
                                <tr>
                                    <td>${item.count}</td>
                                    <td>${list.patientID.firstName} ${list.patientID.lastName}</td>
                                    <td>${list.patientID.email}</td>
                                    <td>${list.patientID.phoneNumber}</td>
                                    <td><fmt:formatDate value="${list.dateBegin}" pattern="yyyy/MM/dd HH:mm"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(list.note) > 20}">
                                                ${fn:substring(list.note, 0, 20)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${list.note}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="badge
                                              <c:choose>
                                                  <c:when test="${list.appointmentStatus eq 'Pending'}">bg-warning text-dark</c:when>
                                                  <c:when test="${list.appointmentStatus eq 'Approved'}">bg-primary</c:when>
                                                  <c:when test="${list.appointmentStatus eq 'Completed'}">bg-success</c:when>
                                                  <c:when test="${list.appointmentStatus eq 'Canceled'}">bg-danger</c:when>
                                                  <c:otherwise>bg-secondary</c:otherwise>
                                              </c:choose>">
                                            ${list.appointmentStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/manage-my-patient-appointment?action=detail&appointmentID=${list.appointmentID}"
                                           class="btn btn-sm btn-info text-white">
                                            <i class="fa-solid fa-eye"></i> View Detail
                                        </a>
                                        <c:choose>
                                            <c:when test="${list.appointmentStatus eq 'Approved' and list.hasRecord}">
                                                <button type="button"
                                                        class="btn btn-sm btn-success text-white"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#confirmCompleteModal"
                                                        data-appointment-id="${list.appointmentID}">
                                                    <i class="fa-solid fa-check"></i> Completed
                                                </button>

                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-sm btn-secondary" disabled>
                                                    <i class="fa-solid fa-check"></i> Completed
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>                                  
                                </tr>
                            </c:forEach>

                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">
                                        <i class="fa-solid fa-circle-info me-2"></i>No appointments found.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- Bootstrap notice Modal -->
        <div class="modal fade" id="success" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-circle-exclamation me-2"></i>Successfully</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ${sessionScope.message}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap Error Modal -->
        <div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-circle-exclamation me-2"></i>Error</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ${sessionScope.error}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Confirm Complete Modal -->
    <div class="modal fade" id="confirmCompleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-dark">
                    <h5 class="modal-title text-white">
                        <i class="fa-solid fa-circle-question me-2"></i>Confirm Completion
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    Are you sure you want to mark this appointment as <b>Completed</b>?
                </div>

                <div class="modal-footer">       

                    <a id="confirmCompleteBtn" href="#" class="btn btn-success">
                        Yes, Complete
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var confirmModal = document.getElementById('confirmCompleteModal');
        confirmModal.addEventListener('show.bs.modal', function (event) {

            var button = event.relatedTarget;
            var appointmentID = button.getAttribute('data-appointment-id');

            var confirmBtn = document.getElementById('confirmCompleteBtn');
            confirmBtn.href = "${pageContext.request.contextPath}/manage-my-patient-appointment?action=completed&appointmentID=" + appointmentID;
        });
    </script>

    <c:if test="${not empty sessionScope.message}">
        <script>
            window.onload = function () {
                var myModal = new bootstrap.Modal(document.getElementById('success'));
                myModal.show();
            };
        </script>
        <c:remove var="message" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <script>
            window.onload = function () {
                var myModal = new bootstrap.Modal(document.getElementById('errorModal'));
                myModal.show();
            };
        </script>
        <c:remove var="error" scope="session" />
    </c:if>
</body>

</html>
