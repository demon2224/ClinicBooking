<%--
    Document   : MyInvoiceDetail
    Created on : Nov 10, 2025, 11:28:12 AM
    Author     : Le Anh Tuan - CE180905
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice Details - CLINIC</title>
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

        <main class="appointment-main-content">
            <div class="appointment-detail-card">
                <div class="appointment-page-header">
                    <h1><i class="fas fa-file-invoice-dollar"></i> Invoice Details</h1>
                </div>

                <!-- Content Sections -->
                <div class="appointment-content">
                    <c:choose>
                        <%-- Handle CONSULTATION PAYMENT (appointment) - Only consultation fee --%>
                        <c:when test="${not empty appointment}">
                            <!-- Appointment Information -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-calendar-check"></i>
                                    Appointment Information
                                </h3>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-calendar"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Date Created</h4>
                                            <p>
                                                <fmt:formatDate value="${appointment.dateCreate}"
                                                                pattern="EEEE, MMMM dd, yyyy"/>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-clock"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Appointment Date & Time</h4>
                                            <p>
                                                <fmt:formatDate value="${appointment.dateBegin}"
                                                                pattern="EEEE, MMMM dd, yyyy HH:mm"/>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-info-circle"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Status</h4>
                                            <p>
                                                <span class="appointment-status status-completed">
                                                    ${appointment.appointmentStatus != null ? appointment.appointmentStatus : 'N/A'}
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Doctor Information -->
                            <c:if test="${not empty appointment.doctorID}">
                                <div class="info-section">
                                    <h3 class="section-title">
                                        <i class="fas fa-user-md"></i>
                                        Doctor Information
                                    </h3>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <div class="info-icon">
                                                <i class="fas fa-user-md"></i>
                                            </div>
                                            <div class="info-content">
                                                <h4>Doctor Name</h4>
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${not empty appointment.doctorID.staffID.firstName && not empty appointment.doctorID.staffID.lastName}">
                                                            Dr. ${appointment.doctorID.staffID.firstName} ${appointment.doctorID.staffID.lastName}
                                                        </c:when>
                                                        <c:otherwise>
                                                            Doctor information not available
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="info-item">
                                            <div class="info-icon">
                                                <i class="fas fa-stethoscope"></i>
                                            </div>
                                            <div class="info-content">
                                                <h4>Specialty</h4>
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${not empty appointment.doctorID.specialtyID.specialtyName}">
                                                            ${appointment.doctorID.specialtyID.specialtyName}
                                                        </c:when>
                                                        <c:otherwise>
                                                            General Medicine
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Payment Information -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-money-bill-wave"></i>
                                    Payment Information
                                </h3>
                                <div class="info-grid">
                                    <!-- Consultation Fee -->
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-dollar-sign"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Consultation Fee</h4>
                                            <p class="amount-highlight">
                                                <fmt:formatNumber value="${consultationFee}" pattern="#,##0"/> VND
                                            </p>
                                            <p>
                                                <span class="appointment-status status-completed">
                                                    ${consultationFeeStatus}
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                    
                                    <!-- Medicine Fee -->
                                    <c:if test="${medicineFee != null && medicineFee > 0}">
                                        <div class="info-item">
                                            <div class="info-icon">
                                                <i class="fas fa-pills"></i>
                                            </div>
                                            <div class="info-content">
                                                <h4>Total Medicine Fee</h4>
                                                <p class="amount-highlight">
                                                    <fmt:formatNumber value="${medicineFee}" pattern="#,##0"/> VND
                                                </p>
                                                <p>
                                                    <span class="appointment-status
                                                          <c:choose>
                                                              <c:when test="${medicineFeeStatus == 'Paid'}">status-completed</c:when>
                                                              <c:otherwise>status-pending</c:otherwise>
                                                          </c:choose>">
                                                        ${medicineFeeStatus != null ? medicineFeeStatus : 'Pending'}
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            
                            <!-- Medicine Details Table -->
                            <c:if test="${not empty prescriptionItems}">
                                <div class="info-section">
                                    <h3 class="section-title">
                                        <i class="fas fa-pills"></i>
                                        Medicine Details
                                    </h3>
                                    <div class="medicines-table">
                                        <div class="table-header">
                                            <div class="header-cell">Medicine Name</div>
                                            <div class="header-cell">Type</div>
                                            <div class="header-cell">Price</div>
                                            <div class="header-cell">Dosage</div>
                                            <div class="header-cell">Instructions</div>
                                            <div class="header-cell">Subtotal</div>
                                        </div>

                                        <c:set var="totalPrice" value="0" />
                                        <c:forEach var="prescriptionItem" items="${prescriptionItems}">
                                            <c:set var="itemPrice" value="${prescriptionItem.medicineID.price != null ? prescriptionItem.medicineID.price : 0}" />
                                            <c:set var="dosageNum" value="${prescriptionItem.dosage != null ? prescriptionItem.dosage : 1}" />
                                            <c:set var="subtotal" value="${itemPrice * dosageNum}" />
                                            <c:set var="totalPrice" value="${totalPrice + subtotal}" />

                                            <div class="table-row">
                                                <div class="table-cell medicine-name-cell">
                                                    <i class="fas fa-capsules"></i>
                                                    ${prescriptionItem.medicineID.medicineName}
                                                </div>
                                                <div class="table-cell">
                                                    ${prescriptionItem.medicineID.medicineType != null ? prescriptionItem.medicineID.medicineType : 'N/A'}
                                                </div>
                                                <div class="table-cell price-cell">
                                                    <fmt:formatNumber value="${itemPrice}" pattern="#,##0"/> VND
                                                </div>
                                                <div class="table-cell">
                                                    ${prescriptionItem.dosage != null ? prescriptionItem.dosage : 'N/A'}
                                                </div>
                                                <div class="table-cell instructions-cell">
                                                    ${prescriptionItem.instruction != null ? prescriptionItem.instruction : 'No specific instructions'}
                                                </div>
                                                <div class="table-cell price-cell">
                                                    <fmt:formatNumber value="${subtotal}" pattern="#,##0"/> VND
                                                </div>
                                            </div>
                                        </c:forEach>

                                        <div class="table-footer">
                                            <div class="total-row">
                                                <div class="total-label">Total:</div>
                                                <div class="total-amount"><fmt:formatNumber value="${totalPrice}" pattern="#,##0"/> VND</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty appointment.note}">
                                <div class="info-section">
                                    <h3 class="section-title">
                                        <i class="fas fa-notes-medical"></i>
                                        Note
                                    </h3>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <div class="info-icon">
                                                <i class="fas fa-comment-alt"></i>
                                            </div>
                                            <div class="info-content">
                                                <h4>Note</h4>
                                                <p>${appointment.note}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:when>
                        <%-- Handle MEDICINE INVOICE (invoice) - Not used anymore --%>
                        <c:when test="${not empty invoice}">
                            <!-- Invoice Information -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-file-invoice-dollar"></i>
                                    Invoice Information
                                </h3>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-calendar"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Date Created</h4>
                                            <p>
                                                <fmt:formatDate value="${invoice.dateCreate}"
                                                                pattern="EEEE, MMMM dd, yyyy"/>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-info-circle"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Invoice Status</h4>
                                            <p>
                                                <span class="appointment-status
                                                      <c:choose>
                                                          <c:when test="${invoice.invoiceStatus == 'Paid'}">status-completed</c:when>
                                                          <c:otherwise>status-pending</c:otherwise>
                                                      </c:choose>">
                                                    ${invoice.invoiceStatus != null ? invoice.invoiceStatus : 'Pending'}
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-credit-card"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Payment Type</h4>
                                            <p>${invoice.paymentType != null ? invoice.paymentType : 'N/A'}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Payment Information -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-money-bill-wave"></i>
                                    Payment Information
                                </h3>
                                <div class="info-grid">
                                    <!-- Consultation Fee -->
                                    <c:if test="${consultationFee != null && consultationFee > 0}">
                                        <div class="info-item">
                                            <div class="info-icon">
                                                <i class="fas fa-dollar-sign"></i>
                                            </div>
                                            <div class="info-content">
                                                <h4>Consultation Fee</h4>
                                                <p class="amount-highlight">
                                                    <fmt:formatNumber value="${consultationFee}" pattern="#,##0"/> VND
                                                </p>
                                                <p>
                                                    <span class="appointment-status status-completed">
                                                        ${consultationFeeStatus}
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                    </c:if>
                                    
                                    <!-- Medicine Fee -->
                                    <c:if test="${medicineFee != null && medicineFee > 0}">
                                        <div class="info-item">
                                            <div class="info-icon">
                                                <i class="fas fa-pills"></i>
                                            </div>
                                            <div class="info-content">
                                                <h4>Total Medicine Fee</h4>
                                                <p class="amount-highlight">
                                                    <fmt:formatNumber value="${medicineFee}" pattern="#,##0"/> VND
                                                </p>
                                                <p>
                                                    <span class="appointment-status
                                                          <c:choose>
                                                              <c:when test="${medicineFeeStatus == 'Paid'}">status-completed</c:when>
                                                              <c:otherwise>status-pending</c:otherwise>
                                                          </c:choose>">
                                                        ${medicineFeeStatus != null ? medicineFeeStatus : 'Pending'}
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            
                            <!-- Medicine Details Table -->
                            <c:if test="${not empty prescriptionItems}">
                                <div class="info-section">
                                    <h3 class="section-title">
                                        <i class="fas fa-pills"></i>
                                        Medicine Details
                                    </h3>
                                    <div class="medicines-table">
                                        <div class="table-header">
                                            <div class="header-cell">Medicine Name</div>
                                            <div class="header-cell">Type</div>
                                            <div class="header-cell">Price</div>
                                            <div class="header-cell">Dosage</div>
                                            <div class="header-cell">Instructions</div>
                                            <div class="header-cell">Subtotal</div>
                                        </div>

                                        <c:set var="totalPrice" value="0" />
                                        <c:forEach var="prescriptionItem" items="${prescriptionItems}">
                                            <c:set var="itemPrice" value="${prescriptionItem.medicineID.price != null ? prescriptionItem.medicineID.price : 0}" />
                                            <c:set var="dosageNum" value="${prescriptionItem.dosage != null ? prescriptionItem.dosage : 1}" />
                                            <c:set var="subtotal" value="${itemPrice * dosageNum}" />
                                            <c:set var="totalPrice" value="${totalPrice + subtotal}" />

                                            <div class="table-row">
                                                <div class="table-cell medicine-name-cell">
                                                    <i class="fas fa-capsules"></i>
                                                    ${prescriptionItem.medicineID.medicineName}
                                                </div>
                                                <div class="table-cell">
                                                    ${prescriptionItem.medicineID.medicineType != null ? prescriptionItem.medicineID.medicineType : 'N/A'}
                                                </div>
                                                <div class="table-cell price-cell">
                                                    <fmt:formatNumber value="${itemPrice}" pattern="#,##0"/> VND
                                                </div>
                                                <div class="table-cell">
                                                    ${prescriptionItem.dosage != null ? prescriptionItem.dosage : 'N/A'}
                                                </div>
                                                <div class="table-cell instructions-cell">
                                                    ${prescriptionItem.instruction != null ? prescriptionItem.instruction : 'No specific instructions'}
                                                </div>
                                                <div class="table-cell price-cell">
                                                    <fmt:formatNumber value="${subtotal}" pattern="#,##0"/> VND
                                                </div>
                                            </div>
                                        </c:forEach>

                                        <div class="table-footer">
                                            <div class="total-row">
                                                <div class="total-label">Total:</div>
                                                <div class="total-amount"><fmt:formatNumber value="${totalPrice}" pattern="#,##0"/> VND</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <!-- Error State -->
                            <div class="appointment-empty-state">
                                <i class="fas fa-exclamation-triangle"></i>
                                <h3>Invoice Not Found</h3>
                                <p>The invoice you're looking for doesn't exist or has been removed.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
        <jsp:include page="../includes/footer.jsp" />
    </body>
</html>
