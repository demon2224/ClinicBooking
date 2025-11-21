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
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">

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

                <!-- Success Modal -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div id="successModal" class="modal-overlay">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title">
                                    <i class="fas fa-check-circle text-success"></i> Success
                                </h3>
                                <button type="button" class="modal-close" onclick="closeSuccessModal()">&times;</button>
                            </div>
                            <div class="modal-body">
                                <p>${sessionScope.successMessage}</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-success" onclick="closeSuccessModal()">OK</button>
                            </div>
                        </div>
                    </div>
                    <c:remove var="successMessage" scope="session"/>
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
        <jsp:include page="../includes/footer.jsp" />

        <script>
            // Modal functions
            function closeModal() {
                const modal = document.getElementById('messageModal');
                if (modal) {
                    modal.classList.remove('active'); // Remove active class instead of setting display
                    document.body.style.overflow = 'auto'; // Re-enable scrolling
                }
            }

            function closeSuccessModal() {
                const modal = document.getElementById('successModal');
                if (modal) {
                    modal.classList.remove('active'); // Remove active class instead of setting display
                    document.body.style.overflow = 'auto'; // Re-enable scrolling
                }
            }

            // Calendar and DateTime functionality
            let currentDate = new Date();
            let selectedDateStr = '';
            let selectedTimeStr = '';
            
            // ⭐ Optimization: Cache và request management
            let validationCache = new Map(); // Cache validation results
            let pendingRequests = new Set(); // Track pending requests
            let debounceTimer = null; // Debounce timer
            let currentValidationAbortController = null; // Abort controller for current validation

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
                
                // Normalize dates to 00:00:00 for proper comparison
                const todayStart = new Date(today.getFullYear(), today.getMonth(), today.getDate());
                // ⭐ Cho phép chọn từ ngày mai trở đi (validation 24h sẽ check ở level time slot)
                const minDate = new Date(todayStart);
                minDate.setDate(minDate.getDate() + 1); // Tomorrow - cho phép chọn
                const maxDate = new Date(todayStart);
                maxDate.setDate(maxDate.getDate() + 30); // 30 days from today

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
                    // Normalize dayDate to 00:00:00 for comparison
                    const dayDateNormalized = new Date(year, month, day, 0, 0, 0);

                    // Disable past dates (today and before) and dates beyond 30 days
                    // ⭐ Cho phép chọn từ ngày mai trở đi (validation 24h sẽ check ở level time slot)
                    if (dayDateNormalized < minDate || dayDateNormalized > maxDate) {
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

                // Store selected date - Dùng toISOString() nhưng set time 12:00:00 để tránh timezone shift
                // Set time về 12:00:00 (giữa ngày) để khi convert sang UTC không bị lệch ngày
                const dateAtNoon = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 12, 0, 0);
                const newDateStr = dateAtNoon.toISOString().split('T')[0];
                selectedDateStr = newDateStr;
                document.getElementById('selectedDate').value = selectedDateStr;

                // ⭐ RESET SLOTS NGAY LẬP TỨC khi chọn ngày mới (không đợi debounce)
                resetAllTimeSlots();

                // ⭐ Debounce validation để tránh gửi quá nhiều request
                if (debounceTimer) {
                    clearTimeout(debounceTimer);
                }
                
                // Cancel previous validation if still running
                if (currentValidationAbortController) {
                    currentValidationAbortController.abort();
                    currentValidationAbortController = null;
                }
                
                debounceTimer = setTimeout(() => {
                    validateAllTimeSlots(newDateStr);
                }, 300); // Wait 300ms after last date selection

                // Update combined datetime if time is also selected
                updateDateTime();
            }
            
            // ⭐ Reset tất cả time slots về trạng thái ban đầu
            function resetAllTimeSlots() {
                document.querySelectorAll('.time-slot').forEach(slot => {
                    slot.classList.remove('disabled', 'booked', 'warning', 'selected');
                    slot.disabled = false;
                    slot.style.display = 'block';
                    slot.style.opacity = '1';
                    slot.style.cursor = 'pointer';
                    slot.title = '';
                });
                // Clear selected time when date changes
                selectedTimeStr = '';
                const selectedTimeInput = document.getElementById('selectedTime');
                if (selectedTimeInput) {
                    selectedTimeInput.value = '';
                }
            }
            
            // ⭐ Validate tất cả time slots - Optimized với cache và abort controller
            function validateAllTimeSlots(date) {
                const doctorId = '${doctorId}';
                if (!doctorId || !date) return;
                
                // ⭐ RESET TRƯỚC KHI VALIDATE (đảm bảo clean state cho ngày mới)
                resetAllTimeSlots();
                
                // ⭐ Check cache first - Đảm bảo cache date khớp với date hiện tại
                const cacheKey = `${doctorId}_${date}`;
                if (validationCache.has(cacheKey)) {
                    const cachedResult = validationCache.get(cacheKey);
                    // Verify cached date matches current date
                    if (cachedResult.date === date) {
                        applyValidationResults(cachedResult.bookedSlots, cachedResult.validationResults, date);
                        return;
                    } else {
                        // Cache date mismatch - clear and fetch fresh
                        validationCache.delete(cacheKey);
                    }
                }
                
                // Create new abort controller for this validation
                currentValidationAbortController = new AbortController();
                const signal = currentValidationAbortController.signal;
                
                // Reset đã được gọi ở trên, không cần reset lại
                
                // ⭐ GỬI 1 REQUEST DUY NHẤT: Lấy tất cả thông tin (booked slots + validation results)
                fetch('${pageContext.request.contextPath}/manage-my-appointments?action=getTimeSlotsStatus&doctorId=' + doctorId + '&date=' + date, { signal })
                    .then(response => {
                        if (signal.aborted) throw new Error('Request aborted');
                        return response.json();
                    })
                    .then(data => {
                        if (signal.aborted) return;
                        if (!data || !data.bookedSlots) {
                            return;
                        }
                        
                        const bookedSlots = data.bookedSlots || [];
                        const validationResults = data.validationResults || {};
                        
                        // Parse booked slots thành Set để check nhanh
                        const bookedSlotsSet = new Set(bookedSlots.map(slot => normalizeTime(slot)));
                        
                        // ⭐ Apply booked slots TRƯỚC (ưu tiên hiển thị ngay)
                        document.querySelectorAll('.time-slot').forEach(slot => {
                            const slotTime = normalizeTime(slot.dataset.time);
                            
                            // Check nếu đã bị book - làm mờ ngay lập tức
                            if (bookedSlotsSet.has(slotTime)) {
                                slot.classList.add('disabled', 'booked', 'warning');
                                slot.disabled = true;
                                slot.style.opacity = '0.5';
                                slot.style.cursor = 'not-allowed';
                                slot.title = getWarningMessage('already_booked');
                            }
                        });
                        
                        // ⭐ Sau đó apply các validation khác
                        document.querySelectorAll('.time-slot').forEach(slot => {
                            const slotTime = normalizeTime(slot.dataset.time);
                            
                            // Skip nếu đã được đánh dấu là booked
                            if (bookedSlotsSet.has(slotTime)) {
                                return; // Đã xử lý ở trên
                            }
                            
                            // Tạo slotDateTime với format đúng (local timezone)
                            // date format: "YYYY-MM-DD", slotTime format: "HH:mm"
                            const [year, month, day] = date.split('-').map(Number);
                            const [hour, minute] = slotTime.split(':').map(Number);
                            const slotDateTime = new Date(year, month - 1, day, hour, minute, 0);
                            
                            let shouldDisable = false;
                            let reason = '';
                            
                            // 1. Check quá khứ (client-side check)
                            const now = new Date();
                            if (slotDateTime <= now) {
                                shouldDisable = true;
                                reason = 'past';
                            }
                            // 2. Check ngoài giờ làm việc (client-side check)
                            else if (!isWithinWorkingHours(slotDateTime)) {
                                shouldDisable = true;
                                reason = 'outside_working_hours';
                            }
                            // 3. Check quá 30 ngày (client-side check)
                            else if (isMoreThan30Days(slotDateTime)) {
                                shouldDisable = true;
                                reason = 'too_far_future';
                            }
                            // 4. Check chưa đủ 24h trước (client-side check)
                            else if (!isAtLeast24HoursInAdvance(slotDateTime)) {
                                shouldDisable = true;
                                reason = 'less_than_24h';
                            }
                            // 5. Check validation results từ server (ưu tiên server validation)
                            // Lưu ý: validationResults có thể dùng format "07:00" hoặc "7:00", cần check cả 2
                            const normalizedSlotTime = normalizeTime(slotTime);
                            if (validationResults[slotTime] && validationResults[slotTime].disabled) {
                                shouldDisable = true;
                                reason = validationResults[slotTime].reason || '';
                            } else if (validationResults[normalizedSlotTime] && validationResults[normalizedSlotTime].disabled) {
                                shouldDisable = true;
                                reason = validationResults[normalizedSlotTime].reason || '';
                            }
                            
                            // Apply to UI - CHỈ disable nếu thực sự cần
                            if (shouldDisable) {
                                slot.classList.add('disabled', 'warning');
                                slot.disabled = true;
                                slot.style.opacity = '0.5';
                                slot.style.cursor = 'not-allowed';
                                slot.title = getWarningMessage(reason);
                            } else {
                                // Đảm bảo slot hợp lệ không bị disable
                                slot.classList.remove('disabled', 'warning');
                                slot.disabled = false;
                                slot.style.opacity = '1';
                                slot.style.cursor = 'pointer';
                                slot.title = '';
                            }
                        });
                        
                        // Cache results - Đảm bảo cache với đúng date
                        if (!signal.aborted) {
                            // Validate cache key matches current date
                            const expectedCacheKey = `${doctorId}_${date}`;
                            if (cacheKey === expectedCacheKey) {
                                validationCache.set(cacheKey, {
                                    bookedSlots: bookedSlots,
                                    validationResults: validationResults,
                                    date: date // Store date in cache để verify sau
                                });
                                
                                // Clear cache after 5 minutes
                                setTimeout(() => {
                                    validationCache.delete(cacheKey);
                                }, 5 * 60 * 1000);
                            }
                        }
                    })
                    .catch(error => {
                        if (error.name === 'AbortError' || error.message === 'Request aborted') {
                            return; // Request was cancelled
                        }
                    });
            }
            
            // ⭐ Apply validation results to UI (from cache or fresh fetch)
            function applyValidationResults(bookedSlots, validationResults, date) {
                // Đảm bảo date được truyền đúng
                if (!date) {
                    return;
                }
                
                // Reset trước khi apply (đảm bảo clean state)
                resetAllTimeSlots();
                
                const bookedSlotsSet = new Set(bookedSlots.map(slot => normalizeTime(slot)));
                
                // ⭐ Apply booked slots TRƯỚC (ưu tiên hiển thị ngay)
                document.querySelectorAll('.time-slot').forEach(slot => {
                    const slotTime = normalizeTime(slot.dataset.time);
                    
                    // Check nếu đã bị book - làm mờ ngay lập tức
                    if (bookedSlotsSet.has(slotTime)) {
                        slot.classList.add('disabled', 'booked', 'warning');
                        slot.disabled = true;
                        slot.style.opacity = '0.5';
                        slot.style.cursor = 'not-allowed';
                        slot.title = getWarningMessage('already_booked');
                    }
                });
                
                // ⭐ Sau đó apply các validation khác
                document.querySelectorAll('.time-slot').forEach(slot => {
                    const slotTime = normalizeTime(slot.dataset.time);
                    
                    // Skip nếu đã được đánh dấu là booked
                    if (bookedSlotsSet.has(slotTime)) {
                        return; // Đã xử lý ở trên
                    }
                    
                    // Tạo slotDateTime với format đúng (local timezone)
                    // date format: "YYYY-MM-DD", slotTime format: "HH:mm"
                    // ⭐ QUAN TRỌNG: Phải dùng đúng date được truyền vào, không dùng biến date từ closure
                    const [year, month, day] = date.split('-').map(Number);
                    const [hour, minute] = slotTime.split(':').map(Number);
                    const slotDateTime = new Date(year, month - 1, day, hour, minute, 0);
                    
                    let shouldDisable = false;
                    let reason = '';
                    
                    const now = new Date();
                    if (slotDateTime <= now) {
                        shouldDisable = true;
                        reason = 'past';
                    } else if (!isWithinWorkingHours(slotDateTime)) {
                        shouldDisable = true;
                        reason = 'outside_working_hours';
                    } else if (isMoreThan30Days(slotDateTime)) {
                        shouldDisable = true;
                        reason = 'too_far_future';
                    } else if (!isAtLeast24HoursInAdvance(slotDateTime)) {
                        shouldDisable = true;
                        reason = 'less_than_24h';
                    } else {
                        // Check validation results từ server (ưu tiên server validation)
                        // Lưu ý: validationResults có thể dùng format "07:00" hoặc "7:00", cần check cả 2
                        const normalizedSlotTime = normalizeTime(slotTime);
                        if (validationResults[slotTime] && validationResults[slotTime].disabled) {
                            shouldDisable = true;
                            reason = validationResults[slotTime].reason || '';
                        } else if (validationResults[normalizedSlotTime] && validationResults[normalizedSlotTime].disabled) {
                            shouldDisable = true;
                            reason = validationResults[normalizedSlotTime].reason || '';
                        }
                    }
                    
                    // Apply to UI - CHỈ disable nếu thực sự cần
                    if (shouldDisable) {
                        slot.classList.add('disabled', 'warning');
                        slot.disabled = true;
                        slot.style.opacity = '0.5';
                        slot.style.cursor = 'not-allowed';
                        slot.title = getWarningMessage(reason);
                    } else {
                        // Đảm bảo slot hợp lệ không bị disable
                        slot.classList.remove('disabled', 'warning');
                        slot.disabled = false;
                        slot.style.opacity = '1';
                        slot.style.cursor = 'pointer';
                        slot.title = '';
                    }
                });
            }
            
            // ⭐ Helper functions cho client-side validation
            function isWithinWorkingHours(dateTime) {
                const hour = dateTime.getHours();
                const minute = dateTime.getMinutes();
                // 7:00 AM - 4:30 PM
                if (hour < 7) return false;
                if (hour > 16) return false;
                if (hour === 16 && minute > 30) return false;
                return true;
            }
            
            function isMoreThan30Days(dateTime) {
                const now = new Date();
                const maxDate = new Date(now.getTime() + 30 * 24 * 60 * 60 * 1000);
                return dateTime > maxDate;
            }
            
            function isAtLeast24HoursInAdvance(dateTime) {
                const now = new Date();
                const minDate = new Date(now.getTime() + 24 * 60 * 60 * 1000);
                // Return true nếu dateTime lớn hơn minDate (có thể book)
                // Return false nếu dateTime nhỏ hơn hoặc bằng minDate (không thể book)
                return dateTime.getTime() > minDate.getTime();
            }
            
            // ⭐ Function này không còn cần thiết nữa vì đã gộp vào getTimeSlotsStatus
            // Giữ lại để tương thích ngược nếu có code khác đang dùng
            
            // ⭐ Lấy warning message theo reason
            function getWarningMessage(reason) {
                const messages = {
                    'past': 'Past time',
                    'outside_working_hours': 'Outside working hours (7:00-16:30)',
                    'too_far_future': 'Can only book up to 30 days in advance',
                    'already_booked': 'Already booked',
                    'conflict_30min': 'Conflict with another appointment',
                    'less_than_24h': 'Must book at least 24 hours in advance',
                    'patient_24h_gap': 'Must wait 24 hours between appointments'
                };
                return messages[reason] || 'Cannot book this slot';
            }
            
            // Normalize time format: "7:00" -> "07:00"
            function normalizeTime(time) {
                if (!time) return '';
                const parts = time.split(':');
                if (parts.length === 2) {
                    const hour = parts[0].padStart(2, '0');
                    const minute = parts[1].padStart(2, '0');
                    return hour + ':' + minute;
                }
                return time;
            }

            function setupTimeSlots() {
                const timeSlots = document.querySelectorAll('.time-slot');

                timeSlots.forEach(slot => {
                    slot.addEventListener('click', () => {
                        // ⭐ Không cho click vào slot đã bị book hoặc disabled
                        if (slot.classList.contains('disabled') || slot.classList.contains('booked') || slot.disabled) {
                            return;
                        }
                        
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

                // Auto show error modal on page load if exists (Fix CSS conflict by using 'active' class)
                const errorModal = document.getElementById('messageModal');
                if (errorModal) {
                    // Add 'active' class to show modal (override display:none in CSS)
                    errorModal.classList.add('active');
                    document.body.style.overflow = 'hidden';

                    // Close modal when clicking outside
                    errorModal.addEventListener('click', function (e) {
                        if (e.target === errorModal) {
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

                // Auto show success modal on page load if exists
                const successModal = document.getElementById('successModal');
                if (successModal) {
                    // Add 'active' class to show modal (override display:none in CSS)
                    successModal.classList.add('active');
                    document.body.style.overflow = 'hidden';

                    // Close modal when clicking outside
                    successModal.addEventListener('click', function (e) {
                        if (e.target === successModal) {
                            closeSuccessModal();
                        }
                    });

                    // Close modal with Escape key
                    document.addEventListener('keydown', function (e) {
                        if (e.key === 'Escape') {
                            closeSuccessModal();
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

                // Không cần setup click handlers nữa - validate tất cả khi chọn date

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