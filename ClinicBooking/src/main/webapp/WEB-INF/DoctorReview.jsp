<%--
    Document   : DoctorReview
    Created on : Oct 15, 2025, 7:56:58 AM
    Author     : Nguyen Minh Khang - CE190728
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    <div class="reviews-section">
        <div class="reviews-header">
            <h3 class="reviews-title">
                <i class="fas fa-star"></i>
                Doctor Reviews
            </h3>
            <span class="reviews-count">
                <c:choose>
                    <c:when test="${not empty doctorReviews}">
                        ${fn:length(doctorReviews)} Reviews
                    </c:when>
                    <c:otherwise>
                        No Reviews
                    </c:otherwise>
                </c:choose>
            </span>
        </div>
        <c:choose>
            <c:when test="${not empty doctorReviews}">
                <c:forEach var="review" items="${doctorReviews}">
                    <div class="review-item">
                        <div class="reviewer-info">
                            <div class="reviewer-avatar">
                                ${fn:substring(review.reviewerFullName, 0, 1)}
                            </div>
                            <div class="reviewer-details">
                                <p class="reviewer-name">${review.reviewerFullName}</p>
                                <div class="review-meta">
                                    <div class="review-rating">
                                        <div class="rating-stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i
                                                    class="fas fa-star rating-star ${i <= review.rateScore ? '' : 'empty'}"></i>
                                            </c:forEach>
                                        </div>
                                        <span
                                            class="rating-score">${review.rateScore}/5</span>
                                    </div>
                                    <span class="review-date">
                                        ${review.dateCreate.toString().substring(0,
                                          16).replace('T', ' ')}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="review-content">
                            ${review.content}
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-reviews">
                    <i class="fas fa-comments"
                       style="font-size: 2rem; color: #dee2e6; margin-bottom: 1rem;"></i>
                    <p>No reviews available for this doctor yet.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

