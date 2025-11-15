<%--
    Document   : MyPrescriptionDetail
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
        <title>Prescription Details - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">


        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="../includes/header.jsp">
            <jsp:param name="activePage" value="manage-prescriptions" />
        </jsp:include>

        <main class="appointment-main-content">
            <div class="appointment-detail-card">
                <div class="appointment-page-header">
                    <h1><i class="fas fa-prescription-bottle-alt"></i> Prescription Details</h1>
                </div>

                <!-- Content Sections -->
                <div class="appointment-content">
                    <c:choose>
                        <c:when test="${not empty prescription}">
                            <!-- Prescription Information -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-prescription-bottle-alt"></i>
                                    Prescription Information
                                </h3>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-calendar"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Prescription Date</h4>
                                            <p>
                                                <fmt:formatDate value="${prescription.dateCreate}"
                                                                pattern="EEEE, MMMM dd, yyyy"/>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-prescription-bottle-alt"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Prescription Status</h4>
                                            <p>
                                                <span class="appointment-status
                                                      <c:choose>
                                                          <c:when test="${prescription.prescriptionStatus == 'Delivered'}">status-completed</c:when>
                                                      </c:choose>">
                                                    ${prescription.prescriptionStatus != null ? prescription.prescriptionStatus : 'Pending'}
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <c:choose>
                                    <c:when test="${not empty prescription.prescriptionItemList}">
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
                                            <c:forEach var="prescriptionItem" items="${prescription.prescriptionItemList}">
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
                                                        $<fmt:formatNumber value="${itemPrice}" pattern="#,##0.00"/>
                                                    </div>
                                                    <div class="table-cell">
                                                        ${prescriptionItem.dosage != null ? prescriptionItem.dosage : 'N/A'}
                                                    </div>
                                                    <div class="table-cell instructions-cell">
                                                        ${prescriptionItem.instruction != null ? prescriptionItem.instruction : 'No specific instructions'}
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
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-medicines">
                                            <i class="fas fa-info-circle"></i>
                                            <p>No medicines prescribed for this appointment.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- Prescription Notes -->
                            <c:choose>
                                <c:when test="${not empty prescription.note}">
                                    <div class="info-section">
                                        <h3 class="section-title">
                                            <i class="fas fa-sticky-note"></i>
                                            Prescription Notes
                                        </h3>
                                        <div class="info-grid">
                                            <div class="info-item">
                                                <div class="info-icon">
                                                    <i class="fas fa-comment-alt"></i>
                                                </div>
                                                <div class="info-content">
                                                    <h4>Notes</h4>
                                                    <p>${prescription.note}</p>
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
                                                    <c:when test="${not empty prescription.appointmentID.doctorID.staffID.firstName && not empty prescription.appointmentID.doctorID.staffID.lastName}">
                                                        Dr. ${prescription.appointmentID.doctorID.staffID.firstName} ${prescription.appointmentID.doctorID.staffID.lastName}
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
                                            <p>${prescription.appointmentID.doctorID.specialtyID.specialtyName != null ? prescription.appointmentID.doctorID.specialtyID.specialtyName : 'General Medicine'}</p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-graduation-cap"></i>
                                        </div>
                                        <div class="info-content">
                                            <h4>Experience</h4>
                                            <p>${prescription.appointmentID.doctorID.yearExperience}+ years</p>
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
                                            <p>${prescription.appointmentID.doctorID.staffID.email != null ? prescription.appointmentID.doctorID.staffID.email : 'N/A'}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Error State -->
                            <div class="appointment-empty-state">
                                <i class="fas fa-exclamation-triangle"></i>
                                <h3>Prescription Not Found</h3>
                                <p>The prescription you're looking for doesn't exist or has been removed.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>

        <!-- JavaScript for interactivity -->
        <script>
            // Dropdown menu functionality
            document.addEventListener('DOMContentLoaded', function () {
                const dropdowns = document.querySelectorAll('.dropdown');

                dropdowns.forEach(dropdown => {
                    const toggle = dropdown.querySelector('.dropdown-toggle');
                    const menu = dropdown.querySelector('.dropdown-menu');

                    if (toggle && menu) {
                        toggle.addEventListener('click', function (e) {
                            e.preventDefault();

                            // Close other dropdowns
                            dropdowns.forEach(otherDropdown => {
                                if (otherDropdown !== dropdown) {
                                    const otherMenu = otherDropdown.querySelector('.dropdown-menu');
                                    if (otherMenu) {
                                        otherMenu.style.opacity = '0';
                                        otherMenu.style.visibility = 'hidden';
                                        otherMenu.style.transform = 'translateY(-10px)';
                                    }
                                }
                            });

                            // Toggle current dropdown
                            const isVisible = menu.style.opacity === '1';
                            if (isVisible) {
                                menu.style.opacity = '0';
                                menu.style.visibility = 'hidden';
                                menu.style.transform = 'translateY(-10px)';
                            } else {
                                menu.style.opacity = '1';
                                menu.style.visibility = 'visible';
                                menu.style.transform = 'translateY(0)';
                            }
                        });
                    }
                });

                // Close dropdown when clicking outside
                document.addEventListener('click', function (e) {
                    if (!e.target.closest('.dropdown')) {
                        dropdowns.forEach(dropdown => {
                            const menu = dropdown.querySelector('.dropdown-menu');
                            if (menu) {
                                menu.style.opacity = '0';
                                menu.style.visibility = 'hidden';
                                menu.style.transform = 'translateY(-10px)';
                            }
                        });
                    }
                });
            });
        </script>
    </body>
</html>
