<%--
    Document   : BookAppointment
    Created on : Oct 19, 2025, 12:30:00 AM
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
        <title>Book Appointment - CLINIC</title>
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="book-appointment" />
        </jsp:include>

        <div class="appointment-main-content">
            <!-- Page Header with Icon -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-calendar-plus"></i> Book Appointment</h1>
            </div>
            <!-- Appointments Section -->
            <div class="appointments-section">
                <!-- Error Modal -->
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div id="messageModal" class="modal-overlay">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title">
                                    <i class="fas fa-exclamation-triangle text-error"></i> Error
                                </h3>
                                <button type="button" class="modal-close" onclick="closeModal()">&times;</button>
                            </div>
                            <div class="modal-body">
                                <p>${sessionScope.errorMessage}</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" onclick="closeModal()">Close</button>
                            </div>
                        </div>
                    </div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>

                <!-- Doctor Information Section -->
                <c:if test="${not empty doctor}">
                    <div class="appointment-card">
                        <div class="appointment-header">
                            <h3 class="appointment-title">
                                <i class="fas fa-user-md" style="color: #2563eb;"></i> Doctor Information
                            </h3>
                        </div>

                        <div class="doctor-info-grid">
                            <!-- Doctor Name -->
                            <div class="doctor-info-item">
                                <div class="doctor-info-icon">
                                    <i class="fas fa-user-md"></i>
                                </div>
                                <div class="doctor-info-content">
                                    <div class="doctor-info-label">Doctor Name</div>
                                    <div class="doctor-info-value">${doctor.fullName}</div>
                                </div>
                            </div>

                            <!-- Specialty -->
                            <div class="doctor-info-item">
                                <div class="doctor-info-icon">
                                    <i class="fas fa-stethoscope"></i>
                                </div>
                                <div class="doctor-info-content">
                                    <div class="doctor-info-label">Specialty</div>
                                    <div class="doctor-info-value">
                                        <c:choose>
                                            <c:when test="${not empty doctor.specialtyName}">
                                                ${doctor.specialtyName}
                                            </c:when>
                                            <c:otherwise>
                                                General Practice
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- Rating -->
                            <div class="doctor-info-item">
                                <div class="doctor-info-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="doctor-info-content">
                                    <div class="doctor-info-label">Rating</div>
                                    <div class="doctor-info-value">
                                        <div class="doctor-rating">
                                            <c:forEach var="i" begin="1" end="5">
                                                <i class="fas fa-star star-filled"></i>
                                            </c:forEach>
                                            <span class="rating-score">5.0</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Experience -->
                            <div class="doctor-info-item">
                                <div class="doctor-info-icon">
                                    <i class="fas fa-graduation-cap"></i>
                                </div>
                                <div class="doctor-info-content">
                                    <div class="doctor-info-label">Experience</div>
                                    <div class="doctor-info-value">
                                        ${doctor.yearExperience}+ years
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Booking Form with Beautiful Design -->
                <div class="appointment-card book-appointment-card">
                    <form class="appointment-form modern-form" action="${pageContext.request.contextPath}/manage-my-appointments" method="post">
                        <input type="hidden" name="action" value="bookAppointment">
                        <input type="hidden" name="doctorId" value="${doctorId}">

                        <!-- Appointment Date & Time -->
                        <div class="form-group modern-form-group">
                            <label for="appointmentDateTime" class="form-label modern-label required">
                                <div class="label-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="label-content">
                                    <span class="label-title">Select Appointment Start Time</span>
                                    <span class="label-subtitle">Choose when to start your appointment</span>
                                </div>
                            </label>
                            <div class="input-wrapper">
                                <input type="datetime-local"
                                       id="appointmentDateTime"
                                       name="appointmentDateTime"
                                       class="form-control modern-input"
                                       required>
                                <div class="input-border"></div>
                                <div class="booking-rules-notice">
                                    <div class="notice-header">
                                        <i class="fas fa-info-circle"></i>
                                        <span>Booking Rules</span>
                                    </div>
                                    <ul class="rules-list">
                                        <li><i class="fas fa-clock"></i> Must book at least 24 hours in advance</li>
                                        <li><i class="fas fa-calendar-day"></i> Working hours: 7:00 AM - 5:00 PM</li>
                                        <li><i class="fas fa-calendar-plus"></i> Maximum 30 days in advance</li>
                                        <li><i class="fas fa-user-clock"></i> 24-hour gap between appointments required</li>
                                        <li><i class="fas fa-stethoscope"></i> End time determined by doctor when examination complete</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Appointment Notes -->
                        <div class="form-group modern-form-group">
                            <label for="note" class="form-label modern-label">
                                <div class="label-icon">
                                    <i class="fas fa-sticky-note"></i>
                                </div>
                                <div class="label-content">
                                    <span class="label-title">Additional Notes</span>
                                    <span class="label-subtitle">Help your doctor prepare for the consultation</span>
                                </div>
                            </label>
                            <div class="input-wrapper">
                                <textarea id="note"
                                          name="note"
                                          class="form-control modern-textarea"
                                          placeholder="Please describe your symptoms, medical concerns, or any specific requests..."
                                          maxlength="500"
                                          rows="4"></textarea>
                                <div class="input-border"></div>
                                <div class="character-counter">
                                    <span id="charCount">0</span>/500 characters
                                </div>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="form-actions modern-actions">
                            <button type="submit" class="btn btn-primary modern-btn-primary">
                                <i class="fas fa-calendar-check"></i>
                                <span>Book</span>
                                <div class="btn-shine"></div>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // Modal functions
            function closeModal() {
                const modal = document.getElementById('messageModal');
                if (modal) {
                    modal.style.display = 'none';
                    document.body.style.overflow = 'auto'; // Re-enable scrolling
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                // Auto show modal on page load if exists
                const modal = document.getElementById('messageModal');
                if (modal) {
                    modal.style.display = 'flex';
                    document.body.style.overflow = 'hidden'; // Disable scrolling when modal is open
                    
                    // Close modal when clicking outside
                    modal.addEventListener('click', function(e) {
                        if (e.target === modal) {
                            closeModal();
                        }
                    });
                    
                    // Close modal with Escape key
                    document.addEventListener('keydown', function(e) {
                        if (e.key === 'Escape') {
                            closeModal();
                        }
                    });
                }

                const noteTextarea = document.getElementById('note');
                const charCount = document.getElementById('charCount');

                            // Character counter functionality
                            if (noteTextarea && charCount) {
                                noteTextarea.addEventListener('input', function () {
                                    const currentLength = this.value.length;
                                    charCount.textContent = currentLength;

                                    // Change color based on character count
                                    if (currentLength > 450) {
                                        charCount.style.color = '#ef4444';
                                    } else if (currentLength > 350) {
                                        charCount.style.color = '#f59e0b';
                                    } else {
                                        charCount.style.color = '#6b7280';
                                    }
                                });
                            }

                            // Add focus animations to inputs
                            const inputs = document.querySelectorAll('.modern-input, .modern-textarea');
                            inputs.forEach(input => {
                                input.addEventListener('focus', function () {
                                    this.parentElement.classList.add('focused');
                                });

                                input.addEventListener('blur', function () {
                                    this.parentElement.classList.remove('focused');
                                });
                            });

                            // Add ripple effect to buttons
                            const buttons = document.querySelectorAll('.modern-btn-primary');
                            buttons.forEach(button => {
                                button.addEventListener('click', function (e) {
                                    const ripple = document.createElement('span');
                                    ripple.className = 'ripple';

                                    const rect = this.getBoundingClientRect();
                                    const size = Math.max(rect.width, rect.height);
                                    const x = e.clientX - rect.left - size / 2;
                                    const y = e.clientY - rect.top - size / 2;

                                    ripple.style.width = ripple.style.height = size + 'px';
                                    ripple.style.left = x + 'px';
                                    ripple.style.top = y + 'px';

                                    this.appendChild(ripple);

                                    setTimeout(() => {
                                        ripple.remove();
                                    }, 600);
                                });
                            });
                        });
        </script>
    </body>
</html>