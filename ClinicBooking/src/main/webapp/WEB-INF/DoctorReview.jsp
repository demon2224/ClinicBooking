<%--
    Document   : DoctorReview
    Created on : Oct 15, 2025, 7:56:58 AM
    Author     : Nguyen Minh Khang - CE190728
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="doctor-detail-reviews-section">
    <div class="doctor-detail-reviews-header">
        <h3 class="doctor-detail-reviews-title">
            <i class="fas fa-star"></i>
            Doctor Reviews
        </h3>
        <span class="doctor-detail-reviews-count">
            <c:choose>
                <c:when test="${not empty doctorReviews}">
                    ${reviewCount} Reviews
                </c:when>
                <c:otherwise>
                    0 Reviews
                </c:otherwise>
            </c:choose>
        </span>
    </div>
    <c:choose>
        <c:when test="${not empty doctorReviews}">
            <c:forEach var="review" items="${doctorReviews}">
                <div class="doctor-detail-review-item">
                    <div class="doctor-detail-reviewer-info">
                        <div class="doctor-detail-reviewer-avatar">
                            ${fn:substring(review.patientID.firstName, 0, 1)}
                        </div>
                        <div class="doctor-detail-reviewer-details">
                            <p class="doctor-detail-reviewer-name">${review.patientID.firstName} ${review.patientID.lastName}</p>
                            <div class="doctor-detail-review-meta">
                                <div class="doctor-detail-review-rating">
                                    <div class="doctor-detail-rating-stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i
                                                class="fas fa-star doctor-detail-rating-star ${i <= review.rateScore ? '' : 'empty'}"></i>
                                        </c:forEach>
                                    </div>
                                    <span class="doctor-detail-rating-score">
                                        <c:choose>
                                            <c:when test="${review.rateScore % 1 == 0}">
                                                ${review.rateScore.intValue()}/5
                                            </c:when>
                                            <c:otherwise>
                                                ${review.rateScore}/5
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <span class="review-date">
                                    ${review.dateCreate.toString().substring(0,
                                      16).replace('T', ' ')}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="doctor-detail-review-content">
                        ${review.content}
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="doctor-detail-no-reviews">
                <i class="fas fa-comments"></i>
                <p>No reviews available for this doctor yet.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

