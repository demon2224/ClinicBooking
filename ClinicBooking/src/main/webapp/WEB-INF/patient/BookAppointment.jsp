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
        <jsp:include page="../includes/header.jsp">
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
                                    <div class="doctor-info-value">Dr. ${doctor.staffID.firstName} ${doctor.staffID.lastName}</div>
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
                                            <c:when test="${not empty doctor.specialtyID.specialtyName}">
                                                ${doctor.specialtyID.specialtyName}
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
                            <label class="form-label modern-label required">
                                <div class="label-icon">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <div class="label-content">
                                    <span class="label-title">Select Date & Time</span>
                                    <span class="label-subtitle">Choose your appointment date and time</span>
                                </div>
                            </label>
                            
                            <div class="datetime-selector">
                                <!-- Date Selection (Left Side) -->
                                <div class="date-selection">
                                    <div class="calendar-container">
                                        <div class="calendar-header">
                                            <button type="button" id="prevMonth" class="nav-btn">
                                                <i class="fas fa-chevron-left"></i>
                                            </button>
                                            <span id="monthYear"></span>
                                            <button type="button" id="nextMonth" class="nav-btn">
                                                <i class="fas fa-chevron-right"></i>
                                            </button>
                                        </div>
                                        <div class="calendar-weekdays">
                                            <div class="weekday">Su</div>
                                            <div class="weekday">Mo</div>
                                            <div class="weekday">Tu</div>
                                            <div class="weekday">We</div>
                                            <div class="weekday">Th</div>
                                            <div class="weekday">Fr</div>
                                            <div class="weekday">Sa</div>
                                        </div>
                                        <div class="calendar-days" id="calendarDays">
                                            <!-- Days will be generated by JavaScript -->
                                        </div>
                                    </div>
                                </div>

                                <!-- Time Selection (Right Side) -->
                                <div class="time-selection">
                                    <div class="time-slots-container">
                                        <div class="time-period">
                                            <div class="time-period-header">Morning</div>
                                            <div class="time-slots-grid">
                                                <button type="button" class="time-slot" data-time="07:00">7:00</button>
                                                <button type="button" class="time-slot" data-time="07:30">7:30</button>
                                                <button type="button" class="time-slot" data-time="08:00">8:00</button>
                                                <button type="button" class="time-slot" data-time="08:30">8:30</button>
                                                <button type="button" class="time-slot" data-time="09:00">9:00</button>
                                                <button type="button" class="time-slot" data-time="09:30">9:30</button>
                                                <button type="button" class="time-slot" data-time="10:00">10:00</button>
                                                <button type="button" class="time-slot" data-time="10:30">10:30</button>
                                                <button type="button" class="time-slot" data-time="11:00">11:00</button>
                                                <button type="button" class="time-slot" data-time="11:30">11:30</button>
                                            </div>
                                        </div>
                                        
                                        <div class="time-period">
                                            <div class="time-period-header">Afternoon</div>
                                            <div class="time-slots-grid">
                                                <button type="button" class="time-slot" data-time="12:00">12:00</button>
                                                <button type="button" class="time-slot" data-time="12:30">12:30</button>
                                                <button type="button" class="time-slot" data-time="13:00">13:00</button>
                                                <button type="button" class="time-slot" data-time="13:30">13:30</button>
                                                <button type="button" class="time-slot" data-time="14:00">14:00</button>
                                                <button type="button" class="time-slot" data-time="14:30">14:30</button>
                                                <button type="button" class="time-slot" data-time="15:00">15:00</button>
                                                <button type="button" class="time-slot" data-time="15:30">15:30</button>
                                                <button type="button" class="time-slot" data-time="16:00">16:00</button>
                                                <button type="button" class="time-slot" data-time="16:30">16:30</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Hidden inputs for form submission -->
                            <input type="hidden" id="appointmentDateTime" name="appointmentDateTime">
                            <input type="hidden" id="selectedDate" name="selectedDate">
                            <input type="hidden" id="selectedTime" name="selectedTime">
                            
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
                                </ul>
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
                                    <span id="charCount">0</span>/500
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

            // Calendar and DateTime functionality
            let currentDate = new Date();
            let selectedDateStr = '';
            let selectedTimeStr = '';

            function initCalendar() {
                renderCalendar();
                setupTimeSlots();
            }

            function renderCalendar() {
                const monthYear = document.getElementById('monthYear');
                const calendarDays = document.getElementById('calendarDays');
                
                const year = currentDate.getFullYear();
                const month = currentDate.getMonth();
                
                // Set month/year header
                monthYear.textContent = new Intl.DateTimeFormat('en-US', { 
                    month: 'long', 
                    year: 'numeric' 
                }).format(currentDate);
                
                // Clear previous days
                calendarDays.innerHTML = '';
                
                // Get first day of month and number of days
                const firstDay = new Date(year, month, 1).getDay();
                const daysInMonth = new Date(year, month + 1, 0).getDate();
                const today = new Date();
                const minDate = new Date(today.getTime() + 24 * 60 * 60 * 1000); // 24 hours from now
                const maxDate = new Date(today.getTime() + 30 * 24 * 60 * 60 * 1000); // 30 days from now
                
                // Add empty cells for days before month starts
                for (let i = 0; i < firstDay; i++) {
                    const emptyDay = document.createElement('div');
                    emptyDay.className = 'calendar-day empty';
                    calendarDays.appendChild(emptyDay);
                }
                
                // Add days of month
                for (let day = 1; day <= daysInMonth; day++) {
                    const dayElement = document.createElement('div');
                    dayElement.className = 'calendar-day';
                    dayElement.textContent = day;
                    
                    const dayDate = new Date(year, month, day);
                    
                    // Disable past dates and dates beyond 30 days (visual only)
                    if (dayDate < minDate || dayDate > maxDate) {
                        dayElement.classList.add('disabled');
                    } else {
                        dayElement.addEventListener('click', () => selectDate(dayDate, dayElement));
                    }
                    
                    calendarDays.appendChild(dayElement);
                }
            }

            function selectDate(date, element) {
                // Remove previous selection
                document.querySelectorAll('.calendar-day.selected').forEach(day => {
                    day.classList.remove('selected');
                });
                
                // Add selection to clicked date
                element.classList.add('selected');
                
                // Store selected date
                selectedDateStr = date.toISOString().split('T')[0];
                document.getElementById('selectedDate').value = selectedDateStr;
                
                // Update combined datetime if time is also selected
                updateDateTime();
            }

            function setupTimeSlots() {
                const timeSlots = document.querySelectorAll('.time-slot');
                
                timeSlots.forEach(slot => {
                    slot.addEventListener('click', () => {
                        // Remove previous selection
                        timeSlots.forEach(s => s.classList.remove('selected'));
                        
                        // Add selection to clicked slot
                        slot.classList.add('selected');
                        
                        // Store selected time
                        selectedTimeStr = slot.dataset.time;
                        document.getElementById('selectedTime').value = selectedTimeStr;
                        
                        // Update combined datetime if date is also selected
                        updateDateTime();
                    });
                });
            }

            function updateDateTime() {
                if (selectedDateStr && selectedTimeStr) {
                    const datetime = selectedDateStr + 'T' + selectedTimeStr;
                    document.getElementById('appointmentDateTime').value = datetime;
                }
            }

            function navigateMonth(direction) {
                currentDate.setMonth(currentDate.getMonth() + direction);
                renderCalendar();
            }

            document.addEventListener('DOMContentLoaded', function () {
                // Initialize calendar
                initCalendar();
                
                // Calendar navigation
                document.getElementById('prevMonth').addEventListener('click', () => navigateMonth(-1));
                document.getElementById('nextMonth').addEventListener('click', () => navigateMonth(1));
                
                // Auto show modal on page load if exists
                const modal = document.getElementById('messageModal');
                if (modal) {
                    modal.style.display = 'flex';
                    document.body.style.overflow = 'hidden'; // Disable scrolling when modal is open

                    // Close modal when clicking outside
                    modal.addEventListener('click', function (e) {
                        if (e.target === modal) {
                            closeModal();
                        }
                    });

                    // Close modal with Escape key
                    document.addEventListener('keydown', function (e) {
                        if (e.key === 'Escape') {
                            closeModal();
                        }
                    });
                }

                // Character counter functionality (display only, no validation)
                const noteTextarea = document.getElementById('note');
                const charCount = document.getElementById('charCount');
                
                if (noteTextarea && charCount) {
                    noteTextarea.addEventListener('input', function () {
                        const currentLength = this.value.length;
                        charCount.textContent = currentLength;
                        
                        // Change color based on character count (visual feedback only)
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