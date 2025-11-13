<%-- 
    Document   : PharmacistDashboardSidebar
    Created on : Oct 10, 2025, 4:12:01 PM
    Author     : Vu Minh Khang - CE191371
--%>

<style>
    .sidebar {
        width: 240px;
        height: 100vh;
        background-color: #1B5A90;
        color: white;
        position: fixed;
        top: 0;
        left: 0;
        padding-top: 20px;
    }
    .sidebar h4 {
        color: white;
        font-weight: bold;
    }
    .sidebar a {
        display: block;
        color: white;
        text-decoration: none;
        padding: 12px 20px;
        font-size: 16px;
    }
    .sidebar a:hover {
        background-color: #00D0F1;
    }
</style>

<div class="sidebar">
    <h4 class="text-center">CLINIC</h4>

    <a href="${pageContext.request.contextPath}/pharmacist-dashboard">
        <i class="fa-solid fa-gauge me-2"></i>Dashboard
    </a>

    <a href="${pageContext.request.contextPath}/manage-medicine">
        <i class="fa-solid fa-pills me-2"></i>Manage Medicine
    </a>

    <a href="${pageContext.request.contextPath}/pharmacist-manage-prescription">
        <i class="fa-solid fa-prescription me-2"></i>Manage Prescription
    </a>
</div>
