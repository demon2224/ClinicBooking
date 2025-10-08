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
                        <table class="table align-middle">
                            <thead>
                                <tr>
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
                                <c:forEach var="a" items="${appointmentList}">
                                    <tr>
                                        <td>${a.doctorName}</td>
                                        <td>${a.specialtyName}</td>
                                        <td>${a.patientName}</td>
                                        <td>${a.dateBegin}</td>
                                        <td>${a.note}</td>
                                        <td>${a.statusName}</td>
                                        <td>
                                            <!-- View and Update button -->
                                            <a href="viewAppointment?id=${a.appointmentID}" class="btn btn-sm btn-info text-white">
                                                <i class="fa-solid fa-eye"></i> View Detail
                                            </a>
                                            <a href="updateAppointment?id=${a.appointmentID}" class="btn btn-sm btn-warning text-dark">
                                                <i class="fa-solid fa-pen"></i> Update
                                            </a>

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
                            </tbody>
                        </table>
                    </div>
                </div>          
            </div>
        </div>
    </body>
</html>
