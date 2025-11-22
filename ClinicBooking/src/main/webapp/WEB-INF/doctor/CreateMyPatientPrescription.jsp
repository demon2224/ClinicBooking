<%--
    Document   : CreateMyPatientPrescription
    Created on : Nov 6, 2025
    Author     : Le Thien Tri - CE191249
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Prescription</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assests/img/logo.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

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
                <h2><i class="fa-solid fa-prescription me-2"></i>Create Prescription</h2>
            </div>

            <form action="${pageContext.request.contextPath}/manage-my-patient-prescription?action=create&medicalRecord=${medicalRecordID}"
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
                                <tr class="medicine-row">
                                    <td>
                                        <select name="medicineID" class="form-select medicine-select-field" required> 
                                            <option value="">-- Select Medicine --</option>
                                            <c:forEach var="m" items="${medicineList}">
                                                <option value="${m.medicineID}" class="align-items-start">
                                                    ${m.medicineCode} | ${m.medicineName} — ${m.medicineType} | Stock: ${m.quantity} |  <fmt:formatNumber value="${m.price}"/> ₫
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td><input type="number" name="dosage" class="form-control" min="1" required></td>

                                    <td>

                                        <!-- CUSTOM MODE (default) -->
                                        <div class="instruction-custom-wrapper d-flex align-items-center gap-2">

                                            <input type="text"
                                                   name="instruction"
                                                   class="form-control instruction-input"
                                                   placeholder="Enter instruction...">

                                            <button type="button" class="btn btn-outline-primary btn-sm switch-to-select">
                                                <i class="fa-solid fa-check"></i>
                                            </button>

                                        </div>

                                        <!-- SELECT MODE (hidden) -->
                                        <div class="instruction-select-wrapper d-none d-flex align-items-center gap-2">

                                            <select class="form-select instruction-select">
                                                <option value="">-- Select Instruction --</option>
                                                <c:forEach var="i" items="${instructionList}">
                                                    <option value="${i}">${i}</option>
                                                </c:forEach>
                                            </select>

                                            <button type="button" class="btn btn-outline-secondary btn-sm switch-to-custom">
                                                <i class="fa-solid fa-pen"></i>
                                            </button>

                                        </div>


                                    </td>


                                    <td>
                                        <button type="button" class="btn btn-danger btn-sm remove-row">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
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
                                      placeholder="Enter prescription note..." required></textarea>
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
                        ${errorNull}
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
                $('.medicine-select-field').select2({
                    placeholder: "-- Select Medicine --",
                    allowClear: true
                });
            });



            // DISABLE MEDICINE OPTIONS LIKE EDIT MODE
            function updateMedicineOptions() {
                let selectedValues = $('select[name="medicineID"]').map(function () {
                    return $(this).val();
                }).get();

                $('select[name="medicineID"]').each(function () {
                    let currentSelect = $(this);

                    currentSelect.find('option').each(function () {
                        let val = $(this).val();
                        if (val === "")
                            return; // skip default

                        if (currentSelect.val() === val) {
                            $(this).prop('disabled', false);
                        } else {
                            $(this).prop('disabled', selectedValues.includes(val));
                        }
                    });
                });
            }

            // SWITCH Custom → Select
            $(document).on("click", ".switch-to-select", function () {
                let td = $(this).closest("td");

                let input = td.find(".instruction-input");
                let inputValue = input.val();
                let select = td.find(".instruction-select");

                input.removeAttr("name");
                select.attr("name", "instruction");

                if (inputValue.trim() !== "") {
                    select.val("custom");
                } else {
                    select.val("");
                }

                td.find(".instruction-custom-wrapper").addClass("d-none");
                td.find(".instruction-select-wrapper").removeClass("d-none");
            });

            // SWITCH Select → Custom
            $(document).on("click", ".switch-to-custom", function () {
                let td = $(this).closest("td");

                let select = td.find(".instruction-select");
                let selectedValue = select.val();
                let input = td.find(".instruction-input");

                select.removeAttr("name");
                input.attr("name", "instruction");

                if (selectedValue === "custom") {
                    input.val("");
                } else {
                    input.val(selectedValue);
                }

                td.find(".instruction-select-wrapper").addClass("d-none");
                td.find(".instruction-custom-wrapper").removeClass("d-none");
            });


            $(document).ready(function () {

                $('#addRow').click(function () {
                    let originalRow = $('.medicine-row:first');

                    let newRow = originalRow.clone();

                    newRow.find('.select2-container').remove();

                    let newSelect = newRow.find('select[name="medicineID"]');
                    newSelect.removeClass('select2-hidden-accessible').val('');

                    newRow.find('input').val('');
                    newRow.find('.instruction-select-wrapper').addClass('d-none');
                    newRow.find('.instruction-custom-wrapper').removeClass('d-none');
                    newRow.find('.instruction-select').removeAttr('name');
                    newRow.find('.instruction-input').attr('name', 'instruction').val('');


                    $('#medicineTable tbody').append(newRow);

                    newSelect.select2({
                        placeholder: "-- Select Medicine --",
                        allowClear: true
                    });

                    updateMedicineOptions();
                });

                // XÓA ROW
                $(document).on('click', '.remove-row', function () {
                    if ($('#medicineTable tbody tr').length > 1) {
                        $(this).closest('tr').remove();
                        updateMedicineOptions(); // cập nhật lại
                    }
                });

                // Khi đổi thuốc → cập nhật lại disable
                $(document).on("change", 'select[name="medicineID"]', function () {
                    updateMedicineOptions();
                });
            });
        </script>

    </body>
</html>
