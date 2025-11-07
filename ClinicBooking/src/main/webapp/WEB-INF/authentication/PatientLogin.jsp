<%-- 
    Document   : login
    Created on : Nov 6, 2025, 2:37:12 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập - Clinic Booking</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assests/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assests/css/all.min.css" />
        <style>
            body {
                background-color: #cfe9ff; /* xanh biển nhạt */
            }
            .login-page-container {
                min-height: 100vh;
            }
            .image-side {
                background: url('${pageContext.request.contextPath}/assets/img/CBS_Back') no-repeat center center;
                background-size: cover;
            }
        </style>
    </head>
    <body>

        <div class="container-fluid login-page-container d-flex align-items-center justify-content-center">
            <div class="row w-100 shadow-lg bg-white rounded-4 overflow-hidden" style="max-width: 1000px;">
                <div class="col-md-6 d-none d-md-block image-side">
                </div>

                <div class="col-md-6 d-flex align-items-center p-4 p-md-5">
                    <div class="w-100">
                        <h2 class="text-center mb-4 fw-bold">Patient Login</h2>

                        <form action="${pageContext.request.contextPath}/patient-login" method="POST">
                            <input type="hidden" name="user" value="patient">
                            
                            <div class="mb-3">
                                <label for="patient-username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="patient-username" name="patient-username" required>
                            </div>

                            <div class="mb-3 position-relative">
                                <label for="patient-password" class="form-label">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="patient-password" name="patient-password" required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i> Show
                                    </button>
                                </div>
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="patient-remember-me">
                                <label class="form-check-label" for="patient-remember-me">Remember me</label>
                            </div>

                            <button type="submit" class="btn btn-success w-100">Login</button>
                        </form>

                        <div class="text-center mt-3">
                            <a href="#" class="text-decoration-none">Forgot password?</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script> 
        <script>
            // Toggle show/hide password
            const togglePassword = document.getElementById("togglePassword");
            const passwordField = document.getElementById("patient-password");

            togglePassword.addEventListener("click", function () {
                const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
                passwordField.setAttribute("type", type);

                if (type === "text") {
                    this.innerHTML = '<i class="fas fa-eye-slash"></i> Hide';
                } else {
                    this.innerHTML = '<i class="fas fa-eye"></i> Show';
                }
            });
        </script>
    </body>
</html>
