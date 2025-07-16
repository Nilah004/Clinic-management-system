<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*, java.sql.*, dao.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Set Password</title>
    <style>
    
        body {
            font-family: Arial, sans-serif;
            background: #f0f0f0;
            padding: 40px;
        }
        .container {
            background: white;
            max-width: 400px;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
        h2 {
            color: #007bff;
            text-align: center;
        }
        label, input {
            display: block;
            width: 100%;
            margin-bottom: 15px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
        }
        .msg {
            color: green;
            text-align: center;
        }
        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
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

<div class="container">
    <h2>Set Password</h2>
   <form action="<%= request.getContextPath() %>/setDoctorPassword" method="post">
    <label>Email:</label>
    <input type="email" name="email" required />
    <label>New Password:</label>
    <input type="password" name="password" required />
    <button type="submit">Set Password</button>
</form>


  
</div>

</body>
</html>
