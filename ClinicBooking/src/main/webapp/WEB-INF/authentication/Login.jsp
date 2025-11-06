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
            /* CSS tuỳ chỉnh nhỏ để cố định chiều cao và căn giữa, không sử dụng class tuỳ chỉnh tự viết mà chỉ dùng inline style hoặc utility class của Bootstrap */
            .login-page-container {
                min-height: 100vh;
            }
            .image-side {
                /* Tùy chỉnh ảnh nền cho cột bên trái (chỉ dùng background image) */
                background: url('assets/img/CBS_Back') no-repeat center center;
                background-size: cover;
            }
        </style>
    </head>
    <body class="bg-light">

        <div class="container-fluid login-page-container d-flex align-items-center justify-content-center">
            <div class="row w-100 shadow-lg" style="max-width: 1200px; height: 700px;">
                <div class="col-md-7 d-none d-md-block image-side rounded-start">
                </div>

                <div class="col-md-5 d-flex align-items-center bg-white rounded-end">
                    <div class="card border-0 w-100 p-4 p-md-5">
                        <div class="card-body">
                            <h2 class="card-title text-center mb-4">Đăng Nhập Hệ Thống</h2>

                            <ul class="nav nav-pills nav-justified mb-4" id="loginTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="staff-tab" data-bs-toggle="pill" data-bs-target="#staff-login" type="button" role="tab" aria-controls="staff-login" aria-selected="true"><i class="fas fa-user-md me-2"></i>Nhân viên</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="patient-tab" data-bs-toggle="pill" data-bs-target="#patient-login" type="button" role="tab" aria-controls="patient-login" aria-selected="false"><i class="fas fa-procedures me-2"></i>Bệnh nhân</button>
                                </li>
                            </ul>

                            <div class="tab-content" id="loginTabContent">
                                <div class="tab-pane fade show active" id="staff-login" role="tabpanel" aria-labelledby="staff-tab">
                                    <form action="${pageContext.request.contextPath}/login" method="POST">
                                        <input type="hidden" name="user" value="staff">
                                        <div class="mb-3">
                                            <label for="staff-username" class="form-label">Tài khoản (Username)</label>
                                            <input type="text" class="form-control" id="staff-username" name="username" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="staff-password" class="form-label">Mật khẩu (Password)</label>
                                            <input type="password" class="form-control" id="staff-password" name="password" required>
                                        </div>
                                        <div class="mb-3 form-check">
                                            <input type="checkbox" class="form-check-input" id="staff-remember-me">
                                            <label class="form-check-label" for="staff-remember-me">Ghi nhớ đăng nhập</label>
                                        </div>
                                        <button type="submit" class="btn btn-primary w-100">Đăng nhập Nhân viên</button>
                                    </form>
                                </div>

                                <div class="tab-pane fade" id="patient-login" role="tabpanel" aria-labelledby="patient-tab">
                                    <form action="${pageContext.request.contextPath}/login" method="POST">
                                        <input type="hidden" name="user" value="patient">
                                        <div class="mb-3">
                                            <label for="patient-username" class="form-label">Tài khoản (Username)</label>
                                            <input type="text" class="form-control" id="patient-username" name="username" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="patient-password" class="form-label">Mật khẩu (Password)</label>
                                            <input type="password" class="form-control" id="patient-password" name="password" required>
                                        </div>
                                        <div class="mb-3 form-check">
                                            <input type="checkbox" class="form-check-input" id="patient-remember-me">
                                            <label class="form-check-label" for="patient-remember-me">Ghi nhớ đăng nhập</label>
                                        </div>
                                        <button type="submit" class="btn btn-success w-100">Đăng nhập Bệnh nhân</button>
                                    </form>
                                </div>
                            </div>

                            <div class="text-center mt-3">
                                <a href="#" class="text-decoration-none">Quên mật khẩu?</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assests/js/bootstrap.bundle.min.js"></script> 
    </body>
</html>
