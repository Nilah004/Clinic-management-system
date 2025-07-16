<!-- WebContent/register.jsp -->
<html>
<head><title>Register</title></head>
<body>
    <h2>Patient Registration</h2>
    <form action="<%= request.getContextPath() %>/register" method="post">

        Name: <input type="text" name="name" required><br>
        Email: <input type="email" name="email" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Register">
    </form>
    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</body>
</html>
