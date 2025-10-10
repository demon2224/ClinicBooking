<%-- 
    Document   : DoctorDashboard
    Created on : 7 Oct. 2025, 2:18:25 pm
    Author     : Le Thien Tri - CE191249
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
            color: red; border-color: red;
            
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
                    <h5 class="mb-0">My Patient Appointment List</h5>
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

            <!-- Patients List -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Patient Medical Record List</h5>
                </div>
                <div class="card-body">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Phone</th>
                                <th>Date</th>
                                <th>Paid</th>
                                <th>Symptoms</th>
                                <th>Diagnosis</th>                       
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Charlene Reed</td>
                                <td>8286329170</td>
                                <td>20 Oct 2023</td>
                                <td>$100.00</td>
                                <td>Headache</td>
                                <td>Flu</td>
                                <td>NOT Responding</td>
                            </tr>
                     
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Appointment List -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Patient Prescription List</h5>
                </div>
                <div class="card-body">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Patient Name</th>
                                <th>Prescription Date</th>
                                <th>Status</th>
                                <th>Note</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Khang Nghien</td>
                                <td>07/10/2025</td>
                                <td>Da phat</td>
                                <td>Thuoc Cai Nghien</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
