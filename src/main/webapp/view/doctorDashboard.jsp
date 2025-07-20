<%@ page session="true" %>
<%@ page import="model.User" %>
<%@ page import="dao.AppointmentDAO, dao.DoctorDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Appointment" %>
<%@ page import="dao.AppointmentDAO" %>


<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"doctor".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    DoctorDAO doctorDao = new DoctorDAO();
    AppointmentDAO apptDao = new AppointmentDAO();

    int doctorId = doctorDao.getDoctorIdByUserId(user.getId());
    int todayCount = apptDao.getTodayAppointmentCount(doctorId);

    String departmentName = doctorDao.getDoctorDepartmentName(doctorId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard</title>
    <style>
        body { font-family: Arial; background: #f5f5f5; padding: 20px; }
        .container { background: #fff; padding: 30px; border-radius: 10px; max-width: 800px; margin: auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1 { color: #007bff; }
        .info-box { margin: 15px 0; padding: 15px; background: #e9ecef; border-radius: 8px; }
        a { display: inline-block; margin: 10px 0; text-decoration: none; color: #007bff; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <h1>Welcome Dr. <%= user.getName() %></h1>
    <p><strong>Department:</strong> <%= departmentName %></p>

    <div class="info-box">
        <h3>Today's Appointments: <%= todayCount %></h3>
    </div>

    <h3>Quick Links</h3>
    <ul>
        <li><a href="<%= request.getContextPath() %>/view/appointments.jsp">View Appointments</a></li>
        <li><a href="<%= request.getContextPath() %>/view/doctorAvailability.jsp">View My Availability</a></li>
        <li><a href="<%= request.getContextPath() %>/logout">Logout</a></li>
        <li><a href="doctorPatientHistory.jsp">View Past Patient History</a></li>
        
    </ul>
</div>

</body>
</html>
