<%--
    Document   : MyMedicalRecordDetail
    Created on : Dec 20, 2024, 3:46:33 PM
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
        <title>Medical Record Details - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">


        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="../includes/header.jsp">
            <jsp:param name="activePage" value="manage-medical-records" />
        </jsp:include>

        <main class="appointment-main-content">
            <div class="appointment-detail-card">
                <div class="appointment-page-header">
                    <h1><i class="fas fa-file-medical"></i> Medical Record Details</h1>
                </div>
                <!-- Content Sections -->
                <div class="appointment-content">
                    <c:choose>
                        <c:when test="${not empty medicalRecord}">
                            <!-- Medical Record Information -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-file-medical-alt"></i>
                                    Medical Record Information
                                </h3>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-calendar"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Record Date</h4>
                                            <p>
                                                <fmt:formatDate value="${medicalRecord.dateCreate}"
                                                                pattern="EEEE, MMMM dd, yyyy"/>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-stethoscope"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Symptoms</h4>
                                            <p>${medicalRecord.symptoms != null ? medicalRecord.symptoms : 'No symptoms recorded'}</p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-diagnoses"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Diagnosis</h4>
                                            <p>${medicalRecord.diagnosis != null ? medicalRecord.diagnosis : 'No diagnosis provided'}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Medical Record Notes -->
                            <c:choose>
                                <c:when test="${not empty medicalRecord.note}">
                                    <div class="info-section">
                                        <h3 class="section-title">
                                            <i class="fas fa-sticky-note"></i>
                                            Medical Record Notes
                                        </h3>
                                        <div class="info-grid">
                                            <div class="info-item">
                                                <div class="info-icon">
                                                    <i class="fas fa-comment-alt"></i>
                                                </div>
                                                <div class="info-content">
                                                    <h4>Notes</h4>
                                                    <p>${medicalRecord.note}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>
                            <!-- Doctor Information -->
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
                                                    <c:when test="${not empty medicalRecord.appointmentID.doctorID.staffID.firstName && not empty medicalRecord.appointmentID.doctorID.staffID.lastName}">
                                                        Dr. ${medicalRecord.appointmentID.doctorID.staffID.firstName} ${medicalRecord.appointmentID.doctorID.staffID.lastName}
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
                                            <p>${medicalRecord.appointmentID.doctorID.specialtyID.specialtyName != null && medicalRecord.appointmentID.doctorID.specialtyID.specialtyName != '' ? medicalRecord.appointmentID.doctorID.specialtyID.specialtyName : 'General Medicine'}</p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-graduation-cap"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Experience</h4>
                                            <p>${medicalRecord.appointmentID.doctorID.yearExperience}+ years</p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Rating</h4>
                                            <p>
                                            <div class="doctor-rating">
                                                <c:choose>
                                                    <c:when test="${averageRating > 0}">
                                                        <span class="stars">
                                                            <c:forEach begin="1" end="5" var="star">
                                                                <c:choose>
                                                                    <c:when test="${star <= averageRating}">
                                                                        <i class="fas fa-star star-filled"></i>
                                                                    </c:when>
                                                                    <c:when test="${star - averageRating < 1}">
                                                                        <i class="fas fa-star-half-alt star-filled"></i>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="far fa-star star-empty"></i>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </span>
                                                        <span class="rating-score">
                                                            <c:choose>
                                                                <c:when test="${averageRating % 1 == 0}">
                                                                    ${averageRating.intValue()}/5
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <fmt:formatNumber value="${averageRating}" pattern="#.#"/>/5
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="stars">
                                                            <c:forEach begin="1" end="5" var="star">
                                                                <i class="far fa-star star-empty"></i>
                                                            </c:forEach>
                                                        </span>
                                                        <span class="rating-score">No ratings</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-envelope"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Contact</h4>
                                            <p>${medicalRecord.appointmentID.doctorID.staffID.email != null && medicalRecord.appointmentID.doctorID.staffID.email != '' ? medicalRecord.appointmentID.doctorID.staffID.email : 'Email not available'}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Prescription Information -->
                            <c:choose>
                                <c:when test="${not empty medicalRecord.prescriptionDTO && not empty medicalRecord.prescriptionDTO.prescriptionItemList}">
                                    <div class="info-section">
                                        <h3 class="section-title">
                                            <i class="fas fa-pills"></i>
                                            Prescription Information
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
                                            <c:forEach var="item" items="${medicalRecord.prescriptionDTO.prescriptionItemList}">
                                                <c:set var="itemPrice" value="${item.medicineID.price != null ? item.medicineID.price : 0}" />
                                                <c:set var="dosageNum" value="${item.dosage != null ? item.dosage : 1}" />
                                                <c:set var="subtotal" value="${itemPrice * dosageNum}" />
                                                <c:set var="totalPrice" value="${totalPrice + subtotal}" />

                                                <div class="table-row">
                                                    <div class="table-cell medicine-name-cell">
                                                        <i class="fas fa-capsules"></i>
                                                        ${item.medicineID.medicineName}
                                                    </div>
                                                    <div class="table-cell">
                                                        ${item.medicineID.medicineType != null ? item.medicineID.medicineType : 'N/A'}
                                                    </div>
                                                    <div class="table-cell price-cell">
                                                        $<fmt:formatNumber value="${itemPrice}" pattern="#,##0.00"/>
                                                    </div>
                                                    <div class="table-cell">
                                                        ${item.dosage != null ? item.dosage : 'N/A'}
                                                    </div>
                                                    <div class="table-cell instructions-cell">
                                                        ${item.instruction != null ? item.instruction : 'No specific instructions'}
                                                    </div>
                                                    <div class="table-cell price-cell">
                                                        $<fmt:formatNumber value="${subtotal}" pattern="#,##0.00"/>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                            <div class="table-footer">
                                                <div class="total-row">
                                                    <div class="total-label">Total:</div>
                                                    <div class="total-amount">$<fmt:formatNumber value="${totalPrice}" pattern="#,##0.00"/></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${not empty medicalRecord.prescriptionDTO}">
                                    <div class="info-section">
                                        <h3 class="section-title">
                                            <i class="fas fa-pills"></i>
                                            Prescription Information
                                        </h3>
                                        <div class="appointment-empty-state">
                                            <i class="fas fa-pill"></i>
                                            <h3>No Prescription Items</h3>
                                            <p>This medical record has a prescription but no specific medications listed.</p>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="info-section">
                                        <h3 class="section-title">
                                            <i class="fas fa-pills"></i>
                                            Prescription Information
                                        </h3>
                                        <div class="appointment-empty-state">
                                            <i class="fas fa-pills"></i>
                                            <h3>No Prescription</h3>
                                            <p>No prescription was issued for this medical record.</p>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>


                        </c:when>
                        <c:otherwise>
                            <!-- Error Message -->
                            <div class="appointment-empty-state">
                                <div class="appointment-alert appointment-alert-error">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    <h3>Medical Record Not Found</h3>
                                    <p>The requested medical record could not be found or you don't have permission to view it.</p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </body>
</html>