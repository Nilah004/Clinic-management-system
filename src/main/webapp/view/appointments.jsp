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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments - MediTrackPro</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="admin.css"> <!-- Link to the admin.css for consistent styling -->
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <header class="admin-header">
        <h1>Appointments</h1>
        <a href="<%= request.getContextPath() %>/logout" class="logout-link">Logout <i class="fas fa-sign-out-alt"></i></a>
    </header>

    <div class="container">
        <%
            String msg = (String) session.getAttribute("msg");
            if (msg != null) {
                boolean isSuccess = msg.toLowerCase().contains("success");
        %>
            <div class="message-box <%= isSuccess ? "success" : "error" %>">
                <%= msg %>
            </div>
        <%
                session.removeAttribute("msg");
            }
        %>
        
        <div style="margin-bottom: 20px; text-align: right;">
            <a href="<%= request.getContextPath() %>/view/adminDashboard.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Go Back to Dashboard
            </a>
        </div>

        <h2>All Appointments</h2>
        <% boolean hasAppointments = false; %>
        <table>
            <thead>
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
            </thead>
            <tbody>
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
                    <td data-label="Patient"><%= app.getPatientName() %></td>
                    <td data-label="Doctor"><%= app.getDoctorName() %></td>
                    <td data-label="Department"><%= app.getDepartment() %></td>
                    <td data-label="Date"><%= dateFormatter.format(app.getAppointmentDate()) %></td>
                    <td data-label="Time">
  <%= timeFormatter.format(app.getAppointmentTime()) %>
  -
  <%= app.getEndTime() != null ? timeFormatter.format(app.getEndTime()) : "N/A" %>
</td>
                    
                    <td data-label="Status"><%= app.getStatus() != null ? app.getStatus() : "Pending" %></td>
                    <td data-label="Actions">
                        <% if ("admin".equalsIgnoreCase(user.getRole())) { %>
                           <form action="<%= request.getContextPath() %>/updateAppointmentStatus" method="post" style="display:inline-block; margin-right: 5px;">
                                <input type="hidden" name="appointmentId" value="<%= app.getId() %>">
                                <select name="status" onchange="this.form.submit()" class="form-control">
                                    <option disabled selected>Change</option>
                                    <option value="Pending" <%= "Pending".equalsIgnoreCase(app.getStatus()) ? "selected" : "" %>>Pending</option>
                                    <option value="Confirmed" <%= "Confirmed".equalsIgnoreCase(app.getStatus()) ? "selected" : "" %>>Confirmed</option>
                                    <option value="Cancelled" <%= "Cancelled".equalsIgnoreCase(app.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                </select>
                            </form>
                        <% } else if ("doctor".equalsIgnoreCase(user.getRole())) { %>
                            <form action="<%= request.getContextPath() %>/updateAppointmentStatus" method="post" style="display:inline-block; margin-right: 5px;">
                                <input type="hidden" name="appointmentId" value="<%= app.getId() %>">
                                <input type="hidden" name="status" value="Completed">
                                <button type="submit" class="btn btn-primary btn-sm">Mark as Completed</button>
                            </form>
                            <form action="<%= request.getContextPath() %>/updateAppointmentStatus" method="post" style="display:inline-block;">
                                <input type="hidden" name="appointmentId" value="<%= app.getId() %>">
                                <input type="hidden" name="status" value="No-show">
                                <button type="submit" class="btn btn-danger btn-sm">Mark as No-show</button>
                            </form>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% if (!hasAppointments) { %>
            <p style="text-align: center; margin-top: 20px; color: #6c757d;">No appointments found.</p>
        <% } %>
    </div>
</body>
</html>
