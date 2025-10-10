<%-- 
    Document   : ManageMyPatientAppointment
    Created on : 10 Oct. 2025, 7:07:00 pm
    Author     : Le Thien Tri - CE191249
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
        <meta charset="UTF-8">
        <title>Manage Patient Appointment</title>
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
            <a href="${pageContext.request.contextPath}/doctor-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/manage-my-patient-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="#"><i class="fa-solid fa-user-doctor me-2"></i>Manage Medical Record</a>
            <a href="#"><i class="fa-solid fa-user me-2"></i>Manage Prescription</a>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <nav class="navbar navbar-light">
                <div class="container-fluid">
                    <form class="d-flex w-50">
                        <input class="form-control me-2" type="search" placeholder="Search here">
                        <button class="btn btn-outline-primary" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </form>
                    <div>
                        <button class="btn btn-submit" id="Logout" type="submit">Logout</button>
                    </div>
                </div>
            </nav>

            <div class="container-fluid mt-4">
                <!-- Doctors List -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Patient Appointment List</h5>
                    </div>
                    <div class="card-body">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Date</th>
                                    <th>Note</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="myPatientAppointment" items="${myPatientAppointmentList}">
                                    <tr>
                                        <td>${myPatientAppointment.patientName}</td>
                                        <td>${myPatientAppointment.patientEmail}</td>
                                        <td>${myPatientAppointment.patientPhone}</td>
                                        <td>${myPatientAppointment.dateBegin}</td>
                                        <td>${myPatientAppointment.note}</td>
                                        <td>${myPatientAppointment.appointmentStatusName}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>           
            </div>
        </div>
    </body>
</html>
