<%--
    Document   : ClinicStatistics
    Created on : Nov 13, 2025, 3:06:40 PM
    Author     : Nguyen Minh Khang - CE190728
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clinic Statistics - CLINIC</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>
        <style>
            body {
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }
            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #1B5A90;
                color: white;
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1000;
            }
            .sidebar h4 {
                text-align: center;
                margin-top: 1rem;
                margin-bottom: 1.5rem;
                font-size: 1.4rem;
                font-weight: 500;
                color: white;
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            }
            .sidebar a {
                display: block;
                color: white;
                text-decoration: none;
                padding: 12px 20px;
                transition: background-color 0.3s ease;
            }
            .sidebar a:hover {
                background-color: #00D0F1;
            }
            .sidebar a i {
                margin-right: 8px;
            }
        </style>
    </head>
    <body class="clinic-stats-body">
        <%@include file="../includes/AdminDashboardSidebar.jsp" %>
        <div class="clinic-main-content">
            <div class="clinic-navbar">
                <h3 class="clinic-navbar-title">
                    <i class="fa-solid fa-chart-simple"></i>
                    Clinic Statistics
                </h3>
                <a href="${pageContext.request.contextPath}/staff-logout" class="clinic-logout-btn">
                    <i class="fa-solid fa-right-from-bracket"></i>Logout
                </a>
            </div>
            <!-- KPI CARDS - 6 CARDS -->
            <div class="stats-row">
                <!-- Card 1: Total Doctors -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Total Doctors</h6>
                            <h3>${totalDoctors}</h3>
                        </div>
                        <i class="fa-solid fa-user-md stat-icon"></i>
                    </div>
                </div>

                <!-- Card 2: Total Patients -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Total Patients</h6>
                            <h3>${totalPatients}</h3>
                        </div>
                        <i class="fa-solid fa-users stat-icon"></i>
                    </div>
                </div>

                <!-- Card 3: Total Appointments -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Total Appointments</h6>
                            <h3>${totalAppointments}</h3>
                        </div>
                        <i class="fa-solid fa-calendar-check stat-icon"></i>
                    </div>
                </div>

                <!-- Card 4: Total Prescriptions -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Total Prescriptions</h6>
                            <h3>${totalPrescriptions}</h3>
                        </div>
                        <i class="fa-solid fa-prescription stat-icon"></i>
                    </div>
                </div>

                <!-- Card 5: Total Invoices -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Total Invoices</h6>
                            <h3>${totalInvoices}</h3>
                        </div>
                        <i class="fa-solid fa-file-invoice-dollar stat-icon"></i>
                    </div>
                </div>

                <!-- Card 6: Low Stock Medicines -->
                <div class="stat-card">
                    <div class="stat-card-content">
                        <div>
                            <h6>Low Stock Medicines</h6>
                            <h3>${lowStockCount}</h3>
                        </div>
                        <i class="fa-solid fa-pills stat-icon"></i>
                    </div>
                </div>
            </div>

            <!-- CHARTS - 3 BIỂU ĐỒ TRÒN -->
            <div class="charts-row">
                <!-- Chart 1: Appointment Status -->
                <div class="chart-card">
                    <h5>Appointment Status</h5>
                    <canvas id="appointmentChart"></canvas>
                    <div class="chart-legend">
                        <span><i class="fas fa-circle" style="color: #ffc107"></i> Pending: ${apPending}</span>
                        <span><i class="fas fa-circle" style="color: #1B5A90"></i> Approved: ${apApproved}</span>
                        <span><i class="fas fa-circle" style="color: #28a745"></i> Completed: ${apCompleted}</span>
                        <span><i class="fas fa-circle" style="color: #dc3545"></i> Canceled: ${apCanceled}</span>
                    </div>
                </div>

                <!-- Chart 2: Prescription Status -->
                <div class="chart-card">
                    <h5>Prescription Status</h5>
                    <canvas id="prescriptionChart"></canvas>
                    <div class="chart-legend">
                        <span><i class="fas fa-circle" style="color: #ffc107"></i> Pending: ${prPending}</span>
                        <span><i class="fas fa-circle" style="color: #28a745"></i> Delivered: ${prDelivered}</span>
                    </div>
                </div>

                <!-- Chart 3: Invoice Status -->
                <div class="chart-card">
                    <h5>Invoice Status</h5>
                    <canvas id="invoiceChart"></canvas>
                    <div class="chart-legend">
                        <span><i class="fas fa-circle" style="color: #ffc107"></i> Pending: ${invPending}</span>
                        <span><i class="fas fa-circle" style="color: #28a745"></i> Paid: ${invPaid}</span>
                    </div>
                </div>
            </div>

            <!-- DOCTOR PERFORMANCE TABLE -->
            <div class="doctor-table-card">
                <h5>Top 5 Doctors by Appointments</h5>

                <table class="doctor-performance-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Doctor</th>
                            <th>Specialty</th>
                            <th>Total Appointments</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="doc" items="${topDoctors}" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>${doc.doctorName}</td>
                                <td>${doc.specialtyName}</td>
                                <td>${doc.totalAppointments}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- CHART.JS -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <script>
            // Chart 1: Appointment Status
            new Chart(document.getElementById('appointmentChart'), {
                type: 'pie',
                data: {
                    labels: ['Pending', 'Approved', 'Completed', 'Canceled'],
                    datasets: [{
                            data: [${apPending}, ${apApproved}, ${apCompleted}, ${apCanceled}],
                            backgroundColor: ['#ffc107', '#1B5A90', '#28a745', '#dc3545']
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });

            // Chart 2: Prescription Status
            new Chart(document.getElementById('prescriptionChart'), {
                type: 'pie',
                data: {
                    labels: ['Pending', 'Delivered'],
                    datasets: [{
                            data: [${prPending}, ${prDelivered}],
                            backgroundColor: ['#ffc107', '#28a745']
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });

            // Chart 3: Invoice Status
            new Chart(document.getElementById('invoiceChart'), {
                type: 'pie',
                data: {
                    labels: ['Pending', 'Paid'],
                    datasets: [{
                            data: [${invPending}, ${invPaid}],
                            backgroundColor: ['#ffc107', '#28a745']
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        </script>
    </body>
</html>
