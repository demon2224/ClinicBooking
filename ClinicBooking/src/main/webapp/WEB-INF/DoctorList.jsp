<%-- Document : DoctorList Created on : Oct 7, 2025, 9:48:47 AM Author : KhangNMCE190728 --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DOCCURE - Medical Clinic</title>

        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assests/css/main.css" rel="stylesheet" type="text/css" />

        <style>
            body {
                margin: 0;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                padding-top: 80px;
                /* Space for fixed header */
                background-color: #f8f9fa;
            }

            .main-content {
                padding: 2rem;
                text-align: center;
            }

            /* Doctor List Title */
            h1 {
                color: #2c3e50;
                font-weight: 600;
                margin: 2rem 0;
                text-align: center;
                font-size: 2rem;
            }

            /* Doctor Grid Container */
            .doctor-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 1rem;
            }

            .doctor-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 2rem;
                margin-top: 2rem;
            }

            /* Doctor Card */
            .doctor-card {
                background-color: white;
                border: 2px solid #e0e0e0;
                border-radius: 15px;
                padding: 2rem 1.5rem;
                text-align: center;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            }

            .doctor-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
                border-color: #007bff;
            }

            /* Doctor Name */
            .doctor-name {
                font-size: 1.1rem;
                font-weight: 600;
                color: #2c3e50;
                margin: 0 0 0.5rem 0;
            }

            /* Doctor Specialty */
            .doctor-specialty {
                font-size: 0.9rem;
                color: #495057;
                margin-bottom: 1.5rem;
                background-color: #e7f3ff;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                display: inline-block;
                font-weight: 500;
            }

            /* Button Group */
            .doctor-actions {
                display: flex;
                gap: 0.5rem;
                justify-content: center;
            }

            /* Button Styling */
            .btn-view,
            .btn-book {
                flex: 1;
                padding: 0.6rem 1rem;
                border: 2px solid #e0e0e0;
                background-color: white;
                color: #6c757d;
                text-decoration: none;
                border-radius: 8px;
                font-size: 0.85rem;
                font-weight: 500;
                transition: all 0.3s ease;
                cursor: pointer;
                display: inline-block;
            }

            .btn-view:hover {
                background-color: #f8f9fa;
                border-color: #6c757d;
                color: #2c3e50;
            }

            .btn-book:hover {
                background-color: #007bff;
                border-color: #007bff;
                color: white;
            }

            /* Footer Styling */
            footer {
                background-color: white;
                padding: 2rem;
                text-align: center;
                margin-top: 3rem;
                border-top: 1px solid #e9ecef;
                box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
            }

            footer p {
                margin: 0;
                color: #6c757d;
                font-size: 0.9rem;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .doctor-grid {
                    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                    gap: 1.5rem;
                }

                h1 {
                    font-size: 1.5rem;
                }

                .doctor-card {
                    padding: 1.5rem 1rem;
                }
            }

            @media (max-width: 480px) {
                .doctor-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>

    <body>
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
                            <a href="${pageContext.request.contextPath}/home">Home</a>
                        </li>
                        <li>
                            <a href="#">About</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/doctor-list" class="active">Doctors</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle">Portal</a>
                            <ul class="dropdown-menu">
                                <li><a href="${pageContext.request.contextPath}/manage-my-appointments">Manage My
                                        Appointments</a></li>
                                <li><a href="#">Manage My Medical Records</a></li>
                                <li><a href="#">Manage My Prescriptions</a></li>
                                <li><a href="#">Manage My Invoices</a></li>
                                <li><a href="#">My Feedbacks</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">Contact</a>
                        </li>
                    </ul>
                </nav>

                <!-- User Actions -->
                <div class="user-actions">
                    <!-- Register Button -->
                    <a href="#" class="btn btn-register">
                        <i class="fas fa-user-plus"></i>
                        Register
                    </a>

                    <!-- Login Button -->
                    <a href="#" class="btn btn-login">
                        <i class="fas fa-sign-in-alt"></i>
                        Login
                    </a>
                </div>
            </div>
        </header>

        <h1>Doctor List</h1>

        <!-- Doctor Grid -->
        <div class="doctor-container">
            <div class="doctor-grid">
                <!-- Doctor Card 1 -->
                <div class="doctor-card">
                    <h3 class="doctor-name">Dr. John Smith</h3>
                    <p class="doctor-specialty">Cardiology • 10 years exp</p>
                    <div class="doctor-actions">
                        <a href="#" class="btn-view">Detail</a>
                        <a href="#" class="btn-book">Book</a>
                    </div>
                </div>

                <!-- Doctor Card 2 -->
                <div class="doctor-card">
                    <h3 class="doctor-name">Dr. Anna Tran</h3>
                    <p class="doctor-specialty">Dermatology • 8 years exp</p>
                    <div class="doctor-actions">
                        <a href="#" class="btn-view">Detail</a>
                        <a href="#" class="btn-book">Book</a>
                    </div>
                </div>

                <!-- Doctor Card 3 -->
                <div class="doctor-card">
                    <h3 class="doctor-name">Dr. Kien Nguyen</h3>
                    <p class="doctor-specialty">Dentistry • 12 years exp</p>
                    <div class="doctor-actions">
                        <a href="#" class="btn-view">Detail</a>
                        <a href="#" class="btn-book">Book</a>
                    </div>
                </div>

                <!-- Doctor Card 4 -->
                <div class="doctor-card">
                    <h3 class="doctor-name">Dr. Hieu Pham</h3>
                    <p class="doctor-specialty">Pediatrics • 6 years exp</p>
                    <div class="doctor-actions">
                        <a href="#" class="btn-view">Detail</a>
                        <a href="#" class="btn-book">Book</a>
                    </div>
                </div>

                <!-- Doctor Card 5 -->
                <div class="doctor-card">
                    <h3 class="doctor-name">Dr. Thao Vu</h3>
                    <p class="doctor-specialty">Ophthalmology • 7 years exp</p>
                    <div class="doctor-actions">
                        <a href="#" class="btn-view">Detail</a>
                        <a href="#" class="btn-book">Book</a>
                    </div>
                </div>

                <!-- Doctor Card 6 -->
                <div class="doctor-card">
                    <h3 class="doctor-name">Dr. Minh Pham</h3>
                    <p class="doctor-specialty">Neurology • 9 years exp</p>
                    <div class="doctor-actions">
                        <a href="#" class="btn-view">Detail</a>
                        <a href="#" class="btn-book">Book</a>
                    </div>
                </div>
            </div>
        </div>
