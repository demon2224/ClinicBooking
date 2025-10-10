<%-- 
    Document   : ReceptionistDashboard
    Created on : Oct 8, 2025, 1:32:20 AM
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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

            #Logout{
                color: red;
                border-color: red;

            }
            #Logout:hover{
                background-color: red;
                color: white;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="#"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="#"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="#"><i class="fa-solid fa-user-doctor me-2"></i>Manage Invoice</a>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <nav class="navbar navbar-light">
                <div class="container-fluid">
                    <form class="d-flex w-50" method="get" action="${pageContext.request.contextPath}/receptionist-dashboard">
                        <input class="form-control me-2" type="search" name="searchQuery" placeholder="Search here" value="${param.searchQuery}">
                        <button class="btn btn-outline-primary" type="submit">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                    <div>
                        <button class="btn btn-submit" id="Logout" type="submit">Logout</button>
                    </div>
                </div>
            </nav>

            <div class="container-fluid mt-4">
                <!-- Appointment List -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Appointment List</h5>
                        <!-- Add Appointment button -->
                        ​        <a href="#" class="btn btn-primary">
                            <i class="fa-solid fa-plus me-1"></i> Add
                        </a>
                    </div>
                    <div class="card-body">
                        <table class="table align-middle table-hover">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Doctor Name</th>
                                    <th>Specialty</th>
                                    <th>Patient Name</th>
                                    <th>Appointment Time</th>
                                    <th>Symptom</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="a" items="${appointmentList}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${a.doctorName}</td>
                                        <td>${a.specialtyName}</td>
                                        <td>${a.patientName}</td>
                                        <td>${a.dateBegin}</td>
                                        <td>${a.note}</td>
                                        <td>
                                            <span class="badge
                                                  <c:choose>
                                                      <c:when test="${a.statusName eq 'Pending'}">bg-warning text-dark</c:when>
                                                      <c:when test="${a.statusName eq 'Approved'}">bg-success</c:when>
                                                      <c:when test="${a.statusName eq 'Completed'}">bg-primary</c:when>
                                                      <c:when test="${a.statusName eq 'Canceled'}">bg-danger</c:when>
                                                      <c:otherwise>bg-secondary</c:otherwise>
                                                  </c:choose>">
                                                ${a.statusName}
                                            </span>
                                        </td>
                                        <td>
                                            <!-- View Detail Button -->
                                            <button class="btn btn-sm btn-info text-white btn-view-detail" 
                                                    data-id="${a.appointmentID}">
                                                <i class="fa-solid fa-eye"></i> View Detail
                                            </button>

                                            <!-- Approve form -->
                                            <form action="${pageContext.request.contextPath}/receptionist-dashboard" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="approve">
                                                <input type="hidden" name="appointmentId" value="${a.appointmentID}">
                                                <button type="submit" class="btn btn-sm btn-success"
                                                        onclick="return confirm('Approve this appointment?');">
                                                    <i class="fa-solid fa-check"></i> Approve
                                                </button>
                                            </form>

                                            <!-- Form Cancel -->
                                            <form action="${pageContext.request.contextPath}/receptionist-dashboard" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="cancel">
                                                <input type="hidden" name="appointmentId" value="${a.appointmentID}">
                                                <button type="submit" class="btn btn-sm btn-danger"
                                                        onclick="return confirm('Are you sure you want to cancel this appointment?');">
                                                    <i class="fa-solid fa-xmark"></i> Cancel
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                            <script>
                                                            $(document).ready(function () {
                                                                $('.btn-view-detail').click(function () {
                                                                    var appointmentId = $(this).data('id');

                                                                    // Gửi AJAX request đến chính controller hiện tại
                                                                    $.ajax({
                                                                        url: '${pageContext.request.contextPath}/receptionist-dashboard',
                                                                        type: 'get',
                                                                        data: {action: 'viewDetail', id: appointmentId},
                                                                        success: function (data) {
                                                                            // data trả về là JSON
                                                                            $('#modalDoctorName').text(data.doctorName);
                                                                            $('#modalSpecialty').text(data.specialtyName);
                                                                            $('#modalPatient').text(data.patientName || 'N/A');
                                                                            $('#modalStatus').text(data.statusName);
                                                                            $('#modalDateBegin').text(data.dateBegin);
                                                                            $('#modalDateEnd').text(data.dateEnd);
                                                                            $('#modalNote').text(data.note || 'None');

                                                                            // Hiện modal
                                                                            var myModal = new bootstrap.Modal(document.getElementById('appointmentModal'));
                                                                            myModal.show();
                                                                        },
                                                                        error: function () {
                                                                            alert('Cannot load appointment detail.');
                                                                        }
                                                                    });
                                                                });
                                                            });
                            </script>

                            </tbody>

                        </table>
                    </div>
                </div>          
            </div>
        </div>

        <!-- Appointment Detail Modal -->
        <div class="modal fade" id="appointmentModal" tabindex="-1" aria-labelledby="appointmentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="appointmentModalLabel">Appointment Detail</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Nội dung detail sẽ load bằng JS -->
                        <p><strong>Doctor:</strong> <span id="modalDoctorName"></span></p>
                        <p><strong>Specialty:</strong> <span id="modalSpecialty"></span></p>
                        <p><strong>Patient:</strong> <span id="modalPatient"></span></p>
                        <p><strong>Status:</strong> <span id="modalStatus"></span></p>
                        <p><strong>Date Begin:</strong> <span id="modalDateBegin"></span></p>
                        <p><strong>Date End:</strong> <span id="modalDateEnd"></span></p>
                        <p><strong>Note:</strong> <span id="modalNote"></span></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
