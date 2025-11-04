<%-- 
    Document   : DoctorDashboardSidebar
    Created on : 4 Nov. 2025, 9:05:07 am
    Author     : Le Thien Tri - CE191249
--%>

        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mt-3 mb-4">CLINIC</h4>
            <a href="${pageContext.request.contextPath}/doctor-dashboard"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/manage-my-patient-appointment"><i class="fa-solid fa-calendar-days me-2"></i>Manage Appointment</a>
            <a href="${pageContext.request.contextPath}/manage-my-patient-medical-record"><i class="fa-solid fa-user-doctor me-2"></i>Manage Medical Record</a>
            <a href="#"><i class="fa-solid fa-user me-2"></i>Manage Prescription</a>
        </div>
