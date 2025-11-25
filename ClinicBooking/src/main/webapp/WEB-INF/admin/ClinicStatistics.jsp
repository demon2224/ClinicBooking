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
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css"/>
        <style>
            body {
                background-color: #f4f7fb;
                font-family: "Poppins", sans-serif;
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
           /* Cards */
            .card {
                border: none;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }
            .card-header {
                background-color: #1B5A90;
                color: white;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
                font-weight: 500;
            }
            .dashboard-card {
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }
            .dashboard-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 14px rgba(0,0,0,0.15);
            }
            .stat-icon {
                font-size: 2.3rem;
                color: #1B5A90;
            }
            .stat-value {
                font-size: 1.8rem;
                font-weight: 600;
            }

            .row {
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
            }

            .col-md-4 {
                flex: 0 0 calc(33.333% - 1rem); /* 3 card 1 hàng */
                box-sizing: border-box;
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

            <div class="row g-4 mb-4">
                <!-- Hàng 1 -->
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-user-md stat-icon mb-2"></i>
                        <div class="stat-value">${totalDoctors}</div>
                        <p class="mb-0 text-muted">Total Doctors</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-users stat-icon mb-2"></i>
                        <div class="stat-value">${totalPatients}</div>
                        <p class="mb-0 text-muted">Total Patients</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-calendar-check stat-icon mb-2"></i>
                        <div class="stat-value">${totalAppointments}</div>
                        <p class="mb-0 text-muted">Total Appointments</p>
                    </div>
                </div>

                <!-- Hàng 2 -->
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-prescription stat-icon mb-2"></i>
                        <div class="stat-value">${totalPrescriptions}</div>
                        <p class="mb-0 text-muted">Total Prescriptions</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-file-invoice-dollar stat-icon mb-2"></i>
                        <div class="stat-value">${totalInvoices}</div>
                        <p class="mb-0 text-muted">Total Invoices</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dashboard-card text-center p-3">
                        <i class="fa-solid fa-pills stat-icon mb-2"></i>
                        <div class="stat-value">${lowStockCount}</div>
                        <p class="mb-0 text-muted">Low Stock Medicines</p>
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
