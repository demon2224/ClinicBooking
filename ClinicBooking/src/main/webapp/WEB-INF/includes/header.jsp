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
                    <a href="${pageContext.request.contextPath}/doctor-list" 
                       class="${param.activePage == 'doctors' ? 'active' : ''}">Doctors</a>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle ${param.activePage == 'manage-appointments' ? 'active' : ''}">Portal</a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/manage-my-appointments" 
                               class="${param.activePage == 'manage-appointments' ? 'active' : ''}">Manage My Appointments</a></li>
                        <li><a href="#" 
                               class="${param.activePage == 'medical-records' ? 'active' : ''}">Manage My Medical Records</a></li>
                        <li><a href="#" 
                               class="${param.activePage == 'prescriptions' ? 'active' : ''}">Manage My Prescriptions</a></li>
                        <li><a href="#" 
                               class="${param.activePage == 'invoices' ? 'active' : ''}">Manage My Invoices</a></li>
                        <li><a href="#" 
                               class="${param.activePage == 'feedbacks' ? 'active' : ''}">My Feedbacks</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" 
                       class="${param.activePage == 'contact' ? 'active' : ''}">Contact</a>
                </li>
            </ul>
        </nav>

        <!-- User Actions -->
        <div class="user-actions">
            <!-- Register Button -->
            <a href="#" class="btn btn-register">
                <i class="fas fa-user-plus"></i>
                Register
            </a>

            <!-- Login Button -->
            <a href="#" class="btn btn-login">
                <i class="fas fa-sign-in-alt"></i>
                Login
            </a>
        </div>
    </div>
</header>