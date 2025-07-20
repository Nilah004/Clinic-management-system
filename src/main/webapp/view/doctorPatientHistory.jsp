<%@ page import="model.User, model.Appointment, dao.DoctorDAO, dao.AppointmentDAO, java.util.*" %>
<%
    // Check if user is logged in and is a doctor
    User user = (User) session.getAttribute("user");
    if (user == null || !"doctor".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get doctorId using DoctorDAO
    DoctorDAO docDao = new DoctorDAO();
    int doctorId = docDao.getDoctorIdByUserId(user.getId());

    // Debug output (optional)
    out.println("<p>Logged-in User ID: " + user.getId() + "</p>");
    out.println("<p>Mapped Doctor ID: " + doctorId + "</p>");
    
    

    // Get completed appointments for that doctor
    AppointmentDAO appDao = new AppointmentDAO();
    List<Appointment> completedList = appDao.getCompletedAppointmentsByDoctorId(doctorId);

    out.println("<p>Completed Appointments Found: " + completedList.size() + "</p>");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Past Patient History</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        h2 { text-align: center; }
    </style>
</head>
<body>

<h2>Past Patient History (Completed)</h2>

<%
    if (completedList.isEmpty()) {
%>
    <p style="text-align:center;">No completed appointments found.</p>
<%
    } else {
%>
    <table>
        <tr>
            <th>Patient Name</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
        </tr>
        <%
            for (Appointment appt : completedList) {
        %>
            <tr>
                <td><%= appt.getPatientName() %></td>
                <td><%= appt.getAppointmentDate() %></td>
                <td><%= appt.getAppointmentTime() %></td>
                <td><%= appt.getStatus() %></td>
            </tr>
        <%
            }
        %>
    </table>
<%
    }
%>

<p style="text-align:center;"><a href="doctorDashboard.jsp">← Back to Dashboard</a></p>

</body>
</html>
