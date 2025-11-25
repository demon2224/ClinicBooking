<%--
    Document   : CreateMedicine
    Created on : Oct 11, 2025, 2:00:09 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create Medicine</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <!-- Bootstrap & FontAwesome -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <style>
            body {
                background-color: #f8f9fa;
            }
            .main-content {
                margin-left: 260px;
                padding: 25px;
            }

            .card {
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
                margin-bottom: 30px;
            }

            .card-header {
                background-color: #1B5A90;
                color: white;
                font-weight: bold;
            }

            .required::after {
                content: " *";
                color: red;
            }
        </style>
    </head>

    <body>

        <%@ include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="main-content">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-primary">
                    <i class="fa-solid fa-capsules me-2"></i>Create New Medicine
                </h2>
            </div>

            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-circle-plus me-2"></i>Medicine Information
                </div>

                <div class="card-body p-4">

                    <form action="${pageContext.request.contextPath}/manage-medicine" method="POST">
                        <input type="hidden" name="action" value="create">

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label required">Medicine Name</label>
                                <input type="text" class="form-control" name="medicineName" required>
                                <c:if test="${not empty medicineNameErrorMsg}">
                                    <div class="text-danger small mt-1">
                                        <i class="fa-solid fa-circle-exclamation me-1"></i>
                                        <c:out value="${medicineNameErrorMsg}" />
                                    </div>
                                </c:if>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label required">Medicine Code</label>
                                <input type="text" class="form-control" name="medicineCode" required>
                                <c:if test="${not empty medicineCodeErrorMsg}">
                                    <div class="text-danger small mt-1">
                                        <i class="fa-solid fa-circle-exclamation me-1"></i>
                                        <c:out value="${medicineCodeErrorMsg}" />
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label required">Medicine Type</label>
                                <select class="form-select" name="medicineType" required>
                                    <c:forEach var="type" items="${medicineTypeList}">
                                        <option value="${type}"><c:out value="${type}" /></option>
                                    </c:forEach>
                                </select>

                                <c:if test="${not empty medicineTypeErrorMsg}">
                                    <div class="text-danger small mt-1">
                                        <i class="fa-solid fa-circle-exclamation me-1"></i>
                                        <c:out value="${medicineTypeErrorMsg}" />
                                    </div>
                                </c:if>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label required">Price (VND)</label>
                                <input type="number" min="0"
                                       class="form-control" name="price" required>

                                <c:if test="${not empty medicinePriceErrorMsg}">
                                    <div class="text-danger small mt-1">
                                        <i class="fa-solid fa-circle-exclamation me-1"></i>
                                        <c:out value="${medicinePriceErrorMsg}" />
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <input type="hidden" name="medicineStatus" value="1">

                        <div class="d-flex justify-content-center mt-4">
                            <button class="btn btn-success px-5 py-2 fw-bold"
                                    style="border-radius: 30px;">
                                Create
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>

    </body>
</html>

