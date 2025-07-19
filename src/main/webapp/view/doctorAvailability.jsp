<%@ page session="true" import="model.User, dao.DoctorDAO, model.Doctor" %>
<%@ page import="java.util.List" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"doctor".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    DoctorDAO dao = new DoctorDAO();
    Doctor doctor = dao.getDoctorByUserId(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0f4f8; padding: 20px; }
        .container { background: #fff; padding: 25px; border-radius: 10px; max-width: 700px; margin: auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { color: #007BFF; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #007BFF; color: white; }
    </style>
</head>
<body>

<div class="container">
    <h2>Hello, <%= user.getName() %>  Your Weekly Availability</h2>

    <%
        if (doctor != null && doctor.getAvailabilityList() != null && !doctor.getAvailabilityList().isEmpty()) {
    %>
        <table>
            <tr>
                <th>Day</th>
                <th>Start Time</th>
                <th>End Time</th>
            </tr>
            <% for (model.DoctorAvailability av : doctor.getAvailabilityList()) { %>
                <tr>
                    <td><%= av.getDayOfWeek() %></td>
                    <td><%= av.getStartTime() %></td>
                    <td><%= av.getEndTime() %></td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p style="color: gray;">No availability set. Please contact the admin to add your time slots.</p>
    <% } %>
</div>

</body>
</html>
