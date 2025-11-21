<%-- 
    Document   : 404
    Created on : Nov 18, 2025, 6:20:04 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>404 - Page Not Found | Clinic</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="${pageContext.request.contextPath}/assests/css/main.css?v=<%= System.currentTimeMillis()%>" 
              rel="stylesheet" type="text/css"/>

        <style>
            .error-page-container {
                text-align: center;
                padding: 80px 20px;
                color: #333;
            }

            .error-icon {
                font-size: 120px;
                color: #ff4d4d;
                margin-bottom: 20px;
            }

            .error-title {
                font-size: 48px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .error-description {
                font-size: 20px;
                margin-bottom: 30px;
                opacity: 0.8;
            }

            .btn-back-home {
                display: inline-flex;
                align-items: center;
                padding: 12px 25px;
                font-size: 18px;
                background-color: #007bff;
                color: #fff;
                border-radius: 8px;
                text-decoration: none;
                transition: 0.3s ease;
            }

            .btn-back-home i {
                margin-right: 8px;
            }

            .btn-back-home:hover {
                background-color: #0056b3;
                transform: translateY(-3px);
            }
        </style>
    </head>

    <body>

        <jsp:include page="includes/header.jsp">
            <jsp:param name="activePage" value="none" />
        </jsp:include>

        <main class="error-page-container">
            <i class="fas fa-exclamation-triangle error-icon"></i>
            <h1 class="error-title">404 - Page Not Found</h1>
            <p class="error-description">
                The page you are looking for doesn’t exist or may have been moved.
            </p>

            <a href="${pageContext.request.contextPath}/home" class="btn-back-home">
                <i class="fas fa-home"></i>
                Back to Homepage
            </a>
        </main>

        <jsp:include page="../WEB-INF/includes/footer.jsp" />

    </body>
</html>
