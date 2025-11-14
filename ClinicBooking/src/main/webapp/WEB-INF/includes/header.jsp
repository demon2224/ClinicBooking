<%--
    Header Component
    Created on : Oct 11, 2025
    Author     : Le Anh Tuan - CE180905
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Header -->
<header class="header">
    <div class="container">

        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <i class="fas fa-stethoscope"></i>
            CLINIC
        </a>

        <!-- Navigation Menu -->
        <nav>
            <ul class="nav-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/home"
                       class="${param.activePage == 'home' ? 'active' : ''}">Home</a>
                </li>
                <li>
                    <a href="#"
                       class="${param.activePage == 'about' ? 'active' : ''}">About</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/doctor"
                       class="${param.activePage == 'doctors' ? 'active' : ''}">Doctors</a>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle ${param.activePage == 'manage-appointments' ? 'active' : ''}">Portal</a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/manage-my-appointments"
                               class="${param.activePage == 'manage-appointments' ? 'active' : ''}">Manage My Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/manage-my-medical-records"
                               class="${param.activePage == 'manage-medical-records' ? 'active' : ''}">Manage My Medical Records</a></li>
                        <li><a href="${pageContext.request.contextPath}/manage-my-prescriptions"
                               class="${param.activePage == 'manage-prescriptions' ? 'active' : ''}">Manage My Prescriptions</a></li>
                        <li><a href="${pageContext.request.contextPath}/manage-my-invoices"
                               class="${param.activePage == 'manage-invoices' ? 'active' : ''}">Manage My Invoices</a></li>
                        <li><a href="${pageContext.request.contextPath}/manage-my-feedback"
                               class="${param.activePage == 'manage-feedback' ? 'active' : ''}">My Feedbacks</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#"
                       class="${param.activePage == 'contact' ? 'active' : ''}">Contact</a>
                </li>
            </ul>
        </nav>

        <!-- User Actions Buttons -->
        <c:if test="${empty sessionScope.patient}">
            <div class="user-actions">

                <!-- Login Button -->
                <a href="${pageContext.request.contextPath}/patient-login" class="btn btn-login">
                    <i class="fas fa-sign-in-alt"></i>
                    Login
                </a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-register">
                    <i class="fas fa-user-plus"></i>
                    Register
                </a>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.patient}">
            <div class="user-actions">

                <!-- Profile User -->
                <a href="${pageContext.request.contextPath}/profile" class="icon-user-profile">
                    <i class="fa-solid fa-circle-user"></i>
                </a>

                <!-- Logout Button -->
                <a href="${pageContext.request.contextPath}/patient-logout" class="btn btn-logout">
                    <i class="fas fa-sign-in-alt"></i>
                    Logout
                </a>
            </div>
        </c:if>
    </div>
</header>