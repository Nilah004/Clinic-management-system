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
            font-weight: bold;
        }
        select, input[type="text"], input[type="number"], button {
            padding: 10px;
            width: 100%;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .message {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 5px;
        }
        .link-btn {
            background-color: #007BFF;
            color: white;
            text-align: center;
            padding: 10px;
            display: block;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
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

        <label for="doctorSelect">Select Doctor</label>
        <select name="doctorId" id="doctorSelect" required>
            <option value="">-- Select Doctor --</option>
            <% for (Doctor d : doctors) { %>
                <option value="<%= d.getId() %>"><%= d.getName() %> - <%= d.getDepartmentName() %></option>
            <% } %>
        </select>

        <label for="slot">Select Available Time Slot</label>
        <div id="slotContainer">
            <p>Select a doctor to view available slots.</p>
        </div>

        <label for="fullName">Full Name</label>
        <input type="text" name="fullName" id="fullName" required>

        <label for="contact">Contact</label>
        <input type="text" name="contact" id="contact" required>

        <label for="age">Age</label>
        <input type="number" name="age" id="age" required>

        <label for="gender">Gender</label>
        <select name="gender" id="gender" required>
            <option value="">Select gender</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>

        <button type="submit">Book Appointment</button>
    </form>

    <a href="patientAppointments.jsp" class="link-btn">View Appointment History</a>
</div>

<script>
document.getElementById("doctorSelect").addEventListener("change", function () {
    const doctorId = this.value;
    const slotContainer = document.getElementById("slotContainer");
    slotContainer.innerHTML = "<p>Loading slots...</p>";

    if (!doctorId) {
        slotContainer.innerHTML = "<p>Select a doctor to view available slots.</p>";
        return;
    }

    fetch("<%=request.getContextPath()%>/getAvailableTimes?doctorId=" + doctorId)
        .then(response => response.text())
        .then(html => {
            slotContainer.innerHTML = html;
        })
        .catch(error => {
            console.error("Error loading slots:", error);
            slotContainer.innerHTML = "<p>Failed to load slots.</p>";
        });
});
</script>

</body>
</html>
