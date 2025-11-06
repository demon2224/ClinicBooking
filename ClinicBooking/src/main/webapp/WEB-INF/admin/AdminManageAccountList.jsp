<%-- 
    Document   : AdminManageAccountList
    Created on : Nov 6, 2025, 7:07:00 PM
    Author     : Ngo Quoc Hung - CE191184
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Manage Account</title>
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
            #Logout {
                color: red;
                border-color: red;
            }
            #Logout:hover {
                background-color: red;
                color: white;
            }
            /* === Role badge colors === */
            .badge-doctor {
                background-color: #007bff;
            }
            .badge-pharmacist {
                background-color: #20c997;
            }
            .badge-admin {
                background-color: #ffc107;
                color: black;
            }
            .badge-receptionist {
                background-color: #6f42c1;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/admin-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin-manage-account"><i class="fa-solid fa-calendar-days me-2"></i>Manage Account</a>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <nav class="navbar navbar-light">
                <div class="container-fluid">
                    <form class="d-flex w-50" method="get" action="admin-manage-account">
                        <input class="form-control me-2" type="search" name="searchQuery" placeholder="Search here"
                               value="${param.searchQuery}">
                        <button type="submit" class="btn btn-outline-primary" id="searchBtn">
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
                        <h5 class="mb-0">Account List</h5>   
                        <!-- Add Account button -->
                        <a href="#" class="btn btn-primary">
                            <i class="fa-solid fa-plus me-1"></i> Add
                        </a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle text-center">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Username</th>
                                    <th>Full Name</th>
                                    <th>Role</th>
                                    <th>Phone</th>
                                    <th>Date Created</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="s" items="${staffList}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${s.accountName}</td>
                                        <td>${s.firstName}
                                            ${s.lastName}
                                        </td>
                                        <td>
                                            <span class="badge
                                                  <c:choose>
                                                      <c:when test="${s.role eq 'Doctor'}">badge-doctor</c:when>
                                                      <c:when test="${s.role eq 'Pharmacist'}">badge-pharmacist</c:when>
                                                      <c:when test="${s.role eq 'Admin'}">badge-admin</c:when>
                                                      <c:when test="${s.role eq 'Receptionist'}">badge-receptionist</c:when>
                                                      <c:otherwise>bg-secondary</c:otherwise>
                                                  </c:choose>">
                                                ${s.role}
                                            </span>
                                        </td>
                                        <td>${s.phoneNumber}</td>
                                        <td><fmt:formatDate value="${s.daycreated}" pattern="yyyy-MM-dd HH:mm" /></td>
                                        <td>
                                            <span class="badge ${s.hidden ? 'bg-danger' : 'bg-success'}">
                                                ${s.hidden ? 'Inactive' : 'Active'}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="admin-manage-account?id=${s.staffID}" class="btn btn-sm btn-info text-white">
                                                <i class="fa-solid fa-eye"></i> View Detail
                                            </a>
                                            <a href="admin-manage-account?action=edit&id=${s.staffID}" class="btn btn-sm btn-primary">
                                                <i class="fa-solid fa-pen"></i> Edit
                                            </a>
                                            <!-- Delete form -->
                                            <form action="admin-manage-account" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="staffID" value="${s.staffID}">
                                                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?');">
                                                    <i class="fa-solid fa-trash"></i> Delete
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


