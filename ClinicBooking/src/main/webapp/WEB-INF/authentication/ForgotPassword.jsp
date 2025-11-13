<%-- 
    Document   : ForgotPassword
    Created on : Nov 13, 2025, 11:38:34 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Forgot Password - Clinic Booking</title>
        <link href="${pageContext.request.contextPath}/assests/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assests/css/all.min.css" rel="stylesheet">
    </head>

    <body class="bg-info-subtle d-flex justify-content-center align-items-center vh-100">

        <div class="card shadow-lg border-0 w-100" style="max-width: 400px;">
            <div class="card-body p-4">

                <h3 class="text-center mb-4 fw-bold text-primary">Forgot Password</h3>

                <form action="${pageContext.request.contextPath}/forgot-password" method="POST">

                    <div class="mb-3">
                        <label class="form-label">Enter your email</label>
                        <input type="email" name="email" class="form-control" required>

                        <c:if test="${not empty requestScope.emailErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                <c:out value="${requestScope.emailErrorMsg}" />
                            </div>
                        </c:if>
                    </div>

                    <button type="submit" class="btn btn-success w-100 rounded-pill">
                        Send OTP
                    </button>

                </form>

                <form action="${pageContext.request.contextPath}/patient-login" method="GET" class="mt-3">
                    <button type="submit" class="btn btn-outline-primary w-100 rounded-pill">
                        Back to Login
                    </button>
                </form>

            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
