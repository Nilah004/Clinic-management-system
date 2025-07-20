<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediTrackPro Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="login.css"> <!-- Link to the new login.css -->
</head>
<body class="login-page"> <!-- Added login-page class for specific body styles -->
    <div class="login-container">
        <%
            String msg = (String) session.getAttribute("msg");
            if (msg != null) {
        %>
            <div class="message-box success">
                <%= msg %>
            </div>
        <%
                session.removeAttribute("msg");
            }
        %>

        <% if ("true".equals(request.getParameter("logout"))) { %>
            <div class="message-box info">You have been logged out successfully.</div>
        <% } %>

        <h2>Login to MediTrackPro</h2>
        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
        <p>New patient? <a href="register.jsp">Register here</a></p>
        <p>Are you a doctor? <a href="doctorSetPassword.jsp">Set your password here</a></p>
    </div>
</body>
</html>
