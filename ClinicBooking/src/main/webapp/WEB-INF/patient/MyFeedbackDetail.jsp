s<%--
    Document   : MyFeedbackDetail
    Created on : Oct 18, 2025, 1:30:04 PM
    Author     : Nguyen Minh Khang - CE190728
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
        <title>Feedback Detail - CLINIC</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">


        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS with cache busting -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" rel="stylesheet" type="text/css"/>


    </head>
    <body class="appointment-page">
        <!-- Include Header -->
        <jsp:include page="../includes/header.jsp">
            <jsp:param name="activePage" value="manage-feedbacks" />
        </jsp:include>

        <main class="appointment-main-content">
            <div class="appointment-detail-card">
                <div class="appointment-page-header">
                    <h1><i class="fas fa-star"></i> Feedback Detail</h1>
                </div>

                <!-- Content Sections -->
                <div class="appointment-content">
                    <!-- Feedback Information Section -->
                    <div class="info-section">
                        <h3 class="section-title">
                            <i class="fas fa-info-circle"></i>
                            Feedback Information
                        </h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-user-md"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Doctor Name</h4>
                                    <p>Dr. ${reviewDetail.doctorID.staffID.firstName} ${reviewDetail.doctorID.staffID.lastName}</p>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Your Rating</h4>
                                    <p>
                                    <div class="doctor-rating">
                                        <span class="stars">
                                            <c:forEach begin="1" end="5" var="star">
                                                <c:choose>
                                                    <c:when test="${star <= reviewDetail.rateScore}">
                                                        <i class="fas fa-star star-filled"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="far fa-star star-empty"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </span>
                                        <span class="rating-score">${reviewDetail.rateScore}/5</span>
                                    </div>
                                    </p>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Feedback Date</h4>
                                    <p>
                                        <c:choose>
                                            <c:when test="${reviewDetail.dateCreate != null}">
                                                <fmt:formatDate value="${reviewDetail.dateCreate}" pattern="EEEE, MMMM dd, yyyy"/>
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Feedback Time</h4>
                                    <p>
                                        <c:choose>
                                            <c:when test="${reviewDetail.dateCreate != null}">
                                                <fmt:formatDate value="${reviewDetail.dateCreate}" pattern="hh:mm a"/>
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Your Feedback Content Section -->
                    <div class="info-section">
                        <h3 class="section-title">
                            <i class="fas fa-comment"></i>
                            Your Feedback
                        </h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-comment-alt"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Feedback Content</h4>
                                    <p>${reviewDetail.content}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../includes/footer.jsp" />

    </body>
</html>
