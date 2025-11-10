<%-- 
    Document   : register
    Created on : Nov 6, 2025, 2:37:21 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Patient Registration - Clinic Booking</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/all.min.css" />
        <style>
            body {
                background-color: #eaf3ff;
            }
            .register-container {
                min-height: 100vh;
            }
            .image-side {
                background: url('${pageContext.request.contextPath}/assets/img/CBS_Back') no-repeat center center;
                background-size: cover;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid register-container d-flex align-items-center justify-content-center">
            <div class="row w-100 shadow-lg bg-white rounded-4 overflow-hidden" style="max-width: 900px;">
                <div class="col-md-6 d-none d-md-block image-side"></div>

                <div class="col-md-6 d-flex align-items-center p-4 p-md-5">
                    <div class="w-100">
                        <h2 class="text-center mb-4 fw-bold">Create Your Account</h2>

                        <form action="${pageContext.request.contextPath}/patient-register" method="POST">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="firstName" class="form-label">First Name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="lastName" class="form-label">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Gender</label>
                                <select class="form-select" name="gender">
                                    <option value="0">Male</option>
                                    <option value="1">Female</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="phoneNumber" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>

                            <div class="mb-3">
                                <label for="accountName" class="form-label">Account Name</label>
                                <input type="text" class="form-control" id="accountName" name="accountName" required>
                            </div>

                            <div class="mb-3 position-relative">
                                <label for="accountPassword" class="form-label">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="accountPassword" name="accountPassword" required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i> Show
                                    </button>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-success w-100">Register</button>

                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/staff-login" class="text-decoration-none">Already have an account? Login here</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script>
            // Toggle password visibility
            const togglePassword = document.getElementById("togglePassword");
            const passwordField = document.getElementById("accountPassword");

            togglePassword.addEventListener("click", function () {
                const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
                passwordField.setAttribute("type", type);
                this.innerHTML = type === "text"
                        ? '<i class="fas fa-eye-slash"></i> Hide'
                        : '<i class="fas fa-eye"></i> Show';
            });
        </script>
    </body>
</html>
