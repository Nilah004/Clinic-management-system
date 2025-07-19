<%@ page import="java.util.*, model.Appointment, dao.AppointmentDAO, dao.DoctorDAO" %>
<%@ page session="true" %>
<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null || (!"admin".equals(user.getRole()) && !"doctor".equals(user.getRole()))) {
        response.sendRedirect("login.jsp");
        return;
    }

    AppointmentDAO dao = new AppointmentDAO();
    DoctorDAO docDao = new DoctorDAO();

    List<Appointment> appointments = dao.getAllAppointments();
    int doctorId = -1;

    if ("doctor".equalsIgnoreCase(user.getRole())) {
        doctorId = docDao.getDoctorIdByUserId(user.getId());
    }
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
        .msg-success {
            background-color: #d4edda;
            border: 1px solid #28a745;
            padding: 10px;
            border-radius: 5px;
            color: #155724;
            margin-bottom: 15px;
        }
        .msg-error {
            background-color: #f8d7da;
            border: 1px solid #dc3545;
            padding: 10px;
            border-radius: 5px;
            color: #721c24;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="container">

<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
        boolean isSuccess = msg.toLowerCase().contains("success");
%>
    <div class="<%= isSuccess ? "msg-success" : "msg-error" %>">
        <%= msg %>
    </div>
<%
        session.removeAttribute("msg");
    }
%>

    <h2>Appointments</h2>

    <% boolean hasAppointments = false; %>
    <table>
        <tr>
            <th>Patient</th>
            <th>Doctor</th>
            <th>Department</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
            <% if ("admin".equalsIgnoreCase(user.getRole()) || "doctor".equalsIgnoreCase(user.getRole())) { %>
                <th>Actions</th>
            <% } %>
        </tr>

        <%
            java.text.SimpleDateFormat dateFormatter = new java.text.SimpleDateFormat("EEEE, MMM dd yyyy");
            java.text.SimpleDateFormat timeFormatter = new java.text.SimpleDateFormat("hh:mm a");

            for (Appointment app : appointments) {

                // Doctor should only see their own confirmed appointments
                if ("doctor".equalsIgnoreCase(user.getRole())) {
                    if (app.getDoctorId() != doctorId || !"Confirmed".equalsIgnoreCase(app.getStatus())) {
                        continue;
                    }
                }

                hasAppointments = true;
        %>
        <tr>
            <td><%= app.getPatientName() %></td>
            <td><%= app.getDoctorName() %></td>
            <td><%= app.getDepartment() %></td>
            <td><%= dateFormatter.format(app.getAppointmentDate()) %></td>
            <td><%= timeFormatter.format(app.getAppointmentTime()) %></td>
            <td><%= app.getStatus() != null ? app.getStatus() : "Pending" %></td>

            <td>
                <% if ("admin".equalsIgnoreCase(user.getRole())) { %>
                   <form action="<%= request.getContextPath() %>/updateAppointmentStatus" method="post">
                        <input type="hidden" name="appointmentId" value="<%= app.getId() %>">
                        <select name="status" onchange="this.form.submit()">
                            <option disabled selected>Change</option>
                            <option value="Pending">Pending</option>
                            <option value="Confirmed">Confirmed</option>
                            <option value="Cancelled">Cancelled</option>
                        </select>
                    </form>
                <% } else if ("doctor".equalsIgnoreCase(user.getRole())) { %>
                    <form action="<%= request.getContextPath() %>/updateAppointmentStatus" method="post">

                        <input type="hidden" name="appointmentId" value="<%= app.getId() %>">
                        <input type="hidden" name="status" value="Completed">
                        <button type="submit">Mark as Completed</button>
                    </form>

                    <form action="<%= request.getContextPath() %>/updateAppointmentStatus" method="post">

                        <input type="hidden" name="appointmentId" value="<%= app.getId() %>">
                        <input type="hidden" name="status" value="No-show">
                        <button type="submit">Mark as No-show</button>
                    </form>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>

    <% if (!hasAppointments) { %>
        <p>No appointments found.</p>
    <% } %>
</div>

</body>
</html>
