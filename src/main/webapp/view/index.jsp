<!DOCTYPE html>
<html>
<head>
    <title>MediTrackPro – Clinic Management System</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f2f5;
        }

        header {
            background-color: #007BFF;
            color: white;
            padding: 20px 0;
            text-align: center;
        }

        nav {
            background-color: #0056b3;
            text-align: center;
            padding: 10px 0;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 20px;
            font-weight: bold;
        }

        nav a:hover {
            text-decoration: underline;
        }

        .hero {
            background: url('clinic-bg.jpg') no-repeat center center/cover;
            height: 400px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-shadow: 1px 1px 4px #000;
        }

        .hero h1 {
            font-size: 48px;
        }

        .hero p {
            font-size: 20px;
        }

        .btn-group {
            margin-top: 20px;
        }

        .btn {
            padding: 12px 30px;
            margin: 10px;
            font-size: 16px;
            color: white;
            background-color: #007BFF;
            text-decoration: none;
            border-radius: 6px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .section {
            padding: 50px;
            text-align: center;
            background-color: white;
        }

        footer {
            text-align: center;
            padding: 20px;
            background-color: #007BFF;
            color: white;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>MediTrackPro</h1>
        <p>Smart Clinic Management System</p>
    </header>

    <!-- Navigation -->
    <nav>
        <a href="#home">Home</a>
        <a href="#about">About Us</a>
        <a href="#contact">Contact</a>
    </nav>

    <!-- Hero Section -->
    <div class="hero" id="home">
        <h1>Welcome to MediTrackPro</h1>
        <p>Manage your clinic appointments, patients, and staff efficiently</p>
        <div class="btn-group">
            <a href="view/login.jsp" class="btn">Login</a>
<a href="view/register.jsp" class="btn">Register</a>

        </div>
    </div>

    <!-- About Section -->
    <div class="section" id="about">
        <h2>About Us</h2>
        <p>
            MediTrackPro is an all-in-one web-based Clinic Management System designed for small to mid-sized clinics.
            Our platform helps administrators manage patient records, doctors’ schedules, appointments, and medical reports
            in one secure and user-friendly environment.
        </p>
    </div>

    <!-- Contact Section -->
    <div class="section" id="contact" style="background-color: #f9f9f9;">
        <h2>Contact Us</h2>
        <p>📍 Address: 123 Health Street, MedCity, Nepal</p>
        <p>📞 Phone: +977-123-456789</p>
        <p>📧 Email: contact@meditrackpro.com</p>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2025 MediTrackPro | All Rights Reserved
    </footer>

</body>
</html>
