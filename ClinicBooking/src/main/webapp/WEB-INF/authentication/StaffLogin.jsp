<%--
    Document   : login
    Created on : Nov 6, 2025, 2:37:12 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Staff Login - Clinic Booking</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link href="${pageContext.request.contextPath}/assests/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assests/css/all.min.css" rel="stylesheet">
    </head>
    <body class="bg-info-subtle d-flex justify-content-center align-items-center vh-100">

        <div class="card shadow-lg border-0 w-100" style="max-width: 400px;">
            <div class="card-body p-4">
                <h3 class="text-center mb-4 fw-bold text-primary">Staff Login</h3>

                <form action="${pageContext.request.contextPath}/staff-login" method="POST">

                    <div class="mb-3">
                        <label for="staff-username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="staff-username" name="staff-username" required>
                        <c:if test="${not empty requestScope.staffUsernameErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                <c:out value="${requestScope.staffUsernameErrorMsg}" />
                            </div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="staff-password" class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="staff-password" name="staff-password" required>
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <c:if test="${not empty requestScope.staffPasswordErrorMsg}">
                            <div class="text-danger small mt-1">
                                <i class="fa-solid fa-circle-exclamation me-1"></i>
                                <c:out value="${requestScope.staffPasswordErrorMsg}" />
                            </div>
                        </c:if>
                    </div>

                    <button type="submit" class="btn btn-success w-100 rounded-pill">Login</button>
                </form>
            </div>
        </div>

        <c:if test="${not empty requestScope.loginErrorMsg}">
            <div class="modal fade" id="loginErrorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-danger">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title" id="errorModalLabel">
                                <i class="fa-solid fa-circle-exclamation me-2"></i>Login Failed
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body text-center">
                            <c:out value="${requestScope.loginErrorMsg}" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger w-100" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var errorModal = new bootstrap.Modal(document.getElementById('loginErrorModal'));
                    errorModal.show();
                });
            </script>
        </c:if>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script>
        <script>
                // Toggle show/hide password
                const togglePassword = document.getElementById("togglePassword");
                const passwordField = document.getElementById("staff-password");

                togglePassword.addEventListener("click", function () {
                    const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
                    passwordField.setAttribute("type", type);
                    this.innerHTML = type === "text"
                            ? '<i class="fas fa-eye-slash"></i>'
                            : '<i class="fas fa-eye"></i>';
                });
        </script>
    </body>
</html>

