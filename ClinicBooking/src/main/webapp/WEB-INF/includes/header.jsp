<%--
    Header Component
    Created on : Oct 11, 2025
    Author     : Le Anh Tuan - CE180905
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Header -->
<header class="header">
    <div class="container">

        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <i class="fas fa-stethoscope"></i>
            CLINIC
        </a>

        <!-- Navigation Menu -->
        <nav>
            <ul class="nav-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/home"
                       class="${param.activePage == 'home' ? 'active' : ''}">Home</a>
                </li>
                <li>
                    <a href="#about-section" onclick="scrollToAbout(event)"
                       class="${param.activePage == 'about' ? 'active' : ''}">About</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/doctor"
                       class="${param.activePage == 'doctors' ? 'active' : ''}">Doctors</a>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle ${param.activePage == 'manage-appointments' ? 'active' : ''}">Portal</a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/manage-my-appointments"
                               class="${param.activePage == 'manage-appointments' ? 'active' : ''}">Manage My Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/manage-my-medical-records"
                               class="${param.activePage == 'manage-medical-records' ? 'active' : ''}">Manage My Medical Records</a></li>
                        <li><a href="${pageContext.request.contextPath}/manage-my-prescriptions"
                               class="${param.activePage == 'manage-prescriptions' ? 'active' : ''}">Manage My Prescriptions</a></li>
                        <li><a href="${pageContext.request.contextPath}/manage-my-invoices"
                               class="${param.activePage == 'manage-invoices' ? 'active' : ''}">Manage My Invoices</a></li>
                        <li><a href="${pageContext.request.contextPath}/manage-my-feedback"
                               class="${param.activePage == 'manage-feedback' ? 'active' : ''}">My Feedbacks</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#footer-contact" onclick="scrollToContact(event)"
                       class="${param.activePage == 'contact' ? 'active' : ''}">Contact</a>
                </li>
            </ul>
        </nav>

        <!-- User Actions Buttons -->
        <c:if test="${empty sessionScope.patient}">
            <div class="user-actions">

                <!-- Login Button -->
                <a href="${pageContext.request.contextPath}/patient-login" class="btn btn-login">
                    <i class="fas fa-sign-in-alt"></i>
                    Login
                </a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-register">
                    <i class="fas fa-user-plus"></i>
                    Register
                </a>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.patient}">
            <div class="user-actions">

                <!-- Profile User -->
                <a href="${pageContext.request.contextPath}/profile" class="icon-user-profile">
                    <div class="profile-avatar-small">
                        <c:choose>
                            <c:when test="${sessionScope.patient.avatar != null && !empty sessionScope.patient.avatar}">
                                <img src="${pageContext.request.contextPath}/${sessionScope.patient.avatar}"
                                     alt="Profile"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assests/img/0.png'">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assests/img/0.png"
                                     alt="Profile"
                                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'">
                                <div class="avatar-placeholder profile-avatar-small" style="display: none;">
                                    <i class="fas fa-user"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </a>

                <!-- Logout Button -->
                <a href="${pageContext.request.contextPath}/patient-logout" class="btn btn-logout">
                    <i class="fas fa-sign-in-alt"></i>
                    Logout
                </a>
            </div>
        </c:if>
    </div>
</header>

<!-- Contact Scroll JavaScript -->
<script>
    function scrollToContact(event) {
        event.preventDefault();

        // Check if footer exists on current page
        const footer = document.getElementById('footer-contact');

        if (footer) {
            // Smooth scroll to footer
            footer.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });

            // Add highlight effect
            footer.style.transition = 'all 0.3s ease';
            footer.style.backgroundColor = 'rgba(25, 118, 210, 0.1)';

            setTimeout(() => {
                footer.style.backgroundColor = '';
            }, 2000);
        } else {
            // If no footer on current page, redirect to home and then scroll
            const currentPath = window.location.pathname;
            const contextPath = '${pageContext.request.contextPath}';

            if (currentPath.includes('/home') || currentPath.endsWith('/') || currentPath.endsWith(contextPath)) {
                // Already on home page, scroll to bottom
                window.scrollTo({
                    top: document.body.scrollHeight,
                    behavior: 'smooth'
                });
            } else {
                // Redirect to home page with scroll parameter
                window.location.href = contextPath + '/home#footer-contact';
            }
        }
    }

// Scroll to About section function
    function scrollToAbout(event) {
        event.preventDefault();

        // Check if about section exists on current page
        const aboutSection = document.getElementById('about-section');

        if (aboutSection) {
            // Smooth scroll to about section
            aboutSection.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });

            // Add highlight effect
            aboutSection.style.transition = 'all 0.3s ease';
            aboutSection.style.backgroundColor = 'rgba(25, 118, 210, 0.05)';

            setTimeout(() => {
                aboutSection.style.backgroundColor = '';
            }, 2000);
        } else {
            // If no about section on current page, redirect to home and then scroll
            const currentPath = window.location.pathname;
            const contextPath = '${pageContext.request.contextPath}';

            if (currentPath.includes('/home') || currentPath.endsWith('/') || currentPath.endsWith(contextPath)) {
                // Already on home page, scroll to top
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            } else {
                // Redirect to home page with scroll parameter
                window.location.href = contextPath + '/home#about-section';
            }
        }
    }
    }

// Handle scroll to contact on page load if hash is present
    window.addEventListener('load', function () {
        if (window.location.hash === '#footer-contact') {
            setTimeout(() => {
                const footer = document.getElementById('footer-contact');
                if (footer) {
                    footer.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            }, 500);
        } else if (window.location.hash === '#about-section') {
            setTimeout(() => {
                const aboutSection = document.getElementById('about-section');
                if (aboutSection) {
                    aboutSection.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            }, 500);
        }
    });
</script>