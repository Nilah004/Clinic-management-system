<%@ page session="true" import="java.util.*, model.User, dao.DoctorDAO, model.Doctor" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"patient".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    DoctorDAO doctorDAO = new DoctorDAO();
    List<Doctor> doctors = doctorDAO.getAllDoctors();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f7;
            padding: 20px;
        }
        .container {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            max-width: 600px;
            margin: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #007BFF;
            margin-bottom: 20px;
        }
        label {
            margin-top: 10px;
            display: block;
        }
        select, input {
            padding: 10px;
            width: 100%;
            margin-top: 5px;
            margin-bottom: 15px;
        }
        button {
            background-color: #007BFF;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            width: 100%;
        }
        button:hover {
            background-color: #0056b3;
        }
        .message {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Welcome, <%= user.getName() %> - Book Appointment</h2>

    <% 
        String msg = (String) session.getAttribute("msg");
        if (msg != null) {
    %>
        <div class="message"><%= msg %></div>
    <%
            session.removeAttribute("msg");
        }
    %>

    <form action="<%= request.getContextPath() %>/bookAppointment" method="post">

        <label>Select Doctor</label>
        <select name="doctorId" required>
            <% for (Doctor d : doctors) { %>
                <option value="<%= d.getId() %>"><%= d.getName() %> - <%= d.getDepartmentName() %></option>
            <% } %>
        </select>

        <label>Date</label>
        <input type="date" name="date" required>

        <label>Time</label>
        <input type="time" name="time" required>

        <button type="submit">Book Appointment</button>
    </form>
</div>
</body>
</html>
