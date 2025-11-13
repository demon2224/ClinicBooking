<%-- 
    Document   : ResetPassword.jsp
    Created on : Nov 14, 2025, 12:21:38 AM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Reset Password - Clinic Booking</title>
        <link href="${pageContext.request.contextPath}/assests/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assests/css/all.min.css" rel="stylesheet">
    </head>

    <body class="bg-info-subtle d-flex justify-content-center align-items-center vh-100">

        <div class="card shadow-lg border-0 w-100" style="max-width: 400px;">
            <div class="card-body p-4">

                <h3 class="text-center mb-4 fw-bold text-primary">Reset Password</h3>

                <form action="${pageContext.request.contextPath}/reset-password" method="POST">

                    <div class="mb-3">
                        <label class="form-label">New password</label>
                        <input type="password" name="newPassword" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Confirm password</label>
                        <input type="password" name="confirmPassword" class="form-control" required>
                    </div>

                    <c:if test="${not empty requestScope.errorMsg}">
                        <div class="text-danger small mb-3">
                            <i class="fa-solid fa-circle-exclamation me-1"></i>
                            <c:out value="${requestScope.errorMsg}" />
                        </div>
                    </c:if>

                    <button type="submit" class="btn btn-success w-100 rounded-pill">
                        Submit
                    </button>
                </form>

                <form action="${pageContext.request.contextPath}/patient-login" method="GET" class="mt-3">
                    <button class="btn btn-outline-primary w-100 rounded-pill">
                        Back to Login
                    </button>
                </form>

            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>

    </body>
</html>

