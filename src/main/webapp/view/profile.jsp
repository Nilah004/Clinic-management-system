<%@ page session="true" import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"patient".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; padding: 20px; }
        .container { background: #fff; padding: 20px; max-width: 500px; margin: auto; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { color: #007BFF; }
        label { font-weight: bold; margin-top: 10px; display: block; }
        input { width: 100%; padding: 10px; margin: 5px 0 15px; border: 1px solid #ccc; border-radius: 5px; }
        button { background-color: #007BFF; color: white; padding: 10px 20px; border: none; border-radius: 5px; }
        .msg { background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px; }
    </style>
</head>
<body>

<div class="container">
    <h2>My Profile</h2>

    <% String msg = (String) session.getAttribute("msg"); if (msg != null) { %>
        <div class="msg"><%= msg %></div>
        <% session.removeAttribute("msg"); } %>

    <form action="<%= request.getContextPath() %>/updateProfile" method="post">
        <label>Name</label>
        <input type="text" name="name" value="<%= user.getName() %>" required>

        <label>Email</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" required>

        <input type="hidden" name="id" value="<%= user.getId() %>">
        <button type="submit">Update Profile</button>
    </form>
</div>

</body>
</html>
