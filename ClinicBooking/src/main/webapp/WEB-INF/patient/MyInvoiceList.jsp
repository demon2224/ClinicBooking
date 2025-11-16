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

            <!-- Invoices Section -->
            <div class="appointments-section">
                <div class="appointments-content">
                    <c:choose>
                        <c:when test="${empty invoiceList}">
                            <!-- Empty State -->
                            <div class="appointment-empty-state">
                                <i class="fas fa-file-invoice-dollar"></i>
                                <h3>No Invoices Found</h3>
                                <p>You don't have any invoices yet.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Display Invoices -->
                            <c:forEach var="invoice" items="${invoiceList}">
                                <div class="appointment-card">
                                    <div class="appointment-header">
                                        <div class="appointment-info">
                                            <div class="appointment-date">
                                                <i class="fas fa-calendar"></i>
                                                <fmt:formatDate value="${invoice.dateCreate}"
                                                                pattern="EEEE, MMMM dd, yyyy" />
                                            </div>
                                            <div class="appointment-doctor">
                                                <i class="fas fa-user-md"></i>
                                                <c:choose>
                                                    <c:when test="${not empty invoice.medicalRecordID.appointmentID.doctorID.staffID.firstName && not empty invoice.medicalRecordID.appointmentID.doctorID.staffID.lastName}">
                                                        Dr. ${invoice.medicalRecordID.appointmentID.doctorID.staffID.firstName} ${invoice.medicalRecordID.appointmentID.doctorID.staffID.lastName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Doctor information not available
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-stethoscope"></i>
                                                <c:choose>
                                                    <c:when test="${not empty invoice.specialtyID.specialtyName}">
                                                        ${invoice.specialtyID.specialtyName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Specialty not available
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-credit-card"></i>
                                                Payment: ${invoice.paymentType}
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-dollar-sign"></i>
                                                Total: $<fmt:formatNumber value="${invoice.totalFee}" pattern="#,##0.00"/>
                                            </div>
                                        </div>
                                        <div class="appointment-status
                                             <c:choose>
                                                 <c:when test="${invoice.invoiceStatus == 'Paid'}">status-completed</c:when>
                                                 <c:otherwise>status-pending</c:otherwise>
                                             </c:choose>
                                             ">
                                            ${invoice.invoiceStatus != null ? invoice.invoiceStatus : 'Pending'}
                                        </div>
                                    </div>
                                    <div class="appointment-actions">
                                        <a href="${pageContext.request.contextPath}/manage-my-invoices?id=${invoice.invoiceID}" class="btn-action btn-view">
                                            <i class="fas fa-eye"></i>
                                            View Details
                                        </a>

                                        <!-- Add checkout button for unpaid invoices -->
                                        <c:if test="${invoice.invoiceStatus == 'Pending'}">
                                            <a href="${pageContext.request.contextPath}/payment?id=${invoice.invoiceID}" class="btn-action btn-primary">
                                                <i class="fas fa-credit-card"></i>
                                                Checkout
                                            </a>
                                        </c:if>
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
