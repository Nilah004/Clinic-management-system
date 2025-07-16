<%@ page import="java.util.*, model.Appointment, dao.AppointmentDAO" %>
<%@ page session="true" %>
<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null || (!"admin".equals(user.getRole()) && !"doctor".equals(user.getRole()))) {
        response.sendRedirect("login.jsp");
        return;
    }

    AppointmentDAO dao = new AppointmentDAO();
    List<Appointment> appointments = dao.getAllAppointments();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Appointments</title>
    <style>
        body {
            font-family: Arial;
            background: #f2f2f2;
            padding: 20px;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            max-width: 1000px;
            margin: auto;
            box-shadow: 0 0 10px #ccc;
        }
        h2 {
            color: #007BFF;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }
        th {
            background: #007BFF;
            color: white;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>All Appointments</h2>

    <% if (appointments != null && !appointments.isEmpty()) { %>
    <table>
        <tr>
            <th>Patient</th>
            <th>Doctor</th>
            <th>Department</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
        </tr>
        <% for (Appointment app : appointments) { %>
            <tr>
                <td><%= app.getPatientName() %></td>
                <td><%= app.getDoctorName() %></td>
                <td><%= app.getDepartment() %></td>
                <td><%= app.getAppointmentDate() %></td>
                <td><%= app.getAppointmentTime() %></td>
                <td><%= app.getStatus() != null ? app.getStatus() : "Pending" %></td>
            </tr>
        <% } %>
    </table>
    <% } else { %>
        <p>No appointments found.</p>
    <% } %>
</div>

</body>
</html>
