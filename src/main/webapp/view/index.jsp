<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediTrackPro – Clinic Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="view/index.css">
    <!-- Font Awesome for section icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Header -->
    <header>
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-clinic-medical"></i>
                <div>
                    <h1>MediTrackPro</h1>
                    <span>Smart Clinic Management</span>
                </div>
            </div>
            <nav>
                <a href="#home">Home</a>
                <a href="#patient-services">Patient Services</a>
                <a href="#about">About Us</a>
                <a href="#contact">Contact</a>
            </nav>
            <div class="auth-buttons">
                <a href="view/login.jsp" class="btn btn-outline">Login</a>
                <a href="view/register.jsp" class="btn btn-primary">Register</a>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="hero-content">
            <h1>Your Clinic, Simplified.</h1>
            <p>Efficiently manage appointments, patient records, and doctors the intuitive solution for modern healthcare.</p>
            <div class="btn-group">
                <a href="view/register.jsp" class="btn btn-primary">Get Started Free <i class="fas fa-arrow-right"></i></a>
                <a href="#patient-services" class="btn btn-secondary">Explore Patient Services</a>
            </div>
        </div>
    </section>

    <!-- Patient Services Section -->
    <section class="section services-section" id="patient-services">
        <div class="section-header">
            <h2>Your Journey with MediTrackPro</h2>
            <p>Empowering patients with easy access to healthcare services and personal information management.</p>
        </div>
        <div class="services-grid">
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-user-plus"></i></div>
                <h3>Easy Patient Registration</h3>
                <p>Quickly create your secure patient account to get started with MediTrackPro's services.</p>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-calendar-plus"></i></div>
                <h3>Seamless Appointment Booking</h3>
                <p>Browse departments and doctors, view real-time availability, and book your preferred time slot with ease.</p>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-clipboard-list"></i></div>
                <h3>Appointment Tracking</h3>
                <p>View all your booked appointments, check real-time status updates, and access your appointment history.</p>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-user-cog"></i></div>
                <h3>Personal Profile Management</h3>
                <p>Securely view and update your personal details, contact information, age, and gender at any time.</p>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="section services-section" id="services">
        <div class="section-header">
            <h2>Seamless Appointment Booking</h2>
            <p>Patients can easily book appointments for various departments and doctors, ensuring a smooth experience from start to finish.</p>
        </div>
        <div class="services-grid">
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-hospital"></i></div>
                <h3>Book by Department</h3>
                <p>Patients can select their desired department (e.g., Cardiology, Dermatology, Pediatrics) and view available slots.</p>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-user-md"></i></div>
                <h3>Choose Your Doctor</h3>
                <p>Browse doctor profiles, check their availability, and book appointments directly with your preferred specialist.</p>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-calendar-alt"></i></div>
                <h3>Flexible Scheduling</h3>
                <p>View real-time availability, reschedule, or cancel appointments with ease through a user-friendly interface.</p>
            </div>
        </div>
    </section>

    
    
    <!-- About Section -->
    <section class="section about-section" id="about">
        <div class="section-header">
            <h2>About MediTrackPro</h2>
            <p>Innovating healthcare management for a healthier tomorrow.</p>
        </div>
        <div class="about-content">
            <div class="about-image">
                <img src="https://tse1.mm.bing.net/th/id/OIP.9VOCWS3EDw1gFgm4GYx_0gHaF7?rs=1&pid=ImgDetMain&o=7&rm=3" alt="Modern Clinic Interior">
            </div>
            <div class="about-text">
                <h3>Our Mission</h3>
                <p>MediTrackPro is dedicated to empowering healthcare providers with intuitive, secure, and efficient clinic management solutions. We believe that by simplifying administrative tasks, clinics can focus more on delivering exceptional patient care.</p>
                <h3>Why Choose Us?</h3>
                <ul>
                    <li><i class="fas fa-check-circle"></i> User-friendly interface designed for all staff levels.</li>
                    <li><i class="fas fa-check-circle"></i> Scalable solutions for clinics of all sizes.</li>
                    <li><i class="fas fa-check-circle"></i> Robust security measures to protect sensitive patient data.</li>
                    <li><i class="fas fa-check-circle"></i> Continuous updates and new features based on user feedback.</li>
                </ul>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="section contact-section" id="contact">
        <div class="section-header">
            <h2>Connect With Us</h2>
            <p>Have questions or ready to get started? Reach out to our team.</p>
        </div>
        <div class="contact-grid">
            <div class="contact-info-card">
                <i class="fas fa-map-marker-alt"></i>
                <h3>Address</h3>
                <p>123 Health Street, MedCity, Nepal</p>
            </div>
            <div class="contact-info-card">
                <i class="fas fa-phone"></i>
                <h3>Phone</h3>
                <p>+977-123-456789</p>
            </div>
            <div class="contact-info-card">
                <i class="fas fa-envelope"></i>
                <h3>Email</h3>
                <p>contact@meditrackpro.com</p>
            </div>
        </div>
        <div class="contact-form-container">
            <h3>Send Us a Message</h3>
            <form action="#" method="POST" class="contact-form">
                <div class="form-group">
                    <input type="text" id="name" name="name" placeholder="Your Name" required>
                </div>
                <div class="form-group">
                    <input type="email" id="email" name="email" placeholder="Your Email" required>
                </div>
                <div class="form-group">
                    <textarea id="message" name="message" rows="5" placeholder="Your Message" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Send Message <i class="fas fa-paper-plane"></i></button>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <p>&copy; 2025 MediTrackPro | All Rights Reserved</p>
            <div class="social-links">
                <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
    </footer>
</body>
</html>
