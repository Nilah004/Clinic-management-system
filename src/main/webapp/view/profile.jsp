<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    User user = (User) session.getAttribute("user");

    String gender = user.getGender() != null ? user.getGender() : "";
    String contact = user.getContact() != null ? user.getContact() : "";
    int age = user.getAge();
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <style>
        body { font-family: Arial; padding: 30px; background-color: #f4f4f4; }
        .container { max-width: 600px; margin: auto; background: #fff; padding: 20px; border-radius: 5px; }
        label { display: block; margin-top: 15px; }
        input, select { width: 100%; padding: 8px; margin-top: 5px; }
        button { margin-top: 20px; padding: 10px 15px; background: #28a745; color: white; border: none; }
        .msg { color: green; margin-top: 10px; }
        .error { color: red; }
    </style>
</head>
<body>
<div class="container">
    <h2>My Profile</h2>

    <% if (session.getAttribute("msg") != null) { %>
        <p class="msg"><%= session.getAttribute("msg") %></p>
        <% session.removeAttribute("msg"); %>
    <% } %>

    <form action="../updateProfile" method="post">
        <label>Name</label>
        <input type="text" name="name" value="<%= user.getName() %>" required>

        <label>Email</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" readonly>

        <label>Contact</label>
        <input type="text" name="contact" value="<%= contact %>" required>

        <label>Age</label>
        <input type="number" name="age" value="<%= age %>" required>
        <input type="hidden" name="id" value="<%= user.getId() %>">
        

        <label>Gender</label>
        <select name="gender" required>
            <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
            <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
            <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
        </select>

        <button type="submit">Update Profile</button>
    </form>
</div>
</body>
</html>
