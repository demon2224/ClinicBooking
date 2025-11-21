<%--
    Document   : ImportMedicine
    Created on : Oct 20, 2025, 5:44:32 PM
    Author     : Vu Minh Khang - CE191371
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Import Medicine</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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

            th {
                background-color: #f1f3f5;
                width: 220px;
                font-weight: 600;
            }
        </style>
    </head>

    <body>

        <%@include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="main-content">
            <c:set var="rate" value="25000" />
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-primary">
                    <i class="fa-solid fa-file-import me-2"></i>Import Medicine
                </h2>
            </div>

            <c:if test="${medicine.isHidden}">
                <div class="alert alert-danger text-center fs-4 py-3">
                    <i class="fa-solid fa-circle-exclamation me-2"></i>Medicine Not Found
                </div>
            </c:if>

            <c:if test="${!medicine.isHidden}">

                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-info-circle me-2"></i>Medicine Information
                    </div>

                    <div class="card-body p-4">

                        <table class="table table-bordered mb-4">
                            <tr>
                                <th>Name</th>
                                <td>${medicine.medicineName}</td>
                            </tr>

                            <tr>
                                <th>Code</th>
                                <td>${medicine.medicineCode}</td>
                            </tr>

                            <tr>
                                <th>Type</th>
                                <td>${medicine.medicineType}</td>
                            </tr>

                            <tr>
                                <th>Price</th>
                                <td>
                                    <fmt:formatNumber value="${medicine.price * rate}" type="number"
                                                      groupingUsed="true" maxFractionDigits="0" />
                                    đ
                                </td>
                            </tr>
                        </table>

                        <form action="${pageContext.request.contextPath}/manage-medicine" method="POST">
                            <input type="hidden" name="action" value="import">
                            <input type="hidden" name="medicineID" value="${medicine.medicineID}">

                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Quantity</label>
                                    <input type="number" name="quantity" class="form-control" min="1" required>

                                    <c:if test="${not empty medicineImportQuantityErrorMsg}">
                                        <div class="text-danger small mt-1">
                                            <i class="fa-solid fa-circle-exclamation me-1"></i>
                                            ${medicineImportQuantityErrorMsg}
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <div class="d-flex justify-content-center mt-4">
                                <button type="submit"
                                        class="btn btn-success px-5 py-2 fw-bold"
                                        style="border-radius: 30px;">
                                    Import
                                </button>
                            </div>

                        </form>
                    </div>
                </div>
            </c:if>
        </div>
    </body>
</html>

