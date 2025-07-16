<!-- WebContent/login.jsp -->
<html>
<head><title>Login</title></head>
<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
%>
    <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px; border: 1px solid #c3e6cb;">
        <%= msg %>
    </div>
<%
        session.removeAttribute("msg");
    }
%>

<body>
    <h2>Login</h2>
    <form action="<%= request.getContextPath() %>/login" method="post">

        Email: <input type="email" name="email" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
    <p>New patient? <a href="register.jsp">Register here</a></p>
    
    <p>
    Are you a doctor? 
    <a href="doctorSetPassword.jsp">Set your password here</a>
</p>
    
    
    <% if ("true".equals(request.getParameter("logout"))) { %>
    <div style="color: green;">You have been logged out successfully.</div>
<% } %>
    
</body>
</html>
