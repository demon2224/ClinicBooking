<%--
    Document   : Payment
    Created on : Nov 13, 2025, 10:51:15 PM
    Author     : Le Anh Tuan - CE180905
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment - CLINIC</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>
    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="../includes/header.jsp">
            <jsp:param name="activePage" value="payment" />
        </jsp:include>

        <div class="appointment-main-content">
            <!-- Page Header -->
            <div class="appointment-page-header">
                <h1><i class="fas fa-credit-card"></i> Payment</h1>
            </div>

            <!-- Payment Content -->
            <div class="appointments-section">
                <!-- Invoice Information -->
                <div class="appointment-card">
                    <div class="appointment-header">
                        <h3><i class="fas fa-file-invoice-dollar"></i> Invoice Information</h3>
                    </div>
                    <div class="info-grid">
                        <div class="info-item">
                            <i class="fas fa-user-md info-icon"></i>
                            <div class="info-content">
                                <div class="info-label">Doctor</div>
                                <div class="info-value">Dr. ${invoice.medicalRecordID.appointmentID.doctorID.staffID.firstName} ${invoice.medicalRecordID.appointmentID.doctorID.staffID.lastName}</div>
                            </div>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-dollar-sign info-icon"></i>
                            <div class="info-content">
                                <div class="info-label">Total Amount</div>
                                <div class="info-value amount-highlight">${currencyDisplay}</div>
                                <div class="currency-note">QR code will automatically convert to VND</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Payment Methods Selection -->
                <div class="appointment-card payment-methods-card">
                    <div class="appointment-header">
                        <h3><i class="fas fa-credit-card"></i> Select Payment Method</h3>
                    </div>

                    <div class="payment-methods-grid">
                        <!-- Cash Payment -->
                        <div class="payment-method-option" onclick="selectPaymentMethod('cash')">
                            <div class="payment-method-icon">
                                <i class="fas fa-money-bill-wave"></i>
                            </div>
                            <div class="payment-method-info">
                                <h4>Cash</h4>
                                <p>Pay directly at the clinic</p>
                                <span class="payment-method-badge">Instant</span>
                            </div>
                            <div class="payment-method-radio">
                                <input type="radio" name="paymentMethod" value="cash" id="cash-method">
                            </div>
                        </div>

                        <!-- Credit Card Payment -->
                        <div class="payment-method-option" onclick="selectPaymentMethod('qr')">
                            <div class="payment-method-icon">
                                <i class="fas fa-credit-card"></i>
                            </div>
                            <div class="payment-method-info">
                                <h4>Credit Card</h4>
                                <p>Pay with your credit card</p>
                                <span class="payment-method-badge">Secure</span>
                            </div>
                            <div class="payment-method-radio">
                                <input type="radio" name="paymentMethod" value="qr" id="qr-method">
                            </div>
                        </div>
                    </div>

                    <!-- Payment Actions -->
                    <div class="payment-actions">
                        <button type="button" class="btn btn-primary" onclick="processPayment()" id="continue-btn">
                            <i class="fas fa-arrow-right"></i> Continue
                        </button>
                    </div>
                </div>

                <!-- Credit Card Payment Section (Initially Hidden) -->
                <div class="appointment-card qr-payment-section" id="qr-payment-section" style="display: none;">
                    <div class="appointment-header">
                        <h3><i class="fas fa-credit-card"></i> Credit Card Payment</h3>
                    </div>
                    <div class="payment-content">
                        <div class="qr-container">
                            <c:if test="${not empty qrUrl}">
                                <img src="${qrUrl}" alt="VietQR Payment Code" class="qr-image"
                                     onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI2Y4ZjlmYSIgc3Ryb2tlPSIjZGRkIi8+CiAgPHRleHQgeD0iNTAiIHk9IjEwMCIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjE0IiBmaWxsPSIjNjY2Ij5RUiBDb2RlIEVycm9yPC90ZXh0Pgo8L3N2Zz4=';"/>
                            </c:if>
                            <c:if test="${empty qrUrl}">
                                <div class="qr-error">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    <p>Unable to generate QR code</p>
                                </div>
                            </c:if>
                        </div>

                        <div class="payment-details">
                            <h4><i class="fas fa-university"></i> Bank Information</h4>
                            <div class="bank-info">
                                <div class="bank-item">
                                    <span class="bank-label">Bank:</span>
                                    <span class="bank-value">${bankName}</span>
                                </div>
                                <div class="bank-item">
                                    <span class="bank-label">Account Number:</span>
                                    <span class="bank-value">${accountNumber}</span>
                                </div>
                                <div class="bank-item">
                                    <span class="bank-label">Account Name:</span>
                                    <span class="bank-value">${accountName}</span>
                                </div>
                                <div class="bank-item">
                                    <span class="bank-label">Amount (VND):</span>
                                    <span class="bank-value amount-vnd"><fmt:formatNumber value="${vndAmount}" pattern="#,##0"/> VND</span>
                                </div>
                                <div class="bank-item">
                                    <span class="bank-label">Transfer Note:</span>
                                    <span class="bank-value transfer-content">${paymentReference}</span>
                                </div>
                            </div>
                        </div>

                        <div class="payment-instructions">
                            <h4><i class="fas fa-info-circle"></i> Payment Instructions</h4>
                            <ol>
                                <li>Open your banking app</li>
                                <li>Scan the QR code above or enter bank details manually</li>
                                <li>Ensure transfer note matches exactly: <strong>${paymentReference}</strong></li>
                                <li>Complete the payment on your banking app</li>
                                <li>After successful payment, click the <strong>"Payment Completed Successfully"</strong> button below</li>
                            </ol>
                            <div class="alert alert-warning" style="margin-top: 15px; padding: 10px; background: #fff3cd; border: 1px solid #ffeaa7; border-radius: 5px;">
                                <i class="fas fa-exclamation-triangle"></i>
                                <strong>Note:</strong> Only click the confirm button after you have successfully completed the payment.
                            </div>
                        </div>

                        <div class="qr-payment-actions">
                            <button type="button" class="btn btn-success" onclick="markPaymentSuccess()">
                                <i class="fas fa-check"></i> Payment Completed Successfully
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Payment Status Messages - Hidden -->
                <%--
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="appointment-card success-card">
                        <div class="success-content">
                            <i class="fas fa-check-circle success-icon"></i>
                            <h3>Payment Successful!</h3>
                            <p>${sessionScope.successMessage}</p>
                        </div>
                    </div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="appointment-card error-card">
                        <div class="error-content">
                            <i class="fas fa-exclamation-triangle error-icon"></i>
                            <h3>Notice</h3>
                            <p>${sessionScope.errorMessage}</p>
                        </div>
                    </div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>
                --%>
            </div>
        </div>

        <script>
            let selectedPaymentMethod = 'cash'; // Default to cash

            // Select payment method
            function selectPaymentMethod(method) {
                selectedPaymentMethod = method;

                // Update UI
                document.querySelectorAll('.payment-method-option').forEach(option => {
                    option.classList.remove('selected');
                });

                const radioInput = document.querySelector(`#${method}-method`);
                if (radioInput) {
                    radioInput.checked = true;
                    const paymentOption = radioInput.closest('.payment-method-option');
                    if (paymentOption) {
                        paymentOption.classList.add('selected');
                    }
                }

                // Hide QR section when selecting cash
                if (method === 'cash') {
                    document.getElementById('qr-payment-section').style.display = 'none';
                }
            }

            // Process payment when Continue button is clicked
            function processPayment() {
                if (selectedPaymentMethod === 'cash') {
                    // PT1: Cash payment - direct success
                    processCashPayment();
                } else if (selectedPaymentMethod === 'qr') {
                    // PT2: Credit Card payment - show payment section
                    showQRSection();
                }
            }

            // PT1: Cash payment processing
            function processCashPayment() {
                showLoadingSpinner('Processing cash payment...');

                const contextPath = '${contextPath}';
                const invoiceId = '${invoiceId}';

                fetch(contextPath + '/payment', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `action=processCashPayment&invoiceId=${invoiceId}`
                })
                        .then(response => response.json())
                        .then(data => {
                            hideLoadingSpinner();
                            if (data.success) {
                                showSuccessPopup(data.message);
                            } else {
                                alert('Payment failed: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Cash payment error:', error);
                            hideLoadingSpinner();
                            alert('Error processing payment: ' + error.message);
                        });
            }

            // PT2: Show QR section
            function showQRSection() {
                const qrSection = document.getElementById('qr-payment-section');
                qrSection.style.display = 'block';
                qrSection.scrollIntoView({behavior: 'smooth'});
            }

            // Mark Credit Card payment as successful
            function markPaymentSuccess() {
                showLoadingSpinner('Confirming Credit Card payment...');

                const contextPath = '${contextPath}';
                const invoiceId = '${invoiceId}';

                fetch(contextPath + '/payment', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `action=markPaymentSuccess&invoiceId=${invoiceId}`
                })
                        .then(response => response.json())
                        .then(data => {
                            hideLoadingSpinner();
                            if (data.success) {
                                showSuccessPopup(data.message);
                            } else {
                                alert('Payment failed: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Credit Card payment error:', error);
                            hideLoadingSpinner();
                            alert('Error processing payment: ' + error.message);
                        });
            }

            // Show success popup for 2 seconds then redirect
            function showSuccessPopup(message) {
                const popup = document.createElement('div');
                popup.className = 'success-popup show';
                popup.innerHTML = `
                    <div class="popup-content">
                        <i class="fas fa-check-circle"></i>
                        <h3>Payment Successful!</h3>
                        <p>${message}</p>
                    </div>
                `;
                document.body.appendChild(popup);

                // Redirect after 2 seconds
                setTimeout(() => {
                    window.location.href = '${contextPath}/manage-my-invoices';
                }, 2000);
            }

            // Loading spinner functions
            function showLoadingSpinner(text) {
                const spinner = document.createElement('div');
                spinner.id = 'loading-spinner';
                spinner.className = 'loading-overlay';
                spinner.innerHTML = `
                    <div class="loading-content">
                        <div class="spinner"></div>
                        <p>${text}</p>
                    </div>
                `;
                document.body.appendChild(spinner);
            }

            function hideLoadingSpinner() {
                const spinner = document.getElementById('loading-spinner');
                if (spinner) {
                    spinner.remove();
                }
            }

            // Initialize on page load
            document.addEventListener('DOMContentLoaded', function () {
                selectPaymentMethod('cash'); // Auto-select cash
            });
        </script>
    </body>
</html>
</script>
</body>
</html>
