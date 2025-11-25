<%--
    Document   : RevenueReport
    Created on : Nov 13, 2025, 5:36:17 PM
    Author     : Nguyen Minh Khang - CE190728
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Revenue Report - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    </head>
    <body>
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
            #Logout {
                color: red;
                border-color: red;
                transition: all 0.3s ease;
            }
            #Logout:hover {
                background-color: red;
                color: white;
            }
        </style>
        <%@include file="../includes/AdminDashboardSidebar.jsp" %>
        <div class="main-content">
            <nav class="navbar navbar-light justify-content-between px-3 py-2 border-bottom shadow-sm">
                <h3 class="fw-bold text-primary mb-0 d-flex align-items-center">
                    <i class="fa-solid fa-money-bill me-2"></i>
                    Revenue Report
                </h3>
                <form class="d-flex align-items-center" method="get" action="${pageContext.request.contextPath}/revenue-report">
                    <a href="${pageContext.request.contextPath}/staff-logout"
                       class="btn btn-outline-danger d-flex align-items-center" id="Logout">
                        <i class="fa-solid fa-right-from-bracket me-2"></i>Logout
                    </a>
                </form>
            </nav>
            <div class="container-fluid p-4">

                <!-- ROW 2: Payment Methods -->
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h6>Payment Method Distribution</h6>
                                <canvas id="paymentChart" style="max-height: 300px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- ROW 3: Revenue Timeline -->
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h6>Monthly Revenue Timeline (Last 12 Months)</h6>
                                <canvas id="timelineChart" style="max-height: 350px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ROW 4: Revenue by Specialty -->
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h6>Revenue by Specialty</h6>
                                <canvas id="specialtyChart" style="max-height: 400px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ROW 5: Revenue by Doctor -->
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h6>Top 10 Doctors by Revenue</h6>
                                <canvas id="doctorChart" style="max-height: 400px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // Payment Method Pie Chart
            const paymentData = {
            labels
                    : [<c:forEach var="entry" items="${paymentMethods}" varStatus="status">'${entry.key}'<c:if test="${!status.last}">,</c:if></c:forEach>],
            datasets: [{
            data: [<c:forEach var="entry" items="${paymentMethods}" varStatus="status">${entry.value}<c:if test="${!status.last}">,</c:if></c:forEach>],
                    backgroundColor: ['#36A2EB', '#FF6384']
            }]
            }
            ;
            new Chart(document.getElementById('paymentChart'), {
                type: 'pie',
                data: paymentData,
                options: {
                    responsive: true,
                    plugins: {
                        legend: {position: 'top'},
                        title: {display: false}
                    }
                }
            });

            // Monthly Revenue Timeline
            const monthLabels = [<c:forEach var="m" items="${monthlyRevenue}" varStatus="status">'<fmt:formatDate value="${m.datePay}" pattern="MM/yyyy"/>'<c:if test="${!status.last}">,</c:if></c:forEach>];
            const monthRevenue = [<c:forEach var="m" items="${monthlyRevenue}" varStatus="status">${m.totalFee}<c:if test="${!status.last}">,</c:if></c:forEach>];

            new Chart(document.getElementById('timelineChart'), {
                type: 'line',
                data: {
                    labels: monthLabels,
                    datasets: [{
                            label: 'Monthly Revenue (VND)',
                            data: monthRevenue,
                            borderColor: '#36A2EB',
                            backgroundColor: 'rgba(54, 162, 235, 0.1)',
                            fill: true,
                            tension: 0.3
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {display: true},
                        title: {display: false}
                    },
                    scales: {
                        y: {beginAtZero: true}
                    }
                }
            });

            // Specialty Revenue Bar Chart
            const specialtyNames = [<c:forEach var="s" items="${specialtyRevenue}" varStatus="status">'${s.specialtyName}'<c:if test="${!status.last}">,</c:if></c:forEach>];
            const specialtyRevenues = [<c:forEach var="s" items="${specialtyRevenue}" varStatus="status">${s.totalRevenue}<c:if test="${!status.last}">,</c:if></c:forEach>];

            new Chart(document.getElementById('specialtyChart'), {
                type: 'bar',
                data: {
                    labels: specialtyNames,
                    datasets: [{
                            label: 'Revenue (VND)',
                            data: specialtyRevenues,
                            backgroundColor: '#4BC0C0'
                        }]
                },
                options: {
                    indexAxis: 'y',
                    responsive: true,
                    plugins: {
                        legend: {display: false},
                        title: {display: false}
                    },
                    scales: {
                        x: {beginAtZero: true}
                    }
                }
            });

            // Doctor Revenue Bar Chart
            const doctorNames = [<c:forEach var="d" items="${doctorRevenue}" varStatus="status">'${d.staffID.firstName} ${d.staffID.lastName}'<c:if test="${!status.last}">,</c:if></c:forEach>];
                const doctorRevenues = [<c:forEach var="d" items="${doctorRevenue}" varStatus="status">${d.totalRevenue}<c:if test="${!status.last}">,</c:if></c:forEach>];

                new Chart(document.getElementById('doctorChart'), {
                    type: 'bar',
                    data: {
                        labels: doctorNames,
                        datasets: [{
                                label: 'Revenue (VND)',
                                data: doctorRevenues,
                                backgroundColor: '#FFCE56'
                            }]
                    },
                    options: {
                        indexAxis: 'y',
                        responsive: true,
                        plugins: {
                            legend: {display: false},
                            title: {display: false}
                        },
                        scales: {
                            x: {beginAtZero: true}
                        }
                    }
                });
        </script>
    </body>
</html>
