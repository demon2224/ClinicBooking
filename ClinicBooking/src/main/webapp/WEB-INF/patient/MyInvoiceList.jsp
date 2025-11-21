<%--
    Document   : MyInvoiceList
    Created on : Nov 10, 2025, 11:28:12 AM
    Author     : Le Anh Tuan - CE180905
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Invoices - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">


        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="../includes/header.jsp">
            <jsp:param name="activePage" value="manage-invoices" />
        </jsp:include>

        <!-- Main Content -->
        <main class="appointment-main-content">
            <!-- Page Header -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-file-invoice-dollar"></i> My Invoices</h1>
            </div>

            <!-- Search and Filter Section -->
            <div class="search-filter-section">
                <div class="search-filter-content">
                    <form method="GET"
                          action="${pageContext.request.contextPath}/manage-my-invoices"
                          class="search-form">

                        <div class="search-row">
                            <!-- Search Input -->
                            <div class="search-input-group">
                                <i class="fas fa-search"></i>
                                <input type="text"
                                       name="search"
                                       placeholder="Search by doctor name or specialty..."
                                       value="${searchQuery}"
                                       class="search-input" />
                            </div>

                            <!-- Search Button -->
                            <button type="submit" class="btn-search">
                                <i class="fas fa-search"></i>
                                Search
                            </button>

                            <!-- Clear Button -->
                            <a href="${pageContext.request.contextPath}/manage-my-invoices"
                               class="btn-clear">
                                <i class="fas fa-times"></i>
                                Clear
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Only show consultation payments (Completed appointments) -->
            <div class="appointments-section">
                <div class="appointments-content">
                    <c:choose>
                        <c:when test="${empty completedAppointments}">
                            <div class="appointment-empty-state">
                                <i class="fas fa-file-invoice-dollar"></i>
                                <h3>No Invoices Found</h3>
                                <p>You don't have any completed appointments yet.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="appointment" items="${completedAppointments}">
                                <div class="appointment-card">
                                    <div class="appointment-header">
                                        <div class="appointment-info">
                                            <div class="appointment-date">
                                                <i class="fas fa-calendar"></i>
                                                <fmt:formatDate value="${appointment.dateCreate}" pattern="EEEE, MMMM dd, yyyy" />
                                            </div>
                                            <div class="appointment-doctor">
                                                <i class="fas fa-user-md"></i>
                                                <c:choose>
                                                    <c:when test="${not empty appointment.doctorID.staffID.firstName && not empty appointment.doctorID.staffID.lastName}">
                                                        Dr. ${appointment.doctorID.staffID.firstName} ${appointment.doctorID.staffID.lastName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Doctor information not available
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-stethoscope"></i>
                                                <c:choose>
                                                    <c:when test="${not empty appointment.doctorID.specialtyID.specialtyName}">
                                                        ${appointment.doctorID.specialtyID.specialtyName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Specialty not available
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-dollar-sign"></i>
                                                Consultation Fee: <fmt:formatNumber value="${appointment.doctorID.specialtyID.price}" pattern="#,##0"/> VND
                                            </div>
                                            <c:set var="medicineFee" value="${appointmentMedicineFeeMap[appointment.appointmentID]}" />
                                            <c:if test="${medicineFee != null && medicineFee > 0}">
                                                <div class="appointment-specialty">
                                                    <i class="fas fa-pills"></i>
                                                    Total medicine fee: <fmt:formatNumber value="${medicineFee}" pattern="#,##0"/> VND
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="appointment-status status-completed">
                                            PAID
                                        </div>
                                    </div>
                                    <div class="appointment-actions">
                                        <a href="${pageContext.request.contextPath}/manage-my-invoices?appointmentId=${appointment.appointmentID}" class="btn-action btn-view">
                                            <i class="fas fa-eye"></i>
                                            View Details
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
        <jsp:include page="../includes/footer.jsp" />
    </body>
</html>
