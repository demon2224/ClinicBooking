<%--
    Document   : EditMedicine
    Created on : Oct 20, 2025, 9:52:48 AM
    Author     : Vu Minh Khang - CE191371
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit Medicine</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <!-- Bootstrap & FontAwesome -->
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
            .required::after {
                content: " *";
                color: red;
            }
        </style>
    </head>

    <body>

        <%@include file="../includes/PharmacistDashboardSidebar.jsp" %>

        <div class="main-content">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-primary">
                    <i class="fa-solid fa-pen-to-square me-2"></i>Edit Medicine
                </h2>
            </div>

            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-file-pen me-2"></i>Medicine Information
                </div>

                <div class="card-body p-4">

                    <form action="${pageContext.request.contextPath}/manage-medicine" method="POST">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="medicineID" value="${medicine.medicineID}">

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label required">Medicine Name</label>
                                <input type="text" class="form-control"
                                       name="medicineName"
                                       value="${medicine.medicineName}" required>

                                <c:if test="${not empty medicineNameErrorMsg}">
                                    <div class="text-danger small mt-1">
                                        <i class="fa-solid fa-circle-exclamation me-1"></i>
                                        ${medicineNameErrorMsg}
                                    </div>
                                </c:if>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label required">Medicine Code</label>
                                <input type="text" class="form-control"
                                       name="medicineCode"
                                       value="${medicine.medicineCode}" required>

                                <c:if test="${not empty medicineCodeErrorMsg}">
                                    <div class="text-danger small mt-1">
                                        <i class="fa-solid fa-circle-exclamation me-1"></i>
                                        ${medicineCodeErrorMsg}
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label required">Medicine Type</label>
                                <select class="form-select" name="medicineType" required>
                                    <c:forEach var="type" items="${medicineTypeList}">
                                        <option value="${type}"
                                                <c:if test="${medicine.medicineType eq type}">selected</c:if>>
                                            ${type}
                                        </option>
                                    </c:forEach>
                                </select>

                                <c:if test="${not empty medicineTypeErrorMsg}">
                                    <div class="text-danger small mt-1">
                                        <i class="fa-solid fa-circle-exclamation me-1"></i>
                                        ${medicineTypeErrorMsg}
                                    </div>
                                </c:if>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label required">Price (đ)</label>
                                <c:set var="vnd" value="${medicine.price}" />
                                <fmt:formatNumber value='${vnd}' type='number' groupingUsed='false' maxFractionDigits="0" var="vndFormatted"/>
                                <input type="number" step="0.01" min="0"
                                       class="form-control"
                                       name="price"
                                       value="${vndFormatted}"
                                       required>

                                <c:if test="${not empty medicinePriceErrorMsg}">
                                    <div class="text-danger small mt-1">
                                        <i class="fa-solid fa-circle-exclamation me-1"></i>
                                        ${medicinePriceErrorMsg}
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label required">Status</label>
                                <select class="form-select" name="medicineStatus" required>
                                    <option value="1" <c:if test="${medicine.medicineStatus}">selected</c:if>>Available</option>
                                    <option value="0" <c:if test="${!medicine.medicineStatus}">selected</c:if>>Unavailable</option>
                                    </select>

                                <c:if test="${not empty medicineStatusErrorsMsg}">
                                    <div class="text-danger small mt-1">
                                        <i class="fa-solid fa-circle-exclamation me-1"></i>
                                        ${medicineStatusErrorsMsg}
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="d-flex justify-content-center mt-4">
                            <button class="btn btn-success px-5 py-2 fw-bold"
                                    style="border-radius: 30px;">
                                Update
                            </button>
                        </div>
                    </form>
                </div>
            </div>

        </div>

        <div class="modal fade" id="successModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Success</h5>
                    </div>
                    <div class="modal-body">
                        ${sessionScope.medicineEditSuccessMsg}
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${not empty sessionScope.medicineEditSuccessMsg}">
            <script>
                window.onload = function () {
                    var myModal = new bootstrap.Modal(document.getElementById('successModal'));
                    myModal.show();
                }
            </script>
            <c:remove var="medicineEditSuccessMsg" scope="session"/>
        </c:if>

    </body>
</html>

