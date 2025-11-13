<%-- 
    Document   : register
    Created on : Nov 6, 2025, 2:37:21 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Patient Registration - Clinic Booking</title>
        <link href="${pageContext.request.contextPath}/assests/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assests/css/all.min.css" rel="stylesheet">
    </head>

    <body class="bg-info-subtle d-flex justify-content-center align-items-center vh-100">

        <div class="card shadow-lg border-0 w-100" style="max-width: 430px;">
            <div class="card-body p-4">

                <h3 class="text-center mb-4 fw-bold text-primary">Register</h3>

                <form action="${pageContext.request.contextPath}/register" method="POST">

                    <!-- FIRST NAME -->
                    <div class="mb-3">
                        <label class="form-label">First name</label>
                        <input type="text" name="firstName" class="form-control" value="${param.firstName}">
                        <c:if test="${not empty firstNameErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                ${firstNameErrorMsg}
                            </div>
                        </c:if>
                    </div>

                    <!-- LAST NAME -->
                    <div class="mb-3">
                        <label class="form-label">Last name</label>
                        <input type="text" name="lastName" class="form-control" value="${param.lastName}">
                        <c:if test="${not empty lastNameErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                ${lastNameErrorMsg}
                            </div>
                        </c:if>
                    </div>

                    <!-- SEX -->
                    <div class="mb-3">
                        <label class="form-label">Sex</label>
                        <select class="form-select" name="sex">
                            <option value="1" ${param.sex == '1' ? 'selected' : ''}>Male</option>
                            <option value="0" ${param.sex == '0' ? 'selected' : ''}>Female</option>
                        </select>
                        <c:if test="${not empty sexErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                ${sexErrorMsg}
                            </div>
                        </c:if>
                    </div>

                    <!-- DOB -->
                    <div class="mb-3">
                        <label class="form-label">Date of birth</label>
                        <input type="date" name="dob" class="form-control" value="${param.dob}">
                        <c:if test="${not empty dobErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                ${dobErrorMsg}
                            </div>
                        </c:if>
                    </div>

                    <!-- PHONE -->
                    <div class="mb-3">
                        <label class="form-label">Phone number</label>
                        <input type="tel" name="phoneNumber" class="form-control" value="${param.phoneNumber}">
                        <c:if test="${not empty phoneNumberErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                ${phoneNumberErrorMsg}
                            </div>
                        </c:if>
                    </div>

                    <!-- EMAIL -->
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" value="${param.email}">
                        <c:if test="${not empty emailErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                ${emailErrorMsg}
                            </div>
                        </c:if>
                    </div>

                    <!-- USERNAME -->
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" value="${param.username}">
                        <c:if test="${not empty usernameErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                ${usernameErrorMsg}
                            </div>
                        </c:if>
                    </div>

                    <!-- PASSWORD -->
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control">
                        <c:if test="${not empty passwordErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                ${passwordErrorMsg}
                            </div>
                        </c:if>
                    </div>

                    <button type="submit" class="btn btn-success w-100 rounded-pill">Register</button>

                </form>

                <!-- FAIL MESSAGE -->
                <c:if test="${not empty registerFailMsg}">
                    <div class="alert alert-danger text-center mt-3">
                        ${registerFailMsg}
                    </div>
                </c:if>

            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
