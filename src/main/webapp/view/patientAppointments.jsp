<%@ page import="java.util.*, model.Appointment, dao.AppointmentDAO, model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"patient".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    AppointmentDAO appointmentDAO = new AppointmentDAO();
    List<Appointment> appointments = appointmentDAO.getAppointmentsByPatientId(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Appointments</title>
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
            max-width: 900px;
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
    <h2>Your Appointment History</h2>

    <% if (appointments != null && !appointments.isEmpty()) { %>
        <table>
            <tr>
                <th>Doctor</th>
                <th>Department</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
            </tr>
            <%
                java.text.SimpleDateFormat dateFormatter = new java.text.SimpleDateFormat("EEEE, MMM dd yyyy");
                java.text.SimpleDateFormat timeFormatter = new java.text.SimpleDateFormat("hh:mm a");

                for (Appointment app : appointments) {
            %>
            <tr>
                <td><%= app.getDoctorName() %></td>
                <td><%= app.getDepartment() %></td>
                <td><%= dateFormatter.format(app.getAppointmentDate()) %></td>
                <td><%= timeFormatter.format(app.getAppointmentTime()) %></td>
                <td><%= app.getStatus() != null ? app.getStatus() : "Pending" %></td>
            </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>No appointment history found.</p>
    <% } %>
</div>

</body>
</html>
