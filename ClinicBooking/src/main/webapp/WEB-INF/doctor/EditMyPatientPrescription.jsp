<%-- 
    Document   : EditMyPatientPrescription
    Created on : 12 Nov. 2025, 8:26:11 am
    Author     : Le Thien Tri - CE191249
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Prescription</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style>
            body {
                background-color: #f8f9fa;
            }
            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #1B5A90;
                color: white;
                position: fixed;
            }
            .sidebar a {
                display: block;
                color: white;
                text-decoration: none;
                padding: 12px 20px;
            }
            .sidebar a:hover {
                background-color: #00D0F1;
            }
            .main-content {
                margin-left: 260px;
                padding: 25px;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0px 3px 6px rgba(0,0,0,0.1);
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
            label {
                font-weight: 500;
            }
        </style>
    </head>

    <body>
        <%@include file="../includes/DoctorDashboardSidebar.jsp" %>

        <!-- Main Content -->
        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fa-solid fa-prescription me-2"></i>Edit Prescription</h2>
            </div>

            <form action="${pageContext.request.contextPath}/manage-my-patient-prescription?action=edit&prescriptionID=${prescription.prescriptionID}" 
                  method="post" class="needs-validation" novalidate>

                <input type="hidden" name="medicalRecordID" value="${medicalRecordID}" />

                <!-- Medicine Items -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-prescription-bottle-medical me-2"></i>Medicine Items
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered align-middle text-center" id="medicineTable">
                            <thead class="table-light">
                                <tr>
                                    <th width="35%">Medicine</th>
                                    <th width="15%">Dosage</th>
                                    <th width="35%">Instruction</th>
                                    <th width="15%">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${itemList}">
                                    <tr class="medicine-row">
                                        <td>
                                            <select name="medicineID" class="form-select" required>
                                                <option value="">-- Select Medicine --</option>
                                                <c:forEach var="m" items="${medicineList}">
                                                    <option value="${m.medicineID}" 
                                                            <c:if test="${item.medicineID.medicineID == m.medicineID}">selected</c:if>>
                                                        ${m.medicineName} — ${m.medicineType} | Stock: ${m.quantity} | $${m.price}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td><input type="number" name="dosage" class="form-control" min="1" value="${item.dosage}" required></td>
                                        <td>
                                            <select name="instruction" class="form-select" required>
                                                <option value="">-- Select instruction --</option>
                                                <c:forEach var="m" items="${medicineList}">
                                                    <option value="${item.instruction}">
                                                        ${item.instruction}
                                                    </option>
                                                </c:forEach>
                                            </select>                                         
                                        <td>
                                            <button type="button" class="btn btn-danger btn-sm remove-row">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <button type="button" id="addRow" class="btn btn-outline-secondary btn-sm">
                            <i class="fa-solid fa-plus"></i> Add Medicine
                        </button>
                    </div>
                </div>

                <!-- Prescription Note -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-clipboard-list me-2"></i>Prescription Note
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Note</label>
                            <textarea name="note" class="form-control" rows="3"
                                      placeholder="Enter prescription note..." required>${prescription.note}</textarea>
                            <div class="invalid-feedback">Please enter the note.</div>
                        </div>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-success me-2">
                        <i class="fa-solid fa-save me-2"></i>Save Prescription
                    </button>
                </div>
            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Bootstrap Error Modal -->
        <div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-circle-exclamation me-2"></i>Error</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${not empty medicineError}">
                            ${medicineError}<br>
                        </c:if>
                        <c:if test="${not empty dosageError}">
                            ${dosageError}<br>
                        </c:if>
                        <c:if test="${not empty intructionError}">
                            ${intructionError}
                        </c:if>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap another Error Modal -->
        <div class="modal fade" id="errorModalNull" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-circle-exclamation me-2"></i>Error</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${not empty medicineError}">
                            ${medicineError}<br>
                        </c:if>
                        <c:if test="${not empty dosageError}">
                            ${dosageError}<br>
                        </c:if>
                        <c:if test="${not empty intructionError}">
                            ${intructionError}
                        </c:if>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap Info Modal -->
        <div class="modal fade" id="warningModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-warning text-dark">
                        <h5 class="modal-title">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>Notice
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        A prescription must have at least one medicine.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${not empty error}">
            <script>
                window.onload = function () {
                    var myModal = new bootstrap.Modal(document.getElementById('errorModal'));
                    myModal.show();
                };
                <c:remove var="error" scope="session" />
                <c:remove var="medicineError" scope="session" />
                <c:remove var="dosageError" scope="session" />
                <c:remove var="intructionError" scope="session" />
            </script>
        </c:if>
        <c:if test="${not empty errorNull}">
            <script>
                window.onload = function () {
                    var myModal = new bootstrap.Modal(document.getElementById('errorModalNull'));
                    myModal.show();
                };
                <c:remove var="errorNull" scope="session" />
            </script>
        </c:if>

        <script>
            $(document).ready(function () {

                //  Thêm hàng mới, tránh trùng thuốc
                $('#addRow').click(function () {
                    let selectedValues = $('select[name="medicineID"]').map(function () {
                        return $(this).val();
                    }).get();

                    let newRow = $('.medicine-row:first').clone();

                    // Reset input fields
                    newRow.find('input').val('');

                    // Cập nhật select thuốc
                    let newSelect = $('.medicine-row:first select[name="medicineID"]').clone();
                    newSelect.find('option').each(function () {
                        if (selectedValues.includes($(this).val())) {
                            $(this).prop('disabled', true);
                        } else {
                            $(this).prop('disabled', false);
                        }
                    });

                    newRow.find('select').replaceWith(newSelect);
                    $('#medicineTable tbody').append(newRow);
                });

                //Xóa hàng (hoạt động với cả hàng cũ và mới)
                $(document).on('click', '.remove-row', function () {
                    if ($('#medicineTable tbody tr').length > 1) {
                        $(this).closest('tr').fadeOut(200, function () {
                            $(this).remove();
                        });
                    } else {
                        var warningModal = new bootstrap.Modal(document.getElementById('warningModal'));
                        warningModal.show();
                    }
                });
            });
        </script>

    </body>
</html>
