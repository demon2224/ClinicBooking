<%-- Document : HomePage Created on : Oct 7, 2025, 12:07:56 AM Author : Le Anh Tuan - CE180905 --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Healthcare Excellence - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Main CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </head>

    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="home" />
        </jsp:include>

        <!-- Main Content -->
        <main class="appointment-main-content">
            <!-- Page Header -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-home"></i> Welcome Clinic</h1>
                <p class="page-description">Your health is our priority. Comprehensive medical care with experienced doctors.</p>
            </div>

            <!-- Health & Wellbeing Section -->
            <div class="health-wellbeing-section" id="about-section">
                <div class="health-wellbeing-container">
                    <div class="health-wellbeing-content">
                        <div class="health-wellbeing-text">
                            <h2>Committed to Your Health & Wellbeing</h2>
                            <p>At MediCare Clinic, we believe that exceptional healthcare should be accessible to everyone.
                                For over 15 years, we have been dedicated to providing comprehensive medical services with
                                compassion, innovation, and excellence.</p>
                        </div>
                        <div class="health-wellbeing-stats">
                            <div class="stat-item">
                                <div class="stat-number">15+</div>
                                <div class="stat-label">Years of<br>Excellence</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">10,000+</div>
                                <div class="stat-label">Happy Patients</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">50+</div>
                                <div class="stat-label">Medical Experts</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">10+</div>
                                <div class="stat-label">International Partners</div>
                            </div>
                        </div>
                    </div>
                    <div class="health-wellbeing-visual">
                        <div class="facility-icon">
                            <i class="fas fa-hospital"></i>
                        </div>
                        <div class="facility-text">Clinic</div>

                    </div>
                </div>
            </div>
            <!-- Statistics Section -->
            <div class="search-filter-section">
                <div class="search-filter-content">
                    <div class="filter-section">
                        <h2>Clinic Overview</h2>
                        <div class="homepage-stats-grid">
                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-user-md"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>Expert Doctors</h3>
                                    <p>Professional healthcare providers</p>
                                </div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-heart"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>Quality Care</h3>
                                    <p>Best treatment for your health</p>
                                </div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-shield-alt"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>Safe & Secure</h3>
                                    <p>Your health data is protected</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Doctors Section -->
            <div class="appointments-section">

                <div class="appointments-content">
                    <div class="appointments-header">
                        <h2><i class="fas fa-user-md"></i> Our Expert Doctors</h2>
                        <p>Meet our team of experienced healthcare professionals</p>
                    </div>
                    <c:choose>
                        <c:when test="${empty featuredDoctors}">
                            <!-- Empty State -->
                            <div class="appointment-empty-state">
                                <i class="fas fa-user-md"></i>
                                <h3>No Doctors Available</h3>
                                <p>Please check back later for our available doctors.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Display Featured Doctors -->
                            <c:forEach var="doctor" items="${featuredDoctors}">
                                <div class="appointment-card doctor-highlight">
                                    <div class="appointment-header">
                                        <div class="doctor-avatar-section">
                                            <div class="doctor-avatar">
                                                <c:choose>
                                                    <c:when test="${doctor.staffID.avatar != null && !empty doctor.staffID.avatar}">
                                                        <img src="${pageContext.request.contextPath}${doctor.staffID.avatar}"
                                                             alt="Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}"
                                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assests/img/doctor${(doctor.doctorID % 3) + 1}.jpg'">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/assests/img/doctor${(doctor.doctorID % 3) + 1}.jpg"
                                                             alt="Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}"
                                                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'">
                                                        <div class="avatar-placeholder" style="display: none;">
                                                            <i class="fas fa-user-md"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="appointment-info">
                                            <div class="appointment-date">
                                                <i class="fas fa-user-md"></i>
                                                Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}
                                            </div>
                                            <div class="appointment-doctor">
                                                <i class="fas fa-stethoscope"></i>
                                                ${doctor.specialtyID.specialtyName != null ? doctor.specialtyID.specialtyName : 'General Medicine'}
                                            </div>
                                            <div class="appointment-specialty">
                                                <i class="fas fa-medal"></i>
                                                ${doctor.yearExperience} years experience

                                                <!-- Rating Display -->
                                                <c:set var="currentRating" value="${doctorRatings[doctor.doctorID]}" />
                                                <c:choose>
                                                    <c:when test="${currentRating > 0}">
                                                        <div class="rating-display">
                                                            <c:forEach begin="1" end="5" var="star">
                                                                <c:choose>
                                                                    <c:when test="${star <= currentRating}">
                                                                        <i class="fas fa-star text-warning"></i>
                                                                    </c:when>
                                                                    <c:when test="${star - currentRating < 1}">
                                                                        <i class="fas fa-star-half-alt text-warning"></i>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="far fa-star text-muted"></i>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                            <span class="rating-value">
                                                                <c:choose>
                                                                    <c:when test="${currentRating % 1 == 0}">
                                                                        ${currentRating.intValue()}/5
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <fmt:formatNumber value="${currentRating}" pattern="#.#"/>/5
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="rating-display">
                                                            <span class="no-rating">No reviews yet</span>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="appointment-status status-approved">
                                            Available
                                        </div>
                                    </div>
                                    <div class="appointment-actions">
                                        <button class="btn-action btn-view" onclick="viewDoctorDetail('${doctor.doctorID}')">
                                            <i class="fas fa-eye"></i>
                                            View Profile
                                        </button>
                                        <button class="btn-action btn-cancel" onclick="bookAppointment('${doctor.doctorID}')">
                                            <i class="fas fa-calendar-plus"></i>
                                            Book Appointment
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>

        <!-- Include Footer -->
        <jsp:include page="../WEB-INF/includes/footer.jsp" />

        <!-- Success/Error Modal -->
        <c:if test="${not empty sessionScope.successMessage || not empty sessionScope.errorMessage}">
            <div id="messageModal" class="modal-overlay">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title">
                            <c:choose>
                                <c:when test="${not empty sessionScope.successMessage}">
                                    <i class="fas fa-check-circle text-success"></i> Success
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-exclamation-triangle text-error"></i> Error
                                </c:otherwise>
                            </c:choose>
                        </h3>
                        <button class="modal-close" onclick="closeModal()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${not empty sessionScope.successMessage}">
                            <p class="text-success">${sessionScope.successMessage}</p>
                            <c:remove var="successMessage" scope="session"/>
                        </c:if>
                        <c:if test="${not empty sessionScope.errorMessage}">
                            <p class="text-error">${sessionScope.errorMessage}</p>
                            <c:remove var="errorMessage" scope="session"/>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- JavaScript -->
        <script>
            // Modal functionality
            function closeModal() {
                document.getElementById('messageModal').style.display = 'none';
            }

            // Close modal when clicking outside
            document.addEventListener('click', function (event) {
                const modal = document.getElementById('messageModal');
                if (modal && event.target === modal) {
                    closeModal();
                }
            });

            // Doctor actions
            function viewDoctorDetail(doctorId) {
                window.location.href = '${pageContext.request.contextPath}/doctor?action=detail&id=' + doctorId;
            }

            function bookAppointment(doctorId) {
                window.location.href = '${pageContext.request.contextPath}/manage-my-appointments?action=bookAppointment&doctorId=' + doctorId;
            }

            // Card hover effects
            document.querySelectorAll('.stat-card, .quick-action-item, .appointment-card').forEach(card => {
                card.addEventListener('mouseenter', function () {
                    this.style.transform = 'translateY(-8px)';
                });

                card.addEventListener('mouseleave', function () {
                    this.style.transform = 'translateY(0)';
                });
            });

            // Button click effects
            document.querySelectorAll('.btn-action').forEach(button => {
                button.addEventListener('click', function (e) {
                    // Create ripple effect
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;

                    ripple.style.width = ripple.style.height = size + 'px';
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    ripple.classList.add('ripple');

                    this.appendChild(ripple);

                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
        </script>
    </body>
</html>