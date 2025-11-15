<%-- Footer component for all pages --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<footer class="main-footer" id="footer-contact">
    <div class="footer-container">
        <!-- Contact Info Section -->
        <div class="footer-section">
            <h4>Contact Information</h4>
            <div class="footer-contact">
                <div class="contact-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <div>
                        <strong>Address</strong>
                        <p>600 Nguyen Van Cu<br>An Binh, Binh Thuy, Can Tho City<br>Vietnam</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-phone"></i>
                    <div>
                        <strong>Phone</strong>
                        <p>0815255855</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-envelope"></i>
                    <div>
                        <strong>Email</strong>
                        <p>tuanlace180905@fpt.edu.vn</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-clock"></i>
                    <div>
                        <strong>Working Hours</strong>
                        <p>Mon - Sun: 7:00 AM - 5:00 PM</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Quick Links Section -->
        <div class="footer-section">
            <h4>Quick Links</h4>
            <ul class="footer-links">
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Home</a></li>
                    <li><a href="#about-section" onclick="scrollToAbout(event)"><i class="fas fa-info-circle"></i> About</a></li>
                    <li><a href="#footer-contact" onclick="scrollToContact(event)"><i class="fas fa-phone"></i> Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/doctor"><i class="fas fa-user-md"></i> Doctor</a></li>
                </ul>
            </ul>
        </div>
        <!-- Services Section -->
        <div class="footer-section">
            <h4>Our Services</h4>
            <ul class="footer-links">
                <li><a href="#"><i class="fas fa-stethoscope"></i> General Consultation</a></li>
                <li><a href="#"><i class="fas fa-heartbeat"></i> Cardiology</a></li>
                <li><a href="#"><i class="fas fa-brain"></i> Neurology</a></li>
                <li><a href="#"><i class="fas fa-bone"></i> Orthopedics</a></li>
                <li><a href="#"><i class="fas fa-eye"></i> Ophthalmology</a></li>
                <li><a href="#"><i class="fas fa-ambulance"></i> Emergency Care</a></li>
            </ul>
        </div>


        <div class="facility-map" style="margin-top:24px; border-radius:16px; overflow:hidden; box-shadow:0 4px 16px rgba(25,118,210,0.12);">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4962.476241704804!2d105.72985667596828!3d10.01245179009358!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0882139720a77%3A0x3916a227d0b95a64!2sFPT%20University!5e1!3m2!1svi!2sin!4v1763171848126!5m2!1svi!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </div>

    <!-- Footer Bottom -->
    <div class="footer-bottom">
        <div class="footer-container">
            <div class="footer-bottom-content">
                <div class="footer-copyright">
                    <p>&copy;2025 Clinic.</p>
                </div>
            </div>
        </div>
    </div>
</footer>
