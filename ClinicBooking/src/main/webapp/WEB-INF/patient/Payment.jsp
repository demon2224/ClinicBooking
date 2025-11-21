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
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">

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
                            </div>
                        </div>
                    </div>
                </div>

                <!-- QR Payment Section -->
                <div class="appointment-card qr-payment-section" id="qr-payment-section">
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
            </div>
        </div>
        <jsp:include page="../includes/footer.jsp" />

        <script>
            // Mark QR payment as successful
            function markPaymentSuccess() {
                showLoadingSpinner('Confirming payment...');

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
                            console.error('Payment error:', error);
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

                // Redirect after 2 seconds to prescription list
                setTimeout(() => {
                    window.location.href = '${contextPath}/manage-my-prescriptions';
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

        </script>
    </body>
</html>
