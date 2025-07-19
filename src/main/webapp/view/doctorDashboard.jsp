<!-- WebContent/view/doctorDashboard.jsp -->
<%@ page session="true" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"doctor".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Doctor Dashboard</title>
</head>
<body>
    <h1>Welcome Dr. <%= user.getName() %></h1>
    <ul>
        <ul>
    <li><a href="<%= request.getContextPath() %>/view/appointments.jsp">View Appointments</a></li>
    <li><a href="#">Prescriptions</a></li>
</ul>

        <li><a href="#">Add Diagnosis/Prescription</a></li>
    </ul>
    <p><a href="logout.jsp">Logout</a></p>
    <p><a href="doctorAvailability.jsp">View My Availability</a></p>
    
</body>
</html>
